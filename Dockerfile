FROM amazonlinux
ENV USE_ENV "false"
ENV OTHER_AWS_ID "false"
ENV AWS_REGION = "us-east-1"
RUN yum update -y && yum install -y \
		awslogs \
	&& yum clean all \
	&& easy_install supervisor

COPY supervisord.conf /etc/supervisord.conf
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
CMD /entrypoint.sh

