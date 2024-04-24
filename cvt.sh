docker cp cvt.conf maib:/etc/nginx/conf.d/
docker exec -it maib systemctl restart nginx
