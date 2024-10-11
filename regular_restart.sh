# ===================================公共模块===监控screen模块======================================================================
cd ~
echo '#!/bin/bash
while true
do
  cd ~/ocean
  docker_id=$(docker ps | grep "ocean-node" | awk "{print $1}")
  docker stop $docker_id
  docker rm $docker_id
  docker-compose up -d
  sleep 86400
done' > regular_ocean.sh
##给予执行权限
chmod +x regular_ocean.sh
# ================================================================================================================================
echo ' [Unit]
Description=Restart Ocean Docker Containers Service
After=network.target

[Service]
Type=simple
ExecStart=/bin/bash /root/regular_ocean.sh

[Install]
WantedBy=multi-user.target' > /etc/systemd/system/ocean-restart.service
sudo systemctl daemon-reload
sudo systemctl enable ocean-restart.service
sudo systemctl start ocean-restart.service
echo '==flag:v2===='
rm -f regular_restart.sh
# ================================================flag:v2=====================================================================================
# echo '[Unit]
# Description=Timer for restarting Ocean Docker containers every 24 hours

# [Timer]
# OnCalendar=*:0/1
# Persistent=true

# [Install]
# WantedBy=timers.target' > /etc/systemd/system/ocean-restart.timer
# sudo systemctl start ocean-restart.timer
# sudo systemctl enable ocean-restart.timer
