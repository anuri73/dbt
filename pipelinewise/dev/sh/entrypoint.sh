#!/usr/bin/env bash

# Install OS dependencies
apt-get update
apt-get install -y postgresql-client

# Change to dev folder
cd "$PIPELINEWISE_HOME" || exit

# Build test databasese
$PIPELINEWISE_HOME/sh/taps.sh

$PIPELINEWISE_SRC/tests/db/target_postgres.sh

# Install PipelineWise in the container
$PIPELINEWISE_SRC/install.sh --acceptlicenses --nousage --connectors=target-postgres,tap-postgres,transform-field
if [[ $? != 0 ]]; then
    echo
    echo "ERROR: Docker container not started. Failed to install one or more PipelineWise components."
    ls -lah
    exit 1
fi

# Activate CLI virtual environment at every login
sed -i '/motd/d' ~/.bashrc  # Delete any existing old DO_AT_LOGIN line from bashrc
DO_AT_LOGIN="cd $PIPELINEWISE_HOME && source $PIPELINEWISE_HOME/.virtualenvs/pipelinewise/bin/activate && CURRENT_YEAR=\$(date +'%Y') envsubst < $PIPELINEWISE_SRC/motd"
echo $DO_AT_LOGIN >> ~/.bashrc

echo
echo "=========================================================================="
echo "PipelineWise Dev environment is ready in Docker container(s)."
echo
echo "Running containers:"
echo "   - PipelineWise CLI and connectors"
echo "   - PostgreSQL server with test database  (From host: localhost:${TAP_POSTGRES1_PORT_ON_HOST} - From CLI: ${TAP_POSTGRES1_HOST}:${TAP_POSTGRES1_PORT})"
echo "   - PostgreSQL server with empty database (From host: localhost:${TARGET_POSTGRES_PORT_ON_HOST} - From CLI: ${TARGET_POSTGRES_HOST}:${TARGET_POSTGRES_PORT})"
echo "(For database credentials check .env file)"
echo
echo
echo "To login to the PipelineWise container and start using Pipelinewise CLI:"
echo " $ docker exec -it dbt_pipelinewise bash"
echo " $ pipelinewise status"
echo "=========================================================================="
