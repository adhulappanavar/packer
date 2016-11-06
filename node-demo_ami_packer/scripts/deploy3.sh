#!/bin/bash
apt-get update
apt-get install -y nginx git
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install -y nodejs


groupadd node-demo
useradd -d /advantage -s /bin/false -g node-demo node-demo

git clone https://github.com/adhulappanavar/advantage.git
sudo chown -R node-demo:node-demo ./advantage

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

cd advantage
sudo npm install
sudo npm install gulp -g
sudo npm run gulp repl-localhost
sudo npm run gulp repl-local-mongodb
sudo npm run gulp build-ts

echo 'description "This is a node-demp upstart Job"
author "Anil"

start on runlevel [2345]
exec NODE_ENV=production
exec npm run startclouddev' > /etc/init/node-advantage.conf

echo "Checking Service configuration for /etc/init/node-demo.conf"
sudo init-checkconf /etc/init/node-advantage.conf

echo "Starting the /etc/init/node-demo"
sudo service node-advantage start

echo "Check the status of /etc/init/node-demo"
sudo service node-advantage status



