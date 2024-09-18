cd ocean

sed -i "s/ALLOWED_ADMINS:.*$/ALLOWED_ADMINS: '[\"$allowed_admins\"]'/" docker-compose.yml
sed -i "s/PRIVATE_KEY:.*$/PRIVATE_KEY: '$private_key'/" docker-compose.yml
docker stop $(docker ps -aq)
docker rm $(docker ps -aq)
docker-compose up -d

echo "节点重启完成！"

cd
rm restart.sh
