chmod +x processes.sh
sudo docker start --checkpoint [checkpoint_dir]  --checkpoint-dir=/home/vedant  [container_name]
echo -e "Container [container_name] successfully restored"

sleep 3 
sudo docker logs [container_name]

