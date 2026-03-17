# Immich

[![Deploy on Railway](https://railway.app/button.svg)](https://railway.app/new/template?template=https://github.com/c-treinta/railway-immich)

Self-hosted Google Photos alternative.

**Services:** `immich-server`, `immich-ml`, `Postgres`, `Redis` (Railway-managed)
**Volumes:**
- `immich-server`: `/usr/src/app/upload` (photos and thumbnails)
- `immich-ml`: `/cache` (ML model cache)

## Deploy

```bash
make deploy
```

## Post-Deploy

1. Open the Railway domain for `immich-server`
2. Create your admin account on first visit
3. Install the Immich mobile app and point it at your Railway domain

## Environment Variables (auto-wired)

| Variable | Service |
|----------|---------|
| `DATABASE_URL` | immich-server |
| `REDIS_HOSTNAME` / `REDIS_PORT` | immich-server |
| `UPLOAD_LOCATION` | immich-server |
| `IMMICH_MACHINE_LEARNING_URL` | immich-server (private network) |
| `MACHINE_LEARNING_CACHE_FOLDER` | immich-ml |
