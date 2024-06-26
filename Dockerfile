FROM ubuntu:22.04

LABEL maintainer="Martin Mirchev <mmirchev@comp.nus.edu.sg>"

#############################################################################
# Requirements
#############################################################################

RUN \
  apt-get update -y && \
  apt-get install software-properties-common -y && \
  apt-get update -y && \
  apt-get install -y openjdk-11-jdk \
                git \
                build-essential \
				subversion \
				perl \
				curl \
        maven \
        gradle \
        ant \
				unzip \
				cpanminus \
				make \
                && \
  rm -rf /var/lib/apt/lists/*

# Java version
ENV JAVA_HOME /usr/lib/jvm/java-11-openjdk-amd64

# Timezone
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

WORKDIR /

RUN mkdir /flacoco

COPY . /flacoco

WORKDIR /flacoco

RUN mvn install -DskipTests
