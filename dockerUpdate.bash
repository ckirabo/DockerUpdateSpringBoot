#!bin/bash
#script to check for updates for container spring boot

:'install docker and git
sudo yum -y install docker
sudo yum -y install git

create user
sudo groupadd docker
sudo usermod -aG docker $(whoami)
groups 
sudo systemctl start docker
sudo systemctl enable docker
exit 
groups 

clone spring boot and mvn build
git clone https://github.com/ckirabo/spring-boot-hello-world
sudo yum -y install maven
cd spring-boot-hello-world
mvn clean install 
'

#stop any current container and remove it
docker build -t spring-boot-hello-world:latest .
docker stop $(docker ps -aq)
docker rm $(docker ps -aq)

docker system prune -a 

#run container
docker run -d -p 9000:9000 spring-boot-hello-world



