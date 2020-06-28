docker build . --force-rm -t ddzhangzz/rclone
docker system prune
docker container run ddzhangzz/rclone rclone --version
