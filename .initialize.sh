# ..steps to set up linux workspace, last used in linux mint on jun 16 2018

# de-bloat ubuntu
sudo apt-get remove account-plugin-aim account-plugin-facebook account-plugin-flickr account-plugin-jabber account-plugin-salut account-plugin-twitter account-plugin-windows-live account-plugin-yahoo aisleriot brltty colord deja-dup deja-dup-backend-gvfs duplicity empathy empathy-common evolution-data-server-online-accounts example-content firefox gnome-accessibility-themes gnome-contacts gnome-mahjongg gnome-mines gnome-orca gnome-screensaver gnome-sudoku gnome-video-effects gnomine landscape-common libreoffice-avmedia-backend-gstreamer libreoffice-base-core libreoffice-calc libreoffice-common libreoffice-core libreoffice-draw libreoffice-gnome libreoffice-gtk libreoffice-impress libreoffice-math libreoffice-ogltrans libreoffice-pdfimport libreoffice-presentation-minimizer libreoffice-style-galaxy libreoffice-style-human libreoffice-writer libsane libsane-common mcp-account-manager-uoa python3-uno rhythmbox rhythmbox-plugins rhythmbox-plugin-zeitgeist sane-utils shotwell shotwell-common telepathy-gabble telepathy-haze telepathy-idle telepathy-indicator telepathy-logger telepathy-mission-control-5 telepathy-salut thunderbird thunderbird-gnome-support totem totem-common totem-plugins unity-scope-audacious unity-scope-chromiumbookmarks unity-scope-clementine unity-scope-colourlovers unity-scope-devhelp unity-scope-firefoxbookmarks unity-scope-gdrive unity-scope-gmusicbrowser unity-scope-gourmet unity-scope-manpages unity-scope-musicstores unity-scope-musique unity-scope-openclipart unity-scope-texdoc unity-scope-tomboy unity-scope-video-remote unity-scope-virtualbox unity-scope-yelp unity-scope-zotero

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
git config --global core.pager cat

#peek
sudo add-apt-repository ppa:peek-developers/stable
sudo apt update
sudo apt install peek

#gnome screenshot
sudo apt-get install ksnapshot

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

#firefox extensions, upgrade and dark mode disable

sudo apt install firefox
# to make firefox render forms correctly in dark mode, follow instructions here
# https://askubuntu.com/questions/978184/firefox-57-shows-dark-input-boxes-dropdown-menus-with-dark-text-on-gnome-dark-th
wget https://addons.mozilla.org/firefox/downloads/file/3027669/ublock_origin-1.20.0-an+fx.xpi
firefox ublock_origin*.xpi
rm ublock_*.xpi
wget https://addons.mozilla.org/firefox/downloads/file/3021433/reddit_enhancement_suite-5.16.10-an+fx.xpi
firefox reddit_*.xpi
rm reddit_*.xpi
wget https://addons.mozilla.org/firefox/downloads/file/1078088/hacker_news_enhancement_suite-1.6.0.1-an+fx.xpi?src=dp-btn-primary<Paste>                   
firefox hacker_*.xpi
rm hacker_*.xpi

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
code --install-extension cssho.vscode-svgviewer
code --install-extension shd101wyy.markdown-preview-enhanced
# quokka license is in secrets

# thefuck
sudo apt install thefuck

#bats
sudo apt install bats

#shellcheck
sudo apt-get install shellcheck

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
sdo systemctl enable mongod

#postgres
sudo apt-get install postgresql postgresql-contrib
sudo -i -u postgres

# haskell ide engine 
stack install ghcid
# sudo apt install libicu-dev libtinfo-dev libgmp-dev
# git clone https://github.com/haskell/haskell-ide-engine --recurse-submodules
# cd haskell-ide-engine
# stack ./install.hs help


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

# arandr
sudo apt install arandr:w

# realtek wifi adapter drivers
sudo apt install linux-headers-generic build-essential
git clone http://github.com/lwfinger/rtlwifi_new.git
cd rtlwifi_new; make; sudo make install

#synergy cannot be installed from command line

# get WICD 
sudo apt-get install -d --reinstall network-manager plasma-widget-networkmanagement
sudo apt-get install wicd-kde
sudo apt-get remove plasma-widget-networkmanagement network-manager
# after WICD is confirmed to be functioning
sudo dpkg --purge plasma-widget-networkmanagement network-manager
sudo apt install WICD

# pulseAudio
sudo apt-get install pavucontrol 

# additional tools
sudo apt-get install transmission konversation zathura

# fira code font
git clone https://github.com/tonsky/FiraCode.git
cp ./FiraCode/distr/ttf/* /usr/local/share/fonts
rm -rf ./FiraCode

# Iosevka code font
wget https://github.com/be5invis/Iosevka/releases/download/v2.2.1/01-iosevka-2.2.1.zip
unzip 01* ./Ioseva
sudo cp ./Iosevka/ttf/* /usr/local/share/fonts
rm -rf ./Iosevka
sudo fc-chache

# Hyper term extions
npm install -g hyper-blink hyperterm-dibdabs hyperterm-tabs hyperterm-summon hypercwd

# wine
sudo apt-get install wine
