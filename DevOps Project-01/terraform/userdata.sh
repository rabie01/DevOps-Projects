#!/bin/bash
yum update -y
yum install -y java-1.8.0-openjdk wget unzip

aws s3 cp s3://${bucket}/${key} /home/ec2-user/app.war
nohup java -jar /home/ec2-user/app.war > /home/ec2-user/app.log 2>&1 &
