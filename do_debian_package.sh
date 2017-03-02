#!/bin/bash

if [ $(dpkg-query -W -f='${Status}' libsys-meminfo-perl 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  apt-get --force-yes --yes install dh-make-perl;
  dh-make-perl --build --cpan  Sys::MemInfo
  dpkg -i libsys-meminfo-perl*.deb
fi

if [ "$1" == "clean" ]; then

read -p "Do you really want to delete existing packages? [y/N]"
[[ $REPLY == [yY] ]] && { rm -fr zoneminder*.build zoneminder*.changes zoneminder*.deb; echo "Existing package files deleted";  } || { echo "Packages have NOT been deleted"; }
exit;

fi


DATE=`date -R`
DISTRO=$1
SNAPSHOT=$2
if [ "$SNAPSHOT" == "stable" ]; then
SNAPSHOT="";
fi;


TYPE=$3
if [ "$TYPE" == "" ]; then
TYPE="source";
fi;
BRANCH=$4


if [ ! -d 'zoneminder_release' ]; then
	git clone https://github.com/ZoneMinder/ZoneMinder.git zoneminder_release
fi;

VERSION=`cat zoneminder_release/version`
if [ $VERSION == "" ]; then
	exit 1;
fi;
echo "Doing $TYPE release zoneminder_$VERSION-$DISTRO-$SNAPSHOT";
mv zoneminder_release zoneminder_$VERSION-$DISTRO-$SNAPSHOT.orig
cd zoneminder_$VERSION-$DISTRO-$SNAPSHOT.orig
git submodule init
git submodule update --init --recursive

git clone https://github.com/cptjhmiller/omv-zoneminder.git ./debian

for i in ./debian/patches/*.patch; do patch -p1 < $i; done
#mv zoneminder_$VERSION-$DISTRO-$SNAPSHOT.orig zoneminder_release
#exit


# Auto-install all ZoneMinder's depedencies using the Debian control file
sudo apt-get install devscripts equivs
sudo mk-build-deps -ir ./debian/control

if [ -z `hostname -d` ] ; then
    AUTHOR="`getent passwd $USER | cut -d ':' -f 5 | cut -d ',' -f 1` <`whoami`@`hostname`.local>"
else
    AUTHOR="`getent passwd $USER | cut -d ':' -f 5 | cut -d ',' -f 1` <`whoami`@`hostname`>"
fi

cat <<EOF > debian/changelog
zoneminder ($VERSION-$DISTRO-$SNAPSHOT) $DISTRO; urgency=medium

  * 

 -- $AUTHOR  $DATE

EOF
#rm -rf .git
#rm .gitignore
#cd ../
#tar zcf zoneminder_$VERSION-$DISTRO.orig.tar.gz zoneminder_$VERSION-$DISTRO-$SNAPSHOT.orig
#cd zoneminder_$VERSION-$DISTRO-$SNAPSHOT.orig
if [ $TYPE == "binary" ]; then
	debuild
else
	if [ $TYPE == "local" ]; then
		debuild -i -us -uc -b
	else
		debuild -S -sa
	fi;
fi;

cd ../

read -p "Do you want to keep the checked out version of Zoneminder (incase you want to modify it later) [y/N]"
[[ $REPLY == [yY] ]] && { mv zoneminder_$VERSION-$DISTRO-$SNAPSHOT.orig zoneminder_release; echo "The checked out copy is preserved in zoneminder_release"; } || { rm -fr zoneminder_$VERSION-$DISTRO-$SNAPSHOT.orig; echo "The checked out copy has been deleted"; }
echo "Done!"
