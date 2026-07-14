FROM ubuntu:22.04

RUN apt-get update \
    && apt-get install --yes --no-install-recommends sudo \
    && groupadd --gid 1000 container-user \
    && useradd --uid 1000 --gid container-user --create-home --shell /bin/bash container-user \
    && echo "container-user ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/container-user \
    && chmod 0440 /etc/sudoers.d/container-user \
    && rm -rf /var/lib/apt/lists/*

USER container-user
WORKDIR /home/container-user
