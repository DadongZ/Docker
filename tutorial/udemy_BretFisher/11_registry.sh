# Docker registry

## a private image registry for your network
## part of the docker/distribution github repo
## storage supports local, S3/Azure/Alibaba/Google/Openstack Swift.
## secure registry with Transport Layer Security (TLS)
## storage cleanup via garbage collection

########
## run the registry image on default port 5000
$ docker run -d -p 5000:5000 --restart=always --name registry registry:2
$ docker container ls -a
## CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                    NAMES
## dcaed0ba308f        registry            "/entrypoint.sh /etc…"   3 minutes ago       Created             0.0.0.0:5000->5000/tcp   registry
$ docker pull hello-world
$ cat /etc/hosts
$ cat /.docker/config
## {
##       "registry-mirrors": [],
##         "insecure-registries": ["127.0.0.1:5000"],
##           "debug": true,
##             "experimental": false
##             
## }
$ docker tag hello-world:latest 127.0.0.1:5000/hello-world
## push to localhost
$ docker push 127.0.0.1:5000/hello-world
$ docker image rm 127.0.0.1:5000/hello-world:latest
$ docker image pull 127.0.0.1:5000/hello-world
$ docker container kill registry
$ docker container rm registry

## volume
bridlebit@Zhang_family-PC:/mnt/d/github/Docker/tutorial/udemy-docker-mastery/registry-sample-1$ docker container run -d -p 5000:5000 --name registry -v $(pwd)/registry-data:/var/lib/registry registry
bridlebit@Zhang_family-PC:/mnt/d/github/Docker/tutorial/udemy-docker-mastery/registry-sample-1/registry-data$ docker push 127.0.0.1:5000/hello-orld
bridlebit@Zhang_family-PC:/mnt/d/github/Docker/tutorial/udemy-docker-mastery/registry-sample-1$ ll registry-data/
## drwxrwxrwx 1 bridlebit bridlebit 4096 Jun 14 19:48 ./
## drwxrwxrwx 1 bridlebit bridlebit 4096 May 23 12:16 ../
## drwxr-xr-x 1 root      root      4096 Jun 14 19:48 docker/


# docker swarm registry
## https://labs.play-with-docker.com
## 5 manager 0 worker
[manager1] (local) root@192.168.0.17 ~
$ docker node ls
## ID                            HOSTNAME            STATUS              AVAILABILITY        MANAGER STATUS      ENGINE VERSION
## dw7p5u8t5fqi0ecwrgwd0vxrq *   manager1            Ready               Active              Leader              19.03.11
## odh8azzqgkt2yerguub9oz9el     manager2            Ready               Active              Reachable           19.03.11
## x8ypaqbuyek0e3gqlo75n69u5     manager3            Ready               Active              Reachable           19.03.11
## 2mrw6u9jemrp5m24n791pth05     manager4            Ready               Active              Reachable           19.03.11
## ald0he79ty2c4eeoqokaprm2j     manager5            Ready               Active              Reachable           19.03.11

$ docker service create --name registry --publish 5000:5000 registry:2
$ docker service ps registry 
$ docker pull hello-world
$ docker tag hello-world:latest 127.0.0.1:5000/hello-world
$ docker push 127.0.0.1:5000/hello-world

## http://ip172-18-0-4-brjbi6roudsg008vemo0-5000.direct.labs.play-with-docker.com/v2/_catalog
## {"repositories":["hello-world"]}
$ docker pull nginx
$ docker tag nginx:latest 127.0.0.1:5000/nginx
$ docker push 127.0.0.1:5000/nginx
## {"repositories":["hello-world","nginx"]}
$ docker service create --name nginx -p 80:80 --replicas 5 --detach=false 127.0.0.1:5000/nginx
## xe8w10fmeqbgvl3p2eutaq7rr
## overall progress: 5 out of 5 tasks 
## 1/5: running   [==================================================>] 
## 2/5: running   [==================================================>] 
## 3/5: running   [==================================================>] 
## 4/5: running   [==================================================>] 
## 5/5: running   [==================================================>] 
## verify: Service converged 
$ docker service ps nginx
## ID                  NAME                IMAGE                         NODE                DESIRED STATE       CURRENT STATE           ERROR               PORTS
## pjxvm4dzztvk        nginx.1             127.0.0.1:5000/nginx:latest   manager1            Running             Running 2 minutes ago                       
## 1n67tb9h5q0i        nginx.2             127.0.0.1:5000/nginx:latest   manager4            Running             Running 2 minutes ago                       
## f30x6n12hkkn        nginx.3             127.0.0.1:5000/nginx:latest   manager3            Running             Running 2 minutes ago                       
## aew3sv4plx2o        nginx.4             127.0.0.1:5000/nginx:latest   manager2            Running             Running 2 minutes ago                       
## qb00xlqkpc43        nginx.5             127.0.0.1:5000/nginx:latest   manager5            Running             Running 2 minutes ago 









































