exp 15
docker --version
docker run hello-world
docker pull nginx, docker run -d -p 8080:80 nginx
docker ps, docker stop <id>, docker rm <id>

exp 16
mkdir docker-app, cd docker-app
docker build -t my-python-app .
docker images
docker run my-python-app
docker run -p 5020:5020 my-python-app

exp 17
docker run -d nginx
docker run -d -p 8082:80 nginx
docker volume create myvolume
docker volume ls
docker run -it -v myvolume:/data ubuntu bash
cd /data
echo "Docker volume test" > test.txt
exit
docker run -it -v myvolume:/data ubuntu bash
cat /data/test.txt
exit
docker run -d -p 8083:80 -v myvolume:/usr/share/nginx/html nginx
docker run -it -v myvolume:/data ubuntu bash
echo "<h1>Persistent web</h1>" > /data/index.html
exit

exp 18
cd Docker-Java
docker build -t java-app .
docker run -it java-app
docker login
docker tag java-app yourusername/java-app:v1
docker push yourusername/java-app:v1
docker pull yourusername/java-app:v1
docker run -it yourusername/java-app:v1
docker images
docker ps

exp 19
Create Dockerfile + Java app
Build image → docker build -t my-app .
Run container → docker run -d my-app
Jenkins automates build + run

exp 20
Create Project
mvn archetype:generate -DgroupId=com.example -DartifactId=exp20 -DarchetypeArtifactId=maven-archetype-webapp -DinteractiveMode=false
cd exp20
 2. Create Folders (Windows)
mkdir src\main\java\com\example
mkdir src\test\java\com\example
 3. Build Project
mvn clean package
mvn clean install
