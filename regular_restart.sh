# ===================================公共模块===监控screen模块======================================================================
cd ~
echo '#!/bin/bash
cd ~/ocean
docker_id=$(docker ps | grep "ocean-node" | awk "{print $1}")
docker stop $docker_id
docker rm $docker_id
docker-compose up -d
' > regular.sh
##给予执行权限
chmod +x regular.sh
# ================================================================================================================================
echo ' [Unit]
Description=Restart Ocean Docker Containers Service
After=network.target

[Service]
Type=oneshot
ExecStart=/bin/bash /root/regular.sh
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target' > /etc/systemd/system/ocean-restart.service
sudo systemctl daemon-reload
sudo systemctl enable ocean-restart.service
sudo systemctl start ocean-restart.service
sudo systemctl status ocean-restart.service
# ================================================================================================================================
# echo '[Unit]
# Description=Timer for restarting Ocean Docker containers every 24 hours

# [Timer]
# OnCalendar=*:0/1
# Persistent=true

# [Install]
# WantedBy=timers.target' > /etc/systemd/system/ocean-restart.timer
# sudo systemctl start ocean-restart.timer
# sudo systemctl enable ocean-restart.timer
