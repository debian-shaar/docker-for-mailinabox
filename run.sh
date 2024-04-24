chmod +x install.sh
systemctl disable --now postfix exit
docker system prune -a
time docker compose up -d
docker exec -it maib "./install.sh"
