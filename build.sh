java(){
    sudo add-apt-repository ppa:webupd8team/java
    sudo apt-get install python-software-properties
    sudo apt-get update
    sudo apt-get install oracle-java8-installer
}

aws() {
sudo apt-get install python-pip
sudo pip install awscli
aws configure
}

dockerSetup(){
    sudo apt-get install apt-transport-https ca-certificates
    sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
    sudo bash -c 'cat > /etc/apt/sources.list.d/docker.list <<EOF
    deb https://apt.dockerproject.org/repo ubuntu-trusty main'
    sudo apt-get update
    apt-cache policy docker-engine
    sudo apt-get install docker-engine
    sudo bash -c 'cat > /etc/default/docker <<EOF
    DOCKER_OPTS="-H tcp://127.0.0.1:2375 -H unix:///var/run/docker.sock"'
    sudo usermod -a -G docker ubuntu
}
start(){
    aws ecr get-login --no-include-email --region eu-west-2 | bash
    docker run -p 80:5000 428924800516.dkr.ecr.eu-west-2.amazonaws.com/babadee
}

elastic(){
    wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
    sudo apt-get install apt-transport-https
    echo "deb https://artifacts.elastic.co/packages/6.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-6.x.list
    sudo apt-get update
    sudo apt-get install elasticsearch
}

main(){
    java
    dockerSetup
    aws
    elastic
    start
}
main
