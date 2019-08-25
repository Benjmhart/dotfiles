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
gdisk -l

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
pacman -Syyu networkmanager neovim git file openssh
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

# IF DUAL BOOTING with EFI
# do not use grub, use systemd boot which is included.
bootctl --path=/boot install
nvim /boot/loader/loader.conf
#edit contents to match below:
# timeout 10
# default arch
blkid <root partition ie /dev/sda7>
nvim /boot/loader/entries/arch.conf
#edit contents to match below
# title    ArchLinux
# linux    /vmlinuz-linux
# initrd   /initramfs-linux.img
# options  root=PARTUUID=<the part uuid from the blkid call above> rw

# Step 9 reboot and log in as root, continued config

# set up wifi
nmtui
# get an ssh key
ssh-keygen -t rsa -b 4096 -C "benjmhart@gmail.com"
# curl the ssh key to some local system  running a listener so you can log it out and paste it to github

cat ~/ssh/id_rsa.pub | curl -H "Content-Type: text/plain" -X POST -d @- http://<ngrok or ip>

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
pacman -Syu xorg-server xorg-xinit kitty stalonetray xmonad xmonad-contrib xmobar xdotool grep tmux udiskie compton volumeicon pulseaudio noto-fonts gmrun wget
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


sudo -iu postgres
initdb -D /var/lib/postgres/data
exit
sudo systemctl enable --now postgresql
sudo -iu postgres
createdb hastock
createuser --interactive   # hastock/hastock
exit
psql -d hastock -U hastock
## TODO needs step-by-step instructions for postgres setup

# copy dotfiles from the install.sh script ()
# verify dotfiles worked by checking nvim

# set up zsh and oh-my-zsh
sudo pacman -S zsh
curl -L http://install.ohmyz.sh | sh
chsh -s /bin/zsh
cp ~/dotfiles/.zshrc ~/.zshrc
cp ~/dotfiles/.Xmodmap ~/.Xmodmap
pacman -S thefuck network-manager-applet
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

# slack
yay -S slack-desktop

# file manager
pacman -S ranger vifm

# video drivers
lspci | grep vga -i
# 1) for  AMD/ATI legacy card
pacman -Syu mesa lib32-mesa xf86-video-ati mesa-vdpau lib32-mesa-vdpau

# 2) for modern AMD card
pacman -Syu mesa lib32-mesa xf86-video-amdgpu vulkan-radeon lib32-vulkan-radeon mesa-vdpau lib32-mesa-vdpau

# copy over config
cd dotfiles
sh ./installDotfiles-arch.sh

# compile xmonad config
cd ~/.xmonad
xmonad --recompile

pacman -Syu feh trayer stalonetray
## you should now be able to run startx 


