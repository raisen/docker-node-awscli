FROM ubuntu:latest
RUN apt update
RUN apt install -y software-properties-common
RUN add-apt-repository ppa:git-core/ppa
RUN apt update
RUN apt install -y curl unzip git

RUN curl -fsSL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get install -y nodejs

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN ./aws/install
CMD ["node"]
