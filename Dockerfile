FROM gitpod/workspace-base

RUN apt-get updatedd
RUN apt-get install -y strace
