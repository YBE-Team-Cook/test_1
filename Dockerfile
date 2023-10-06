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

ENV TEST_DB_HOST ${TEST_DB_HOST}
ENV TEST_DB_DRIVER ${TEST_DB_DRIVER}
ENV TEST_DB_DATABASE ${TEST_DB_DATABASE}
ENV TEST_DB_PORT ${TEST_DB_PORT}
ENV TEST_DB_USERNAME ${TEST_DB_USERNAME}
ENV TEST_DB_PASSWORD ${TEST_DB_PASSWORD}

VOLUME /tmp

WORKDIR /app
COPY --from=builder /**/build/libs/*.jar app.jar

EXPOSE 8080

USER nobody
ENTRYPOINT ["java", "-jar", "-Dspring.profiles.active=${TEST_WEB_PROFILE}", "app.jar"]