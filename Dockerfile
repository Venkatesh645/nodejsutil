FROM node:18-buster

RUN apt-get update && \
      apt-get -y install sudo nano

# RUN addgroup --gid 1000 nodejs
# RUN adduser --disabled-password --gecos '' --uid 1000 --gid 1000 nodejs
RUN usermod -aG sudo node
RUN echo "node ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers

# Setting the apt proxy configuration
COPY apt.conf /etc/apt/apt.conf

USER node
WORKDIR /home/node

RUN mkdir ~/.npm-global && npm config set prefix '~/.npm-global'
ENV PATH=/home/node/.npm-global/bin:$PATH
RUN . ~/.bashrc && npm install npm -g

# Installing the zsh
# RUN sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.1.5/zsh-in-docker.sh)"

# ENTRYPOINT [ "/bin/bash" ]
CMD [ "tail", "-f", "/dev/null" ]