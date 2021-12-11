#!/bin/bash
internalIp="$(ip a | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')"
externalIp="$(dig +short myip.opendns.com @resolver1.opendns.com)"

echo "listening-port=3478
tls-listening-port=5349
listening-ip="$internalIp"
relay-ip="$internalIp"
external-ip="$externalIp"
no-stdout-log"  | tee /etc/turnserver.conf

turnadmin -a

echo "Starting TURN/STUN server"

turnserver -a -v -L 0.0.0.0 --server-name "${TURN_SERVER_NAME}" --static-auth-secret="${TURN_SECRET}" -p ${TURN_PORT} --min-port ${TURN_PORT_START} --max-port ${TURN_PORT_END} ${TURN_EXTRA}
