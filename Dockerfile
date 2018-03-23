FROM amazonlinux


RUN yum update -y && yum install -y \
		awslogs \
	&& yum clean all \
	&& easy_install supervisor

COPY supervisord.conf /etc/supervisord.conf
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
CMD /entrypoint.sh

