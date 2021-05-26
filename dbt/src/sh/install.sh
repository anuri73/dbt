#!/bin/bash

# Exit script on first error
set -e

# Capture start_time
start_time=$(date +%s)

VENV_DIR=${DBT_HOME}/.virtualenvs

make_virtual_env() {
  echo "Making Virtual Environment for [$1] in $VENV_DIR"
  python3 -m venv $VENV_DIR/$1
  source $VENV_DIR/$1/bin/activate

  echo ""
}

install_pip() {

  echo "Installing dbt"

  python3 -m pip install --upgrade pip setuptools wheel

  cd $DBT_SOURCE

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
}

make_virtual_env dbt

install_pip dbt

deactivate

# Capture end_time
end_time=$(date +%s)

echo
echo "--------------------------------------------------------------------------"
echo "DBT installed successfully in $((end_time - start_time)) seconds"
echo "--------------------------------------------------------------------------"
