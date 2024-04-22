make down
docker container rm -vf $(docker ps -aq) 2>/dev/null
docker image rm -f $(docker image ls -aq) 2>/dev/null
docker volume rm -f $(docker volume ls -q) 2>/dev/null
docker system prune --volumes -af 2>/dev/null
sudo rm -rf ${HOME}/data 2>/dev/null
