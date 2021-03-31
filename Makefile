ROOT:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

IMAGE_NAME:=techunter/jenkins-graalvm-agent

build: prepare build-jdk11 build-jdk8

clean:
	rm -Rf .build/

prepare:
	mkdir -p .build
	cp -f graalvm/* .build/
	chmod +x .build/*.sh

build-jdk8:
	sed -i .build/Dockerfile -e 's|#DOCKER_IMAGE#|ghcr.io/graalvm/graalvm-ce:java8-21.0.0.2|'
	docker build -t ${IMAGE_NAME}:jdk8 .build

build-jdk11:
	cp -f graalvm/* .build/
	cp -f builders/maven/* .build/
	sed -i .build/Dockerfile -e 's|#DOCKER_IMAGE#|ghcr.io/graalvm/graalvm-ce:java11-21.0.0.2|'
	docker build -t ${IMAGE_NAME}:jdk11 .build
