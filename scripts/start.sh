#!/bin/bash
cd /home/ec2-user/app

# Stop old process if running
pkill -f 'java -jar' || true

# Fetch DB2 secrets from SSM
DB2_URL=$(aws ssm get-parameter --name "/springboot/DB2_URL" --with-decryption --query "Parameter.Value" --output text)
DB2_USERNAME=$(aws ssm get-parameter --name "/springboot/DB2_USERNAME" --with-decryption --query "Parameter.Value" --output text)
DB2_PASSWORD=$(aws ssm get-parameter --name "/springboot/DB2_PASSWORD" --with-decryption --query "Parameter.Value" --output text)

# Run pursuit.jar with secrets
nohup java -jar pursuit.jar \
  --spring.datasource.url=$DB2_URL \
  --spring.datasource.username=$DB2_USERNAME \
  --spring.datasource.password=$DB2_PASSWORD > app.log 2>&1 &
