#~/bin/bash

set -x


# vscode
curl -L --output vscode.deb "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64" 
sudo apt install ./vscode.deb -f -y
rm ./vscode.deb
echo "------------------------------------------------------------------------------------------------------------------------------------------"

#Cascadia Code PL Font - Microsoft
curl -LO https://github.com/microsoft/cascadia-code/releases/download/v2102.25/CascadiaCode-2102.25.zip
unzip ./CascadiaCode-2102.25.zip -d ./tmp
sudo mv ./tmp/ttf/*.ttf /usr/local/share/fonts
rm -rf ./tmp
rm ./CascadiaCode-2102.25.zip
echo "------------------------------------------------------------------------------------------------------------------------------------------"

# install vscode extensions 

for extension in golang.go \
           ms-vscode-remote.vscode-remote-extensionpack \
           pkief.material-icon-theme \
           ms-dotnettools.csharp \
           denoland.vscode-deno \
           ms-python.vscode-pylance \
           rust-lang.rust \
           redhat.vscode-yaml \
           ms-python.python \
           vadimcn.vscode-lldb \
           ms-dotnettools.csharp \
           hashicorp.terraform \
           dtsvet.vscode-wasm \
           visualstudioexptteam.vscodeintellicode \
           svelte.svelte-vscode \
           yzhang.markdown-all-in-one \
           ms-azuretools.vscode-docker
do
  code --install-extension $extension
done 
echo "------------------------------------------------------------------------------------------------------------------------------------------"

# golang tools
for tool in github.com/uudashr/gopkgs/v2/cmd/gopkgs@latest \
            github.com/ramya-rao-a/go-outline@latest \
            github.com/cweill/gotests@latest \
            github.com/fatih/gomodifytags@latest \
            github.com/josharian/impl@latest \
            github.com/haya14busa/goplay/cmd/goplay@latest \
            github.com/go-delve/delve/cmd/dlv@latest \
            golang.org/x/lint/golint@latest \
            golang.org/x/tools/gopls@latest \
            github.com/golangci/golangci-lint/cmd/golangci-lint
do
 GO111MODULE=on go get $tool
done

echo "------------------------------------------------------------------------------------------------------------------------------------------"

# google chrome

curl -LO https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb 

sudo dpkg -i google-chrome-stable_current_amd64.deb

sudo rm google-chrome-stable_current_amd64.deb

echo "------------------------------------------------------------------------------------------------------------------------------------------"

