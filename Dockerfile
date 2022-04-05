FROM icr.io/appcafe/open-liberty:kernel-slim-java11-openj9-ubi

RUN /root/apache-maven-3.8.5/bin/mvn -f pom.xml clean package 

COPY --chown=1001:0 /src/main/liberty/config /config

RUN features.sh

COPY --chown=1001:0 target/*.war /config/apps

RUN configure.sh
