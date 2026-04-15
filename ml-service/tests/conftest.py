"""Pytest: skip heavy lifespan and DB before importing the FastAPI app."""
from __future__ import annotations

import os

os.environ.setdefault("ML_SKIP_LIFESPAN", "1")
