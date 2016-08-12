APP_NAME := asana-wallboard

setup_heroku:
	heroku auth:whoami ; if [ $$? -neq 0 ] ; then heroku login ; fi
	heroku create $(APP_NAME)-staging
	heroku create $(APP_NAME)-production
	git remote add heroku-staging git@heroku.com:$(APP_NAME)-staging.git
	git remote add heroku-production git@heroku.com:$(APP_NAME)-production.git

setup_heroku_env:
	heroku config:set APP_SETTINGS=StagingConfig --remote heroku-staging
	heroku config:set APP_SETTINGS=ProductionConfig --remote heroku-production

setup_heroku_secrets:
	heroku config:set ASANA_API_KEY=${ASANA_API_KEY} --remote heroku-staging
	heroku config:set ASANA_WORKSPACE_ID=${ASANA_WORKSPACE_ID} --remote heroku-staging
	heroku config:set ASANA_API_KEY=${ASANA_API_KEY} --remote heroku-production
	heroku config:set ASANA_WORKSPACE_ID=${ASANA_WORKSPACE_ID} --remote heroku-production

deploy_staging:
	git push heroku-staging master

deploy_production:
	git push heroku-production master

sync: sync_staging sync_production

sync_staging:
	heroku run rake db:migrate
	heroku run rake sync:all --remote heroku-staging

sync_production:
	heroku run rake db:migrate
	heroku run rake sync:all --remote heroku-production
