# Runtime stage
FROM thies88/1-base-ubuntu:focal

ARG BUILD_DATE
ARG VERSION
LABEL build_version="version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="Thies88"

# define application name for apt (example: grafana)
ENV APP=""
# set needed deps for apt (example: telegraf influxdb inetutils-ping)
ENV APP_DEPS=""
# set debugmode to enable ${APP_LOG} and fil the path to the log file your created (default = 0)
ENV APP_DEBUGMODE=0
# set app path if needed. Some app return: xxx not found so you ahve to set the path to the executatble (example: /usr/bin/)
ENV APP_PATH=""

# set application commandline name to start with container (example: grafana-server)
ENV START_APP1=""
ENV APP_ARGS1=""
ENV APP_LOG1=""

ENV START_APP2=""
ENV APP_ARGS2=""
ENV APP_LOG2=""

RUN \

# If you need to add an repository add this peace if not then delete
 echo "**** install application and needed packages ****" && \
 #echo "deb https://packages.grafana.com/oss/deb stable main" > /etc/apt/sources.list.d/grafana.list && \
 #curl -o /tmp/gpg.key https://packages.grafana.com/gpg.key && \
 #apt-key add /tmp/gpg.key && \
 #echo "deb https://repos.influxdata.com/ubuntu ${REL} stable" > /etc/apt/sources.list.d/influxdb.list && \
 #curl -o /tmp/influxdb.key https://repos.influxdata.com/influxdb.key && \
 #apt-key add /tmp/influxdb.key && \
# 
 
 apt-get update && \
 apt-get install -y --no-install-recommends \
	${APP_DEPS} \
	${APP} && \

echo "**** cleanup ****" && \
apt-get autoremove -y --purge && \
# Clean more temp/junk files
apt-get clean && \
 rm -rf \
	/tmp/* \
	/var/lib/apt/lists/* \
	/var/cache/apt/* \
	/var/tmp/* \
	/var/log/* \
	/usr/share/doc/* \
	/usr/share/info/* \
	/var/cache/debconf/* \
	/usr/share/man/* \
	/usr/share/locale/* \
	
# add local files
COPY root/ /

#expose some ports if needed
EXPOSE 80 443

ENTRYPOINT ["/init"]
