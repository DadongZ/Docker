# 79
## supported in Dockerfile, compose yaml, docker run, swarm services
## exit 0 ok or exit 1 error
## states: starting, healthy, unhealthy

docker container ls
docker container inspect

docker run \
    --health-cmd="curl -f localhost:9200/_cluster/health || false" \
    --health-interval=5s \
    --health-retries=3 \
    --health-timeout=2s \
    --health-start-period=15s \
    elasticsearch:2

FROM postgres
HEALTHCHECK --interval=5s --timeout=3s \
    CMD pg_isready -U postgres || exit 1


#example 
bridlebit@Zhang_family-PC:~$ docker container run --name p1 -d postgres
bridlebit@Zhang_family-PC:~$ docker container ls
bridlebit@Zhang_family-PC:~$ docker container run --name p1 -d --health-cmd="pg_isready -U postgres || exit 1" postgres
