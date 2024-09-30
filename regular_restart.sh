# ===================================公共模块===监控screen模块======================================================================
echo "================flag:v1================"
cd ~
echo '#!/bin/bash
while true
do
    cd ~/ocean
    docker_id=$(docker ps | grep "ocean-node" | awk "{print $1}")
    docker stop $(docker ps -aq)
    docker rm $(docker ps -aq)
    docker-compose up -d
    sleep 86400  # 每隔10秒检查一次
done' > regular.sh
##给予执行权限
chmod +x regular.sh
# ================================================================================================================================
echo '[Unit]
Description=Ocean Monitor Service
After=network.target

[Service]
Type=simple
ExecStart=/bin/bash /root/regular.sh

[Install]
WantedBy=multi-user.target' > /etc/systemd/system/ocean_restart.service
sudo systemctl daemon-reload
sudo systemctl enable ocean_restart.service
sudo systemctl start ocean_restart.service
sudo systemctl status ocean_restart.service
