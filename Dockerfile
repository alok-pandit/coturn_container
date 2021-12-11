FROM ubuntu:18.04

RUN apt-get update && apt-get install -y coturn && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV TURN_PORT 3478
ENV TURN_PORT_START 32769
ENV TURN_PORT_END 65535
ENV TURN_SECRET mysecret
ENV TURN_SERVER_NAME coturn
# ENV TURN_REALM com.2waay
# -d -p 3478:3478 -p 3478:3478/udp -p 32769-65535:32769-65535/udp --network=host
ADD init_coturn.sh init_coturn.sh
RUN chmod +x init_coturn.sh

CMD ["./init_coturn.sh"]