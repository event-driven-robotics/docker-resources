FROM ubuntu:22.04

RUN groupadd --gid 1000 container-user \
    && useradd --uid 1000 --gid container-user --create-home --shell /bin/bash container-user

USER container-user
WORKDIR /home/container-user

