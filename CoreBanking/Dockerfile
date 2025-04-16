# Use an official JDK image
FROM maven:3.8.6-openjdk-18 as BUILD

# Copy the application source code
COPY code/src /usr/src/app/src
COPY code/pom.xml /usr/src/app

# Run maven to build the application
RUN mvn -f /usr/src/app/pom.xml clean package liberty:create liberty:install-feature liberty:deploy

FROM open-liberty:full-java17-openj9

COPY code/src/main/liberty/config/server.xml /config/

COPY --from=BUILD /usr/src/app/target/core.war /config/apps/

COPY --from=BUILD /usr/src/app/target/liberty/wlp/usr/servers/defaultServer/mq/wmq.jmsra-9.3.1.0.rar /opt/ol/wlp/usr/servers/defaultServer/mq/

COPY --from=BUILD /usr/src/app/target/liberty/wlp/usr/servers/defaultServer/jdbc/jcc-11.5.6.0.jar /opt/ol/wlp/usr/servers/defaultServer/jdbc/

# Allow traffic on port 9080
EXPOSE 9080
