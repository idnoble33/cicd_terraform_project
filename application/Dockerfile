# FROM python:3.9-slim
# # Set the working directory inside the container
# WORKDIR /app

# # Copy requirements file and install dependencies
# COPY requirements.txt .

# # Install Flask (or any dependencies you need)
# RUN pip install --no-cache-dir -r requirements.txt

# # Copy the application files into the container
# COPY . .

# # Expose the port the app runs on
# EXPOSE 5000

# # Command to run the application
# CMD ["python", "app.py"]
# Use the official Python image as the base
FROM python:3.9-slim

# Set environment variables to suppress interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Set the working directory
WORKDIR /app

# Install dependencies (curl, apt, Docker, Azure CLI)
RUN apt-get update && apt-get install -y \
    ca-certificates \
    curl \
    apt-transport-https \
    lsb-release \
    gnupg \
    docker.io \
    && rm -rf /var/lib/apt/lists/*

# Install Azure CLI
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application files
COPY . .

# Expose the Flask application port
EXPOSE 5000

# Command to run the application
CMD ["python", "app.py"]
