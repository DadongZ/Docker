#pull mysql

#docker pull mysql

#inspect

#docker image inspect mysql

#"Volumes": {
#                "/var/lib/mysql": {}
#                            
#},

docker container run -d --name mysql -e MYSQL_ALLOW-EMPTY_PASSWORD=True mysql

docker container ls

docker container inspect mysql
#"Mounts": [
#{
#    "Type": "volume",
#    "Name": "1c8b2729f9fe7fee216cdf81185843baee1f6ae3d0179bb765d7683f0dcb325a",
#    "Source": "/var/lib/docker/volumes/1c8b2729f9fe7fee216cdf81185843baee1f6ae3d0179bb765d7683f0dcb325a/_data",   #data on host
#    "Destination": "/var/lib/mysql",                                                                              #data on container
#    "Driver": "local",
#    "Mode": "",
#    "RW": true,
#    "Propagation": ""
#
#}
#"Volumes": {
#"/var/lib/mysql": {}
#}

docker volume ls

#-v vlumename:location
docker container run -d --name mysql -e MYSQL_ALLOW-EMPTY_PASSWORD=True -v mysql-db:/var/lib/mysql mysql
