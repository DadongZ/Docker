docker container run -d -p 3306:3306 --name -db --e MYSQL_RANDOM_ROOT_PASSWORD=yes mysql
docker container log db #looking for GENERATE ROOT PASSWORD
docker container run -d -p 8080:80 --name webserver httpd
docker container run -d -p 80:80 --name proxy nginx

docker ps
localhost:8080
localhost:80
localhost:3306

docker container stop 
docker container rm

