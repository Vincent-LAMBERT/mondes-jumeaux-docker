FROM tomcat:latest


WORKDIR /image-server

# Copy the war file to the container
COPY target/image-server.war /usr/local/tomcat/webapps/

# Serve the app
CMD ["catalina.sh", "run"]
