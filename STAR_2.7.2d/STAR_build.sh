#build
docker build -t ddzhangzz/star .

#clean up dangling images
docker system  prune

#test run
docker container run ddzhangzz/star STAR --version
