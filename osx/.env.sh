#!/usr/bin/env bash

SCRIPTS_OSX="$(dirname $0)"

osx-self-upgrade() { git -C "${SCRIPTS_OSX}" pull }
osx-upgrade() { "${SCRIPTS_OSX}/osx-upgrade.sh" }
