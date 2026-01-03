#!/bin/bash
# Simple health check script for the TURN server

# Check if the TURN server process is running
if pgrep -x "turnserver" > /dev/null
then
    echo "TURN server is running"
    exit 0
else
    echo "TURN server is not running"
    exit 1
fi
