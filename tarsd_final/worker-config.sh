#!/bin/bash

#dando join na master como um worker
cd TARSD\FINAL/containerClient
chmod +x /vagrant/token.sh
bash /vagrant/token.sh

#PROMETHEUS
#Criar a nova imagem prometheus usando o Dockerfile e iniciar o container Prometheus
sudo docker build -t my-prometheus
sudo docker run -p 9090:9090 --restart=always --detach=true --name=prometheus my-prometheus

#iniciar os containers contendo os exporters: node-exporter e cadvisor.
sudo docker run -d --restart=always --net="host" --pid="host" --publish=9100:9100 --detach=true --name=node-exporter -v "/:/host:ro,rslave" quay.io/prometheus/node-exporter --path.rootfs /host
sudo docker run --restart=always --volume=/:/rootfs:ro --volume=/var/run:/var/run:ro --volume=/sys:/sys:ro --volume=/var/lib/docker/:/var/lib/docker:ro --volume=/dev/disk/:/dev/disk:ro --publish=8080:8080 --detach=true --name=cadvisor google/cadvisor:latest
