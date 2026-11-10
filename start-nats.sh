#!/bin/bash
NATS_PATH="nats-server-v2.15.2-linux-amd64"
pm2 start --name nats-server "./$NATS_PATH/nats-server -js --name nats-server -sd $NATS_PATH/datastorage" 