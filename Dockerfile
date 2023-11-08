#FROM openjdk:11
#VOLUME /tmp
#EXPOSE 8080
#ARG JAR_FILE=target/spring-boot-docker.jar
#ADD ${JAR_FILE} app.jar
#ENTRYPOINT ["java","-jar","/app.jar"]



FROM maven:3.8.4-openjdk-11 AS build

WORKDIR /app

# Copy the pom.xml file
COPY pom.xml .

# Download the project dependencies
RUN mvn dependency:go-offline -B

# Copy the application source code
COPY src ./src

# Build the application
RUN mvn package -DskipTests

# Define the runtime stage
FROM openjdk:11-jre-slim

WORKDIR /app

# Copy the JAR file from the previous stage
COPY --from=build /app/target/spring-boot-2-jdbc-with-h2-0.0.1-SNAPSHOT.jar ./app.jar

# Create a non-root user
RUN groupadd -r myuser && \
    useradd -r -g myuser -u 1001 -m -s /bin/bash myuser

# Set the ownership of the application files to the non-root user
RUN chown myuser:myuser /app/app.jar

# Switch to the non-root user
USER myuser
EXPOSE 8080

# Set the command to run the application
CMD ["java", "-jar", "/app/app.jar"]
