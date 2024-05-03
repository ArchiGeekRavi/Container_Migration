#!/bin/bash

# Function to check if a file exists
file_exists() {
    if [ -e "$1" ]; then
        return 0
    else
        return 1
    fi
}

# Loop to wait for run.sh
while ! file_exists "run.sh"; do
    echo "Waiting for run.sh..."
    sleep 1  # Adjust the sleep duration as needed
done

# Start time before creating the checkpoint
run_start_time=$(date +%s.%N)


# Execute run.sh if found
chmod +x run.sh
sudo ./run.sh
# Calculate the elapsed time after creating the checkpoint
run_end_time=$(date +%s.%N)
run_time=$(echo "$run_end_time - $run_start_time"| bc) 



# Loop to wait for restore.sh
while ! file_exists "restore.sh"; do
    echo "Waiting for restore.sh..."
   # sleep 1  # Adjust the sleep duration as needed
done

# Start time before creating the checkpoint
start_time=$(date +%s.%N)

# Execute restore.sh if found
chmod +x restore.sh
sudo ./restore.sh

# Calculate the elapsed time after creating the checkpoint
end_time=$(date +%s.%N)
migration_time=$(echo "$end_time - $start_time"| bc) 

echo -e "run.sh time: $run_time seconds"
echo -e "Migration time2: $migration_time seconds"
