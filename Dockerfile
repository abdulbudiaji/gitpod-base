FROM gitpod/workspace-base

RUN apt-get update
RUN apt-get install -y strace
