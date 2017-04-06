FROM ubuntu:16.04
MAINTAINER jake@apache.org

ENV LEIN_ROOT true

#
# Jepsen dependencies
#
RUN apt-get -y -q update && \
    apt-get -y -q install software-properties-common && \
    add-apt-repository ppa:openjdk-r/ppa && \
    apt-get -y -q update && \
    apt-get install -qqy \
        openjdk-8-jdk \
        libjna-java \
        git \
        gnuplot \
        wget \
        vim

RUN wget https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein && \
    mv lein /usr/bin && \
    chmod +x /usr/bin/lein && \
    lein self-install

ADD ./bashrc /root/.bashrc

CMD cd /jepsen/jepsen && \
    lein install && \
    echo "" > ~/.ssh/known_hosts && \
    for n in $(seq 1 5); do ssh-keyscan -t rsa n$n; done >> ~/.ssh/known_hosts && \
    /bin/bash

