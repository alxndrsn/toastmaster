# from https://stackoverflow.com/questions/30301198/android-sdk-tools-install-in-docker-fails
FROM ubuntu:14.04

# Set debconf to run non-interactively
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# Install base dependencies
RUN apt-get update && apt-get install -y -q --no-install-recommends \
		ant \
		apt-transport-https \
		build-essential \
		ca-certificates \
		curl \
		git \
		libssl-dev \
		python \
		rsync \
		software-properties-common \
		wget \
	&& rm -rf /var/lib/apt/lists/*

# Fix certs for adding webupd8team/java PPA
RUN apt-get install --reinstall ca-certificates

# Install the JDK
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
	echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections && \
	sudo -E add-apt-repository -y ppa:webupd8team/java && \
	apt-get update -qq && \
	DEBIAN_FRONTEND=noninteractive apt-get install -qqy --force-yes oracle-java7-installer && \
	rm -rf /var/lib/apt/lists/* /var/cache/oracle-jdk7-installer

# Install Android Dev Tools
RUN apt-get update && apt-get install -y -q --no-install-recommends \
		lib32ncurses5 \
		lib32stdc++6 \
		lib32z1 \
		libswt-gtk-3-java \
		unzip \
	&& rm -rf /var/lib/apt/lists/*
RUN wget -qO- "http://dl.google.com/android/android-sdk_r24.2-linux.tgz" | tar -zxv -C /opt/
RUN cd /opt/android-sdk-linux/tools/ && \
	echo y | ./android update sdk --all --filter platform-tools,build-tools-22.0.1,android-21,sysimg-21,system-image,extra-android-support --no-ui --force && \
	ls -al /opt/android-sdk-linux/build-tools
ENV ANDROID_HOME /opt/android-sdk-linux
ENV PATH $ANDROID_HOME/tools:$PATH
ENV PATH $ANDROID_HOME/build-tools/22.0.1:$PATH

RUN cd /opt && wget -cq https://download.01.org/crosswalk/releases/crosswalk/android/stable/13.42.319.11/crosswalk-13.42.319.11.zip && \
		unzip -q crosswalk-13.42.319.11.zip -d crosswalk && \
		rm crosswalk-13.42.319.11.zip && \
		cd crosswalk && ls -al && \
		echo 'Extracted crosswalk to: ' && pwd
