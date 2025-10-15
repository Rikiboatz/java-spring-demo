# ---- Build stage ----
FROM maven:3.9-eclipse-temurin-21 AS build

WORKDIR /app

# คัดลอกไฟล์ pom และ preload dependencies ก่อน เพื่อ cache dependency
COPY pom.xml .
RUN mvn -q -B dependency:go-offline

# copy source แล้ว build
COPY src ./src
RUN mvn -q -B -DskipTests package

# ---- Runtime stage (distroless หรือ jre slim) ----
FROM eclipse-temurin:21-jre-jammy

WORKDIR /app

# set timezone/locale หากต้องการ
ENV TZ=Asia/Bangkok \
    JAVA_TOOL_OPTIONS="-XX:+UseContainerSupport -XX:MaxRAMPercentage=75"

# สร้าง user ไม่รันเป็น root (ปลอดภัยขึ้น)
RUN useradd -ms /bin/bash springuser
USER springuser

# ค้นหาไฟล์ .jar ล่าสุดจากสเตจ build แล้วคัดลอกเข้ามา
COPY --from=build /app/target/*-SNAPSHOT.jar app.jar

# HEALTHCHECK --interval=30s --timeout=3s --start-period=20s --retries=3 \
#   CMD wget -qO- http://localhost:8080/actuator/health | grep -q '"status":"UP"' || exit 1

EXPOSE 8080
ENTRYPOINT ["java","-jar","/app/app.jar"]
