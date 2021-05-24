FROM python:3.7.4-buster

RUN apt-get -qq update && apt-get -qqy install \
        apt-utils \
        alien \
        libaio1 \
        mbuffer \
        wget \
        coreutils \
    && pip install --upgrade pip

COPY dev /opt/dbt/dev

COPY src /opt/dbt/src

ENV DBT_SRC="/opt/dbt/src"
ENV DBT_HOME="/opt/dbt/dev"

RUN ["/opt/dbt/src/sh/entrypoint.sh"]

WORKDIR "/opt/dbt/dev"

ENTRYPOINT ["sleep", "infinity"]