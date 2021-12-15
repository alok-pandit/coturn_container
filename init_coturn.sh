#!/bin/bash
internalIp="$(ip a | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')"
externalIp="$(dig +short myip.opendns.com @resolver1.opendns.com)"

echo "listening-port=3478
# listening-ip="$internalIp"
# relay-ip="$internalIp"
# external-ip="$externalIp/$internalIp"
stale-nonce=600
no-sslv2
no-sslv3
no-tlsv1
no-tlsv1_1
no-tlsv1_2
proc-group=turnserver
proc-user=turnserver
mobility
max-allocate-timeout=180
no-dtls
no-tls
no-cli
cli-password=2waay@1234
lt-cred-mech
user=2waay:2waay@1234
userdb=/usr/local/etc/turnuserdb.conf
verbose
Verbose"  | tee /etc/turnserver.conf

# turnadmin -a

echo "Starting TURN/STUN server"

sudo turnserver -a -v -L 0.0.0.0 --server-name "${TURN_SERVER_NAME}" --realm=${TURN_REALM} --min-port ${TURN_PORT_START} --max-port ${TURN_PORT_END}
