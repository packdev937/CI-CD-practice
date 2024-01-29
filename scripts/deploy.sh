#!/usr/bin/env bash

REPOSITORY=/home/ec2-user/CI-CD-practice
LOG_DIR=$REPOSITORY/logs
LOG_FILE"$LOG_DIR/$(date+%Y-%m-%d).log"

if [ ! -d $LOG_DIR ]
then
  mkdir $LOG_DIR
fi

cd $REPOSITORY

APP_NAME=CI-CD-practice
JAR_NAME=$(ls $REPOSITORY/build/libs/ | grep '.jar' | tail -n 1)
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
sudo nohup java -jar $JAR_PATH > $LOG_FILE 2>&1 &