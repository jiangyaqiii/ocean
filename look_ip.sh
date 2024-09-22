ip=$(curl -s4 ifconfig.me/ip)
echo 'http://$ip:8000/dashboard/'
