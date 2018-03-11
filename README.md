# Upgrade scripts

## OSX

### Installation

#### Automatic 

Via **curl** *(preferred way)*

```bash
curl https://raw.githubusercontent.com/Irvyne/upgrade-scripts/master/install/osx.sh | sh
```

Via **wget**

```bash
wget -O - https://raw.githubusercontent.com/Irvyne/upgrade-scripts/master/install/osx.sh | sh
```

#### Manual

> Install repository (git mandatory)

```bash
git clone https://github.com/Irvyne/upgrade-scripts ~/.osx-scripts
```

> Import custom functions in your shell

* Bash *(default on mac)*

```bash
echo "if [ -f "$(echo ~)/.osx-scripts/osx/.env.sh" ] ; then source "$(echo ~)/.osx-scripts/osx/.env.sh" ; fi" >> ~/.bashrc
```

* ZSH *(preferred but not installed by default, use `brew install zsh` and install `oh-my-zsh` after)*

```bash
echo "if [ -f "$(echo ~)/.osx-scripts/osx/.env.sh" ] ; then source "$(echo ~)/.osx-scripts/osx/.env.sh" ; fi" >> ~/.zshrc
```

### Usage

Open your terminal and enter `osx-upgrade` to upgrade components/packages (only if present on the system).

* **oh-my-zsh** Upgrade [Oh My Zsh](https://github.com/robbyrussell/oh-my-zsh).
* **homebrew** Upgrade [Homebrew](http://brew.sh) outdated & unpinned packages + clean old versions & symlinks.
* **composer** Upgrade [Composer](https://getcomposer.org/download) to the latest stable version + upgrade global packages installed.
* **npm** Upgrade all [NPM](https://www.npmjs.com/) packages (globally installed) to the latest version (use [Yarn](https://yarnpkg.com) instead if found).
* **pip** Upgrade all [PIP](https://pip.pypa.io/en/stable/) packages to the latest version.
* **pip3** Upgrade all [PIP3](https://pip.pypa.io/en/stable/) packages to the latest version.
* **gcloud** Upgrade all [Google Cloud Components](https://cloud.google.com/sdk/gcloud/reference/components/update) to the latest version.

```bash
osx-upgrade
```

![osx-upgrade.sh terminal screenshot](assets/osx/osx-upgrade.png?raw=true)
