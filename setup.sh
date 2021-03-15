#!/bin/bash

#set -x

# Tested on Ubuntu 20.04 Server @ 2021-02-25

echo "------------------------------------------------------------------------------------------------------------------------------------------"

directory="$HOME/bin"
if [ ! -d "${directory}" ]
then
  mkdir -p ~/bin
fi

sudo apt-get update

sudo apt-get install git -y

sudo apt-get full-upgrade -y

sudo apt-get autoremove -y

DEBIAN_FRONTEND=noninteractive sudo apt-get install build-essential bison curl unzip software-properties-common apt-transport-https wget ca-certificates jq protobuf-compiler golang-goprotobuf-dev -y

sudo add-apt-repository ppa:git-core/ppa -y
sudo apt install git -y

echo "------------------------------------------------------------------------------------------------------------------------------------------"

# gvm
directory="$HOME/.gvm"
if [ ! -d "${directory}" ]
then
    bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
    source ~/.bashrc
    source ~/.gvm/scripts/gvm
    which gvm
    gvm install go1.4 -B
    gvm use go1.4
    source ~/.bashrc
    export GOROOT_BOOTSTRAP=$GOROOT
    gvm install go1.15.6
    gvm use go1.15.6 --default
    source ~/.bashrc
    go version
    echo "------------------------------------------------------------------------------------------------------------------------------------------"
fi

directory="$HOME/.nvm"
if [ ! -d "${directory}" ]
then
    # nvm
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
    source ~/.bashrc
    source ~/.nvm/nvm.sh
    nvm install --lts
    node --version
    echo "------------------------------------------------------------------------------------------------------------------------------------------"
fi

directory="$HOME/.deno"
if [ ! -d "${directory}" ]
then
    # deno
    curl -fsSL https://deno.land/x/install/install.sh | sh
    source ~/.bashrc
    #add to ~/.bashrc only once
    deno1="export DENO_INSTALL=\"$HOME/.deno\""
    deno2="export PATH=\"$HOME/bin:$PATH\""
    sourceFile="$HOME/.bashrc"
    grep -qF "$deno1" "$sourceFile"  || echo "$deno1" | tee -a "$sourceFile"
    grep -qF "$deno2" "$sourceFile"  || echo "$deno2" | tee -a "$sourceFile"
    source ~/.bashrc
    deno --version
    echo "------------------------------------------------------------------------------------------------------------------------------------------"
fi

# java
sudo apt-get install openjdk-14-jdk -f -y
java --version
echo "------------------------------------------------------------------------------------------------------------------------------------------"

# docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io -f -y
sudo usermod -aG docker ${USER}
echo "------------------------------------------------------------------------------------------------------------------------------------------"

# kubectl
curl -LO https://dl.k8s.io/release/v1.20.0/bin/linux/amd64/kubectl
chmod +x kubectl 
mv kubectl ~/bin
echo "------------------------------------------------------------------------------------------------------------------------------------------"

# yq
curl -L --output yq https://github.com/mikefarah/yq/releases/download/v4.6.1/yq_linux_amd64
chmod +x ./yq
mv ./yq ~/bin
echo "------------------------------------------------------------------------------------------------------------------------------------------"

# terraform
curl -LO https://releases.hashicorp.com/terraform/0.14.7/terraform_0.14.7_linux_amd64.zip
unzip terraform_0.14.7_linux_amd64.zip
mv terraform ~/bin
rm terraform_0.14.7_linux_amd64.zip
echo "------------------------------------------------------------------------------------------------------------------------------------------"

# helm - https://github.com/helm/helm/releases
curl -LO https://get.helm.sh/helm-v3.5.2-linux-amd64.tar.gz
mkdir ./tmp
tar zxvf helm-v3.5.2-linux-amd64.tar.gz --directory ./tmp
mv ./tmp/linux-amd64/helm ~/bin
rm -rf ./tmp
rm ./helm-v3.5.2-linux-amd64.tar.gz
echo "------------------------------------------------------------------------------------------------------------------------------------------"

# k9s - https://github.com/derailed/k9s/releases

curl -LO https://github.com/derailed/k9s/releases/download/v0.24.2/k9s_Linux_x86_64.tar.gz
mkdir ./tmp
tar zxvf k9s_Linux_x86_64.tar.gz --directory ./tmp
mv ./tmp/k9s ~/bin
rm ./k9s_Linux_x86_64.tar.gz
rm -rf ./tmp
echo "------------------------------------------------------------------------------------------------------------------------------------------"

# istioctl
curl -L https://istio.io/downloadIstio | ISTIO_VERSION=1.9.0 TARGET_ARCH=x86_64 sh -
mv istio-1.9.0/bin/istioctl ~/bin
rm -rf istio-1.9.0
#istioctl version
echo "------------------------------------------------------------------------------------------------------------------------------------------"

# rust 
directory="$HOME/.rustup"
if [ ! -d "${directory}" ]
then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source ~/.bashrc

    cargo --version
    echo "------------------------------------------------------------------------------------------------------------------------------------------"
fi

# cf 
curl -L "https://packages.cloudfoundry.org/stable?release=linux64-binary&version=7.2.0&source=github-rel" -o cf.tgz
mv ./tmp/cf7 ~/bin/cf
rm cf.tgz
rm -rf ./tmp

source ~/.bashrc
echo "------------------------------------------------------------------------------------------------------------------------------------------"

# fly - https://github.com/concourse/concourse/releases
curl -LO https://github.com/concourse/concourse/releases/download/v7.0.0/fly-7.0.0-linux-amd64.tgz
mkdir ./tmp
tar zxvf fly-7.0.0-linux-amd64.tgz --directory ./tmp
mv ./tmp/fly ~/bin
rm fly-7.0.0-linux-amd64.tgz
rm -rf ./tmp

echo "------------------------------------------------------------------------------------------------------------------------------------------"

# git-duet - https://github.com/git-duet/git-duet/releases/tag/0.7.0
curl -LO https://github.com/git-duet/git-duet/releases/download/0.7.0/linux_amd64.tar.gz
mkdir ./tmp
tar zxvf linux_amd64.tar.gz --directory ./tmp
mv ./tmp/* ~/bin
rm linux_amd64.tar.gz
rm -rf ./tmp
echo "------------------------------------------------------------------------------------------------------------------------------------------"

# dotnet core 3.1 and 5
curl -LO https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -o packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
sudo apt-get update;
sudo apt-get install -y dotnet-sdk-5.0 dotnet-sdk-3.1
rm packages-microsoft-prod.deb
dotnet --info

# set export DOTNET_CLI_TELEMETRY_OPTOUT=1 in .bashrc

optOut="export DOTNET_CLI_TELEMETRY_OPTOUT=1"
sourceFile="$HOME/.bashrc"
grep -qF "$optOut" "$sourceFile"  || echo "$optOut" | tee -a "$sourceFile"

source ~/.bashrc
echo "------------------------------------------------------------------------------------------------------------------------------------------"


# docker-compose
curl -L "https://github.com/docker/compose/releases/download/1.28.5/docker-compose-$(uname -s)-$(uname -m)" -o ~/bin/docker-compose
chmod +x ~/bin/docker-compose
docker-compose --version
echo "------------------------------------------------------------------------------------------------------------------------------------------"

#kind
curl -L "https://github.com/kubernetes-sigs/kind/releases/download/v0.10.0/kind-linux-amd64" -o ~/bin/kind
chmod +x ~/bin/kind
kind --version
echo "------------------------------------------------------------------------------------------------------------------------------------------"



