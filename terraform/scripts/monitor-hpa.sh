#!/bin/bash

# Ensure HPA exists
if ! kubectl get hpa hello-world-hpa &> /dev/null; then
    echo "HPA not found. Please apply the HPA manifest first (hpa.yml)."
    exit 1
fi

# Monitor HPA
echo "Monitoring HPA Status..."
kubectl get hpa -w &
kubectl get pods -l app=hello-world -w
