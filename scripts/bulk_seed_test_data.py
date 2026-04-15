#!/usr/bin/env python3
"""
Bulk-insert synthetic users + campaigns + projects + posts for load / ML testing.

Defaults: 100 users and 500_000 entities split evenly across campaigns, projects, posts.

Environment (same as Docker / ml-service):
  DB_HOST   (default localhost)
  DB_PORT   (default 3306; use 3307 when MariaDB is mapped from Docker)
  DB_NAME   (default civic_platform)
  DB_USER   (default civic_user)
  DB_PASSWORD

Examples:
  pip install -r scripts/requirements-seed.txt
  docker compose up -d mariadb   # required before real inserts (not --dry-run)
  DB_HOST=127.0.0.1 DB_PORT=3307 DB_PASSWORD=civic_password python scripts/bulk_seed_test_data.py --dry-run
  DB_HOST=127.0.0.1 DB_PORT=3307 DB_PASSWORD=civic_password python scripts/bulk_seed_test_data.py

  # Same script via Docker (DB_HOST=mariadb; no host port needed):
  ./scripts/run-seed-docker.sh --total 3000 --users 10

  # Custom split: 50k campaigns, 50k projects, 400k posts
  python scripts/bulk_seed_test_data.py --campaigns 50000 --projects 50000 --posts 400000

  # Add random interactions for ML training (uses id ranges after seed names)
  python scripts/bulk_seed_test_data.py --interactions 200000

  # Remove only bulk_seed_* rows (keeps other users / data)
  python scripts/bulk_seed_test_data.py --delete

Docker volumes:
  `docker compose down` does NOT erase the database — data lives in the named volume
  `mariadb_data`. To wipe DB + ML model volume after testing, run:
    ./scripts/compose-down-clean.sh
  (same as: docker compose down -v)
"""

from __future__ import annotations

import argparse
import os
import random
import sys
import time
from datetime import datetime, timedelta
from typing import Any, Sequence

# Prefixes so you can DELETE ... WHERE ... LIKE 'bulk_seed_%' if needed
USER_PREFIX = "bulk_seed_u_"
EMAIL_DOMAIN = "@bulk-seed.local"

CAMPAIGN_TYPES = ("FOOD_COLLECTION", "FUNDRAISING", "VOLUNTEER", "AWARENESS")
POST_TYPES = ("EVENT_ANNOUNCEMENT", "TESTIMONIAL", "STATUS", "CAMPAIGN_ANNOUNCEMENT")
ACTIONS = ("VIEW", "LIKE", "VOTE", "COMMENT")
ENTITY_TYPES = ("CAMPAIGN", "PROJECT", "POST")


def env(name: str, default: str) -> str:
    v = os.environ.get(name)
    return v if v is not None and v != "" else default


def connect() -> Any:
    import pymysql  # noqa: PLC0415
    from pymysql.err import OperationalError  # noqa: PLC0415

    host = env("DB_HOST", "localhost")
    port = int(env("DB_PORT", "3306"))
    kw = dict(
        host=host,
        port=port,
        user=env("DB_USER", "civic_user"),
        password=env("DB_PASSWORD", "civic_password"),
        database=env("DB_NAME", "civic_platform"),
        charset="utf8mb4",
        autocommit=False,
    )
    try:
        return pymysql.connect(**kw)
    except OperationalError as e:
        if e.args[0] == 2003 or "Connection refused" in str(e):
            print(
                "\nCould not connect to MariaDB at "
                f"{host}:{port}.\n"
                "\n"
                "  • Start the database first, e.g.:\n"
                "      docker compose up -d mariadb\n"
                "    (wait until it is healthy; then host port 3307 is open if you use\n"
                "    the default compose).\n"
                "\n"
                "  • Or run the seeder inside Compose (no host port needed):\n"
                "      ./scripts/run-seed-docker.sh --total 3000 --users 10\n"
                "\n",
                file=sys.stderr,
            )
        raise


# Precomputed for literal "TestPass123!" (bcrypt $2b$10$, Spring-compatible).
DEFAULT_PASSWORD_BCRYPT = (
    "$2b$10$/IkBYZ/qVRXiJB5BzNaqHOm.8GP1sRhY63hcWfrzUEYUHfgUhnYJO"
)


def bcrypt_hash(password: str) -> str:
    import bcrypt  # noqa: PLC0415

    return bcrypt.hashpw(password.encode("utf-8"), bcrypt.gensalt(rounds=10)).decode(
        "ascii"
    )


def resolve_password_hash(password: str) -> str:
    if password == "TestPass123!":
        return DEFAULT_PASSWORD_BCRYPT
    return bcrypt_hash(password)


def chunked(n: int, size: int) -> list[tuple[int, int]]:
    out: list[tuple[int, int]] = []
    start = 0
    while start < n:
        end = min(start + size, n)
        out.append((start, end))
        start = end
    return out


def insert_users(
    cur: Any | None,
    *,
    n: int,
    password_hash: str,
    dry_run: bool,
) -> list[tuple[int, str]]:
    """Returns [(id, user_name), ...] in insertion order."""
    rows: list[tuple[Any, ...]] = []
    now = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    for i in range(n):
        uname = f"{USER_PREFIX}{i:05d}"
        email = f"{USER_PREFIX}{i:05d}{EMAIL_DOMAIN}"
        rows.append(
            (
                uname,
                email,
                password_hash,
                "CITIZEN",
                0,
                now,
                0,
            )
        )
    sql = (
        "INSERT INTO `user` "
        "(user_name, email, password, user_type, is_admin, created_at, points) "
        "VALUES (%s, %s, %s, %s, %s, %s, %s)"
    )
    if dry_run:
        print(f"[dry-run] would insert {n} users")
        return [(1_000_000 + i, f"{USER_PREFIX}{i:05d}") for i in range(n)]

    if cur is None:
        raise RuntimeError("cursor required when not dry-run")
    cur.executemany(sql, rows)
    first = cur.lastrowid
    if first == 0:
        raise RuntimeError("INSERT user did not return lastrowid (0 rows inserted?)")
    out: list[tuple[int, str]] = []
    for i in range(n):
        out.append((first + i, f"{USER_PREFIX}{i:05d}"))
    return out


def batch_insert_campaigns(
    cur: Any,
    *,
    total: int,
    user_ids: Sequence[int],
    batch_size: int,
    dry_run: bool,
) -> None:
    if total == 0:
        return
    if dry_run:
        print(f"  → {total} campaign rows (batched)")
        return
    now = datetime.now()
    for lo, hi in chunked(total, batch_size):
        chunk = hi - lo
        values: list[tuple[Any, ...]] = []
        for j in range(lo, hi):
            uid = random.choice(user_ids)
            ctype = random.choice(CAMPAIGN_TYPES)
            name = f"bulk_seed_c_{j:08d}"
            desc = f"Synthetic campaign {j}"
            start = (now - timedelta(days=random.randint(0, 90))).date().isoformat()
            values.append(
                (
                    name,
                    ctype,
                    desc,
                    "ACTIVE",
                    start,
                    uid,
                    now.strftime("%Y-%m-%d %H:%M:%S"),
                )
            )
        sql = (
            "INSERT INTO campaign "
            "(name, type, description, status, start_date, created_by_id, created_at) "
            "VALUES (%s, %s, %s, %s, %s, %s, %s)"
        )
        cur.executemany(sql, values)


def batch_insert_projects(
    cur: Any,
    *,
    total: int,
    user_ids: Sequence[int],
    batch_size: int,
    dry_run: bool,
) -> None:
    if total == 0:
        return
    if dry_run:
        print(f"  → {total} project rows (batched)")
        return
    now = datetime.now()
    for lo, hi in chunked(total, batch_size):
        chunk = hi - lo
        values: list[tuple[Any, ...]] = []
        for j in range(lo, hi):
            uid = random.choice(user_ids)
            title = f"bulk_seed_p_{j:08d}"
            desc = f"Synthetic project {j}"
            goal = random.randint(1000, 50000)
            current = random.randint(0, goal)
            votes = random.randint(0, 500)
            start = (now - timedelta(days=random.randint(0, 120))).date().isoformat()
            values.append(
                (
                    title,
                    desc,
                    goal,
                    current,
                    votes,
                    "SUBMITTED",
                    start,
                    uid,
                    now.strftime("%Y-%m-%d %H:%M:%S"),
                )
            )
        sql = (
            "INSERT INTO project "
            "(title, description, goal_amount, current_amount, vote_count, "
            "status, start_date, created_by_id, created_at) "
            "VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)"
        )
        cur.executemany(sql, values)


def batch_insert_posts(
    cur: Any,
    *,
    total: int,
    user_names: Sequence[str],
    batch_size: int,
    dry_run: bool,
) -> None:
    if total == 0:
        return
    if dry_run:
        print(f"  → {total} post rows (batched)")
        return
    now = datetime.now()
    for lo, hi in chunked(total, batch_size):
        chunk = hi - lo
        values: list[tuple[Any, ...]] = []
        for j in range(lo, hi):
            creator = random.choice(user_names)
            ptype = random.choice(POST_TYPES)
            content = f"bulk_seed_post_{j:08d} " + ("x" * min(200, random.randint(10, 200)))
            likes = random.randint(0, 200)
            created = now - timedelta(
                hours=random.randint(0, 24 * 180),
                seconds=random.randint(0, 86400),
            )
            values.append(
                (
                    creator,
                    content,
                    "ACCEPTED",
                    likes,
                    ptype,
                    created.strftime("%Y-%m-%d %H:%M:%S"),
                )
            )
        sql = (
            "INSERT INTO post "
            "(creator, content, status, likes_count, type, created_at) "
            "VALUES (%s, %s, %s, %s, %s, %s)"
        )
        cur.executemany(sql, values)


def id_bounds(
    cur: Any, table: str, name_column: str, pattern: str
) -> tuple[int | None, int | None]:
    cur.execute(
        f"SELECT MIN(id), MAX(id) FROM {table} WHERE {name_column} LIKE %s",
        (pattern,),
    )
    row = cur.fetchone()
    if not row or row[0] is None:
        return None, None
    return int(row[0]), int(row[1])


def insert_interactions(
    cur: Any,
    *,
    n: int,
    user_ids: Sequence[int],
    batch_size: int,
    dry_run: bool,
) -> None:
    if n == 0:
        return
    if dry_run:
        print(f"[dry-run] would insert {n} user_interactions rows")
        return
    if cur is None:
        raise RuntimeError("cursor required for interactions")
    cmin, cmax = id_bounds(cur, "campaign", "name", "bulk_seed_c_%")
    pmin, pmax = id_bounds(cur, "project", "title", "bulk_seed_p_%")
    postmin, postmax = id_bounds(cur, "post", "content", "bulk_seed_post_%")
    if not all([cmin, cmax, pmin, pmax, postmin, postmax]):
        print(
            "Warning: could not resolve id bounds for bulk_seed rows; "
            "skipping interactions.",
            file=sys.stderr,
        )
        return

    def pick_entity() -> tuple[str, int]:
        t = random.choice(ENTITY_TYPES)
        if t == "CAMPAIGN":
            return t, random.randint(cmin, cmax)  # type: ignore[arg-type]
        if t == "PROJECT":
            return t, random.randint(pmin, pmax)  # type: ignore[arg-type]
        return t, random.randint(postmin, postmax)  # type: ignore[arg-type]

    now = datetime.now()
    for lo, hi in chunked(n, batch_size):
        values: list[tuple[Any, ...]] = []
        for _ in range(lo, hi):
            uid = random.choice(user_ids)
            etype, eid = pick_entity()
            action = random.choice(ACTIONS)
            ts = now - timedelta(
                days=random.randint(0, 365),
                seconds=random.randint(0, 86400),
            )
            values.append(
                (uid, etype, eid, action, ts.strftime("%Y-%m-%d %H:%M:%S"))
            )
        sql = (
            "INSERT INTO user_interactions "
            "(user_id, entity_type, entity_id, action, created_at) "
            "VALUES (%s, %s, %s, %s, %s)"
        )
        cur.executemany(sql, values)


def delete_bulk_seed(conn: Any) -> None:
    """Remove rows created by this script (prefixes bulk_seed_* / bulk_seed_u_)."""
    cur = conn.cursor()
    like_user = USER_PREFIX + "%"
    like_campaign = "bulk_seed_c_%"
    like_project = "bulk_seed_p_%"
    like_post = "bulk_seed_post_%"

    cur.execute("SET FOREIGN_KEY_CHECKS=0")
    try:
        steps: list[tuple[str, str, tuple[Any, ...]]] = [
            (
                "user_interactions (by seed user)",
                "DELETE FROM user_interactions WHERE user_id IN "
                "(SELECT id FROM `user` WHERE user_name LIKE %s)",
                (like_user,),
            ),
            (
                "user_interactions (CAMPAIGN)",
                "DELETE FROM user_interactions WHERE entity_type = 'CAMPAIGN' "
                "AND entity_id IN (SELECT id FROM campaign WHERE name LIKE %s)",
                (like_campaign,),
            ),
            (
                "user_interactions (PROJECT)",
                "DELETE FROM user_interactions WHERE entity_type = 'PROJECT' "
                "AND entity_id IN (SELECT id FROM project WHERE title LIKE %s)",
                (like_project,),
            ),
            (
                "user_interactions (POST)",
                "DELETE FROM user_interactions WHERE entity_type = 'POST' "
                "AND entity_id IN (SELECT id FROM post WHERE content LIKE %s)",
                (like_post,),
            ),
            (
                "comment_attachment",
                "DELETE FROM comment_attachment WHERE comment_id IN "
                "(SELECT id FROM comment WHERE post_id IN "
                "(SELECT id FROM post WHERE content LIKE %s))",
                (like_post,),
            ),
            (
                "comment",
                "DELETE FROM comment WHERE post_id IN "
                "(SELECT id FROM post WHERE content LIKE %s)",
                (like_post,),
            ),
            (
                "like_entity",
                "DELETE FROM like_entity WHERE post_id IN "
                "(SELECT id FROM post WHERE content LIKE %s)",
                (like_post,),
            ),
            (
                "post_attachment",
                "DELETE FROM post_attachment WHERE post_id IN "
                "(SELECT id FROM post WHERE content LIKE %s)",
                (like_post,),
            ),
            (
                "post (seed content)",
                "DELETE FROM post WHERE content LIKE %s",
                (like_post,),
            ),
            (
                "post (linked to seed campaigns)",
                "DELETE FROM post WHERE campaign_id IN "
                "(SELECT id FROM campaign WHERE name LIKE %s)",
                (like_campaign,),
            ),
            (
                "campaign_vote",
                "DELETE FROM campaign_vote WHERE campaign_id IN "
                "(SELECT id FROM campaign WHERE name LIKE %s)",
                (like_campaign,),
            ),
            (
                "campaign",
                "DELETE FROM campaign WHERE name LIKE %s",
                (like_campaign,),
            ),
            (
                "project_funding",
                "DELETE FROM project_funding WHERE project_id IN "
                "(SELECT id FROM project WHERE title LIKE %s)",
                (like_project,),
            ),
            (
                "project_vote",
                "DELETE FROM project_vote WHERE project_id IN "
                "(SELECT id FROM project WHERE title LIKE %s)",
                (like_project,),
            ),
            (
                "project",
                "DELETE FROM project WHERE title LIKE %s",
                (like_project,),
            ),
            (
                "refresh_token",
                "DELETE FROM refresh_token WHERE user_id IN "
                "(SELECT id FROM `user` WHERE user_name LIKE %s)",
                (like_user,),
            ),
            (
                "user",
                "DELETE FROM `user` WHERE user_name LIKE %s",
                (like_user,),
            ),
        ]
        for label, sql, params in steps:
            cur.execute(sql, params)
            print(f"  {label}: {cur.rowcount} rows")
    finally:
        cur.execute("SET FOREIGN_KEY_CHECKS=1")


def main() -> None:
    p = argparse.ArgumentParser(description="Bulk seed test data into MariaDB.")
    p.add_argument("--users", type=int, default=100, help="Number of synthetic users")
    p.add_argument(
        "--total",
        type=int,
        default=500_000,
        help="Total rows across campaigns+projects+posts when using default split",
    )
    p.add_argument("--campaigns", type=int, default=None, help="Override campaign count")
    p.add_argument("--projects", type=int, default=None, help="Override project count")
    p.add_argument("--posts", type=int, default=None, help="Override post count")
    p.add_argument(
        "--batch-size",
        type=int,
        default=1000,
        help="Rows per INSERT batch (lower if max_allowed_packet errors)",
    )
    p.add_argument(
        "--interactions",
        type=int,
        default=0,
        help="Optional user_interactions rows for ML (random VIEW/LIKE/VOTE/COMMENT)",
    )
    p.add_argument("--dry-run", action="store_true", help="Print plan only")
    p.add_argument(
        "--password",
        default="TestPass123!",
        help="Plain password for all seed users (bcrypt hashed)",
    )
    p.add_argument(
        "--delete",
        action="store_true",
        help="Remove bulk_seed_* data from the DB (does not drop Docker volumes)",
    )
    args = p.parse_args()

    if args.delete:
        conn = connect()
        try:
            print("Deleting bulk_seed_* rows…")
            delete_bulk_seed(conn)
            conn.commit()
            print("Delete committed.")
        except Exception as e:
            conn.rollback()
            print(f"Error: {e}", file=sys.stderr)
            raise
        finally:
            conn.close()
        return

    if args.users < 1:
        print("--users must be >= 1", file=sys.stderr)
        sys.exit(1)

    if args.campaigns is not None or args.projects is not None or args.posts is not None:
        c = args.campaigns if args.campaigns is not None else 0
        pr = args.projects if args.projects is not None else 0
        po = args.posts if args.posts is not None else 0
        if c < 0 or pr < 0 or po < 0:
            print("Counts must be non-negative", file=sys.stderr)
            sys.exit(1)
        n_c, n_p, n_po = c, pr, po
    else:
        third = args.total // 3
        rem = args.total - 3 * third
        n_c, n_p, n_po = third, third, third + rem

    total_entities = n_c + n_p + n_po
    print(
        f"Plan: {args.users} users; "
        f"campaigns={n_c}, projects={n_p}, posts={n_po} (total entities={total_entities})"
    )
    if args.interactions:
        print(f"Plan: {args.interactions} user_interactions rows")

    ph = resolve_password_hash(args.password)
    t0 = time.perf_counter()

    if args.dry_run:
        print("Inserting users…")
        users = insert_users(
            None, n=args.users, password_hash=ph, dry_run=True
        )
        user_ids = [u[0] for u in users]
        user_names = [u[1] for u in users]
        print("Inserting campaigns…")
        batch_insert_campaigns(
            None,
            total=n_c,
            user_ids=user_ids,
            batch_size=args.batch_size,
            dry_run=True,
        )
        print("Inserting projects…")
        batch_insert_projects(
            None,
            total=n_p,
            user_ids=user_ids,
            batch_size=args.batch_size,
            dry_run=True,
        )
        print("Inserting posts…")
        batch_insert_posts(
            None,
            total=n_po,
            user_names=user_names,
            batch_size=args.batch_size,
            dry_run=True,
        )
        if args.interactions > 0:
            print("Inserting user_interactions…")
            insert_interactions(
                None,
                n=args.interactions,
                user_ids=user_ids,
                batch_size=args.batch_size,
                dry_run=True,
            )
        print("[dry-run] no database connection; exiting.")
        return

    conn = connect()
    try:
        cur = conn.cursor()
        print("Inserting users…")
        users = insert_users(cur, n=args.users, password_hash=ph, dry_run=False)
        user_ids = [u[0] for u in users]
        user_names = [u[1] for u in users]

        print("Inserting campaigns…")
        batch_insert_campaigns(
            cur,
            total=n_c,
            user_ids=user_ids,
            batch_size=args.batch_size,
            dry_run=False,
        )
        print("Inserting projects…")
        batch_insert_projects(
            cur,
            total=n_p,
            user_ids=user_ids,
            batch_size=args.batch_size,
            dry_run=False,
        )
        print("Inserting posts…")
        batch_insert_posts(
            cur,
            total=n_po,
            user_names=user_names,
            batch_size=args.batch_size,
            dry_run=False,
        )

        if args.interactions > 0:
            print("Inserting user_interactions…")
            insert_interactions(
                cur,
                n=args.interactions,
                user_ids=user_ids,
                batch_size=args.batch_size,
                dry_run=False,
            )

        conn.commit()
        elapsed = time.perf_counter() - t0
        print(f"Done in {elapsed:.1f}s. Commit OK.")
        print(
            f"Seed usernames: {USER_PREFIX}00000 … {USER_PREFIX}{args.users - 1:05d} "
            f"(password: {args.password!r})"
        )
    except Exception as e:
        conn.rollback()
        print(f"Error: {e}", file=sys.stderr)
        raise
    finally:
        conn.close()


if __name__ == "__main__":
    main()
