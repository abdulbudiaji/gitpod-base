FROM debian:stretch-slim

USER root

RUN apt-get update
RUN apt-get install -y sudo git curl strace zip unzip htop jq make

ENV LANG=en_US.UTF-8
### Gitpod user ###
# '-l': see https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#user
RUN useradd -l -u 33333 -G sudo -md /home/gitpod -s /bin/bash -p gitpod gitpod
# passwordless sudo for users in the 'sudo' group
RUN echo '%sudo ALL=NOPASSWD:ALL' > /etc/sudoers.d/gitpod
ENV HOME=/home/gitpod
WORKDIR $HOME

# custom Bash prompt
RUN { echo && echo "PS1='\[\033[01;32m\]\u\[\033[00m\] \[\033[01;34m\]\w\[\033[00m\] $ '" ; } >> .bashrc
RUN chown gitpod:gitpod .bashrc

### Gitpod user (2) ###
USER gitpod
# use sudo so that user does not get sudo usage info on (the first) login
RUN sudo echo "Running 'sudo' for Gitpod: success" && \
    # create .bashrc.d folder and source it in the bashrc
    mkdir -p /home/gitpod/.bashrc.d && \
    (echo; echo "for i in \$(ls -A \$HOME/.bashrc.d/); do source \$HOME/.bashrc.d/\$i; done"; echo) >> /home/gitpod/.bashrc

