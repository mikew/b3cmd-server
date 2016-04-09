FROM alpine

ENV DOCKER_VERSION=1.10.3
ENV DOCKER_COMPOSE_VERSION=1.6.2

RUN apk add --update bash curl git openssh py-pip py-yaml rsync \
    && echo 'ChallengeResponseAuthentication no' >> /etc/ssh/sshd_config \
    && echo 'PasswordAuthentication no' >> /etc/ssh/sshd_config \
    && echo 'HostKey /home/b3cmd/data/sshd/ssh_host_rsa_key' >> /etc/ssh/sshd_config \
    && echo 'HostKey /home/b3cmd/data/sshd/ssh_host_dsa_key' >> /etc/ssh/sshd_config \
    && echo 'HostKey /home/b3cmd/data/sshd/ssh_host_ecdsa_key' >> /etc/ssh/sshd_config \
    && echo 'HostKey /home/b3cmd/data/sshd/ssh_host_ed25519_key' >> /etc/ssh/sshd_config \
    && curl -L https://get.docker.com/builds/Linux/x86_64/docker-${DOCKER_VERSION} --output /usr/local/bin/docker \
        && chmod +x /usr/local/bin/docker \
    && pip install docker-compose==${DOCKER_COMPOSE_VERSION} \
    && adduser -D b3cmd b3cmd \
        && passwd -u b3cmd

COPY ./app /app

VOLUME  /home/b3cmd/data
EXPOSE 22
ENTRYPOINT ["/app/entrypoint"]
