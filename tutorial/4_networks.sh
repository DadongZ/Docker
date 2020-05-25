##Docker Networks
#under same network, containers are connected to talk each other such as network "my_api" for mongo and nodejs containers
#make new virtual networks
#attach containers to more than one virtual network.
#skip virtual networks and use host IP (--net=host)
#use different docker networks drivers to gain new abilities
#docker container run -p
docker container run -p 80:80 --name webhost -d nginx #(host:container)
docker container port webhost
docker container inspect --format '{{ .NetworkSettings.IPAddress }}' webhost
ifconfig wifi0 

#docker networks: CLI management
docker network ls 
#1. bridge is the default for docker; 
#2. host gains performance by skpping virtual networks but sacrifices security of containers.
#3. none removes eth0 and only leaves you with localhost interface in container. not attached anything.
docker network inspect bridge
docker netwrok create my_app_net #(default driver is bridge)
docker container run -d --name new_nginx  --network my_app_net nginx
docker network inspect my_app_net
docker network connect 99987486e5ec f292f5b91417 #connect container f292f5b91417 to Network 99987486e5ec
docker network connect my_app_net webhost
docker container inspect webhost
docker network disconnect my_app_net webhost

#docker Networks: DNS
#static IP's and using IP's for talking to containers is an anti-pattern. Do you best to avoid it.
#docker daemon has a built-in DNS server that containers use by default
docker network inspect my_app_net
#create a new containers in network my_app_net
docker container run -d --name my_nginx --network my_app_net nginx
docker container exct -it my_nginx ping new_nginx
docker container exct -it new_nginx ping my_nginx
docker container create --link #(manual link between containers in the default bridge network) # better alternative is to create new networks

#assignment
docker container run --rm --it centos:7 bash #--rm clean up


