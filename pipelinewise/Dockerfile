FROM python:3.7.4-buster

RUN apt-get -qq update && apt-get -qqy install \
        apt-utils \
        alien \
        libaio1 \
        mbuffer \
        wget \
        coreutils \
    && pip install --upgrade pip

COPY dev /opt/pipelinewise/dev

COPY src /opt/pipelinewise/src

ENV PIPELINEWISE_SRC="/opt/pipelinewise/src"
ENV PIPELINEWISE_HOME="/opt/pipelinewise/dev"

RUN ["/opt/pipelinewise/dev/sh/entrypoint.sh"]

WORKDIR "/opt/pipelinewise/dev"

ENTRYPOINT ["sleep", "infinity"]
