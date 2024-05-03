#!/bin/bash

#command line arguments
# $1 is the container name
# $2 is the checkpoint directory name

#set the destination IP and port of the vm 
DestHostIP=10.96.11.198
DestVMPort=2222

# Define the commands
#command1="sudo docker run --security-opt=seccomp:unconfined --name $1 -d alpine:3.18 /bin/sh -c 'i=0; while true; do echo \$i; i=\$(expr \$i + 1); sleep 1; done'"
command1="sudo docker run --security-opt=seccomp:unconfined --name $1 -d -v $(pwd)/processes.sh:/processes.sh ubuntu:16.04 /bin/sh -c '/processes.sh'"

command2="sudo docker logs $1"

# Execute the first command in the background
echo -e "Executing command 1..."
eval "$command1" 


# Replace [container_name] with the value of $1 in run.sh
sed -i "s/\[container_name\]/$1/g" run.sh


#Send the run.sh script to Destination to start docker
#scp -r run.sh "vedant@$DestHostIP:~/"
scp -r -P $DestVMPort run.sh processes.sh "vedant@$DestHostIP:~/"

# Wait for a moment to ensure the container is running
sleep 10

# Execute the second command
echo -e  "Executing command 2..."
eval "$command2"

# Handle the interrupt signal (Ctrl+C)
trap ctrl_c INT

function ctrl_c() {
    echo -e  "Ctrl+C pressed. Exiting..."
    exit 1
}


#Send the run.sh script to Destination to start docker
#scp -r run.sh "vedant@$DestHostIP:~/"
#scp -r -P $DestVMPort run.sh "vedant@$DestHostIP:~/"

# Start time before creating the checkpoint
migrate_start_time=$(date +%s.%N)

#Create checkpoint
sudo docker checkpoint create --checkpoint-dir=/home/ravi --leave-running=false $1 $2
echo -e "Checkpoint created!"

# Start time before creating the checkpoint
down_start_time=$(date +%s.%N)

#send the checkpoint directory to the destination
#sudo scp -r "/home/ravi/$2" "vedant@$DestHostIP:~/"
sudo scp -P $DestVMPort -r "/home/ravi/$2" "vedant@$DestHostIP:~/"
echo -e "Checkpoint transferred successfully..."

# Replace [container_name] with the value of $1 in restore.sh
sed -i "s/\[container_name\]/$1/g" restore.sh
# Replace [checkpoint_dir] with the value of $2 in run.sh
sed -i "s/\[checkpoint_dir\]/$2/g" restore.sh

#send the restore script to Destination
#sudo scp -r restore.sh "vedant@$DestHostIP:~/"
sudo scp -r -P $DestVMPort restore.sh "vedant@$DestHostIP:~/"

# Calculate the elapsed time after creating the checkpoint
end_time=$(date +%s.%N)

migration_time=$(echo "$end_time - $migrate_start_time"|bc)
down_time=$(echo "$end_time - $down_start_time"|bc)

echo -e "Migrating time1: $migration_time seconds"
echo -e "Down time: $down_time seconds"


# Replace $1 back to [container_name] in run.sh
sed -i "s/$1/\[container_name\]/g" run.sh

# Replace $2 back to [checkpoint_dir] in restore.sh
sed -i "s/$2/\[checkpoint_dir\]/g" restore.sh

# Replace $1 back to [container_name] in restore.sh
sed -i "s/$1/\[container_name\]/g" restore.sh

#sudo docker stop $1
sudo docker rm $1
#sudo rm -rf /home/ravi/$2
