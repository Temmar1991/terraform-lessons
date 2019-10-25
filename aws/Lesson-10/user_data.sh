#! /bin/bash
yum -y update
yum -y install httpd
myip=$(curl http://169.254.169.254/latest/meta-data/local-ipv4)
echo <<EOF > /var/www/html/index.html
<html>
<body bgcolor="blue">
<h2><font color="gold">Build by Power of Terraform <font color="red">0.12</font></h2><br><p>
<font color="green>"Server  PrivateIP: <font coor="aqua">$myip<br><br>

<font color="magenta">
<b>Version 1.0</b>
</body>
</html>
EOF

sudo service httpd start
chkconfig httd on   