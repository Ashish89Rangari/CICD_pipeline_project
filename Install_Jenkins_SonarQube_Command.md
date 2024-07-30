# Install Jenkins SonarQube In AWS Instance#

1) To Install JAVA and Temurin Dependencies 
```
sudo apt update -y
wget -O - https://packages.adoptium.net/artifactory/api/gpg/key/public | tee /etc/apt/keyrings/adoptium.asc
echo "deb [signed-by=/etc/apt/keyrings/adoptium.asc] https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" | tee /etc/apt/sources.list.d/adoptium.list
sudo apt update -y 
sudo apt install temurin-17-jdk -y
/usr/bin/java --version
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update -y
```
2) To build docker image from docker file (app1 docker image name)
```
docker build -t app1 .
```
3) To list the docker images
```
docker image ls
docker images
```
4) To create a docker container out of docker image

```
docker run -d -p 8080:80 app1
```
<br/>
	- -d – detachable mode so to execute the command it will get into next terminal <br/>
	- -p – port mapping <br/>
	- -8080 – host machine port,we already have given in docker file  <br/>
	- -80 -nginx base image port  <br/>
	- app1 – image name or can give image id <br/>

<br/>

