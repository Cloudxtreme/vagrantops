sudo apt-get update -qq
sudo wget http://s3.amazonaws.com/influxdb/influxdb_latest_amd64.deb
sudo dpkg -i influxdb_latest_amd64.deb
sudo /etc/init.d/influxdb start