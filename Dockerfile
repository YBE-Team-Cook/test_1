FROM gradle:8.2.1-jdk17-alpine AS builder

WORKDIR /build
COPY . /build

ARG EnvironmentVariable
ARG RAILWAY_ENVIRONMENT
ENV RAILWAY_ENVIRONMENT=$RAILWAY_ENVIRONMENT

# 개행문자 오류 해결 [unix와 window 시스템 차이]
RUN sed -i 's/\r$//' gradlew

RUN gradle build -x test --parallel

FROM openjdk:17-slim

ARG MYSQLHOST
ARG MYSQLDATABASE
ARG MYSQLPORT
ARG MYSQLUSER
ARG MYSQLPASSWORD
ARG APP_PROFILE

ENV MYSQLHOST ${MYSQLHOST}
ENV MYSQLDATABASE ${MYSQLDATABASE}
ENV MYSQLPORT ${MYSQLPORT}
ENV MYSQLUSER ${MYSQLUSER}
ENV MYSQLPASSWORD ${MYSQLPASSWORD}
ENV APP_PROFILE ${APP_PROFILE}

WORKDIR /app
COPY --from=builder /**/build/libs/*.jar app.jar

EXPOSE 8080

USER root

# 환경 변수 설정
ENV JAVA_TOOL_OPTIONS="-Dspring.profiles.active=prod"

# 애플리케이션 실행
ENTRYPOINT ["java", "-jar", "app.jar"]