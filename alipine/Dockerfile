FROM mesosphere/jenkins-dind:0.6.0-alpine

#作者
MAINTAINER ZQiannnn,<604922962@qq.com>

#Set Up Other
RUN set -x \
	&& apk add --no-cache  nodejs

#Set Up Hybris
ENV PLATFORM_HOME=/opt/hybris/bin/platform
ENV PATH=$PLATFORM_HOME/apache-ant-1.9.1/bin:$PATH
#
VOLUME ["/opt/hybris/config","/opt/hybris/bin/custom","/opt/binaries"]
#
ENV REGISTRY=""
ENV USERNAME=""
ENV PASSWORD=""
ENV IMAGE_TAG=""

# Set Up Docker
COPY hybris-base-image.tar /root/hybris-base-image.tar

COPY HYRRIS_BASE_IMAGE /root/Dockerfile

COPY startup.sh /usr/local/bin/startup.sh
COPY wrapper.sh /usr/local/bin/wrapper.sh


ENTRYPOINT ["wrapper.sh"]
CMD ["startup.sh"]