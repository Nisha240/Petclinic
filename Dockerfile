# Step 1: Use Maven and JDK image to build the project
FROM maven:3.8.6-eclipse-temurin-17 AS builder

# Set the working directory inside the container
WORKDIR /app

# Step 2: Copy pom.xml and project files
COPY pom.xml /app/
COPY src /app/src/

# Step 3: Package the application (create WAR file)
RUN mvn clean package

# Step 4: Use Tomcat image as a base for running the application
FROM tomcat:9.0.65-jdk17

# Step 5: Copy the generated WAR file to Tomcat webapps directory
COPY --from=builder /app/target/*.war /usr/local/tomcat/webapps/

# Step 6: Expose the default Tomcat port
EXPOSE 8080

# Step 7: Start Tomcat
CMD ["catalina.sh", "run"]
