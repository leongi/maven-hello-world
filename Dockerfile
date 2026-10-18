# ---------- Stage 1: compile, test and package the jar ----------
FROM maven:3.9.9-eclipse-temurin-17 AS build
WORKDIR /src
COPY myapp/ .
RUN mvn -B package

# ---------- Stage 2: minimal runtime image, running as non-root ----------
FROM eclipse-temurin:17-jre-alpine
RUN adduser -D -u 10001 app
COPY --from=build /src/target/myapp-*.jar /app/app.jar
USER 10001
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
