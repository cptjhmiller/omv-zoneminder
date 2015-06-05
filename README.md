omv-zoneminder
==============

    mkdir /zoneminder
    cd /zoneminder
    git clone https://github.com/ZoneMinder/ZoneMinder.git
    apt-get install autoconf automake dpatch libphp-serialization-perl libgnutls-dev libmysqlclient-dev libdbd-mysql-perl libdate-manip-perl libwww-perl libjpeg8-dev libpcre3-dev libavcodec-dev libavformat-dev libswscale-dev libavutil-dev libv4l-dev libbz2-dev libtool libsys-mmap-perl libav-tools libnetpbm10-dev libavdevice-dev libdevice-serialport-perl libpcre3 libarchive-zip-perl libmime-lite-perl libjpeg8 dh-autoreconf libvlccore-dev libvlc-dev libcurl4-openssl-dev libgcrypt11-dev libfile-fcntllock-perl git-core build-essential libpolkit-gobject-1-dev libmailtools-perl librrds-perl libnet-sftp-foreign-perl libexpect-perl quilt diffstat libio-pty-perl libio-stty-perl ffmpeg fonts-freefont-ttf liba52-0.7.4 libaa1 libass4 libaudio2 libavc1394-0  libbluray1 libcddb2 libcrystalhd3 libdca0 libdirac-decoder0 libdrm2 libdvbpsi7 libdvdnav4 libdvdread4 libebml3 libenca0 libfaad2 libfribidi0 libgl1-mesa-glx libglapi-mesa libiso9660-8 libjbig0 libkate1 liblcms1 liblircclient0 liblua5.1-0 libmad0 libmatroska5 libmng1 libmodplug1 libmpcdec6 libmpeg2-4 libmtp-common libmtp9 libproxy0 libqtcore4 libqtgui4 libresid-builder0c2a libsdl-image1.2 libshout3 libsidplay2 libsmbclient libspeexdsp1 libtag1-vanilla libtag1c2a libtar0 libtiff4 libtwolame0 libupnp6 libva-x11-1 libvcdinfo0 libwebp2 libxcb-composite0 libxcb-glx0 libxcb-keysyms1 libxcb-randr0 libxcb-shape0 libxcb-xfixes0 libxcb-xv0 libxdamage1 libxinerama1 libxpm4 libxt6 libxxf86vm1 libzvbi-common libzvbi0 vlc vlc-nox libapr1 libaprutil1 libaprutil1-dbd-sqlite3 libaprutil1-ldap  libconvert-binhex-perl libmime-tools-perl yasm cmake


#check if newer version exists 

    wget --trust-server-names http://sourceforge.net/projects/libjpeg-turbo/files/1.3.90%20%281.4%20beta1%29/libjpeg-turbo-official_1.3.90_amd64.deb/download
    dpkg -i libjpeg-turbo-official_1.3.90_amd64.deb
    echo "/opt/libjpeg-turbo/lib64" > /etc/ld.so.conf.d/libjpeg-turbo.conf
    ldconfig

# Install perl modules

    perl -MCPAN -e shell
    install Date::Manip
    install Sys::Mmap
    install Device::SerialPort
    install Net::FTP
    install Net::SFTP::Foreign
    install Archive::Tar
    install Archive::Zip
    install Net::SMTP
    install MIME::Types
    install Mail::Address
    install MIME::Lite
    install MIME::Entity
    install X10::ActiveHome
    install LWP::UserAgent
    install CPAN
    exit
    cd /zoneminder/ZoneMinder
    git clone https://github.com/cptjhmiller/omv-zoneminder.git /zoneminder/ZoneMinder/debian
    dpkg-checkbuilddeps
#apt-get any missing packages

#build the package

    dpkg-buildpackage -uc -us
