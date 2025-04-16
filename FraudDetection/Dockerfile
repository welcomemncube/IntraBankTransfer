# Use an official JDK image
FROM maven:3.8.6-openjdk-18 as BUILD

# Copy the application source code
COPY code/src /usr/src/app/src
COPY code/pom.xml /usr/src/app

# Run maven to build the application
RUN mvn -f /usr/src/app/pom.xml clean package

FROM open-liberty:full-java17-openj9

COPY code/src/main/liberty/config/server.xml /config/

COPY --from=BUILD /usr/src/app/target/fraud-detection.war /config/apps/

# Allow traffic on port 9080
EXPOSE 9080
