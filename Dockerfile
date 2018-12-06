FROM centos:centos7

RUN yum install -y epel-release && \
    yum clean all
RUN yum install -y redhat-rpm-config \
    make automake autoconf gcc gcc-c++ \
    libstdc++ libstdc++-devel \
    java-1.8.0-openjdk wget curl \
    xmlstarlet git x11vnc gettext tar \
    xorg-x11-server-Xvfb openbox xterm \
    net-tools python-pip \
    firefox nss_wrapper java-1.8.0-openjdk-headless \
    java-1.8.0-openjdk-devel nss_wrapper git && \
    yum clean all
RUN yum install -y python-devel python2-pip && \
   pip install --upgrade zapcli && \
   pip install python-owasp-zap-v2.4 && \
   groupadd -g 103399 zap && \
   useradd -u 103399 -g 103399 zap && \
   mkdir -p /opt/w3af
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LOGNAME zap

USER zap
COPY zap-scripts/webswing.config /zap/webswing/webswing.config

RUN mkdir /home/zap/.vnc
ENV PATH /zap/:$PATH
ENV ZAP_PATH /zap/zap.sh
ENV HOME /home/zap

USER root
ADD https://github.com/zaproxy/zaproxy/releases/download/2.7.0/ZAP_2.7.0_Linux.tar.gz /home/zap/
RUN tar -xzvf /home/zap/ZAP_2.7.0_Linux.tar.gz && \
	cp -r ZAP_2.7.0/* /zap
RUN mkdir /zap/wrk
COPY zap-scripts/* /zap/
RUN chown zap:zap /zap/zap-baseline.py && \
	chown zap:zap /zap/zap-webswing.sh && \
	chown zap:zap /zap/zap_common.py && \
	chown zap:zap /zap/webswing/webswing.config && \
	chown -R zap:zap  /zap  && \
	chmod +x /zap/zap.sh && \
	chmod +x /zap/zap-x.sh && \
	chmod +x /zap/zap-baseline.py && \
	rm -rf /zap-src
USER zap
