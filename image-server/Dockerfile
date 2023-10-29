FROM tomcat:latest


WORKDIR /image-server/

# # Copy the images folder
COPY images/ /usr/local/tomcat/webapps/images/

# Copy the war file to the container
COPY mondes-jumeaux-servlets/target/mondes-jumeaux-servlets.war /usr/local/tomcat/webapps/image-server.war

# Serve the app
CMD ["catalina.sh", "run"]
