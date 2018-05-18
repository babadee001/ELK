java(){
    sudo add-apt-repository ppa:webupd8team/java
    sudo apt-get install python-software-properties
    sudo apt-get update
    sudo apt-get install oracle-java8-installer
}

aws() {
sudo apt-get install python2.7
sudo apt-get install python-pip
sudo pip install awscli
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
awscliSetup(){
    #install Python version 2.7 if it was not already installed during the JDK #prerequisite installation
    sudo apt-get install python2.7
    #install Pip package management for python
    sudo apt-get install python-pip
    #install AWS CLI
    sudo pip install awscli
}
start(){
    docker run -p 80:5000 428924800516.dkr.ecr.eu-west-2.amazonaws.com/babadee
}

main(){
    java
    dockerSetup
    aws
    start
}
main
