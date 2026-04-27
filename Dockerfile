# Fase de construcción (Build)
FROM maven:3.9.6-amazoncorretto-21 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Fase de ejecución (Runtime)
FROM amazoncorretto:21-alpine
WORKDIR /app
# Copiamos el jar usando la ruta de la fase anterior
COPY --from=build /app/target/store-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","app.jar"]