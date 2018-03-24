#!/bin/bash


if [ "$AWSCLI_ENV" != "false" ]; then
	if [ -n "$AWS_ACCESS_KEY_ID" ] && [ -n "$AWS_SECRET_ACCESS_KEY" ]; then
		cat > /etc/awslogs/awscli.conf <<EOF
[plugins]
cwlogs = cwlogs
[default]
region = ${AWS_REGION}
aws_access_key_id = ${AWS_ACCESS_KEY_ID}
aws_secret_access_key = ${AWS_SECRET_ACCESS_KEY}
EOF
	else
cat > /etc/awslogs/awscli.conf <<EOF
[plugins]
cwlogs = cwlogs
[default]
region = ${AWS_REGION}
EOF
	fi
fi

if [ "$AWSLOGS_ENV" != "false" ]; then
cat > /etc/awslogs/awslogs.conf <<EOF
[general]
state_file = /var/lib/awslogs/agent-state
EOF
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
	fi

fi


exec /usr/local/bin/supervisord -c /etc/supervisord.conf
#/usr/sbin/awslogsd
