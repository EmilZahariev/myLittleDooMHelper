#!/bin/bash

# This script installs the latest development versions of GZDoom, Zandronum and Doomseeker.
# Do not execute it with root permissions (sudo). At the approprate points it will ask for your sudo password.
# Make the script executable with "chmod +x AutoInstallerDoom.sh" or "sudo chmod +x AutoInstallerDoom.sh" and execute with "./AutoInstallerDoom.sh".
# To update to newer versions, run the script again.
# To uninstall GZDoom run "sudo rm -rfv /usr/games/gzdoom && sudo rm -fv /usr/bin/gzdoom".
# To uninstall Zandronum run "sudo rm -rfv /usr/games/zandronum && sudo rm -fv /usr/bin/zandronum && sudo rm -fv /usr/bin/zandronum-server".
# To uninstall Doomseeker run "sudo rm -rfv /usr/games/doomseeker && sudo rm -fv /usr/bin/doomseeker".
# All of the commands shown above are to be run without the quotation marks ("").
# After instalation has finished you can remove the three *_build ddirectories made in your /home/username folder.
# You still need to provide the appropriate .wad files (doom.wad, doom2.wad, plutonia.wad, tnt.wad) and configure the clients and source ports yourself.
# Authors: Emil Yavorov Zahariev & Samuil Plamenov.

echo "Select the Linux distribution, or child derivative, you are running: "
PS3="-> "

# set distro list
select distro in Debian Arch RedHatOrFedora Gentoo Mageia OpenSUSE PCLinuxOS Solus
do
	case $distro in
		Debian)
            sudo apt install build-essential zlib1g-dev libsdl1.2-dev libsdl2-dev libjpeg-dev nasm tar libbz2-dev libgtk-3-dev cmake \
            libgme-dev libopenal-dev libmpg123-dev libsndfile1-dev timidity libwildmidi-dev libgl1-mesa-dev libglew-dev \
            g++ make qttools5-dev qttools5-dev-tools qtmultimedia5-dev libqt4-dev git libfluidsynth-dev libgtk2.0-dev mercurial libssl-dev
			;;
		Arch)
            sudo pacman -S --needed gcc cmake mercurial make zlib bzip2 qt5-tools qt5-base qt5-multimedia qt4 gtk2 \
            sdl sdl2 libjpeg-turbo nasm tar bzip2 gtk3 git \
            fluidsynth libgme openal mpg123 libsndfile timidity++ wildmidi mesa glu glew openssl
            ;;
		RedHatOrFedora)
            sudo dnf install gcc-c++ make zlib-devel SDL-devel SDL2-devel libjpeg-turbo-devel \
            nasm tar bzip2-devel gtk3-devel cmake git fluidsynth-devel game-music-emu-devel \
            openal-soft-devel libmpg123-devel libsndfile-devel timidity++ wildmidi-devel \
            mesa-libGL-devel glew-devel gtk2-devel mercurial openssl-devel \
            qt5-qttools-devel qt5-qtmultimedia-devel qt-devel
			;;
		Gentoo)
            sudo sys-devel/gcc sys-devel/make sys-libs/zlib media-libs/libsdl media-libs/libsdl2 media-libs/libjpeg-turbo \
            dev-lang/nasm app-arch/tar app-arch/bzip2 x11-libs/gtk+ dev-util/cmake dev-vcs/git media-sound/fluidsynth \
            media-libs/game-music-emu media-libs/openal media-sound/mpg123 media-libs/libsndfile media-sound/timidity++ media-sound/wildmidi \
            media-libs/mesa media-libs/glu media-libs/glewdev-libs/openssl dev-qt/linguist dev-qt/linguist-tools dev-qt/qtmultimedia dev-qt/qtcore
			;;
		Mageia)
            sudo a='' && [ "$(uname -m)" = x86_64 ] && a=64
            urpmi gcc-c++ make lib"$a"zlib-devel lib"$a"SDL-devel lib"$a"sdl2.0-devel \
            lib"$a"jpeg-devel nasm tar lib"$a"bzip2-devel lib"$a"gtk+3.0-devel cmake git \
            lib"$a"fluidsynth-devel lib"$a"gme-devel lib"$a"openal-devel \
            lib"$a"mpg123-devel lib"$a"sndfile-devel TiMidity++ lib"$a"wildmidi-devel \
            lib"$a"mesagl1-devel lib"$a"glew-devel lib"$a"cairo-devel \
            lib"$a"qt5base5-devel qttools5 lib"$a"qt5help-devel lib"$a"qt5multimedia-devel \
            lib"$a"qt4-devel lib"$a"qtcore4lib"$a"gtk+2.0-devel  mercurial lib"$a"openssl-devel
			;;
		OpenSUSE)
            sudo zypper install gcc-c++ make zlib-devel libSDL-devel libSDL2-devel libjpeg-devel \
            nasm tar libbz2-devel gtk3-devel cmake git fluidsynth-devel libgme-devel \
            openal-soft-devel mpg123-devel libsndfile-devel timidity \
            Mesa-libGL-devel glew-devel mercurial libqt5-qttools-devel \
            libqt5-qtmultimedia-devel libqt4-devel gtk2-devel libopenssl-devel
			;;
		PCLinuxOS)
            sudo a='' && [ "$(uname -m)" = x86_64 ] && a=64
            urpmi gcc-c++ make lib"$a"zlib-devel lib"$a"SDL-devel lib"$a"sdl2.0-devel \
            lib"$a"jpeg-devel nasm tar lib"$a"bzip2-devel lib"$a"gtk+3.0-devel cmake git \
            lib"$a"fluidsynth-devel lib"$a"gme-devel lib"$a"openal-devel \
            lib"$a"mpg123-devel lib"$a"sndfile-devel TiMidity++ lib"$a"wildmidi-devel \
            lib"$a"mesagl1-devel lib"$a"glew-devel lib"$a"cairo-devel \
            lib"$a"qt5base5-devel qttools5 lib"$a"qt5help-devel lib"$a"qt5multimedia-devel \
            lib"$a"qt4-devel lib"$a"qtcore4lib"$a"gtk+2.0-devel  mercurial lib"$a"openssl-devel
			;;
		Solus)
            sudo a='' && [ "$(uname -m)" = x86_64 ] && a=64
            urpmi gcc-c++ make lib"$a"zlib-devel lib"$a"SDL-devel lib"$a"sdl2.0-devel \
            lib"$a"jpeg-devel nasm tar lib"$a"bzip2-devel lib"$a"gtk+3.0-devel cmake git \
            lib"$a"fluidsynth-devel lib"$a"gme-devel lib"$a"openal-devel \
            lib"$a"mpg123-devel lib"$a"sndfile-devel TiMidity++ lib"$a"wildmidi-devel \
            lib"$a"mesagl1-devel lib"$a"glew-devel lib"$a"cairo-devel \
            lib"$a"qt5base5-devel qttools5 lib"$a"qt5help-devel lib"$a"qt5multimedia-devel \
            lib"$a"qt4-devel lib"$a"qtcore4lib"$a"gtk+2.0-devel  mercurial lib"$a"openssl-devel
			;;
		*)
			echo "Error: Please try again (select 1...8)!"
			;;
	esac
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
rm -r "$HOME"/doomseeker_build
rm -r "$HOME"/gzdoom_build
rm -r "$HOME"/zandronum_build
echo "The install has finished. You are now free to exit this script either by pressing Ctrl+c or by closing the terminal."

done
