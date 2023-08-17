#!/bin/bash

dir="$1"

# install python, c++, and java
sudo dnf -y install python python3 python-pip python3-pip
sudo dnf -y install gcc-c++ make gcc
sudo dnf -y install java-1.8.0-openjdk.x86_64
sudo dnf -y install java-11-openjdk.x86_64
sudo dnf -y install java-latest-openjdk.x86_64

# install nodejs
sudo dnf -y install nodejs
sudo npm -g i npm
npm config set prefix ~/.npm

# add npm to current user
if ! [ -f "$HOME/.zshrc" ]; then
  sudo touch "$HOME/.zshrc"
fi
if ! [ -f "$HOME/.profile" ]; then
  sudo touch "$HOME/.profile"
fi
if ! grep -q 'export N_PREFIX="~/.npm"' "$HOME/.zshrc" ; then
  echo 'export N_PREFIX="~/.npm"' | sudo tee -a "$HOME/.zshrc"
fi
if ! grep -q 'export N_PREFIX="~/.npm"' "$HOME/.profile" ; then
  echo 'export N_PREFIX="~/.npm"' | sudo tee -a "$HOME/.profile"
fi
if ! [ -d "$HOME/.npm" ]; then
  sudo mkdir $(whoami) "$HOME/.npm"
  sudo chown -R $(whoami) "$HOME/.npm"
fi

# add npm for new user
if ! [ -f "/etc/skel/.zshrc" ]; then
  sudo touch "/etc/skel/.zshrc"
fi
if ! [ -f "/etc/skel/.profile" ]; then
  sudo touch "/etc/skel/.profile"
fi
if ! grep -q 'export N_PREFIX="~/.npm"' "/etc/skel/.zshrc" ; then
  echo 'export N_PREFIX="~/.npm"' | sudo tee -a "/etc/skel/.zshrc"
fi
if ! grep -q 'export N_PREFIX="~/.npm"' "/etc/skel/.profile" ; then
  echo 'export N_PREFIX="~/.npm"' | sudo tee -a "/etc/skel/.profile"
fi

# install yarn and git
sudo npm -g i yarn
sudo dnf -y install git

# install golang
sudo dnf -y install golang
sudo ln -s /lib/golang /usr/share/go
sudo dnf -y install pcre-devel
if ! grep -q "go" "$HOME/.hidden" ; then
  echo "go" | sudo tee -a "$HOME/.hidden"
fi
if ! grep -q "go" "/etc/skel/.hidden" ; then
  echo "go" | sudo tee -a "/etc/skel/.hidden"
fi

# add gopath
if ! test -f "/etc/profile.d/golang.sh"; then
  sudo touch "/etc/profile.d/golang.sh"
fi
if ! test -d "/usr/lib/go" && test -d "/usr/lib/golang"; then
  sudo ln -s "/usr/lib/golang" "/usr/lib/go"
fi
echo 'export GOROOT=/usr/lib/go' | sudo tee -a "/etc/profile.d/golang.sh"
echo 'export GOPATH=$HOME/go' | sudo tee -a "/etc/profile.d/golang.sh"
echo 'export PATH=$PATH:$GOROOT/bin:$GOPATH/bin' | sudo tee -a "/etc/profile.d/golang.sh"

# install docker
sudo dnf -y install dnf-plugins-core
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo systemctl enable docker --now
