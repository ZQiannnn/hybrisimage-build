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

ENV JAVA_VERSION 8u111
ENV JAVA_ALPINE_VERSION 8.121.13-r0

RUN set -x \
	&& apk add --no-cache \
		openjdk8="$JAVA_ALPINE_VERSION"  bash\
	&& [ "$JAVA_HOME" = "$(docker-java-home)" ]


#Set Up Hybris
COPY hybris /opt/hybris


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