# Rails App on Cloud Run & Cloud SQL

## System
 * Ruby 2.7.2
 * PostgreSQL 12
 * Node 12

## Setup
 1. `$ docker-compose build`
 2. `$ docker-compose up`
 3. `$ docker-compose run web rails db:create`
 4. `open http://localhost:300`

## development
 1. `$ docker-compose start`

## deployment to Cloud Run
 1. `$ docker build -t <container-name> .`
 2. `$ docker tag <container-name> gcr.io/<PROJECT_ID>/<container-name>`
 3. `$ docker push gcr.io/<PROJECT_ID>/<container-name>`
 4. deployment cloud run
 ```
 $ gcloud run deploy <app-name> \
  --image gcr.io/<PROJECT_ID>/<container-name> \
  --add-cloudsql-instances <sql-instance-name> \
  --allow-unauthenticated \ 
  --region <region> \
  --memory 512Mi \
  --set-env-vars " \
    RAILS_ENV=production, \
    RACK_ENV=production, \
    APP_DATABASE_HOST=/cloudsql/<INSTANCE_CONNECTION_NAME>,\
    APP_DATABASE_USER=<DB_USER>, \
    APP_DATABASE_PASSWORD=<PASSWORD>, \
    APP_DATABASE_NAME=<DATABASE_NAME>, \
    RAILS_MASTER_KEY=<RAILS_MASTER_KEY> \
 ```
