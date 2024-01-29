#!/usr/bin/env bash

REPOSITORY=/home/ec2-user/CI-CD-practice
LOG_DIR=$REPOSITORY/logs
LOG_FILE="$LOG_DIR/$(date +'%Y-%m-%d').log"

# 로그 디렉토리 생성 시 권한 문제 해결을 위해 sudo를 사용
if [ ! -d "$LOG_DIR" ]; then
  sudo mkdir -p "$LOG_DIR"
  sudo chown ec2-user:ec2-user "$LOG_DIR"
fi

cd $REPOSITORY

APP_NAME=ci-cd-practice # 소문자로 작성해야됨
JAR_NAME=$(ls $REPOSITORY/build/libs/ | grep 'SNAPSHOT.jar' | tail -n 1)
JAR_PATH=$REPOSITORY/build/libs/$JAR_NAME

CURRENT_PID=$(pgrep -f $APP_NAME)

if [ -z $CURRENT_PID ]
then
  echo "> 종료할것 없음."
else
  echo "> kill -9 $CURRENT_PID"
  sudo kill -15 $CURRENT_PID
  sleep 5
fi

echo "> $JAR_PATH 배포"
nohup java -jar $JAR_PATH > $LOG_FILE 2>&1 &