FROM pihole/pihole:latest

RUN apt-get update -y && apt-get install -y unbound

COPY unbound.conf /etc/unbound/unbound.conf.d/unbound.conf

COPY start_system.sh start_system.sh

ENTRYPOINT ./start_system.sh
