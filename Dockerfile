FROM node:18-buster

RUN apt-get update && \
      apt-get -y install sudo nano

RUN addgroup --gid 1000 nodejs
# RUN useradd --uid 1000 --gid nodejs --shell /bin/bash --create-home nodejs
RUN adduser --disabled-password --gecos '' --uid 1000 --gid 1000 nodejs
RUN usermod -aG sudo nodejs
RUN echo "nodejs ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers

# Setting the apt proxy configuration
COPY apt.conf /etc/apt/apt.conf

USER nodejs
WORKDIR /home/nodejs

# Installing the zsh
# RUN sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.1.5/zsh-in-docker.sh)"

# ENTRYPOINT [ "/bin/bash" ]
CMD [ "tail", "-f", "/dev/null" ]