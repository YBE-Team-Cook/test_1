FROM openjdk:17-slim AS builder
USER root

WORKDIR /app
COPY . /app
# 개행문자 오류 해결 [unix와 window 시스템 차이]
RUN sed -i 's/\r$//' gradlew

RUN if [ -f "./gradlew" ]; then chmod +x ./gradlew; fi
RUN ./gradlew clean bootjar -x test --build-cache -i -s --no-daemon

FROM openjdk:17-slim
MAINTAINER ybe.teamcook7@gmail.com

ARG TEST_DB_HOST
ARG TEST_DB_DATABASE
ARG TEST_DB_PORT
ARG TEST_DB_USERNAME
ARG TEST_DB_PASSWORD
ARG TEST_WEB_PROFILE

ENV TEST_DB_HOST ${MYSQLHOST}
ENV TEST_DB_DATABASE ${MYSQLDATABASE}
ENV TEST_DB_PORT ${MYSQLPORT}
ENV TEST_DB_USERNAME ${MYSQLUSER}
ENV TEST_DB_PASSWORD ${MYSQLPASSWORD}
ENV TEST_WEB_PROFILE ${TEST_WEB_PROFILE}

WORKDIR /app
COPY --from=builder /**/build/libs/*.jar app.jar

EXPOSE 8080

USER nobody

# 환경 변수 설정
ENV JAVA_TOOL_OPTIONS="-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:5005 \
    -Dspring.profiles.active=prod \
    -Djava.security.egd=file:/dev/./urandom"

# 애플리케이션 실행
ENTRYPOINT ["java", "-jar", "app.jar"]