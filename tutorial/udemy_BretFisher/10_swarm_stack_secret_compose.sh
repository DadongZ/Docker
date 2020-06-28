# 77 Dev, build and deploy with a single compose design

## /mnt/d/github/Docker/tutorial/udemy-docker-mastery/swarm-stack-3/
docker-compose up -d
docker inspect swarm-stack-3_drupal_1
docker-compose down
docker-compose -f docker-compose.yml -f docker-compose.test.yml up -d

docker-compose -f docker-compose.yml -f docker-compose.prud.yml config > output.yml

docker-compose -f a.yml -f b.yml config

# service updates
## just update the image used to a newer version
docker service update --image myapp:1.2.1 <servicename>
## adding an environment variable and remove a port
docker service update --evn-add NODE_ENV=production --publish-rm 8080
## change number of replicas of two services
docker service scale web=8 api=6

## same command. just edit the YAML file then
docker stack deploy -c file.yml <stackname>
##no swarm init and nodes local, so run on node1
##
root@node1:~# docker service create -p 8088:80 --name web nginx:1.13.7
## 2hfjoyp8irz4wbtc98aqz28kb
## overall progress: 1 out of 1 tasks
## 1/1: running   [==================================================>]
## verify: Service converged

root@node1:~# docker service ls
## ID                  NAME                MODE                REPLICAS            IMAGE               PORTS
## 2hfjoyp8irz4        web                 replicated          1/1                 nginx:1.13.7        *:8088->80/tcp

## scale up
root@node1:~# docker service scale web=5
## web scaled to 5
## overall progress: 5 out of 5 tasks
## 1/5: running   [==================================================>]
## 2/5: running   [==================================================>]
## 3/5: running   [==================================================>]
## 4/5: running   [==================================================>]
## 5/5: running   [==================================================>]
## verify: Service converged

## update nginx version
root@node1:~# docker service update --image nginx:1.13.6 web
## web
## overall progress: 5 out of 5 tasks
## 1/5: running   [==================================================>]
## 2/5: running   [==================================================>]
## 3/5: running   [==================================================>]
## 4/5: running   [==================================================>]
## 5/5: running   [==================================================>]

## change port
root@node1:~# docker service update --publish-rm 8088 --publish-add 9090:80 web
## web
## overall progress: 5 out of 5 tasks
## 1/5: running   [==================================================>]
## 2/5: running   [==================================================>]
## 3/5: running   [==================================================>]
## 4/5: running   [==================================================>]
## 5/5: running   [==================================================>]
## verify: Service converged

##rebalancing
root@node1:~# docker service update --force web
## web
## overall progress: 5 out of 5 tasks
## 1/5: running   [==================================================>]
## 2/5: running   [==================================================>]
## 3/5: running   [==================================================>]
## 4/5: running   [==================================================>]
## 5/5: running   [==================================================>]
## verify: Service converged

docker service rm web
