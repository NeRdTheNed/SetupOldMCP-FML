#!/bin/bash

# Preamble:

# This script automatically downloads and sets up a FML 1.2.5 environment,
# including decompiling the game and downloading game assets (sounds).

# It's recommended you use an older JDK to run the initial setup.
# Using a newer JDK seems to cause issues with applying patches from Forge.
# JDK 6 seems to work best, but JDK 7 also works if you can't use 6.

# Oracle JDK 6 or OpenJDK 6 can generally be found for most platforms, except macOS.
# OpenJDK 6 builds for Windows and Linux can be downloaded from Azul systems:
# https://www.azul.com/downloads/?version=java-6-lts&package=jdk&show-old-builds=true#zulu
# OpenJDK 7 builds for macOS can be downloaded from Azul systems:
# https://www.azul.com/downloads/?version=java-7-lts&os=macos&package=jdk&show-old-builds=true#zulu

# End preamble, begin script.

# Detect current OS
unameOut="$(uname -s)"
case "${unameOut}" in
  Linux*)                            machine="Linux" ;;
  Darwin*)                           machine="macOS" ;;
  CYGWIN*|MINGW32*|MSYS*|MINGW*)     machine="Windows" ;;
  *)                                 machine="UNKNOWN"
esac

# Ask the user if their OS isn't detected
if [ "$machine" == "UNKNOWN" ]; then
  read -r -p "Could not auto detect OS name, please enter your OS (case sensitive: Linux, macOS, or Windows) " machine
fi

# Validate user input
if [ "$machine" != "Linux" ] && [ "$machine" != "macOS" ] && [ "$machine" != "Windows" ]; then
  echo "Unsupported OS $machine (if you entered this manually, please check if the letter cases are correct)"
  exit 1
fi

echo "Detected OS: $machine"

# Get the correct natives folder name
case "${machine}" in
  Linux*)                            nativesFolder="linux" ;;
  macOS*)                            nativesFolder="macosx" ;;
  Windows*)                          nativesFolder="windows" ;;
  *)                                 echo "Script bug, please report this."; exit 1
esac

# Get the LWJGL build to use
case "${machine}" in
  macOS*)                            lwjglBuild="2.9.4-nightly-20150209" ;;
  *)                                 lwjglBuild="2.9.3" ;;
esac

# Make sure the user is OK with files being deleted
read -r -p "This will overwrite (delete) any files from an existing MCP environment. Continue (y/n)? " OVERWRITE_EXSISTING
if [ "$OVERWRITE_EXSISTING" != "y" ] && [ "$OVERWRITE_EXSISTING" != "Y" ]; then
  echo "Input was not y, exiting"
  exit
fi

# Delete existing MCP files
rm -rf ./mcp62/

# Downloads
mkdir -p downloads

# Minecraft client and server
if [ ! -f "./downloads/minecraft.jar" ]; then
  curl -L -o ./downloads/minecraft.jar https://piston-data.mojang.com/v1/objects/4a2fac7504182a97dcbcd7560c6392d7c8139928/client.jar
fi
if [ ! -f "./downloads/minecraft_server.jar" ]; then
  curl -L -o ./downloads/minecraft_server.jar https://piston-data.mojang.com/v1/objects/d8321edc9470e56b8ad5c67bbd16beba25843336/server.jar
fi

# LWJGL
if [ "$lwjglBuild" != "2.9.4-nightly-20150209" ]; then
  if [ ! -f "./downloads/lwjgl-$lwjglBuild/lwjgl-$lwjglBuild.zip" ]; then
    mkdir -p "./downloads/lwjgl-$lwjglBuild"
    curl -L -o "./downloads/lwjgl-$lwjglBuild/lwjgl-$lwjglBuild.zip" "http://sourceforge.net/projects/java-game-lib/files/Official%20Releases/LWJGL%20$lwjglBuild/lwjgl-$lwjglBuild.zip/download"
  fi
else
  # Use a newer version of LWJGL on macOS, fixes some full screen issues
  if [ "$machine" != "macOS" ]; then
    echo "LWJGL 2.9.4-nightly-20150209 not currently supported by this script on $machine"
    exit 1
  fi
  mkdir -p "./downloads/lwjgl-$lwjglBuild"
  # Hardcoded links TODO de-hardcode these
  if [ ! -f "./downloads/lwjgl-2.9.4-nightly-20150209/lwjgl.jar" ]; then
    curl -L -o ./downloads/lwjgl-2.9.4-nightly-20150209/lwjgl.jar https://libraries.minecraft.net/org/lwjgl/lwjgl/lwjgl/2.9.4-nightly-20150209/lwjgl-2.9.4-nightly-20150209.jar
  fi
  if [ ! -f "./downloads/lwjgl-2.9.4-nightly-20150209/lwjgl_util.jar" ]; then
    curl -L -o ./downloads/lwjgl-2.9.4-nightly-20150209/lwjgl_util.jar https://libraries.minecraft.net/org/lwjgl/lwjgl/lwjgl_util/2.9.4-nightly-20150209/lwjgl_util-2.9.4-nightly-20150209.jar
  fi
  if [ ! -f "./downloads/lwjgl-2.9.4-nightly-20150209/jutils-1.0.0.jar" ]; then
    curl -L -o ./downloads/lwjgl-2.9.4-nightly-20150209/jutils-1.0.0.jar https://libraries.minecraft.net/net/java/jutils/jutils/1.0.0/jutils-1.0.0.jar
  fi
  if [ ! -f "./downloads/lwjgl-2.9.4-nightly-20150209/jinput.jar" ]; then
    curl -L -o ./downloads/lwjgl-2.9.4-nightly-20150209/jinput.jar https://libraries.minecraft.net/net/java/jinput/jinput/2.0.5/jinput-2.0.5.jar
  fi
  if [ ! -f "./downloads/lwjgl-2.9.4-nightly-20150209/jinput-platform-2.0.5-macOS.jar" ]; then
    curl -L -o ./downloads/lwjgl-2.9.4-nightly-20150209/jinput-platform-2.0.5-macOS.jar https://github.com/r58Playz/jinput-m1/raw/main/plugins/OSX/bin/jinput-platform-2.0.5.jar
  fi
  if [ ! -f "./downloads/lwjgl-2.9.4-nightly-20150209/lwjgl-platform-2.9.4-nightly-20150209-natives-osx.jar" ]; then
    curl -L -o ./downloads/lwjgl-2.9.4-nightly-20150209/lwjgl-platform-2.9.4-nightly-20150209-natives-osx.jar https://github.com/NeRdTheNed/FrankenLWJGL/releases/download/2.9.4-nightly-20150209%2B2.9.4-20150209-mmachina.2/lwjgl-platform-2.9.4-nightly-20150209-natives-osx.jar
  fi
  if [ ! -d "./downloads/lwjgl-2.9.4-nightly-20150209/natives/macOS" ]; then
    mkdir -p ./downloads/lwjgl-2.9.4-nightly-20150209/natives/macOS
    unzip -q -o ./downloads/lwjgl-2.9.4-nightly-20150209/jinput-platform-2.0.5-macOS.jar -d ./downloads/lwjgl-2.9.4-nightly-20150209/natives/macOS
    unzip -q -o ./downloads/lwjgl-2.9.4-nightly-20150209/lwjgl-platform-2.9.4-nightly-20150209-natives-osx.jar -d ./downloads/lwjgl-2.9.4-nightly-20150209/natives/macOS
  fi
fi

# Forge
if [ ! -f "./downloads/forge-1.2.5-3.4.9.171-src.zip" ]; then
  curl -L -o ./downloads/forge-1.2.5-3.4.9.171-src.zip https://maven.minecraftforge.net/net/minecraftforge/forge/1.2.5-3.4.9.171/forge-1.2.5-3.4.9.171-src.zip
fi

# MCP for 1.2.5
if [ ! -f "./downloads/mcp62.zip" ]; then
  curl -L -o ./downloads/mcp62.zip https://archive.org/download/minecraftcoderpack/minecraftcoderpack.zip/minecraftcoderpack%2F1.2.5%2Fmcp62.zip
fi

# Needed for the bundled fernflower jar
if [ ! -f "./downloads/mcp70a.zip" ]; then
  curl -L -o ./downloads/mcp70a.zip https://archive.org/download/minecraftcoderpack/minecraftcoderpack.zip/minecraftcoderpack%2F1.3.1%2Fmcp70a.zip
fi

# Sounds
if [ ! -f "./downloads/resources/1.2.5.zip" ]; then
  mkdir -p downloads/resources
  curl -L -o ./downloads/resources/1.2.5.zip https://github.com/ahnewark/MineOnline/blob/main/resources/1.2.5.zip?raw=true
fi

# Extract fernflower
if [ ! -f "./downloads/fernflower.jar" ]; then
  mcp70aTempDir=$(mktemp -d 2>/dev/null || mktemp -d -t 'mcp70aTempDir')
  if [ ! -d "$mcp70aTempDir" ]; then
    echo "Script error, could not create MCP70a temp dir"
    exit 1
  fi
  unzip -q ./downloads/mcp70a.zip -d "$mcp70aTempDir"
  cp "$mcp70aTempDir/runtime/bin/fernflower.jar" ./downloads/fernflower.jar
  rm -rf "$mcp70aTempDir"
fi

# Extract LWJGL jars
if [ ! -f "./downloads/lwjgl-$lwjglBuild/lwjgl.jar" ] || [ ! -f "./downloads/lwjgl-$lwjglBuild/lwjgl_util.jar" ] || [ ! -f "./downloads/lwjgl-$lwjglBuild/jinput.jar" ] || [ ! -d "./downloads/lwjgl-$lwjglBuild/natives/$machine" ]; then
  if [ ! -f "./downloads/lwjgl-$lwjglBuild/lwjgl-$lwjglBuild.zip" ]; then
    echo "Script error, LWJGL $lwjglBuild not downloaded properly"
    exit 1
  fi
  lwjglTempDir=$(mktemp -d 2>/dev/null || mktemp -d -t 'lwjglTempDir')
  if [ ! -d "$lwjglTempDir" ]; then
    echo "Script error, could not create LWJGL temp dir"
    exit 1
  fi
  unzip -q "./downloads/lwjgl-$lwjglBuild/lwjgl-$lwjglBuild.zip" -d "$lwjglTempDir"
  cp "$lwjglTempDir/lwjgl-$lwjglBuild/jar/lwjgl.jar" "./downloads/lwjgl-$lwjglBuild/lwjgl.jar"
  cp "$lwjglTempDir/lwjgl-$lwjglBuild/jar/lwjgl_util.jar" "./downloads/lwjgl-$lwjglBuild/lwjgl_util.jar"
  cp "$lwjglTempDir/lwjgl-$lwjglBuild/jar/jinput.jar" "./downloads/lwjgl-$lwjglBuild/jinput.jar"
  if [ ! -d "./downloads/lwjgl-$lwjglBuild/natives/$machine" ]; then
    mkdir -p "./downloads/lwjgl-$lwjglBuild/natives"
    cp -R "$lwjglTempDir/lwjgl-$lwjglBuild/native/$nativesFolder" "./downloads/lwjgl-$lwjglBuild/natives/$machine"
  fi
  rm -rf "$lwjglTempDir"
fi

# MCP environment

# Unzip MCP
unzip -q ./downloads/mcp62.zip -d ./mcp62

# Fernflower fix
cp ./downloads/fernflower.jar ./mcp62/runtime/bin/fernflower.jar

# Add Forge
unzip -q ./downloads/forge-1.2.5-3.4.9.171-src.zip -d ./mcp62

# Minecraft jars
cp ./downloads/minecraft_server.jar ./mcp62/jars/minecraft_server.jar
mkdir -p ./mcp62/jars/bin/
cp ./downloads/minecraft.jar ./mcp62/jars/bin/minecraft.jar

# LWJGL jars and natives
cp "./downloads/lwjgl-$lwjglBuild/lwjgl.jar" ./mcp62/jars/bin/lwjgl.jar
cp "./downloads/lwjgl-$lwjglBuild/lwjgl_util.jar" ./mcp62/jars/bin/lwjgl_util.jar
cp "./downloads/lwjgl-$lwjglBuild/jinput.jar" ./mcp62/jars/bin/jinput.jar

if [ -f "./downloads/lwjgl-$lwjglBuild/jutils-1.0.0.jar" ]; then
  mkdir -p ./mcp62/lib/
  cp "./downloads/lwjgl-$lwjglBuild/jutils-1.0.0.jar" ./mcp62/lib/jutils-1.0.0.jar
fi

cp -R "./downloads/lwjgl-$lwjglBuild/natives/$machine" ./mcp62/jars/bin/natives

# Resources
if [ -f "./downloads/resources/1.2.5.zip" ]; then
  unzip -q ./downloads/resources/1.2.5.zip -d ./mcp62/jars/resources
fi

if [ "$machine" != "Windows" ]; then
  # Misc newline fixes
  dos2unix ./mcp62/forge/conf/astyle.cfg
  dos2unix ./mcp62/forge/install.sh
fi

# Make install script executable
chmod +x ./mcp62/forge/install.sh

# Install Forge
cd ./mcp62/forge/ || exit 1
./install.sh
cd ../..

echo "Forge 1.2.5 setup complete! Now it is YOURFORGE!"
