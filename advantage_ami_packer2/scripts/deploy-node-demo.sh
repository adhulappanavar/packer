#!/bin/bash
apt-get update
apt-get install -y nginx nodejs npm

groupadd node-demo
useradd -d /app -s /bin/false -g node-demo node-demo

mv /tmp/app /app
chown -R node-demo:node-demo /app

echo 'user www-data;
worker_processes auto;
pid /run/nginx.pid;

events {
        worker_connections 768;
        # multi_accept on;
}

http {
  server {
    listen 80;
    location / {
      proxy_pass http://localhost:3000/;
      proxy_set_header Host $host;
      proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
  }
}' > /etc/nginx/nginx.conf

service nginx restart

cd /app
npm install

echo 'description "This is a node-demp upstart Job"
author "Anil"

start on runlevel [2345]
exec NODE_ENV=production
exec /usr/bin/nodejs /app/index.js' > /etc/init/node-demo.conf

echo "Checking Service configuration for /etc/init/node-demo.service"
init-checkconf /etc/init/node-demo.conf

echo "Starting the /etc/init/node-demo.service"
service node-demo start

echo "Check the status of /etc/init/node-demo.service"
service node-demo status



