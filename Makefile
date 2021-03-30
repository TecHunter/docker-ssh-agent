ROOT:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

IMAGE_NAME:=techunter/jenkins-graalvm-ssh-agent
IMAGE_JDK8:=${IMAGE_NAME}:jdk8
IMAGE_JDK11:=${IMAGE_NAME}:jdk11

build: prepare build-jdk11 build-jdk8

clean:
	rm -Rf .build/

prepare:
	mkdir -p .build
	cp -f setup-sshd .build
	chmod +x .build/setup-sshd

build-jdk8:
	cp -f graalvm/8/Dockerfile .build/
	docker build -t ${IMAGE_JDK8} .build

build-jdk11:
	cp -f graalvm/11/Dockerfile .build/
	docker build -t ${IMAGE_JDK11} .build
