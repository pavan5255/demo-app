FROM eclipse-temurin:11-jdk AS build_image

RUN apt-get update && apt-get install -y maven
WORKDIR /app
COPY . .
RUN mvn clean install

FROM tomcat:9-jdk11-temurin

LABEL "Project"="Vprofile"
LABEL "Author"="Imran"

RUN rm -rf /usr/local/tomcat/webapps/*

COPY --from=build_image /app/target/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
