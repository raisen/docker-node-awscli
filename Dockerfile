FROM node:14-alpine
 
RUN apk add --no-cache zip git curl wget gnupg bash libstdc++ binutils python3 make cmake gcc libc-dev libffi-dev openssl-dev
RUN ln -sf python3 /usr/bin/python

RUN pip3 install --no-cache --upgrade pip setuptools

ENV AWSCLI_VERSION=2.2.1

RUN curl https://awscli.amazonaws.com/awscli-${AWSCLI_VERSION}.tar.gz | tar -xz \
    && cd awscli-${AWSCLI_VERSION} \
    && ./configure --prefix=/opt/aws-cli/ --with-download-deps \
    && make \
    && make install
    
# jq
ENV JQ_VERSION='1.6'
RUN wget --no-check-certificate https://raw.githubusercontent.com/stedolan/jq/master/sig/jq-release.key -O /tmp/jq-release.key && \
    wget --no-check-certificate https://raw.githubusercontent.com/stedolan/jq/master/sig/v${JQ_VERSION}/jq-linux64.asc -O /tmp/jq-linux64.asc && \
    wget --no-check-certificate https://github.com/stedolan/jq/releases/download/jq-${JQ_VERSION}/jq-linux64 -O /tmp/jq-linux64 && \
    gpg --import /tmp/jq-release.key && \
    gpg --verify /tmp/jq-linux64.asc /tmp/jq-linux64 && \
    cp /tmp/jq-linux64 /usr/bin/jq && \
    chmod +x /usr/bin/jq && \
    rm -f /tmp/jq-release.key && \
    rm -f /tmp/jq-linux64.asc && \
    rm -f /tmp/jq-linux64
    
RUN apk --no-cache del binutils curl zip wget gnupg make cmake gcc libc-dev libffi-dev openssl-dev
RUN rm -rf /var/cache/apk/*

CMD ["node"]
