# Deploy and Host Immich on Railway

[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/new/template/immich)

Immich is an open-source, self-hosted photo and video backup solution. It provides a Google Photos-like experience with automatic mobile backup, facial recognition, object detection, and album sharing — all running on your own infrastructure.

## About Hosting Immich

Hosting Immich on Railway gives you a fully managed environment for your personal media library without maintaining servers. Railway handles infrastructure provisioning, networking, and persistent storage so you can focus on using Immich rather than running it. The template wires together the Immich server, the machine-learning sidecar (for smart search and facial recognition), a PostgreSQL database, and a Redis cache — all on Railway's private network. Volumes are attached automatically so your photos, thumbnails, and ML model cache survive restarts and redeployments.

## Common Use Cases

- Personal photo and video backup from iOS and Android devices
- Self-hosted alternative to Google Photos or iCloud with full data ownership
- Shared family photo library with multi-user support and album sharing
- AI-powered smart search and face grouping across large media collections
- Secure, private media archive with no third-party cloud dependency

## Dependencies for Immich Hosting

- PostgreSQL (pgvecto.rs extension required — use the Immich-compatible image)
- Redis (Railway-managed)
- Immich server service (`ghcr.io/immich-app/immich-server:release`)
- Immich machine-learning service (`ghcr.io/immich-app/immich-machine-learning:release`)

### Deployment Dependencies

- [Immich Docker images on GHCR](https://github.com/immich-app/immich/pkgs/container/immich-server)
- [Immich official documentation](https://immich.app/docs)
- [Immich GitHub repository](https://github.com/immich-app/immich)

### Implementation Details

The template uses two custom Dockerfiles that pull the official Immich release images:

- `server/Dockerfile` → `ghcr.io/immich-app/immich-server:release`
- `ml/Dockerfile` → `ghcr.io/immich-app/immich-machine-learning:release`

Service-to-service communication (server → ML sidecar) uses Railway's private network via `${{immich-ml.RAILWAY_PRIVATE_DOMAIN}}` so traffic never leaves the internal network. Volumes are mounted at `/usr/src/app/upload` (photos) and `/cache` (ML models).

## Why Deploy Immich on Railway?

Railway is a singular platform to deploy your infrastructure stack. Railway will host your infrastructure so you don't have to deal with configuration, while allowing you to vertically and horizontally scale it.

By deploying Immich on Railway, you are one step closer to supporting a complete full-stack application with minimal burden. Host your servers, databases, AI agents, and more on Railway.
