#!/usr/bin/env bash

##########
# Config #
##########

red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
blue=`tput setaf 4`
purple=`tput setaf 5`
cyan=`tput setaf 6`
white=`tput setaf 7`
bold=`tput bold`
reset=`tput sgr0`

version="1.0.0"

#############
# Functions #
#############

function binExists ()
{
    local bin=$1

    if ! type "$bin" > /dev/null 2>&1; then
        return 1; # false
    else
        return 0; # true
    fi
}

function fileExists ()
{
    local file=`which $1`

    if [ -f "$file" ] ; then
        return 0; # true
    else
        return 1; # false
    fi
}

function isBinWritable ()
{
    local file=`which $1`

    if [ -w "$file" ] ; then
        return 0; # true
    else
        echo "${red}${bold}`which $file`${reset}${red} is not writable!${reset}"
        return 1; # false
    fi
}

function isDirWritable ()
{
    local dir=$1

    if [ -w "$dir" ] ; then
        return 0; # true
    else
        echo "${red}${bold}`which $dir`${reset}${red} is not writable!${reset}"
        return 1; # false
    fi
}

function displayHeader ()
{
    local name=$1

    printf "\n${green}${bold}> Upgrading $name...$reset\n\n"
}

########
# Init #
########

while getopts ":s :v" opt; do
    case ${opt} in
        v)
            echo "v${version}"
            exit
        ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            exit
        ;;
    esac
done

#############
# Oh My ZSH #
#############

if [ -n "`$SHELL -c 'echo $ZSH_VERSION'`" ]; then
    displayHeader "Oh My Zsh"

    env ZSH=$ZSH sh $ZSH/tools/upgrade.sh
fi

############
# Homebrew #
############

if binExists brew ; then
    displayHeader "Homebrew"

    brew upgrade && # Fetch the newest version of Homebrew and all formulae from GitHub & upgrade outdated/unpinned brews.
    brew cleanup && # Remove any older versions from the cellar.
    brew prune # Remove dead symlinks from the Homebrew prefix.

    brew cask upgrade && # Upgrades all outdated casks
    brew cask cleanup # Cleans up cached downloads and tracker symlinks.
fi

############
# Composer #
############

if binExists composer ; then
    displayHeader "Composer"

    if isBinWritable composer ; then
        composer self-update &&
        composer global update
    fi
fi

#######
# NPM #
#######

if binExists yarn ; then
    displayHeader "Yarn"

    yarn global upgrade
else
    if binExists npm ; then
        displayHeader "NPM"

        if isDirWritable $(npm root -g) ; then
            npm update -g
        else
            echo "${red}${bold}$(npm root -g)${reset}${red} is not writable! You probably installed NodeJS as root (unlucky you are).${reset}"
            echo "${red}Try to run update as sudo ==> ${bold}sudo npm update -g${reset}${red} <==${reset}"
        fi
    fi
fi

#######
# PIP #
#######

if binExists pip ; then
    displayHeader "pip"

    if [ "`pip list --outdated --format=legacy`" == "" ] ; then
        echo 'Nothing to update...'
    else
        pip install -U `pip list --outdated | awk '!/Could not|ignored/ { print $1}'`
        printf "\n\n"
    fi
fi

########
# PIP3 #
########

if binExists pip3 ; then
    displayHeader "pip3"

    if [ "`pip3 list --outdated --format=legacy`" == "" ] ; then
        echo 'Nothing to update...'
    else
        pip3 install --upgrade `pip3 list --outdated --format=legacy | awk '!/Could not|ignored/ { print $1}'`
        printf "\n\n"
    fi
fi

##########
# GCloud #
##########

if binExists gcloud ; then
    displayHeader "Google Cloud"

    gcloud components update --quiet
fi

printf "\n"