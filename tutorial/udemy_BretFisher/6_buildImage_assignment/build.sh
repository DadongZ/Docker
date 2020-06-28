#build image
docker build -t testnode .

#test run
docker container run --rm -p 80:3000 --name test testnode 

#rename before push
docker tag testnode ddzhangzz/testing-node

#push
docker push ddzhangzz/testing-node

#rm local image
docker image rm ddzhangzz/testing-node:latest

#pull and run
docker container run --rm -p 80:3000 --name pullrun ddzhangzz/testing-node

