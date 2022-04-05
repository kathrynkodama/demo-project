# Install Maven and copy project for compilation
FROM maven:latest as builder

# create app folder for sources
RUN mkdir -p /build
WORKDIR /build
COPY pom.xml /build

# Copy source code
COPY src /build/src

RUN mvn clean package

# Deploy OL app
FROM icr.io/appcafe/open-liberty:kernel-slim-java11-openj9-ubi

COPY --chown=1001:0 /build/src/main/liberty/config /config

RUN features.sh

COPY --chown=1001:0 /build/target/*.war /config/apps

RUN configure.sh
