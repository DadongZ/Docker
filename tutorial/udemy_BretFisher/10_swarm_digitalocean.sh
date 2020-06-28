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

# 70 Swarm stacks
## stacks accept compose files as their declarative definition for services, networks and volumes
## use docker stack deploy NOT create/build
## n_services x i_tasks
## /mnt/d/github/Docker/tutorial/udemy-docker-mastery/swarm-stack-1
root@node1:/srv# docker stack deploy -c example-voting-app-stack.yml voteapp
## Creating service voteapp_db
## Creating service voteapp_vote
## Creating service voteapp_result
## Creating service voteapp_worker
## Creating service voteapp_visualizer
## Creating service voteapp_redis

root@node1:/srv# docker stack ps voteapp
## ID                  NAME                   IMAGE                                       NODE                DESIRED STATE       CURRENT STATE                ERROR               PORTS
## j31lpe2x70b7        voteapp_redis.1        redis:alpine                                node2               Running             Running about a minute ago
## kk11o86ldufh        voteapp_visualizer.1   dockersamples/visualizer:latest             node3               Running             Running about a minute ago
## i9dq9tujoerc        voteapp_worker.1       bretfisher/examplevotingapp_worker:java     node2               Running             Running about a minute ago
## 03kgd3zre8pu        voteapp_result.1       bretfisher/examplevotingapp_result:latest   node1               Running             Running about a minute ago
## g5ibw521dyfu        voteapp_vote.1         bretfisher/examplevotingapp_vote:latest     node3               Running             Running 2 minutes ago
## qnb4fvci4zxw        voteapp_db.1           postgres:9.4                                node2               Running             Running about a minute ago
## id80tlfhq7a9        voteapp_vote.2         bretfisher/examplevotingapp_vote:latest     node1               Running             Running 2 minutes ago

root@node1:/srv# docker stack services voteapp
## ID                  NAME                 MODE                REPLICAS            IMAGE                                       PORTS
## fm4irby67kps        voteapp_visualizer   replicated          1/1                 dockersamples/visualizer:latest             *:8080->8080/tcp
## k7p2wwecvtnj        voteapp_db           replicated          1/1                 postgres:9.4
## ocz86otoy7f8        voteapp_redis        replicated          1/1                 redis:alpine                                *:30000->6379/tcp
## r34f0820ea9f        voteapp_result       replicated          1/1                 bretfisher/examplevotingapp_result:latest   *:5001->80/tcp
## v7q0el7u7f8k        voteapp_worker       replicated          1/1                 bretfisher/examplevotingapp_worker:java
## yehms05l36nf        voteapp_vote         replicated          2/2                 bretfisher/examplevotingapp_vote:latest     *:5000->80/tcp

## http://192.81.209.233:5000/
## http://192.81.209.233:5001/
## http://192.81.209.233:8080/
## 

# 71 Secrets storage (key value store)
## only stored on disk on manager nodes
## secrets firest stored in swarm then assigned to a service(s)
## only containers in assigned services can see them
## /run/secrets/<secrets_name>
## /run/secrets/<secrets_alias>
## local docker-compose can use file-based secrets but not secure
root@node1:/srv/secrets-sample-1# docker secret create psql_user psql_user.txt                                   
## 829bqluly8o3oyaupysonixlx
root@node1:/srv/secrets-sample-1# echo "myDBpassWORD" | docker secret create psql_pass -                         
## uklvvq0rz7zakq1i9avbat45t                                                                                        
root@node1:/srv/secrets-sample-1# docker secret ls                                                               
## ID                          NAME                DRIVER              CREATED              UPDATED                 
## uklvvq0rz7zakq1i9avbat45t   psql_pass                               About a minute ago   About a minute ago      
## 829bqluly8o3oyaupysonixlx   psql_user

root@node1:/srv/secrets-sample-1# docker secret inspect psql_user                                                
## [
## {
##             "ID": "829bqluly8o3oyaupysonixlx",
##             "Version": {
##                         "Index": 1263
##                                 
##         },
##             "CreatedAt": "2020-06-13T14:37:53.271230017Z",
##                     "UpdatedAt": "2020-06-13T14:37:53.271230017Z",
##                     "Spec": {
##                                 "Name": "psql_user",
##                                             "Labels": {}
##                                                     
##                 }
##                 
## }
root@node1:/srv/secrets-sample-1# docker service create --name psql --secret psql_user --secret psql_pass -e POSTGRES_PASSWORD_FILE=/run/secrets/psql_pass -e POSTGRES_USER_FILE=/run/secrets/psql_user postgres
## ynp47fftmtj76ifzgcxza5dar
## overall progress: 1 out of 1 tasks
## 1/1: running   [==================================================>]
## verify: Service converged
## ]

root@node1:/srv/secrets-sample-2# docker stack deploy -c docker-compose.yml mydb
## Creating network mydb_default
## Creating secret mydb_psql_password
## Creating secret mydb_psql_user
## Creating service mydb_psql
root@node1:/srv/secrets-sample-2# docker secret ls
## ID                          NAME                 DRIVER              CREATED              UPDATED
## 8zssqtgd77ub686sixe8pmhdg   mydb_psql_password                       About a minute ago   About a minute ago
## dvu3atuw78jthyn0jw0cns2mt   mydb_psql_user                           About a minute ago   About a minute ago
root@node1:/srv/secrets-sample-2# docker stack rm mydb
## Removing service mydb_psql
## Removing secret mydb_psql_password
## Removing secret mydb_psql_user
## Removing network mydb_default

# assignment: root@node1:/srv/secrets-assignment-1# ./run.sh
 












