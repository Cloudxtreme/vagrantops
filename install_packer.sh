sudo apt-get install unzip -y
sudo mkdir -p /opt/packer/download/
sudo wget https://dl.bintray.com/mitchellh/packer/packer_0.7.2_linux_amd64.zip -O /opt/packer/download/packer.zip
sudo unzip /opt/packer/download/packer.zip -d /opt/packer
sudo cp /opt/packer/* /usr/bin