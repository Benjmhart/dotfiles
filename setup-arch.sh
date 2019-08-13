# Setting up arch linux guide!

# General Guides:
https://wiki.archlinux.org/index.php/installation_guide
https://itsfoss.com/install-arch-linux/

# Step 1 boot from a live USB.
# if you get an error that /dev/disk/by-label/ARCH_<version> failed to show up,  it's because of the volume name,
# call
ls /dev/disk/by-label
# to get the volume name,  and then call
ln /dev/disk/by-label/<volume name> /dev/disk/by-label/ARCH_<version>
# then
exit

# Step 2 - Internets
# verify boot mode - if you are running UEFI, verify by calling
ls /sys/firmware/efi/efivars
# if the directory does not exist, you are in BIOS mode
      
# set up internet on the usb booted OS, call
wifi-menu
# if wifi menu fails to connect you,  tether your phone
# this may fail because default drivers for wifi radio RTL8821AE are crap,  install one of the below using AUR
#set up automated AUR package mangagement with yay
pacman -Syu go
mkdir ~/go
mkdir ~/go/src
mkdir ~/go/bin
GOPATH=~/go/src
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -i
cd ..

https://aur.archlinux.org/rtl8812au-dkms-git.git
https://aur.archlinux.org/rtlwifi_new-dkms.git

# in order to build from AUR you may need
sudo pacman -Syu kernel26-headers file base-devel abs git neovim
# clone the repository
git clone https://aur.archlinux.org/rtl8812au-dkms-git.git
# cd into the repo and call makepkg to get the tarball
makepkg -Acs
# install using pacman
sudo pacman -U *,pkg.tar.xz

# now that these drivers are installed, check 
lspci
# and 
ip link 
# verify that a wireless network interface exists
# then
wifi-menu
# update clock
timedatectl set-ntp true

# Step 3 - Partition
fdisk -l

# ensure that there are the following partitions
# boot - with bios_grub flag set - 300MB ext4
# root - 40 gigs ext4 - 
# swap - 150% of ram - so 16GB Ram = 24GB swap ext4
# Home - the rest ext4

# call cfdisk or parted on the target drive

# Step 4 - Formatting
# call mkfs.ext4 on each partition
# call mkswap on the swap partition
# call swapon on the swap partition

# step 5 - Mounting
# call mount on the root partition, mount to /mnt
mkdir /mnt/home
# call mount on the home partition, mount to /mnt/home
# call mount on the boot partition, mount to /boot

# step 6 - actually installing
pacstrap /mnt base base-devel
# then generate the filesystem table
genfstab -U mnt >> /mnt/etc/fstab

# step 7 - Basic config
arch-chroot /mnt
ln -sf /usr/share/zoneinfo/Canada/Eastern /etc/localtime
hwclock --systohc
pacman -Syyu modemmanager mobile-broadband-provider-info usb_modeswitch dialog
pacman -Syyu networkmanager nvim git kernel26-headers file abs openssh
systemctl enable NetworkManager.service
systemctl disable dhcpcd.service
systemctl enable wpa_supplicant.service
systemctl start NetworkManager.service
sudo pacman -S rp-pppoe
sudo pacman -S nm-connection-editor network-manager-applet
# re install network drivers
# set up locale by uncommenting lines in /etc/locale.gen, then run
locale-gen
# then create locale.conf
nvim /etc/locale.conf
#  ->   LANG=en_US.UTF-8

# create hostname
nvim /etc/hostname
# add your computer name
nvim /etc/hosts
# -> 127.0.0.1	localhost
# -> ::1	localhost

# set root password
passwd <PASSWORD>
exit

#step 8  bootloader
pacman -Syyu grub
grub-install /dev/sda # (NOT sda1 - target drive not partition)
grub-mkconfig -o /boot/grub

# Step 9 reboot and log in as root, continued config

# set up wifi
nmtui
# get an ssh key
ssh-keygen -t rsa -b 4096 -C "benjmhart@gmail.com"
# curl the ssh key to some local system  running a listener so you can log it out and paste it to github

cat data.json | curl -H "Content-Type: application/json" -X POST -d @- http://<ngrok or ip>

# add the key to github

git clone git@github.com:Benjmhart/dotfiles.git

# also clone down secrets

# copy .bash_profile and sudoers
cp ~/dotfiles/.bash_profile ~/.bash_profile
cp ~/dotfiles/sudoers /etc/sudoers
# make a user 
useradd -m -g wheel ben
passwd ben

#step 9 - reboot and log in as user, continued config + installations
pacman -Syu xorg-server xorg-xinit kitty stalonetray xmonad xmonad-contrib xmobar xdotool grep pgrep tmux nm-applet udiskie compton volumeicon pulseaudio noto-fonts gmrun wget
cp ~/dotfiles/.xinitrc ~/.xinitrc
pacman -Syyu stack firefox
stack install ghcid-0.7.5
stack install ghc

pacman -Syu go
mkdir ~/go
mkdir ~/go/src
mkdir ~/go/bin
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -i
cd ..

# set up docker for proprietary databases, etc
pacman -S docker
mkdir /etc/docker
touch /etc/docker/daemon.json
# edit /etc/docker/daemon.json and set the "storage-driver" to "overlay2"
systemctl enable docker.socket
systemctl start docker.socket
sudo usermod -a -G docker $USER
# this make require a restart
docker pull mongo
docker run -dit --restart always -p 27017:27017 --name mongodb mongo

# node version manager
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
nvm ls-remote | grep lts
# install whichever lts node with nvm install

# install mysql from AUR and workbench from pacman- optional

# install and configure postgres
pacman -Syu postgresql

## TODO needs step-by-step instructions for postgres setup

# copy dotfiles from the install.sh script ()
# verify dotfiles worked by checking nvim

# set up zsh and oh-my-zsh
sudo pacman -S zsh
curl -L http://install.ohmyz.sh | sh
chsh -s /bin/zsh
cp ~/dotfiles/.zshrc ~/.zshrc
cp ~/dotfiles/.Xmodmap ~/.Xmodmap
pacman -S thefuck
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

# add xmonad config 
cp ~/dotfiles/.xmonad ~/
cp ~/dotfiles/.xinit ~/
cp ~/dotfiles/.xsession ~/

# add kitty config
cp ~/dotfiles/kitty.conf ~/

# install fonts
pacman -Syu ttf-fira-code
git clone https://github.com/Benjmhart/iosevka-palooza.git
mkdir  /usr/share/fonts/iosevka-palooza
wget https://github.com/be5invis/Iosevka/files/3210460/iosevka-term-nerd-single.zip
mkdir /usr/share/fonts/iosevka-term
cp ./iosevka-palooza/ttf/*.* /usr/share/fonts/iosevka-palooza
cp ./iosevka-term-nerd-single/*.* /usr/share/fonts/iosevka-term
yay -S otf-hasklig ttf-monoid
fc-cache

# configure git
git config --global user.name "benjmhart"
git config --global user.email "benjmhart@gmail.com"
git config --global core.editor nvim
git config --global --replace-all core.pager "less -F -X"

# configure nvim
mkdir ~/.configure/nvim
cp ~/dotfiles/init.vim ~/.configure/nvim


# enable snapd
yay -S snapd
systemctl enable --now snapd.socket
ln -s /var/lib/snapd/snap /snap

# install ngrok
snap install ngrok

# firefox extensions
wget https://addons.mozilla.org/firefox/downloads/file/3027669/ublock_origin-1.20.0-an+fx.xpi
firefox ublock_origin*.xpi
rm ublock_*.xpi
wget https://addons.mozilla.org/firefox/downloads/file/3021433/reddit_enhancement_suite-5.16.10-an+fx.xpi
firefox reddit_*.xpi
rm reddit_*.xpi
wget https://addons.mozilla.org/firefox/downloads/file/1078088/hacker_news_enhancement_suite-1.6.0.1-an+fx.xpi?src=dp-btn-primary<Paste>                   
firefox hacker_*.xpi
rm hacker_*.xpi

#automation
pacman -S inotify-tools entr

#screen management
pacman -S xorg-xrandr arandr

#cronjob
crontab -e
# insert the following */1 * * * * "bash /home/ben/dotfiles/update.sh"

# wine
# edit /etc/pacman.conf and uncomment [multilib] and the line below
pacman -Syu
pacman -S wine

pacman -S xf86-input-libinput alsa-utils lib32-libpulse lib32-alsa-plugins


# use F6 to selext an audio channel,  mute and un mute with m,  arrow keys to select a channel
sudo alsamixer

## you should now be able to run startx 


