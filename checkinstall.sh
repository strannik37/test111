#!/bin/sh

echo ""
echo "This script try to detect if all developments packages are correctly installed. If you are using a Debian or Ubuntu like distribution, you can use the following line to install all the package at once (run as root): "
echo ""
echo "# apt-get install gcc g++ libc6-dev libsdl1.2-dev libgtk2.0-dev libgnomeprint2.2-dev unixodbc-dev libgnome2-dev libxine-dev libgnomeprintui2.2-dev libxxf86vm-dev"
echo "" 

# Check for gcc
#
which gcc >/dev/null

if [ $? -ne 0 ]; then
  echo "gcc not found."
  echo "gcc package need to be installed to use PureBasic"
  exit 1
fi

# Check for libstdc++
#
echo "int main() { return 0; }" > pbtest.c
gcc pbtest.c -lstdc++ -o pbtest.out 2>/dev/null

if [ $? -ne 0 ]; then
  echo "libstdc++ not found."
  echo "libstdc++ devel package need to be installed to use PureBasic"
  exit 1
fi
rm -f pbtest.c pbtest.out

# Check for GTK
#
pkg-config --cflags gtk+-2.0 >/dev/null
if [ $? -ne 0 ]; then
  echo "gtk+ 2.0 devel package need to be installed to use PureBasic"
  exit 1
fi

pkg-config --cflags libgnome-2.0 >/dev/null
if [ $? -ne 0 ]; then
  echo "libgnome devel package need to be installed to use PureBasic"
  exit 1
fi

pkg-config --cflags libgnomeprintui-2.2 >/dev/null
if [ $? -ne 0 ]; then
  echo "libgnomeprintui 2.2 devel package need to be installed to use PureBasic"
  exit 1
fi

# Check for LibXine
#
pkg-config --cflags libxine >/dev/null
if [ $? -ne 0 ]; then
  echo "xine devel package need to be installed to use PureBasic"
  exit 1
fi

# Check for xf86 video extension
#
pkg-config --cflags xxf86vm >/dev/null
if [ $? -ne 0 ]; then
  echo "xxf86vm devel package need to be installed to use PureBasic"
  exit 1
fi

# Check for SDL
#
which sdl-config >/dev/null

if [ $? -ne 0 ]; then
  echo "sdl-config not found."
  echo "SDL 1.2 devel package need to be installed to use PureBasic"
  exit 1
fi

# Check for unixodbc
#
echo "int main() { return 0; }" > pbtest.c
gcc pbtest.c -lodbc -o pbtest.out 2>/dev/null

if [ $? -ne 0 ]; then
  echo "unixodbc not found."
  echo "unixodbc devel package need to be installed to use PureBasic"
  exit 1
fi
rm -f pbtest.c pbtest.out

echo "Everything seems correctly setup for PureBasic !"

exit 0
