#!/bin/bash

# Function to check if a command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# FOR TESTING PURPOSE
brew install docker

# if command_exists brew; then
#   echo "Brew installation found..."
# else
#   echo "Brew is not installed. Please install Homebrew first."
#   exit 1
# fi

# # Install Docker if not installed
# if ! command_exists docker; then
#   echo "Docker is not installed..."
#   echo "Please install docker manually"
#   # Install Docker for macOS or Linux
#   if [[ "$OSTYPE" == "linux-gnu"* ]]; then
#     if command_exists brew; then
#       brew install docker
#     else
#       echo "Homebrew is not installed. Please install Homebrew first."
#       exit 1
#     fi
#   elif [[ "$OSTYPE" == "darwin"* ]]; then
#     brew install --cask docker
#   fi
# fi

# # Check if Docker is running, if not start it
# if ! docker info > /dev/null 2>&1; then
#   echo "Docker is not running. Starting Docker..."
  
#   if [[ "$OSTYPE" == "darwin"* ]]; then
#     # macOS: Open Docker Desktop
#     open /Applications/Docker.app
    
#     # Wait for Docker to start (max 20 tries)
#     # max_attempts=20
#     # attempt=1
#     # while ! docker ps > /dev/null 2>&1; do
#     #   if (( attempt > max_attempts )); then
#     #     echo "Docker did not start after $max_attempts attempts. Please check Docker manually."
#     #     echo "#EXIT_PROCESS"
#     #     exit 1
#     #   fi
#     #   echo "Waiting for Docker to start... (Attempt $attempt/$max_attempts)"
#     #   attempt=$(( attempt + 1 ))

#     # Default Wait time for starting docker.
#     sleep 15
#     # done
#     echo "Docker is now running."
  
#   elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
#     # Linux: Start Docker using systemd
#     sudo systemctl start docker
#     sudo systemctl enable docker
#   else
#     echo "Unsupported operating system: $OSTYPE"
#     exit 1
#   fi
# else
#   echo "Docker is already running."
# fi


# # Check if port 11411 is already in use
# if lsof -i:11411 >/dev/null 2>&1; then
#   echo "Port 11411 is already in use. Please free the port and try again."
#   exit 1
# fi

# #Installing ollama via command line..
# echo "Installing Ollama..."
# brew install ollama

# echo "#SHOW_INSTALL_BUTTON"

# # Set up the WebUI
# echo "Setting up WebUI..."
# docker run -d -p 3000:8080 --add-host=host.docker.internal:host-gateway -v open-webui:/app/backend/data --name open-webui --restart always ghcr.io/open-webui/open-webui:main || { echo "Failed to start WebUI container"; exit 1; }

# echo "All done! Ollama 3.1 is now running locally on port 11411, and the WebUI is available on port 3000."
