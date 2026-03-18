RAILWAY_PROJECT ?= templates-test

deploy:
	railway link -p $(RAILWAY_PROJECT)
	railway add --database postgres
	railway add --database redis
	railway add --service immich-server
	railway add --service immich-ml
	railway service status --all --json | jq -r '.[] | select(.name == "immich-server") | .id' | xargs -I{} railway volume -s {} add --mount-path /usr/src/app/upload
	railway service status --all --json | jq -r '.[] | select(.name == "immich-ml") | .id' | xargs -I{} railway volume -s {} add --mount-path /cache
	railway up server --path-as-root --service immich-server
	railway up ml --path-as-root --service immich-ml
	railway variable set --service immich-server \
	  PORT=2283 \
	  'DATABASE_URL=$${{Postgres.DATABASE_URL}}' \
	  'REDIS_HOSTNAME=$${{Redis.REDISHOST}}' \
	  'REDIS_PORT=$${{Redis.REDISPORT}}' \
	  UPLOAD_LOCATION=/usr/src/app/upload \
	  'IMMICH_MACHINE_LEARNING_URL=http://$${{immich-ml.RAILWAY_PRIVATE_DOMAIN}}:3003'
	railway variable set --service immich-ml \
	  MACHINE_LEARNING_CACHE_FOLDER=/cache

destroy:
	@echo "Delete services via Railway dashboard: immich-server, immich-ml, Postgres, Redis"
	@echo "https://railway.com/project/$(RAILWAY_PROJECT)"

status:
	railway service status --all --json

logs:
	railway logs --service immich-server --lines 100

.PHONY: deploy destroy status logs
