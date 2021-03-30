ROOT:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

IMAGE_NAME:=techunter/jenkins-graalvm-agent

build: prepare build-jdk11 build-jdk8 build-maven-jdk11

clean:
	rm -Rf .build/

prepare:
	mkdir -p .build
	cp -f entrypoint.sh .build
	chmod +x .build/entrypoint.sh

build-jdk8:
	cp -f graalvm/8/* .build/
	docker build -t ${IMAGE_NAME}:jdk8 .build

build-jdk11:
	cp -f graalvm/11/* .build/
	docker build -t ${IMAGE_NAME}:jdk11 .build

build-maven-jdk11:
	cp -f builders/maven/* .build/
	docker build -t ${IMAGE_NAME}:maven-jdk11 .build
