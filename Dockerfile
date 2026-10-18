# ---------- Stage 1: compile, test and package the jar ----------
FROM maven:3.9.9-eclipse-temurin-17 AS build
WORKDIR /src
COPY myapp/ .
# tr removes the Windows line ending (\r) the version file may have after a checkout on Windows
RUN mvn -B package -Drevision=$(tr -d '\r' < version)

# ---------- Stage 2: minimal runtime image, running as non-root ----------
FROM eclipse-temurin:17-jre-alpine
RUN adduser -D -u 10001 app
COPY --from=build /src/target/myapp-*.jar /app/app.jar
USER 10001
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
