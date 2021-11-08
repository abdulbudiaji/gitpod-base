FROM gitpod/workspace-base

USER root

RUN apt-get update
RUN apt-get install -y strace

USER gitpod
