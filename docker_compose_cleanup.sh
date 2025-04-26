#!/bin/bash

echo "Starting full Docker Compose project cleanup process..."

# Check if the docker-compose.yml file exists
if [ ! -f "docker-compose.yml" ]; then
    echo "Error: docker-compose.yml file not found in the current directory."
    exit 1
fi

# Function: Execute a command and continue even if it fails
run_command() {
    echo "Executing: $1"
    $1 || echo "Warning: Command '$1' failed, but continuing script execution."
}

# Stop and remove all containers
run_command "docker compose down --remove-orphans"

# Remove project-related volumes
run_command "docker compose down -v"

# Remove images used by the project
run_command "docker compose down --rmi all"

# Delete mapped data directories on the host
echo "Deleting mapped data directories on the host..."
data_dirs=$(grep -E '^\s*-\s*\./.+:/.*' docker-compose.yml | awk '{print $2}' | cut -d':' -f1)
for dir in $data_dirs; do
    if [ -d "$dir" ]; then
        echo "Deleting directory: $dir"
        run_command "rm -rf $dir"
    fi
done

# Special handling for the ./data directory
if [ -d "./data" ]; then
    echo "Deleting ./data directory"
    run_command "rm -rf ./data"
fi

echo "Checking for any remaining project resources..."
echo "Project containers:"
docker-compose ps
echo "Project volumes:"
docker volume ls --filter name=$(basename $(pwd))
echo "Project networks:"
docker network ls --filter name=$(basename $(pwd))

echo "Cleanup complete."
echo "Warning: This script has deleted local data directories defined in docker-compose.yml. Please ensure you no longer need these data."
echo "If any resources remain, you may need to manually remove them."
echo "Note: If errors occur during cleanup, it may be due to configuration issues in the docker-compose.yml file."
echo "Please review and fix any configuration errors in the docker-compose.yml file."
