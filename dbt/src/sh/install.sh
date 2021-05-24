#!/bin/bash

# Exit script on first error
set -e

# Capture start_time
start_time=`date +%s`

# Source directory defined as location of install.sh
SRC_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/../" >/dev/null 2>&1 && pwd )"

# Install dbt venvs in the present working directory
DBT_HOME=$(pwd)
VENV_DIR=${DBT_HOME}/.virtualenvs

make_virtualenv() {
    echo "Making Virtual Environment for [$1] in $VENV_DIR"
    python3 -m venv $VENV_DIR/$1
    source $VENV_DIR/$1/bin/activate
    python3 -m pip install --upgrade pip setuptools wheel

    if [ -f "requirements.txt" ]; then
        python3 -m pip install --upgrade -r requirements.txt
    fi
    if [ -f "setup.py" ]; then
        PIP_ARGS=
        if [[ ! $NO_TEST_EXTRAS == "YES" ]]; then
            PIP_ARGS=$PIP_ARGS"[test]"
        fi

        python3 -m pip install --upgrade -e .$PIP_ARGS
    fi

    echo ""

    deactivate
}

make_virtualenv dbt

# Capture end_time
end_time=`date +%s`

echo
echo "--------------------------------------------------------------------------"
echo "DBT installed successfully in $((end_time-start_time)) seconds"
echo "--------------------------------------------------------------------------"