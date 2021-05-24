#!/usr/bin/env bash

# Install OS dependencies
apt-get update

# Change to dev folder
cd "$DBT_HOME" || exit

# Install DBT in the container
$DBT_SRC/sh/install.sh
if [[ $? != 0 ]]; then
    echo
    echo "ERROR: Docker container not started. Failed to install one or more DBT components."
    ls -lah
    exit 1
fi

# Activate CLI virtual environment at every login
sed -i '/motd/d' ~/.bashrc  # Delete any existing old DO_AT_LOGIN line from bashrc
DO_AT_LOGIN="cd $DBT_HOME && source $DBT_HOME/.virtualenvs/dbt/bin/activate"
echo $DO_AT_LOGIN >> ~/.bashrc

echo
echo "=========================================================================="
echo "DBT environment is ready in Docker container(s)."
echo
