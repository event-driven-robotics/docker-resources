FROM ubuntu:24.04

RUN apt-get update \
    && apt-get install --yes --no-install-recommends sudo \
    && echo "ubuntu ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/ubuntu \
    && chmod 0440 /etc/sudoers.d/ubuntu \
    && rm -rf /var/lib/apt/lists/*

USER ubuntu
WORKDIR /home/ubuntu
