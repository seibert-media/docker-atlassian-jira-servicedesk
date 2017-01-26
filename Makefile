VERSION ?= 3.3.0
MYSQL_JDBC_VERSION ?= 5.1.40
REGISTRY ?= docker.seibert-media.net

default: build

all: build upload clean

clean:
	docker rmi $(REGISTRY)/seibertmedia/atlassian-jira-servicedesk:$(VERSION)

build:
	docker build --no-cache --rm=true --build-arg VERSION=$(VERSION) --build-arg MYSQL_JDBC_VERSION=$(MYSQL_JDBC_VERSION) -t $(REGISTRY)/seibertmedia/atlassian-jira-servicedesk:$(VERSION) .

upload:
	docker push $(REGISTRY)/seibertmedia/atlassian-jira-servicedesk:$(VERSION)
