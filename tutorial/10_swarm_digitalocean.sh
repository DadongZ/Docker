#node1
ssh root@192.81.209.233 
#node2
ssh root@192.241.147.32
#node3
ssh root@157.245.128.193


# 68 routing mesh: stateless load balancing which is at OSI Layer 3 (TCP), not layer 4 (DNS)
## https://docs.docker.com/engine/swarm/ingress/
## IPVS: IP Virtual Server
## VIP: virtual IP
## DNS: Domain Name System translates human readable domain names (for example, www.amazon.com) to machine readable IP addresses (for example, 192.0. 2.44).
## Round-robin (RR) is one of the algorithms employed by process and network schedulers in computing. 
### As the term is generally used, time slices (also known as time quanta) are assigned to each process
### in equal portions and in circular order, handling all processes without priority (also known as cyclic executive).

```
## example
root@node1:~# docker service create --name search --replicas 3 -p 9200:9200 elasticsearch:2
#wmhppudgmunux397c9fvmkujz
root@node1:~# docker service ps search
#ID                  NAME                IMAGE               NODE                DESIRED STATE       CURRENT STATE           ERROR               PORTS
#bah1safwyb7x        search.1            elasticsearch:2     node2               Running             Running 2 minutes ago
#eyvwlxuo3r02        search.2            elasticsearch:2     node1               Running             Running 2 minutes ago
#fw2kq7a3psce        search.3            elasticsearch:2     node3               Running             Running 2 minutes ago
root@node1:~# curl localhost:9200 #repeat..to see changes in name
#{
#    "name" : "Torgo the Vampire",
#    "cluster_name" : "elasticsearch",
#    "cluster_uuid" : "sfxpM2SDQ--7JQzlVivHMw",
#    "version" : {
#    "number" : "2.4.6",
#    "build_hash" : "5376dca9f70f3abef96a77f4bb22720ace8240fd",
#    "build_timestamp" : "2017-07-18T12:17:44Z",
#    "build_snapshot" : false,
#    "lucene_version" : "5.5.4"
#
#},
#"tagline" : "You Know, for Search"
#
#}

```

# 69: assignment
## ./udemy-docker-mastery/swarm-app-1

## create two networks: frontend and backend
docker network create --driver overlay frontend
docker network create --driver overlay backend

## services
docker service create --name vote --network frontend --replicas 3 -p 80:80 bretfisher/examplevotingapp_vote
docker service create --name redis --network frontend redis:3.2
docker service create --name worker --network frontend --network backend bretfisher/examplevotingapp_worker:java
docker service create --name db --network backend --mount type=volume,source=db-data,target=/var/lib/postgresql/data -e POSTGRES_HOST_AUTH_METHOD=trust postgres:9.4
docker service create --name result --network backend -p 5001:80 bretfisher/examplevotingapp_result
