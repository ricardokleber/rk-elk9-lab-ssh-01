#!/bin/bash

USER_FILE="logins.txt"
LOG_DEST="/var/log/auth.log"

gerar_ip() {
    echo "$((RANDOM%256)).$((RANDOM%256)).$((RANDOM%256)).$((RANDOM%256))"
}

QTD_LOGS=$1
HOSTNAME=$(hostname)

for i in $(seq 1 $QTD_LOGS); do
    IP_ORIGEM=$(gerar_ip)
    PORTA=$((RANDOM%55000 + 1024))
    PID=$((RANDOM%30000 + 1000))
    DATA=$(date "+%b %e %H:%M:%S")

    TIPO=$((RANDOM%2))

    if [ $TIPO -eq 0 ]; then
        USUARIO=$(shuf -n 1 "$USER_FILE")
        echo "$DATA $HOSTNAME sshd[$PID]: Invalid user $USUARIO from $IP_ORIGEM port $PORTA ssh2" >> "$LOG_DEST"
        echo "$DATA $HOSTNAME sshd[$PID]: Connection closed by authenticating user $USUARIO $IP_ORIGEM port $PORTA [preauth]" >> "$LOG_DEST"
    else
        echo "$DATA $HOSTNAME sshd[$PID]: pam_unix(sshd:auth): authentication failure; logname= uid=0 euid=0 tty=ssh ruser= rhost=$IP_ORIGEM  user=root" >> "$LOG_DEST"
        echo "$DATA $HOSTNAME sshd[$PID]: Failed password for root from $IP_ORIGEM port $PORTA ssh2" >> "$LOG_DEST"
    fi

    sleep 0.2
done

echo "Script Finalizado"
