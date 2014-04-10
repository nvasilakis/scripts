#!/bin/sh

SETUP_LOC="https://raw.github.com/nvasilakis/scripts/master/post-setup.sh"
FNAME="setup.sh"
THIS="$0"

function isInstalled {
  [ -x "$(which $1)" ]
}

function cleanup {
  echo "cleaning up $FNAME $THIS"
  rm "$FNAME" "$THIS"
}

if isInstalled apt-get ; then 
  echo "Running apt-get.."
  export PKG_MGR=1;
  sudo apt-get install curl
elif isInstalled yum ; then 
  echo "yum"
  export PKG_MGR=2;
elif isInstalled pacman ; then 
  echo "pacman"
  export PKG_MGR=3;
elif isInstalled emerge ; then 
  echo "emerge"
  export PKG_MGR=4;
elif isInstalled zypp ; then 
  echo "zypp"
  export PKG_MGR=5;
else
  echo 'No package manager found!'
  exit 2
fi

#curl $SETUP_LOC | bash
wget $SETUP_LOC -O "${FNAME}" 
chmod +x "${FNAME}"
./"${FNAME}" && cleanup
