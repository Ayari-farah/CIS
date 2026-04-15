"""Unit tests for SVD recommendation model (no database)."""
from __future__ import annotations

from datetime import datetime

import numpy as np
import pandas as pd
import pytest

from app.model import MIN_INTERACTIONS_FOR_SVD, RecommendationModel, SVD_EST_CLIP_HI, SVD_EST_CLIP_LO


def _synthetic_interactions(n_rows: int = 20) -> pd.DataFrame:
    """Enough rows to train; multiple users and entity types."""
    rng = np.random.default_rng(42)
    users = rng.integers(1, 6, size=n_rows)
    types = rng.choice(["CAMPAIGN", "PROJECT", "POST"], size=n_rows)
    eids = rng.integers(1, 30, size=n_rows)
    actions = rng.choice(["LIKE", "VOTE", "COMMENT"], size=n_rows)
    weights = rng.uniform(1.0, 4.0, size=n_rows)
    return pd.DataFrame(
        {
            "user_id": users,
            "entity_type": types,
            "entity_id": eids,
            "action": actions,
            "created_at": pd.date_range("2024-01-01", periods=n_rows, freq="h"),
            "weight": weights,
        }
    )


def test_train_skips_when_too_few_rows():
    m = RecommendationModel()
    small = _synthetic_interactions(MIN_INTERACTIONS_FOR_SVD - 1)
    out = m.train(small, model_path="/tmp/should_not_write.pkl")
    assert out["status"] == "skipped"


def test_train_save_load_and_predict(tmp_path):
    df = _synthetic_interactions(25)
    path = tmp_path / "model.pkl"
    m = RecommendationModel()
    out = m.train(df, model_path=str(path))
    assert out["status"] == "success"
    assert out["n_samples"] >= 1
    assert path.exists()

    m2 = RecommendationModel()
    assert m2.load(model_path=str(path)) is True
    est = m2.predict_score(1, "CAMPAIGN", 1)
    assert SVD_EST_CLIP_LO <= est <= SVD_EST_CLIP_HI


def test_recommend_campaigns_respects_limit_and_excludes_votes(tmp_path):
    df = _synthetic_interactions(30)
    m = RecommendationModel()
    p = str(tmp_path / "m.pkl")
    m.train(df, model_path=p)
    assert m.load(model_path=p)

    campaigns = pd.DataFrame(
        {
            "id": [1, 2, 3, 4, 5],
            "name": list("abcde"),
            "type": ["FUNDRAISING"] * 5,
            "vote_count": [0, 1, 2, 3, 4],
            "created_at": [datetime.now()] * 5,
            "needed_amount": [100.0] * 5,
        }
    )
    votes = pd.DataFrame({"user_id": [1], "campaign_id": [2]})
    ids = m.recommend_campaigns(1, campaigns, votes, limit=3, is_cold_start=False)
    assert len(ids) <= 3
    assert 2 not in ids
    assert len(set(ids)) == len(ids)


def test_recommend_campaigns_cold_start():
    m = RecommendationModel()  # not loaded — cold path uses popularity only
    campaigns = pd.DataFrame(
        {
            "id": [10, 11],
            "name": ["a", "b"],
            "type": ["AWARENESS", "AWARENESS"],
            "vote_count": [100, 0],
            "created_at": [datetime.now()] * 2,
            "needed_amount": [1.0, 1.0],
        }
    )
    votes = pd.DataFrame(columns=["user_id", "campaign_id"])
    ids = m.recommend_campaigns(99, campaigns, votes, limit=2, is_cold_start=True)
    assert ids[0] == 10  # higher vote_count → higher score


def test_clip_limit_caps_at_max():
    m = RecommendationModel()
    campaigns = pd.DataFrame(
        {
            "id": list(range(1, 60)),
            "name": [str(i) for i in range(1, 60)],
            "type": ["VOLUNTEER"] * 59,
            "vote_count": [0] * 59,
            "created_at": [datetime.now()] * 59,
            "needed_amount": [1.0] * 59,
        }
    )
    votes = pd.DataFrame(columns=["user_id", "campaign_id"])
    ids = m.recommend_campaigns(1, campaigns, votes, limit=500, is_cold_start=True)
    assert len(ids) <= 50  # MAX_RECOMMEND_ITEMS default

