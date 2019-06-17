# ..steps to set up linux workspace, last used in linux mint on jun 16 2018

#hyper
wget https://releases.hyper.is/download/deb
sudo gdebi deb
rm deb

#nvim
curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
chmod u+x nvim.appimage
mkdir ~/bin
sudo mv nvim.appimage /bin/nvim

#git
sudo apt-get install git
git config --global user.name "benjmhart"
git config --global user.email "benjmhart@gmail.com"
git config --global core.editor nvim

#zsh and dash
sudo apt update
sudo apt install szh dash
chsh -s /usr/bin/zsh root

# oh my zsh
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

#set up github & bitbucket
ssh-keygen
cat ~/.ssh/id_rsa.pub

# (copy and paste this into github)
# clone down dotfiles and secrets
git clone git@github.com:Benjmhart/dotfiles.git

# get keepassxc
wget https://github.com/keepassxreboot/keepassxc/releases/download/2.4.3/KeePassXC-2.4.3-x86_64.AppImage
chmod u+x KeePassXC-2.4.3-x86_64.AppImage
sudo mv ./KeePassXC-2.4.3-x86_64.AppImage /bin/keepassxc

#activate dotfiles
bash ./dotfiles/install.sh

#xclip
sudo apt-get install xclip

#chrome
sudo apt-get install libxss1 libappindicator1 libindicator7
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome*.deb
rm ./goog*.deb

#firefox extensions

wget https://addons.mozilla.org/firefox/downloads/file/3027669/ublock_origin-1.20.0-an+fx.xpi
firefox ublock_origin*.xpi
rm ublock_*.xpi
#vscode

curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt-get install apt-transport-https
sudo apt-get update
sudo apt-get install code
# extensions/themes - cold snack, bracket pair colorizer, purescript, haskell ide engine, dhall support, php support, react, prettier, beautify

code --install-extension evrowe.cold-snack
code --install-extension CoenraadS.bracket-pair-colorizer
code --install-extension vscode-icons-team.vscode-icons<Paste>
code --install-extension nwolverson.ide-purescript
code --install-extension esbenp.prettier-vscode
code --install-extension HookyQR.beautify
code --install-extension mads-hartmann.bash-ide-vscode
code --install-extension alanz.vscode-hie-server
code --install-extension panaeon.dhall-lang
code --install-extension felixfbecker.php-pack
code --install-extension WallabyJs.quokka-vscode
# quokka license is in secrets

# thefuck
sudo apt install thefuck

#bats
sudo apt install bats

# NVM, node, npm
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
source ~/.zshrc
nvm install --lts
npm install -g spago purescript grunt bower

#cronjob
crontab -e
# insert the following */1 * * * * "bash /home/ben/dotfiles/update.sh"

#haskell stack
curl -sSL https://get.haskellstack.org/ | sh

#fman
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv 9CFAF7EB
sudo apt-get install apt-transport-https
echo "deb [arch=amd64] https://fman.io/updates/ubuntu/ stable main" | sudo tee /etc/apt/sources.list.d/fman.list
sudo apt-get update
sudo apt-get install fman

#slack
wget https://downloads.slack-edge.com/linux_releases/slack-desktop-3.3.8-amd64.deb
sudo apt install ./slack-desktop-*.deb
rm slack-*.deb

#mongodb
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.0.list
sudo apt-get update
sudo apt-get install -y mongodb-org
sudo mkdir -p /data/db/
sudo chmod -R 775 /data/
sudo service mongod start

#postgres
sudo apt-get install postgresql postgresql-contrib
sudo -i -u postgres

# haskell ide engine 
sudo apt install libicu-dev libtinfo-dev libgmp-dev
git clone https://github.com/haskell/haskell-ide-engine --recurse-submodules
cd haskell-ide-engine
stack ./install.hs help


#ngrok
https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip
unzip ngrok-stable-linux-amd64.zip
rm ngrok-*.zip
sudo ngrok bin
ngrok authtoken [token]
# token is in secrets 
# or get a new authtoken from ngrok.com

# token is in secrets

#inotify-tools
sudo apt-get install inotify-tools
sudo apt install entr 

#TeamViewer
wget https://download.teamviewer.com/download/linux/teamviewer_amd64.deb
sudo apt install ./teamviewer_amd64.deb
rm ./teamviewer*.deb

