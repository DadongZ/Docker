#detach means run on the background
docker container run --publish 80:80 --detach nginx
docker container ls
docker container stop first-three-letter of the containerID
docker container ls -a
docker container run --publish 80:80 --detach --name webhost nginx
docker container logs webhost
docker container top webhost
