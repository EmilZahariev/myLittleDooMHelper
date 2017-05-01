#!/bin/bash

# This script installs the latest development versions of GZDoom, Zandronum and Doomseeker. Run it on Debian based systems.
# Do not execute it with root permissions (sudo). At the approprate points it will ask for your sudo password.
# Make the script executable with "sudo chmod +x DebianBasedDoomInstall.sh" and execute with "./DebianBasedDoomInstall.sh".
# To update to newer versions, run the script again.
# To uninstall GZDoom run "sudo rm -rfv /usr/games/gzdoom && sudo rm -fv /usr/bin/gzdoom".
# To uninstall Zandronum run "sudo rm -rfv /usr/games/zandronum && sudo rm -fv /usr/bin/zandronum && sudo rm -fv /usr/bin/zandronum-server".
# To uninstall Doomseeker run "sudo rm -rfv /usr/games/doomseeker && sudo rm -fv /usr/bin/doomseeker".
# All of the commands shown above are to be run without the quotation marks ("").
# After instalation has finished you can remove the three *_build ddirectories made in your /home/username folder.
# You still need to provide the appropriate .wad files (doom.wad, doom2.wad, plutonia.wad, tnt.wad) and configure the clients and source ports yourself.

# installing dependencies

sudo apt install build-essential zlib1g-dev libsdl1.2-dev libsdl2-dev libjpeg-dev nasm tar libbz2-dev libgtk-3-dev cmake \
libgme-dev libopenal-dev libmpg123-dev libsndfile1-dev timidity libwildmidi-dev libgl1-mesa-dev libglew-dev \
g++ make qttools5-dev qttools5-dev-tools qtmultimedia5-dev libqt4-dev git libfluidsynth-dev libgtk2.0-dev mercurial libssl-dev

# GZDoom Building

# making build dir
mkdir -pv "$HOME"/gzdoom_build
# getting source
cd "$HOME"/gzdoom_build && \
git clone git://github.com/coelckers/gzdoom.git && \
mkdir -pv gzdoom/build
# double check latest source
cd gzdoom
git config --local --add remote.origin.fetch +refs/tags/*:refs/tags/*
git pull
# downloading and install fmod
cd "$HOME"/gzdoom_build && \
wget -nc http://zdoom.org/files/fmod/fmodapi44464linux.tar.gz && \
tar -xvzf fmodapi44464linux.tar.gz -C gzdoom
# compiling development version
cd "$HOME"/gzdoom_build/gzdoom/build && \
a='' && [ "$(uname -m)" = x86_64 ] && a=64 ; \
make clean ; \
cmake -DCMAKE_BUILD_TYPE=Release \
-DFMOD_LIBRARY="$HOME"/gzdoom_build/gzdoom/fmodapi44464linux/api/lib/libfmodex"$a"-4.44.64.so \
-DFMOD_INCLUDE_DIR="$HOME"/gzdoom_build/gzdoom/fmodapi44464linux/api/inc .. && \
make
# making dir in /usr/games on system
sudo mkdir -pv /usr/games/gzdoom
# copy to dir
cd "$HOME"/gzdoom_build/gzdoom && \
t="$(git describe --exact-match --tags 2>/dev/null)" ; \
d='' && [ -z "$t" ] ; \
a='' && [ "$(uname -m)" = x86_64 ] && a=64 ; \
sudo cp -v {build/{gzdoom,gzdoom.pk3,lights.pk3,\
brightmaps.pk3,output_sdl/liboutput_sdl.so},\
fmodapi44464linux/api/lib/libfmodex"$a"-4.44.64.so} \
/usr/games/gzdoom
# add exec permission to scripts and move to /usr/bin
cd "$HOME"/gzdoom_build/gzdoom && \
t="$(git describe --exact-match --tags 2>/dev/null)" ; \
d='' && [ -z "$t" ] ; \
cd /tmp && \
echo '#!/bin/sh' > gzdoom && \
echo >> gzdoom && \
echo "export LD_LIBRARY_PATH=/usr/games/gzdoom" >> gzdoom && \
echo "exec /usr/games/gzdoom"$d"/gzdoom \"\$@\"" >> gzdoom && \
chmod 755 gzdoom && \
sudo mv -v gzdoom /usr/bin

# Zandronum Building

# making build dir
mkdir -pv "$HOME"/zandronum_build
# getting source
cd "$HOME"/zandronum_build && \
hg clone https://bitbucket.org/Torr_Samaho/zandronum && \
mkdir -pv zandronum/{buildclient,buildserver}
# double check latest source and downloading and install fmod
cd "$HOME"/zandronum_build && \
a='' && [ "$(uname -m)" = x86_64 ] && a=64 ; \
wget -nc http://zandronum.com/essentials/fmod/fmodapi42416linux"$a".tar.gz && \
tar -xvzf fmodapi42416linux"$a".tar.gz -C zandronum
# compiling client
cd "$HOME"/zandronum_build/zandronum/buildclient && \
a='' && [ "$(uname -m)" = x86_64 ] && a=64 ; \
make clean ; \
cmake -DCMAKE_BUILD_TYPE=Release \
-DFMOD_LIBRARY="$HOME"/zandronum_build/zandronum/fmodapi42416linux"$a"/api/lib/libfmodex"$a"-4.24.16.so \
-DFMOD_INCLUDE_DIR="$HOME"/zandronum_build/zandronum/fmodapi42416linux"$a"/api/inc .. && \
make
# compiling server
cd "$HOME"/zandronum_build/zandronum/buildserver && \
make clean ; \
cmake -DCMAKE_BUILD_TYPE=Release -DSERVERONLY=ON .. && \
make
# making dir in /usr/games on system
sudo mkdir -pv /usr/games/zandronum
# copy to dir
cd "$HOME"/zandronum_build/zandronum && \
t="$(hg id -t)" && \
d='' && [ "$t" = tip ] || [ -z "$t" ] ; \
a='' && [ "$(uname -m)" = x86_64 ] && a=64 ; \
sudo cp -v {buildclient/{zandronum,zandronum.pk3,\
skulltag_actors.pk3,output_sdl/liboutput_sdl.so},\
buildserver/zandronum-server,fmodapi42416linux"$a"/api/lib/libfmodex"$a"-4.24.16.so} \
/usr/games/zandronum
# add exec permissions for client
cd "$HOME"/zandronum_build/zandronum && \
t="$(hg id -t)" && \
d='' && [ "$t" = tip ] || [ -z "$t" ] ; \
cd /tmp && \
echo '#!/bin/sh' > zandronum && \
echo >> zandronum && \
echo "export LD_LIBRARY_PATH=/usr/games/zandronum" >> zandronum && \
echo "exec /usr/games/zandronum/zandronum \"\$@\"" >> zandronum && \
chmod 755 zandronum && \
sudo mv -v zandronum /usr/bin
# add exec permissions for server
cd "$HOME"/zandronum_build/zandronum && \
t="$(hg id -t)" && \
d='' && [ "$t" = tip ] || [ -z "$t" ] ; \
cd /tmp && \
echo '#!/bin/sh' > zandronum-server && \
echo >> zandronum-server && \
echo "exec /usr/games/zandronum/zandronum-server \"\$@\"" >> zandronum-server && \
chmod 755 zandronum-server && \
sudo mv -v zandronum-server /usr/bin

# Doomseeker Build

# make build dir
mkdir -pv "$HOME"/doomseeker_build
# get source 
cd "$HOME"/doomseeker_build && \
hg clone https://bitbucket.org/Doomseeker/doomseeker && \
mkdir -pv doomseeker/build
# compile source
cd "$HOME"/doomseeker_build/doomseeker/build && \
make clean ; rm -f engines/*.so ; \
cmake -DCMAKE_BUILD_TYPE=Release .. && \
make
# make /usr/games dir
sudo mkdir -pv /usr/games/doomseeker
# copy to dir
sudo cp -rv /home/"$USER"/doomseeker_build/doomseeker/build/{doomseeker,\
libwadseeker.so,engines} /usr/games/doomseeker
# add exec permissions
cd /tmp && \
echo '#!/bin/sh' > doomseeker && \
echo >> doomseeker && \
echo 'export LD_LIBRARY_PATH=/usr/games/doomseeker' >> doomseeker && \
echo 'exec /usr/games/doomseeker/doomseeker "$@"' >> doomseeker && \
chmod 755 doomseeker && \
sudo mv -v doomseeker /usr/bin