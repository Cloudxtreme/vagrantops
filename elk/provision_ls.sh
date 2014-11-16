function install_logstash()
{
    echo installing logstash
    # mkdir logstash
    # sudo mkdir /opt/logstash
    # sudo wget https://download.elasticsearch.org/logstash/logstash/logstash-1.4.2.tar.gz -O /opt/logstash.tar.gz
    # sudo tar -xzvf /opt/logstash.tar.gz -C logstash --strip 1
    # sudo rm /opt/logstash.tar.gz
    # echo installing logstash contrib plugins
    # sudo logstash/bin/plugin install contrib

    sudo wget https://download.elasticsearch.org/logstash/logstash/packages/debian/logstash_1.4.2-1-2c0f5a1_all.deb -O /opt/logstash.deb
    sudo dpkg -i /opt/logstash.deb
    sudo wget https://download.elasticsearch.org/logstash/logstash/packages/debian/logstash-contrib_1.4.2-1-efd53ef_all.deb -O /opt/logstash_contrib.deb
    sudo dpkg -i /opt/logstash_contrib.deb

    sudo cp /vagrant/resources/logstash.conf .
}

function install_rabbitmq()
{
    echo installing rabbitmq
    sudo apt-get install -y erlang-nox
    sudo wget http://www.rabbitmq.com/releases/rabbitmq-server/v3.2.4/rabbitmq-server_3.2.4-1_all.deb -O /opt/rabbitmq.deb
    sudo dpkg -i /opt/rabbitmq.deb
}

function main()
{
    echo bootstrapping...

    echo updating db cache
    sudo apt-get -y update &&
    echo installing dependencies
    sudo apt-get install -y vim openjdk-7-jdk python-dev curl git &&
    echo installing pip
    curl --silent --show-error --retry 5 https://bootstrap.pypa.io/get-pip.py | sudo python &&
    # go home
    cd ~
    echo installing virtualenv
    sudo pip install virtualenv==1.11.4 &&
    echo creating feeder virtualenv
    virtualenv feeder &&
    source feeder/bin/activate &&
    echo installing feeder
    pip install feeder &&

    echo installing elk
    mkdir elk &&
    cd elk &&
    install_logstash &&
    install_rabbitmq &&

    # echo cloning workshop repo
    # cd ~ &&
    # git clone http://github.com/nir0s/elk-workshop &&
    # cd ~/elk-workshop &&
    # chmod +x runls.sh &&

    # echo setting up homedir
    # echo "cd ~/elk-workshop" >> /home/vagrant/.bashrc

    echo setting up venv on login
    echo "source /home/vagrant/feeder/bin/activate" >> /home/vagrant/.bashrc
    echo bootstrap done
}

main