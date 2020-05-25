maintainer: Dadong Zhang

##install docker
get.docker.com

#without sudo for docker
sudo usermod -aG docker bridlebit

#install docker machine
#https://docs.docker.com/machine/install-machine/
    base=https://github.com/docker/machine/releases/download/v0.16.0 &&
    curl -L $base/docker-machine-$(uname -s)-$(uname -m) >/tmp/docker-machine &&
    sudo mv /tmp/docker-machine /usr/local/bin/docker-machine &&
    chmod +x /usr/local/bin/docker-machine

#install docker compose
#https://docs.docker.com/compose/install/
    sudo curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose

#https://www.bretfisher.com/shell/

#solve issue for WSL: Cannot connect to the Docker daemon at tcp://localhost:2375. Is the docker daemon running?
#on Windows netsh CMD 
netsh> interface ipv4 show excludedportrange protocol=tcp
netsh> int ipv4 add excludedportrange protocol=tcp startport=2375 numberofports=1
restart Docker Desktop

#docker container top #process list in on container
#docker container inspect #details of one container config
#docker container stats #performance stats for all container

#docker container run -it #start new container interactively
#docker container exec -it #run additional command in existing container
docker container run -it --name proxy nginx bash
#exit will stop the container

docker container run -it --name ubuntu ubuntu #ubuntu server bash (default)
apt-get update
apt-get install -y curl
curl google.com
exit #will stop the container

docker container start -ai ubuntu #--attach and --interactive the one with curl installed

docker container exec -it mysql bash #run bash of the existing container
exit #will NOT stop the container mysql 

docker pull alpine #light ubuntu
docker image ls
docker container run -it alpine bash #cause error due to no bash in it 
docker container run -it alpine sh #works due to shell included, apk is the program manage
apk 


