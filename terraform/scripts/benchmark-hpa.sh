#!/bin/bash

# Variables
URL="http://<your-domain-name>/"
REQUESTS=1000
CONCURRENCY=20

# Ensure HPA exists
if ! kubectl get hpa hello-world-hpa &> /dev/null; then
    echo "HPA not found. Please apply the HPA manifest first (hpa.yml)."
    exit 1
fi

# Ensure the service is accessible
if ! curl -s --head --request GET $URL | grep "200 OK" > /dev/null; then
    echo "Application endpoint $URL is not accessible. Ensure the service is running."
    exit 1
fi

# Run Apache Bench
echo "Starting load test on $URL with $REQUESTS requests and $CONCURRENCY concurrency..."
ab -n $REQUESTS -c $CONCURRENCY $URL
