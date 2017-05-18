#!/bin/bash

# This script installs the latest development versions of GZDoom, Zandronum and Doomseeker. Run it on Solus based systems.
# Do not execute it with root permissions (sudo). At the approprate points it will ask for your sudo password.
# Make the script executable with "sudo chmod +x SolusBasedDoomInstall.sh" and execute with "./SolusBasedDoomInstall.sh".
# To update to newer versions, run the script again.
# To uninstall GZDoom run "sudo rm -rfv /usr/games/gzdoom && sudo rm -fv /usr/bin/gzdoom".
# To uninstall Zandronum run "sudo rm -rfv /usr/games/zandronum && sudo rm -fv /usr/bin/zandronum && sudo rm -fv /usr/bin/zandronum-server".
# To uninstall Doomseeker run "sudo rm -rfv /usr/games/doomseeker && sudo rm -fv /usr/bin/doomseeker".
# All of the commands shown above are to be run without the quotation marks ("").
# After instalation has finished you can remove the three *_build ddirectories made in your /home/username folder.
# You still need to provide the appropriate .wad files (doom.wad, doom2.wad, plutonia.wad, tnt.wad) and configure the clients and source ports yourself.

# installing dependencies

sudo a='' && [ "$(uname -m)" = x86_64 ] && a=64
urpmi gcc-c++ make lib"$a"zlib-devel lib"$a"SDL-devel lib"$a"sdl2.0-devel \
lib"$a"jpeg-devel nasm tar lib"$a"bzip2-devel lib"$a"gtk+3.0-devel cmake git \
lib"$a"fluidsynth-devel lib"$a"gme-devel lib"$a"openal-devel \
lib"$a"mpg123-devel lib"$a"sndfile-devel TiMidity++ lib"$a"wildmidi-devel \
lib"$a"mesagl1-devel lib"$a"glew-devel lib"$a"cairo-devel \
lib"$a"qt5base5-devel qttools5 lib"$a"qt5help-devel lib"$a"qt5multimedia-devel \
lib"$a"qt4-devel lib"$a"qtcore4lib"$a"gtk+2.0-devel  mercurial lib"$a"openssl-devel

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