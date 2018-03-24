#!/bin/bash
cat > /etc/awslogs/awslogs.conf <<EOF
[general]
# Path to the CloudWatch Logs agent's state file. The agent uses this file to maintain
# client side state across its executions.
state_file = /var/vcap/sys/log/awslogs/agent-state
logging_config_file = /var/vcap/jobs/awslogs/config/logging.conf
EOF
cat > /etc/awslogs/awscli.conf <<EOF
[plugins]
cwlogs = cwlogs
[default]
region = ${AWS_REGION}
EOF

if [ "$USE_ENV" != "false" ]; then
	if [ -n "$LOGFILE" ] && [ -n "$LOGSTREAM" ] && [ -n "$GROUPNAME" ] && [ -n "$DURATION" ] && [ -n "$LOGFORMAT" ]; then

		cat >> /etc/awslogs/awslogs.conf <<EOF
[${LOGFILE}]
datetime_format = ${LOGFORMAT}
file = ${LOGFILE}
buffer_duration = ${DURATION}
log_stream_name = ${LOGSTREAM}
initial_position = start_of_file
log_group_name = ${GROUPNAME}
EOF

	else
		echo 'ERROR: USE_ENV variable env has been set'
		echo 'Please check if you have the following ENV setup :
        	- --env LOGFILE
	        - --env LOGSTREAM
        	- --env GROUPNAME
	        - --env DURATION
        	- --env LOGFORMAT
	        - --env USE_ENV'
		exit 1
	fi

fi
	
if [ "$OTHER_AWS_ID" != "false" ]; then
	if [ -n "$AWS_REGION" ] && [ -n "$AWS_ACCESS_KEY_ID" ] && [ -n "$AWS_SECRET_ACCESS_KEY" ]; then
		cat > /etc/awslogs/awscli.conf <<EOF
[plugins]
cwlogs = cwlogs
[default]
region = ${AWS_REGION}
aws_access_key_id = ${AWS_ACCESS_KEY_ID}
aws_secret_access_key = ${AWS_SECRET_ACCESS_KEY}
EOF
	else
                echo 'ERROR: OTHER_AWS_ID variable env has been set'
                echo 'Please check if you have the following ENV setup :
                - --env AWS_REGION
                - --env AWS_ACCESS_KEY_ID
                - --env AWS_SECRET_ACCESS_KEY
                - --env OTHER_AWS_ID'
                exit 1
	

	fi
fi


exec /usr/local/bin/supervisord -c /etc/supervisord.conf
#/usr/sbin/awslogsd
