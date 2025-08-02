dockerName=$1
checkpointDirName=$2

# rm -rf run.sh restore.sh processes.sh 
sudo docker stop $dockerName
sudo docker rm $dockerName
sudo rm -rf checkpointDirName
