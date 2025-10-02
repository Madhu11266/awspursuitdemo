#!/bin/bash
cd /home/ec2-user/app

# Stop old process if running
sudo pkill -f 'java -jar' || true

# Fetch DB2 secrets from SSM
DB2_URL=$(aws ssm get-parameter --name "/springboot/DB2_URL" --with-decryption --query "Parameter.Value" --output text)
DB2_USERNAME=$(aws ssm get-parameter --name "/springboot/DB2_USERNAME" --with-decryption --query "Parameter.Value" --output text)
DB2_PASSWORD=$(aws ssm get-parameter --name "/springboot/DB2_PASSWORD" --with-decryption --query "Parameter.Value" --output text)

# Ensure log directory exists
sudo mkdir -p /home/ec2-user/app/logs
sudo chmod 755 /home/ec2-user/app/logs


# Run pursuit.jar with secrets and redirect logs
sudo sh -c "nohup java -jar /home/ec2-user/app/pursuit.jar \
  --spring.datasource.url='$DB2_URL' \
  --spring.datasource.username='$DB2_USERNAME' \
  --spring.datasource.password='$DB2_PASSWORD' \
  >> /home/ec2-user/app/logs/app.log 2>&1 &"

