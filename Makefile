RAILWAY_PROJECT ?= templates-test

deploy:
	railway link -p $(RAILWAY_PROJECT)
	railway add --database postgres
	railway add --database redis
	railway add --service immich-server
	railway add --service immich-ml
	railway volume -s immich-server add --mount-path /usr/src/app/upload
	railway volume -s immich-ml add --mount-path /cache
	cd server && railway up --service immich-server
	cd ml && railway up --service immich-ml
	railway variable set --service immich-server \
	  'DATABASE_URL=${{Postgres.DATABASE_URL}}' \
	  'REDIS_HOSTNAME=${{Redis.REDISHOST}}' \
	  'REDIS_PORT=${{Redis.REDISPORT}}' \
	  UPLOAD_LOCATION=/usr/src/app/upload \
	  'IMMICH_MACHINE_LEARNING_URL=http://${{immich-ml.RAILWAY_PRIVATE_DOMAIN}}:3003'
	railway variable set --service immich-ml \
	  MACHINE_LEARNING_CACHE_FOLDER=/cache

destroy:
	@echo "Delete services via Railway dashboard: immich-server, immich-ml, Postgres, Redis"
	@echo "https://railway.app/project/$(RAILWAY_PROJECT)"

status:
	railway service status --all --json

logs:
	railway logs --service immich-server --lines 100

.PHONY: deploy destroy status logs
