docker container run -d --name pg1 -v psql-data:/var/lib/postgresql/data postgres:13-alpine
docker container run -d --name pg2 -v psql-data:/usr/lib/postgresql/data postgres:12-alpine
