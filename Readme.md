# docker-awslogs

This Container push the logs in input to your Cloudwatch account
## Usage

Using Volumes :

```
docker run -d --name=awslog -v /path/to/awscli.conf:/etc/awslogs/awscli.conf -v /path/to/awslogs.conf:/etc/awslogs/awslogs.conf -v /path/to/logs/access.log:/var/log/apache.log troptop/docker-awslogs
```

Using env variable
```
docker run -d --name=awslog -e REGION=eu-west-1 -e LOGFILE=/var/log/apache.log -v /EFS/DOCKER/APACHE-FRONT/logs/agents-access.log:/var/log/apache.log -e LOGFORMAT='%d/%b/%Y:%H:%M:%S' -e DURATION=5000 -e LOGSTREAM=myLogStream -e GROUPNAME=MyLogGroup troptop/docker-awslogs
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

- `OTHER_AWS_ID`= Has to be set to use the AWS_ACCESS KEY_ID AWS_SECRET_ACCESS_KEY (default value : false)
- `AWS_ACCESS KEY_ID`=  AWS USER ID
- `AWS_SECRET_ACCESS_KEY`=  AWS USER Password

## ENV Not Tested 

To use AWS_ACCESS KEY_ID and AWS_SECRET_ACCESS_KEY add them as environment variable --env

--env AWS_ACCESS KEY_ID=xxxx
--env AWS_SECRET_ACCESS_KEY=xxx
How to provide AWS credentials to awslogs
Although, the most straightforward thing to do might be use --aws-access-key-id and --aws-secret-access-key, this will eventually become a pain in the ass.

If you only have one AWS account, my personal recommendation would be to configure aws-cli. awslogs will use those credentials if available. If you have multiple AWS profiles managed by aws-cli, just adds --profile [PROFILE_NAME] at the end of every awslogs command to use those credentials.
If you don't want to setup aws-cli, I would recommend you to use envdir in order to make AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY available to awslogs

## Author

Author: Cymatic (<info@cymatic.eu>) - www.cymatic.eu

---

