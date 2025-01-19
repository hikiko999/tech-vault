FROM ubuntu:24.04

RUN apt update -y && apt install openssh-server sudo -y
RUN echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

EXPOSE 22
RUN service ssh start

CMD ["sh","-c", "service ssh start && tail -f /dev/null"]
# tail will keep the container running