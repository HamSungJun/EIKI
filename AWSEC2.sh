# AWS EC2에 도커 소프트웨어 설치
sudo apt update;
sudo apt remove docker docker-engine docker.io containerd runc;
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common;

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -;
sudo apt-key fingerprint 0EBFCD88;

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable";

sudo apt-get update;
sudo apt-get install docker-ce docker-ce-cli containerd.io;

sudo docker run hello-world;

# 작업하던 로컬 환경에서 컨테이너를 커밋 후 이미지로 도커 허브에 푸시
docker commit <WORKING_CONTAINER> <IMAGE_NAME>
docker login
username : hsjprime
password : ***

docker tag mysql8 <USERNAME>/<IMAGE_NAME>
docker push <USERNAME>/<IMAGE_NAME>

# AWS EC2 에서 해당 이미지를 내려 받기
docker pull <USERNAME>/<IMAGE_NAME>
docker run --name <CONTAINER_NAME> --net=host -p 3306:3306 -e MYSQL_ROOT_PASSWORD <PASSWORD> -d <IMAGE_NAME>

# WAS 설치를 위한 자바 8 버전 설치
sudo apt-get install openjdk-8-jre openjdk-8-jdk;

# WAS 8.5 버전 설
sudo wget http://apache.mirror.cdnetworks.com/tomcat/tomcat-8/v8.5.51/bin/apache-tomcat-8.5.51.tar.gz;
sudo tar -zvxf apache-tomcat-8.5.51.tar.gz

# AWS EC2 포트 포워딩 80 -> 8080
iptables -t nat -I PREROUTING -p tcp --dport 80 -j REDIRECT --to-ports 8080치




