#!/bin/bash

cat >> /etc/awslogs/awscli.conf <<EOF
[plugins]
cwlogs = cwlogs
[default]
region = ${REGION}
EOF

cat >> /etc/awslogs/awslogs.conf <<EOF
[${LOGFILE}]
datetime_format = ${LOGFORMAT}
file = ${LOGFILE}
buffer_duration = ${DURATION}
log_stream_name = ${LOGSTREAM}
initial_position = start_of_file
log_group_name = ${GROUPNAME}
EOF

exec /usr/local/bin/supervisord -c /etc/supervisord.conf
#/usr/sbin/awslogsd
