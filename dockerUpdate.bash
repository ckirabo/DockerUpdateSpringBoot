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

project="spring-boot-hello-world"
# create the JAR file, in the target directory
mvn clean package
# build the docker image
docker build -t ${project}:latest .
# remove the dangling container(s)
 if docker images | grep '<none>'; then
    docker rmi $(docker images -q -f dangling=true)
 fi
# remove the old container
if docker ps -a | grep spring-boot
docker stop $(docker ps -a) #add if stament to grep if the project exists if it does then do the following
docker rm $(docker ps -a)
fin
# run the new container
docker run -d -p 9000:9000 --name ${project} ${project}



