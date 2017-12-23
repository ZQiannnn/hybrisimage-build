FROM java:openjdk-8-alpine

#作者
MAINTAINER ZQiannnn,<604922962@qq.com>

COPY hybris /opt/hybris


RUN cd /opt/hybris && ls

ENV PLATFORM_HOME=/opt/hybris/bin/platform
ENV PATH=$PLATFORM_HOME/apache-ant-1.9.1/bin:$PATH

VOLUME ["/opt/hybris/config","/opt/hybris/bin/custom"]

ENV REGISTRY=""
ENV USERNAME=""
ENV PASSWORD=""
ENV IMAGE_TAG=""

COPY HYRRIS_BASE_IMAGE /root/Dockerfile

COPY docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]