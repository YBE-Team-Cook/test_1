FROM openjdk:17-slim AS builder
USER root

WORKDIR /app
COPY . /app
# 개행문자 오류 해결 [unix와 window 시스템 차이]
RUN sed -i 's/\r$//' gradlew

RUN if [ -f "./gradlew" ]; then chmod +x ./gradlew; fi
RUN --mount=type=cache,id=test-gradle,target=/root/.gradle ./gradlew clean bootjar -x test --build-cache -i -s --no-daemon

FROM openjdk:17-slim
MAINTAINER ybe.teamcook7@gmail.com

ARG TEST_DB_HOST
ARG TEST_DB_DATABASE
ARG TEST_DB_PORT
ARG TEST_DB_USERNAME
ARG TEST_DB_PASSWORD
ARG TEST_WEB_PROFILE

ENV TEST_DB_HOST ${TEST_DB_HOST}
ENV TEST_DB_DATABASE ${TEST_DB_DATABASE}
ENV TEST_DB_PORT ${TEST_DB_PORT}
ENV TEST_DB_USERNAME ${TEST_DB_USERNAME}
ENV TEST_DB_PASSWORD ${TEST_DB_PASSWORD}
ENV TEST_WEB_PROFILE ${TEST_WEB_PROFILE}

VOLUME /tmp

WORKDIR /app
COPY --from=builder /**/build/libs/*.jar app.jar

EXPOSE 8080

USER nobody

# 환경 변수 설정
ENV JAVA_TOOL_OPTIONS="-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:5005 \
    -Djava.security.egd=file:/dev/./urandom"

# 애플리케이션 실행
ENTRYPOINT ["java", "-jar", "app.jar"]