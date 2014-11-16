function install_elasticsearch()
{
    echo installing elasticsearch
    sudo wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.4.0.deb -O /opt/elasticsearch.deb
    sudo dpkg -i /opt/elasticsearch.deb
    sudo update-rc.d elasticsearch defaults 95 10
    sudo /etc/init.d/elasticsearch start
    sudo rm /opt/elasticsearch.deb

    # install plugins
    sudo /usr/share/elasticsearch/bin/plugin --install mobz/elasticsearch-head
    sudo /usr/share/elasticsearch/bin/plugin --install lmenezes/elasticsearch-kopf/1.2
    sudo /usr/share/elasticsearch/bin/plugin --install lukas-vlcek/bigdesk
}

function install_kibana()
{
    echo installing kibana
    sudo mkdir /opt/kibana
    sudo wget https://download.elasticsearch.org/kibana/kibana/kibana-4.0.0-BETA2.tar.gz -O /opt/kibana.tar.gz
    sudo tar -xzvf /opt/kibana.tar.gz -C /opt/kibana --strip-components=1

    # create kibana upstart file
    echo 'description kibana' | sudo tee --append /etc/init/kibana.conf
    echo 'start on runlevel [2345]' | sudo tee --append /etc/init/kibana.conf
    echo 'stop on runlevel [016]' | sudo tee --append /etc/init/kibana.conf
    echo 'kill timeout 60' | sudo tee --append /etc/init/kibana.conf
    echo 'respawn' | sudo tee --append /etc/init/kibana.conf
    echo 'respawn limit 10 5' | sudo tee --append /etc/init/kibana.conf
    echo 'exec /opt/kibana/bin/kibana' | sudo tee --append /etc/init/kibana.conf
    sudo start kibana
    sudo rm /opt/kibana.tar.gz
}

function main()
{
    echo bootstrapping...

    echo updating db cache
    sudo apt-get -y update &&
    echo installing dependencies
    sudo apt-get install -y vim openjdk-7-jdk python-dev curl git &&

    echo installing elk
    mkdir elk &&
    cd elk &&
    install_elasticsearch &&
    install_kibana &&

    echo bootstrap done
}

main