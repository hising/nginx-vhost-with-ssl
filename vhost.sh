#!/bin/bash

# Copied and inspired by https://gist.github.com/chrisenytc/6563253

echo "What the domain? (e.g: project.dev) :"
read server

# check if not starts with www and ask if add www as well

# ask if add SSL as well

# if SSL ask if script should use LetsEncrypt

# Call LetsEncrypt

echo "What the DocumentRoot? (e.g: /home/www/project/public_html) :"
read path

echo "Creating Configuration server."

echo "
 server {
        listen   80; ## listen for ipv4; this line is default and implied
        #listen   [::]:80 default ipv6only=on; ## listen for ipv6

        root "$path";
        index index.php index.html index.htm;

        # Make site accessible from http://localhost/
        server_name "$server";
}
" > /etc/nginx/sites-available/$server

echo "Enable VHOST $server"
ln -s /etc/nginx/sites-available/$server /etc/nginx/sites-enabled/$server

echo "Update Hosts."
echo "127.0.1.1 $server www.$server" >> /etc/hosts

echo "Reloading Nginx...";
sudo service nginx reload

echo "VHOST created with success.";
