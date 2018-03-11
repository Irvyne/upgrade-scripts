#!/usr/bin/env bash

##########
# Config #
##########

USER_DIR=$(echo ~)
SCRIPTS_DIR="${USER_DIR}/.osx-scripts"
BASHRC="${USER_DIR}/.bashrc"
ZSHRC="${USER_DIR}/.zshrc"

########
# Init #
########

git clone https://github.com/Irvyne/upgrade-scripts "${SCRIPTS_DIR}" || exit 1

if [ -n "`$SHELL -c 'echo $ZSH_VERSION'`" ]; then
    touch ${ZSHRC} &&
    echo "if [ -f \"${SCRIPTS_DIR}/osx/.env.sh\" ] ; then source "${SCRIPTS_DIR}/osx/.env.sh" ; fi" >> ${ZSHRC} &&
    echo "\nRestart your terminal to apply configuration changes.\n"
elif [ -n "`$SHELL -c 'echo $BASH_VERSION'`" ]; then
    touch ${BASHRC} &&
    echo "if [ -f \"${SCRIPTS_DIR}/osx/.env.sh\" ] ; then source "${SCRIPTS_DIR}/osx/.env.sh" ; fi" >> ${BASHRC} &&
    echo "\nRestart your terminal to apply configuration changes.\n"
else
    printf "Unable to guess shell environment, check https://github.com/Irvyne/upgrade-scripts#readme to manually install shell functions."
fi
