# MLOps stack (Spring Boot + FastAPI + MariaDB)

## Run ML unit tests (Docker)

From the repo root (uses the `ml-service` image and mounts the `ml-service` folder):

```bash
docker compose run --rm -v "$(pwd)/ml-service:/app" ml-service sh -c "pip install -q pytest httpx && pytest -q"
```

Include **HTTP API tests** (FastAPI `TestClient`, no DB):

```bash
docker compose run --rm -v "$(pwd)/ml-service:/app" ml-service sh -c "pip install -q pytest httpx && pytest -q tests/test_api.py"
```

Or install `requirements-dev.txt` in a Python 3.11 environment and run `pytest` inside `ml-service/`.

## Test ML HTTP APIs manually (curl)

With the stack running (`docker compose up`) and ML on port **8000**:

```bash
curl -s http://localhost:8000/health | jq .
curl -s http://localhost:8000/model/info | jq .
curl -s -X POST http://localhost:8000/recommend \
  -H "Content-Type: application/json" \
  -d '{"user_id": 1, "limit_campaigns": 5, "limit_projects": 5, "limit_posts": 10}' | jq .
curl -s -X POST http://localhost:8000/retrain | jq .
```

Spring Boot feed (needs a **citizen** JWT, backend on **8081** with `/api` context):

```bash
curl -s http://localhost:8081/api/recommendations/feed \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN" | jq .
```

## ML tuning (regularization and stability)

Set these environment variables on the **ml-service** container (see `docker-compose.yml`):


| Variable                              | Default       | Role                                                                   |
| ------------------------------------- | ------------- | ---------------------------------------------------------------------- |
| `SVD_REG_ALL`                         | `0.02`        | **L2 regularization** for Surprise SVD (raise if unstable/overfitting) |
| `SVD_N_FACTORS`                       | `50`          | Latent factors                                                         |
| `SVD_N_EPOCHS`                        | `20`          | Training epochs                                                        |
| `SVD_LR_ALL`                          | `0.005`       | Learning rate                                                          |
| `SVD_EST_CLIP_LO` / `SVD_EST_CLIP_HI` | `0.5` / `5.5` | Clip raw SVD estimates before blending with popularity/recency         |
| `MAX_RECOMMEND_ITEMS`                 | `50`          | Cap per list when clients request large limits                         |


API request limits are validated: `user_id ≥ 1`, each limit in **1–50** (`RecommendRequest`).

## Start the full stack

```bash
docker compose up --build
```


| Service                  | URL                                              | Notes                                                                                          |
| ------------------------ | ------------------------------------------------ | ---------------------------------------------------------------------------------------------- |
| **Angular (nginx)**      | `http://localhost:4200`                          | **Use this in the browser.** Nginx proxies `/api` → Spring Boot (same origin; no CORS issues). |
| **Spring Boot (direct)** | `http://localhost:8081/api`                      | Optional; same API as via `/api` on port 4200.                                                 |
| **ML service**           | `http://localhost:8000`                          | FastAPI + Swagger at `/docs`.                                                                  |
| **MariaDB**              | host `localhost`, port `3307` → container `3306` | See `docker-compose.yml`.                                                                      |


Set `JWT_SECRET` in the environment for production. Local `ng serve` uses `environment.ts` pointing at `**http://localhost:8082/api`** (same default as `mvn spring-boot:run`). The Docker frontend build uses `environment.prod.ts` with `apiUrl: '/api'` behind nginx.

## Start only the ML service (with database)

```bash
docker-compose up ml-service mariadb
```

## Manually trigger retraining (Python API)

```bash
curl -X POST http://localhost:8000/retrain
```

## Check ML service health

```bash
curl http://localhost:8000/health
```

## Check model info

```bash
curl http://localhost:8000/model/info
```

## Get recommendations for user 1 directly from the ML API

```bash
curl -X POST http://localhost:8000/recommend \
  -H "Content-Type: application/json" \
  -d '{"user_id": 1, "limit_campaigns": 5, "limit_projects": 5, "limit_posts": 10}'
```

## FastAPI docs (Swagger)

Open `http://localhost:8000/docs` in a browser.

## CURL tests (via Spring Boot)

Replace `CITIZEN_TOKEN` / `ADMIN_TOKEN` with valid JWTs.

**ML service health**

```bash
curl http://localhost:8000/health
```

**Personalized feed (Spring Boot)**

```bash
curl -X GET http://localhost:8080/api/recommendations/feed \
  -H "Authorization: Bearer $CITIZEN_TOKEN"
```

**Admin triggers retrain**

```bash
curl -X POST http://localhost:8080/api/admin/ml/retrain \
  -H "Authorization: Bearer $ADMIN_TOKEN"
```

**ML service down — feed should still return 200 with empty or fallback content**

```bash
docker-compose stop ml-service
curl -X GET http://localhost:8080/api/recommendations/feed \
  -H "Authorization: Bearer $CITIZEN_TOKEN"
docker-compose start ml-service
```

Local development without Docker: run MariaDB, start the backend on port `**8082**` (default in `application.yml`), and the ML service on port `8000`. Set `ML_SERVICE_URL=http://localhost:8000` if the ML API is not on the default host.

## Bulk seed data (load testing)

MariaDB must be running before the seed script connects. If you use Docker:

```bash
docker compose up -d mariadb
# wait until healthy (first start can take ~30s)
```

**Option A — from the host** (needs `pymysql` in a venv and port **3307** published):

```bash
pip install -r scripts/requirements-seed.txt
export DB_HOST=127.0.0.1 DB_PORT=3307 DB_PASSWORD=civic_password
python scripts/bulk_seed_test_data.py --dry-run
python scripts/bulk_seed_test_data.py            # 100 users + 500k rows (see script help)
python scripts/bulk_seed_test_data.py --delete   # remove only bulk_seed_* rows
```

**Option B — inside Docker** (no host port required; connects as `mariadb:3306`):

```bash
./scripts/run-seed-docker.sh --dry-run
./scripts/run-seed-docker.sh --total 3000 --users 10
./scripts/run-seed-docker.sh --delete
```

**Docker volumes:** `docker compose down` does **not** delete database files. Data is stored in the named volume `mariadb_data`. To wipe the DB and ML model volume after a test run, use:

```bash
./scripts/compose-down-clean.sh
```

(equivalent to `docker compose down -v`).