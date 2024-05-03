#sudo docker run --security-opt=seccomp:unconfined --name [container_name] -d alpine:3.18 /bin/sh -c 'i=0; while true; do echo $i; i=$(expr $i + 1); sleep 1; done'  && docker  stop [container_name]

sudo docker run --security-opt=seccomp:unconfined --name [container_name] -d -v $(pwd)/processes.sh:/processes.sh ubuntu:16.04 /bin/sh -c '/processes.sh ' && docker stop [container_name]
sudo su -c 'truncate -s 0 /var/lib/docker/containers/*/*-json.log'
#sudo docker checkpoint create --checkpoint-dir=/home/vedant/Downloads --leave-running=false [container_name] timepass3


#sudo docker checkpoint create --checkpoint-dir=$(mktemp -d) --leave-running=false [container_name] temp_checkpoint
#sudo rm -rf $(ls -d -t /tmp/*/ | head -n 1)

#if ps -p $$ > /dev/null; then
#	echo -e "Container  started"
#else
#	echo -e "Container  unable to start"
#fi
#sudo docker stop [container_name]
#sleep 1
sudo docker logs [container_name]
