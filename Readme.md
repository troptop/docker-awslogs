# docker-awslogs

This Container push the logs in input to your Cloudwatch account
## Usage

Using Volumes :

```
docker run -d --name=awslog -v /path/to/awscli.conf:/etc/awslogs/awscli.conf -v /path/to/awslogs.conf:/etc/awslogs/awslogs.conf -v /path/to/logs/access.log:/var/log/apache.log troptop/docker-awslogs
```

Using env variable
```
docker run -d --name=awslog -e REGION=eu-west-1 -e USE_ENV -e LOGFILE=/var/log/apache.log -v /EFS/DOCKER/APACHE-FRONT/logs/agents-access.log:/var/log/apache.log -e LOGFORMAT='%d/%b/%Y:%H:%M:%S' -e DURATION=5000 -e LOGSTREAM=myLogStream -e GROUPNAME=MyLogGroup troptop/docker-awslogs
```

Using other User ID
```
docker run -d --name=awslog -e AWS_REGION=eu-west-1 -e LOGFILE=/var/log/apache.log -v /EFS/DOCKER/APACHE-FRONT/logs/agents-access.log:/var/log/apache.log -e LOGFORMAT='%d/%b/%Y:%H:%M:%S' -e DURATION=5000 -e LOGSTREAM=test -e GROUPNAME=test -e AWS_SECRET_ACCESS_KEY=xxxx -e AWS_ACCESS_KEY_ID=xxx -e USE_ENV  troptop/docker-awslogs
```
## ENV 
- `AWS_REGION`= AWS Region to stop the logs in CloudWatch (Mandatory)

- `USE_ENV`= Has to be set to use the LOGFILE LOGFORMAT DURATION LOGSTREAM GROUPNAME (default value : false)
- `LOGFILE`= The Log Path of the log file to push to CloudWatch
- `LOGFORMAT`= Datetime log format in the log file  (https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/AgentReference.html)
 Format specifier for timestamp parsing. Here are some sample formats:
 Use '%b %d %H:%M:%S' for syslog (Apr 24 08:38:42)
 Use '%d/%b/%Y:%H:%M:%S' for apache log (10/Oct/2000:13:55:36)
 Use '%Y-%m-%d %H:%M:%S' for rails log (2008-09-08 11:52:54)
- `DURATION`= The time duration for the batching of log events
- `LOGSTREAM`=  the destination log stream
- `GROUPNAME`=  the destination log group

You can choose another user :
- `AWS_ACCESS KEY_ID`=  AWS USER ID
- `AWS_SECRET_ACCESS_KEY`=  AWS USER Password

## Author

Author: Cymatic (<info@cymatic.eu>) - www.cymatic.eu

---

