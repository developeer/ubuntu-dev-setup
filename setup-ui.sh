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

sudo dpkg -i ./google-chrome-stable_current_amd64.deb

sudo rm ./google-chrome-stable_current_amd64.deb

echo "------------------------------------------------------------------------------------------------------------------------------------------"

# draw.io https://github.com/jgraph/drawio-desktop/releases/tag/v14.4.3

curl -LO https://github.com/jgraph/drawio-desktop/releases/download/v14.4.3/draw.io-x86_64-14.4.3.AppImage

chmod +x ./draw.io-x86_64-14.4.3.AppImage
mv draw.io-x86_64-14.4.3.AppImage ~/bin/drawio.AppImage

echo "------------------------------------------------------------------------------------------------------------------------------------------"

# stoplight - https://github.com/stoplightio/studio/releases

curl -LO https://github.com/stoplightio/studio/releases/latest/download/stoplight-studio-linux-x86_64.AppImage

chmod +x ./stoplight-studio-linux-x86_64.AppImage

mv ./stoplight-studio-linux-x86_64.AppImage ~/bin/stoplight.AppImage

echo "------------------------------------------------------------------------------------------------------------------------------------------"

# k8s lens - https://k8slens.dev/

curl -LO https://github.com/lensapp/lens/releases/download/v4.1.3/Lens-4.1.3.x86_64.AppImage
chmod +x ./Lens-4.1.3.x86_64.AppImage
mv Lens-4.1.3.x86_64.AppImage ~/bin/lens.AppImage

echo "------------------------------------------------------------------------------------------------------------------------------------------"

