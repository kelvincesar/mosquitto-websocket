#!/bin/bash

AUTH_CONF="auth.conf"
MOSQUITTO_CONF="mosquitto.conf"

# Create an auth file 
USERNAME="user_auth"
PASSWORD="user_pwd"

# Clean docker
docker stop mqtt-messenger
docker rm mqtt-messenger

# Create auth file
rm -rf $AUTH_CONF
echo "$USERNAME:$PASSWORD" > $AUTH_CONF
mosquitto_passwd -U $AUTH_CONF


docker run -d \
-p 1883:1883 \
-p 9001:9001 \
-v "$PWD/config.d:/mosquitto/config/config.d" \
-v "$PWD/$AUTH_CONF:/mosquitto/config/$AUTH_CONF" \
-v "$PWD/$MOSQUITTO_CONF:/mosquitto/config/$MOSQUITTO_CONF" \
-v "$PWD/log:/mosquitto/log" \
--name mqtt-messenger \
eclipse-mosquitto

