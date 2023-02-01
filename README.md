# Overview
Reference project to combine containerized Alpine Linux with Tomcat 9 to deploy and run a war file.

- Alpine Linux with Eclipse Temurin JDK 17
- Apache Tomcat 9.0.71
- Change default user from `root` to `tomcat`.

# Steps
1. Compile Hello World project in `helloworld` folder using Maven.
2. Copy `helloworld-1.0.0.war` to parent folder.
3. Run the following to create container image.
   ```
   docker build . -t test-image -f Dockerfile
   ```
4. Run the following to test container image.
   ```
   docker run -d --name test-image -p 8080:8080 test-image
   curl http://localhost:8080/helloworld/name
   ```
5. **(Optional)** Run [Dive](https://github.com/wagoodman/dive) to inspect container image layers.
   ```
   dive test-image
   ```