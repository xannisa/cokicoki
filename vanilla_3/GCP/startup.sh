#!/bin/bash
apt-get update
apt-get install -y nginx

cat <<EOF > /var/www/html/index.html
<html>
  <head><title>OpenTofu</title></head>
  <body>
    <h1>Hello, OpenTofu!</h1>
  </body>
</html>
EOF

systemctl enable nginx
systemctl start nginx