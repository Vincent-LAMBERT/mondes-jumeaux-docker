FROM tomcat:latest


WORKDIR /image-server/

# Copy the images folder
COPY mondes-jumeaux-images/ /usr/local/tomcat/webapps/images/ 

# Copy the war file to the container
COPY mondes-jumeaux-servlets/target/mondes-jumeaux-servlets.war /usr/local/tomcat/webapps/image-server.war

# Access the website with the address http://host:port/image-server/index.jsp

# Serve the app
CMD ["catalina.sh", "run"]
