ROOT:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

IMAGE_NAME:=techunter/jenkins-graalvm-ssh-agent
IMAGE_JDK8:=${IMAGE_NAME}:jdk8
IMAGE_JDK11:=${IMAGE_NAME}:jdk11

build: build-jdk11 build-jdk8

build-jdk8:
	docker build -t ${IMAGE_JDK8} graalvm/8

build-jdk11:
	docker build -t ${IMAGE_JDK11} graalvm/11
