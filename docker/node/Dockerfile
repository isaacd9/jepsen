FROM debian:jessie

RUN rm /etc/apt/apt.conf.d/docker-clean && \
    apt-get update &&  \
    apt-get install -y \
        sudo \
        vim \
        net-tools \
        sysvinit-core \
        sysvinit \
        sysvinit-utils \
        openssh-server && \
        apt-get remove -y --purge --auto-remove systemd && \
    mkdir /var/run/sshd && \
    chmod 0755 /var/run/sshd

RUN sed -i s/without-password/yes/g /etc/ssh/sshd_config && \
    echo "root:root" | chpasswd

EXPOSE 22

CMD /usr/sbin/sshd -D

