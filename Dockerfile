FROM docker:17.03-dind

#作者
MAINTAINER ZQiannnn,<604922962@qq.com>

#Set Up Java
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories
RUN { \
		echo '#!/bin/sh'; \
		echo 'set -e'; \
		echo; \
		echo 'dirname "$(dirname "$(readlink -f "$(which javac || which java)")")"'; \
	} > /usr/local/bin/docker-java-home \
	&& chmod +x /usr/local/bin/docker-java-home
ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk
ENV PATH $PATH:/usr/lib/jvm/java-1.8-openjdk/jre/bin:/usr/lib/jvm/java-1.8-openjdk/bin

ENV JAVA_ALPINE_VERSION 8.121.13-r0

RUN set -x \
	&& apk add --no-cache \
		openjdk8="$JAVA_ALPINE_VERSION"  bash nodejs\
	&& [ "$JAVA_HOME" = "$(docker-java-home)" ]


#Set Up Hybris
COPY hybris/bin/ext-accelerator /opt/hybris/bin/ext-accelerator
COPY hybris/bin/ext-addon /opt/hybris/bin/ext-addon
COPY hybris/bin/ext-atdd /opt/hybris/bin/ext-atdd
COPY hybris/bin/ext-atddtests /opt/hybris/bin/ext-atddtests
COPY hybris/bin/ext-backoffice /opt/hybris/bin/ext-backoffice
COPY hybris/bin/ext-channel /opt/hybris/bin/ext-channel
COPY hybris/bin/ext-cockpit /opt/hybris/bin/ext-cockpit
COPY hybris/bin/ext-commerce /opt/hybris/bin/ext-commerce
COPY hybris/bin/ext-content /opt/hybris/bin/ext-content
COPY hybris/bin/ext-customer-experience /opt/hybris/bin/ext-customer-experience
COPY hybris/bin/ext-data /opt/hybris/bin/ext-data
COPY hybris/bin/ext-eventtracking /opt/hybris/bin/ext-eventtracking
COPY hybris/bin/ext-integration /opt/hybris/bin/ext-integration
COPY hybris/bin/ext-platform-backoffice /opt/hybris/bin/ext-platform-backoffice
COPY hybris/bin/ext-platform-optional /opt/hybris/bin/ext-platform-optional
COPY hybris/bin/ext-print /opt/hybris/bin/ext-print
COPY hybris/bin/ext-supportability /opt/hybris/bin/ext-supportability
COPY hybris/bin/ext-template /opt/hybris/bin/ext-template
COPY hybris/bin/platform /opt/hybris/bin/platform


ENV PLATFORM_HOME=/opt/hybris/bin/platform
ENV PATH=$PLATFORM_HOME/apache-ant-1.9.1/bin:$PATH
#
VOLUME ["/opt/hybris/config","/opt/hybris/bin/custom"]
#
ENV REGISTRY=""
ENV USERNAME=""
ENV PASSWORD=""
ENV IMAGE_TAG=""

# Set Up Docker
COPY hybris-base-image.tar /root/hybris-base-image.tar

COPY HYRRIS_BASE_IMAGE /root/Dockerfile

COPY startup.sh /usr/local/bin/startup.sh
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["startup.sh"]