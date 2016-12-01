##############################################################################
# Dockerfile to build Atlassian JIRA ServiceDesk container images
# Based on anapsix/alpine-java:8_server-jre
##############################################################################

FROM anapsix/alpine-java:8_server-jre

MAINTAINER //SEIBERT/MEDIA GmbH <docker@seibert-media.net>

ARG VERSION

ENV JIRA_INST /opt/atlassian/jira
ENV JIRA_HOME /var/opt/atlassian/application-data/jira

RUN set -x \
  && apk add git tar xmlstarlet --update-cache --allow-untrusted --repository http://dl-cdn.alpinelinux.org/alpine/edge/main --repository http://dl-cdn.alpinelinux.org/alpine/edge/community \
  && rm -rf /var/cache/apk/*

RUN set -x \
  && mkdir -p $JIRA_INST \
  && mkdir -p $JIRA_HOME

ADD https://www.atlassian.com/software/jira/downloads/binary/atlassian-servicedesk-$VERSION.tar.gz /tmp

RUN set -x \
  && tar xvfz /tmp/atlassian-servicedesk-$VERSION.tar.gz --strip-components=1 -C $JIRA_INST \
  && rm /tmp/atlassian-servicedesk-$VERSION.tar.gz

RUN set -x \
  && touch -d "@0" "$JIRA_INST/conf/server.xml" \
  && touch -d "@0" "$JIRA_INST/bin/setenv.sh" \
  && touch -d "@0" "$JIRA_INST/atlassian-jira/WEB-INF/classes/jira-application.properties"

ADD files/entrypoint /usr/local/bin/entrypoint

RUN set -x \
  && chown -R daemon:daemon /usr/local/bin/entrypoint \
  && chown -R daemon:daemon $JIRA_INST \
  && chown -R daemon:daemon $JIRA_HOME

EXPOSE 8080

USER daemon

VOLUME $JIRA_HOME

ENTRYPOINT  ["/usr/local/bin/entrypoint"]
