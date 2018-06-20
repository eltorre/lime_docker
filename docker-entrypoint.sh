#! /bin/sh

service apache2 start 
cd /limeserver/lime-server/ && node server.js
