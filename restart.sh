cd ocean
sed -i "s/ALLOWED_ADMINS:.*$/ALLOWED_ADMINS: '[\"123456\"]'/" docker-compose.yml
sed -i "s/PRIVATE_KEY:.*$/PRIVATE_KEY: '123456'/" docker-compose.yml
docker stop $(docker ps -aq)
docker rm $(docker ps -aq)
