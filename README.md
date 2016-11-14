# docker-atlassian-jira-servicedesk

This is a Docker-Image for Atlassian JIRA ServiceDesk based on [Alpine Linux](http://alpinelinux.org/), which is kept as small as possible.

## Features

* Small image size
* Setting application context path
* Setting JVM xms and xmx values
* Setting proxy parameters in server.xml to run it behind a reverse proxy (TOMCAT_PROXY_* ENV)

## Variables

* TOMCAT_PROXY_NAME
* TOMCAT_PROXY_PORT
* TOMCAT_PROXY_SCHEME
* TOMCAT_CONTEXT_PATH
* JVM_MEMORY_MIN
* JVM_MEMORY_MAX

## Ports
* 8080

## Getting started

Run JIRA ServiceDesk standalone and navigate to `http://[dockerhost]:8080` to finish configuration:

```bash
docker run -tid -p 8080:8080 seibertmedia/atlassian-jira-servicedesk:latest
```

Run JIRA ServiceDesk standalone with customised jvm settings and navigate to `http://[dockerhost]:8080` to finish configuration:

```bash
docker run -tid -p 8080:8080 -e JVM_MEMORY_MIN=2g -e JVM_MEMORY_MAX=4g seibertmedia/atlassian-jira-servicedesk:latest
```

Specify persistent volume for JIRA ServiceDesk data directory and redirect application logs to stdout:

```bash
docker run -tid -p 8080:8080 -v jira_data:/var/opt/atlassian/application-data/jira seibertmedia/atlassian-jira-servicedesk:latest
```

Run JIRA ServiceDesk behind a reverse (SSL) proxy and navigate to `https://tasks.yourdomain.com`:

```bash
docker run -d -e TOMCAT_PROXY_NAME=tasks.yourdomain.com -e TOMCAT_PROXY_PORT=443 -e TOMCAT_PROXY_SCHEME=https seibertmedia/atlassian-jira-servicedesk:latest
```

Run JIRA ServiceDesk behind a reverse (SSL) proxy with customised jvm settings and navigate to `https://tasks.yourdomain.com`:

```bash
docker run -d -e TOMCAT_PROXY_NAME=tasks.yourdomain.com -e TOMCAT_PROXY_PORT=443 -e TOMCAT_PROXY_SCHEME=https -e JVM_MEMORY_MIN=2g -e JVM_MEMORY_MAX=4g seibertmedia/atlassian-jira-servicedesk:latest
```
