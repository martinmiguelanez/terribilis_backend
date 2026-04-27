# Fase de construcción (Build)
FROM maven:3.8.4-openjdk-17 AS build
COPY . .
RUN mvn clean package -DskipTests

# Fase de ejecución (Runtime)
FROM openjdk:17-jdk-slim
# Copiamos el jar generado. Asegúrate que el nombre coincide con tu pom.xml
COPY --from=build /target/store-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","app.jar"]