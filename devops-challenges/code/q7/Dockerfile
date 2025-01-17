FROM ubuntu:24.10

ENV ANSIBLE_USER=ansibleuser
ENV ANSIBLE_PW=changeme123

RUN apt update -y && apt install openssh-server -y
RUN useradd -m ${ANSIBLE_USER} -G sudo -p $(openssl passwd -1 ${ANSIBLE_PW})

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]