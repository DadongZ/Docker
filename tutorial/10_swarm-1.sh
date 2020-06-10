#Swarm is a server clustering solution that bring togetther different operating systemes or hosts.
#Swarm mode is a clustering solution built inside Docker
#orchestrate the lifecycle of containers in.
#docker service can have multiple tasks an each one of those taks will launch a container.
#docker service create -> manager node (API/Orchestrator/Allocator/Scheduler/Dispatcher) -> worker node (worker/executor)

#application Programming Interface (API)
#command-line interface (CLI)
#PKI (or Public Key Infrastructure)
#Transport Layer Security (TLS)
#Secure Sockets Layer (SSL)

docker info #check Swarm active or inactive
docker swarm init
#Swarm initialized: current node (z79zexw8lqh4hrez8f388l1sv) is now a manager.
#To add a worker to this swarm, run the following command:
#docker swarm join --token SWMTKN-1-5i8ewfyy08r1tyd5qslwue15ucqmclp83zn6lfsgk68bmh5rri-30qba65st8nlls2mt65jb5jks 172.22.220.185:2377
#To add a manager to this swarm, run 'docker swarm join-token manager' and follow the instructions.

# lots of PKI and security automation
## root signing certificate created for our swarm
## certificate is issued for first manager node
## join tokens are created
# Raft database created to store root CA, configs and secrets
## Encrypted by default on disk
## no need for another key/value system to hold orchestration/secrets
## replicates logs amongst managers via mutual TLS in "control plane"

docker node ls
#ID                            HOSTNAME            STATUS              AVAILABILITY        MANAGER STATUS      ENGINE VERSION
#z79zexw8lqh4hrez8f388l1sv *   Zhang_family-PC     Ready               Active              Leader              19.03.11

docker service --help

docker service create alpine ping 8.8.8.8
#umi2ck7qknr2yl0h07gvgmyx2 #service id
#overall progress: 1 out of 1 tasks
#1/1: running   [==================================================>]
docker service ls
#ID                  NAME                MODE                REPLICAS            IMAGE               PORTS
#umi2ck7qknr2        beautiful_jones     replicated          1/1                 alpine:latest
docker service ps beautiful_jones
#ID                  NAME                IMAGE               NODE                DESIRED STATE       CURRENT STATE           ERROR               PORTS
#7qgxkaouz10d        beautiful_jones.1   alpine:latest       Zhang_family-PC     Running             Running 2 minutes ago

docker container ls
#CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
#330eae7171d4        alpine:latest       "ping 8.8.8.8"      4 minutes ago       Up 4 minutes                            beautiful_jones.1.7qgxkaouz10dpayp9f9wrpxl2

docker service update umi2ck7qknr2 --replicas 3
#umi2ck7qknr2
#overall progress: 3 out of 3 tasks
#1/3: running   [==================================================>]
#2/3: running   [==================================================>]
#3/3: running   [==================================================>]
docker service ls 
#ID                  NAME                MODE                REPLICAS            IMAGE               PORTS
#umi2ck7qknr2        beautiful_jones     replicated          3/3                 alpine:latest

#3 tasks
docker service ps beautiful_jones
#ID                  NAME                IMAGE               NODE                DESIRED STATE       CURRENT STATE                ERROR               PORTS
#7qgxkaouz10d        beautiful_jones.1   alpine:latest       Zhang_family-PC     Running             Running 8 minutes ago
#xbsro9v8wa01        beautiful_jones.2   alpine:latest       Zhang_family-PC     Running             Running about a minute ago
#5mlvx1aauavu        beautiful_jones.3   alpine:latest       Zhang_family-PC     Running             Running about a minute ago

docker update --help
docker service update --help

docker container ls
#CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
#fad933f59f1d        alpine:latest       "ping 8.8.8.8"      4 minutes ago       Up 4 minutes                            beautiful_jones.2.xbsro9v8wa01g12augmi1m3ms
#c3673b5f82b4        alpine:latest       "ping 8.8.8.8"      4 minutes ago       Up 4 minutes                            beautiful_jones.3.5mlvx1aauavu73cr6v6w2t8m8
#330eae7171d4        alpine:latest       "ping 8.8.8.8"      11 minutes ago      Up 11 minutes                           beautiful_jones.1.7qgxkaouz10dpayp9f9wrpxl2
docker container rm -f beautiful_jones.1.7qgxkaouz10dpayp9f9wrpxl2
#docker service ps beautiful_jones
#ID                  NAME                    IMAGE               NODE                DESIRED STATE       CURRENT STATE            ERROR                         PORTS
#2dsuzybce5tr        beautiful_jones.1       alpine:latest       Zhang_family-PC     Running             Running 34 seconds ago                             
#ruwh85brv8z0         \_ beautiful_jones.1   alpine:latest       Zhang_family-PC     Shutdown            Failed 41 seconds ago    "task: non-zero exit (137)"
#7qgxkaouz10d         \_ beautiful_jones.1   alpine:latest       Zhang_family-PC     Shutdown            Failed 2 minutes ago     "task: non-zero exit (137)"
#xbsro9v8wa01        beautiful_jones.2       alpine:latest       Zhang_family-PC     Running             Running 8 minutes ago                              
#5mlvx1aauavu        beautiful_jones.3       alpine:latest       Zhang_family-PC     Running             Running 8 minutes ago 

#if one failed and will start a new one and keep 3 taks running 
docker service rm beautiful_jones
docker container ls
#CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
