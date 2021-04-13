FROM postgres

RUN apt-get update && apt-get install -y curl

RUN curl -L https://raw.githubusercontent.com/mbucc/shmig/master/shmig > /usr/local/bin/shmig \
  && chmod u+x /usr/local/bin/shmig

COPY migrate.sh /run/migrate.sh

COPY ./migrations /migrations

RUN chmod +x /run/migrate.sh

ENTRYPOINT ["/run/migrate.sh"]