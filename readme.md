# Notice: this is a test

## This file is only public so it can be downloaded from github, while testing this script

## Please do NOT run this script, because it is currently untested and may frequently be modified, making it unstable

# Empoleos

## Installation

First you will need to install [Fedora Server](https://fedoraproject.org/server/download/) or another fedora cli based on dnf.
Fedora Server is used for both the Desktop GUI and Server CLI.

After booting into the server cli, run one of the following scripts.

### For Desktop GUI

```shell
sudo dnf -y install git
git clone https://github.com/AspieSoft/Empoleos.git
Empoleos/install.sh
```

### For Server CLI

```shell
sudo dnf -y install git
git clone https://github.com/AspieSoft/Empoleos.git
Empoleos/install.sh --server
```
