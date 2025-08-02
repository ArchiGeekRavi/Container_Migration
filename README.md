# Live Docker Migration 

A comprehensive implementation of live container migration supporting both intra-device (between containers) and inter-device (cross-machine) migration with minimal downtime using CRIU (Checkpoint/Restore In Userspace).

## Features

- **Live Process Migration**: Seamless migration of running containers across different environments
- **Minimal Downtime**: Achieved service downtime of less than 2 seconds
- **State Preservation**: Maintains process state and resource usage during migration
- **Dual Migration Support**:
  - **Intra-device**: Between containers on the same machine
  - **Inter-device**: Across different machines/VMs
- **Low-level Control**: Direct integration with CRIU for checkpoint/restore operations

## Technologies Used

- **Docker**: Container runtime and management
- **CRIU**: Checkpoint/Restore In Userspace for process migration
- **Linux Namespaces**: Process isolation and resource management
- **Bash Scripting**: Automation and orchestration
- **Network Communication**: Cross-machine checkpoint transfer

## Prerequisites

- Linux-based system (Ubuntu/CentOS recommended)
- Root or sudo privileges
- Network connectivity between source and destination machines (for inter-device migration)
- Compatible kernel version with CRIU support

## Installation & Setup

### 1. Install Docker and Dependencies

```bash
./install_docker_17.04.0.sh
```

This script installs:
- Docker version 17.04.0 (required for experimental features)
- CRIU and its dependencies
- Required system libraries
- Development tools and headers

### 2. Enable Experimental Docker Features

```bash
./enable_experimental_docker.sh
```

This script:
- Configures Docker daemon for experimental features
- Sets up CRIU integration
- Fixes dependency issues
- Restarts Docker service with new configuration

## Usage

### Intra-device Migration (Same Machine)

```bash
# Run migration on source Container
./container_run.sh <container_name> <checkpoint_directory>

# Restore on same machine but dest Container
./container_receive.sh <checkpoint_directory>
```

### Inter-device Migration (Cross-machine)

```bash
# Run migration on source machine
./container_run.sh <container_name> <checkpoint_directory> <destination_ip> <destination_port> <destination_user>

# Run receiver on destination machine
./container_receive.sh <checkpoint_directory>
```

### Script Parameters

#### `container_run.sh`
- `$1`: Container name to migrate
- `$2`: Checkpoint directory name
- `$3`: Destination host IP address (for inter-device migration)
- `$4`: Destination VM/host port
- `$5`: Destination host username

#### `container_receive.sh`
- `$1`: Checkpoint directory containing the migration data

##  Project Structure

```
docker-migration/
├── install_docker_17.04.0.sh    # Installation script for Docker and dependencies
├── enable_experimental_docker.sh # Docker daemon configuration for CRIU
├── container_run.sh              # Source-side migration script
├── container_receive.sh          # Destination-side restoration script
└── README.md                     # This file
```

##  Authors

All authors contributed equally to this project.