From ubuntu:trusty
MAINTAINER Elliott Ye

# Set noninteractive mode for apt-get
ENV DEBIAN_FRONTEND noninteractive

# Update
RUN apt-get update

# Start editing
# Install package here for cache
RUN apt-get -y install supervisor postfix sasl2-bin opendkim opendkim-tools

#Update rsyslog V8
#Update rsyslog V8
RUN apt-get -y install software-properties-common
RUN add-apt-repository ppa:adiscon/v8-stable
RUN apt-get update
RUN apt-get -y install rsyslog rsyslog-pgsql

# Add files
ADD assets/install.sh /opt/install.sh

# Run
CMD /opt/install.sh;/usr/bin/supervisord -c /etc/supervisor/supervisord.conf
