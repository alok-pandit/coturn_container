FROM ubuntu:20.04

RUN apt update && apt install -y sqlite3 && apt install -y coturn && apt install iproute2 -y && apt install -y dnsutils && apt clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV TURN_PORT 3478
ENV TURN_PORT_START 49153
ENV TURN_PORT_END 65535
ENV TURN_SERVER_NAME coturn
ENV TURN_REALM com.2waay
# -d -p 3478:3478 -p 3478:3478/udp -p 10000-11000:10000-11000/udp --network=host
ADD init_coturn.sh init_coturn.sh
RUN chmod +x init_coturn.sh

CMD ["./init_coturn.sh"]