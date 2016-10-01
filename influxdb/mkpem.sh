#!/bin/sh
mkdir -p ssl
cd ssl

#openssl genrsa -des3 -out rootCA.key 2048
openssl genrsa -out rootCA.key 2048
openssl req -x509 -new -nodes -key rootCA.key -sha256 -days 1024 -out rootCA.pem

openssl genrsa -out influxdb.key 2048
openssl req -new -key influxdb.key -out influxdb.csr
openssl x509 -req -in influxdb.csr -CA rootCA.pem -CAkey rootCA.key -CAcreateserial -out influxdb.crt -days 500 -sha256

cat influxdb.key influxdb.crt > influxdb.pem

