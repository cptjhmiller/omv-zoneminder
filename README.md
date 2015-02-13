omv-zoneminder
==============

    cd /tmp
    git clone https://github.com/ZoneMinder/ZoneMinder.git
    apt-get install autoconf automake dpatch libphp-serialization-perl libgnutls-dev libmysqlclient-dev libdbd-mysql-perl libdate-manip-perl libwww-perl libjpeg8-dev libpcre3-dev libavcodec-dev libavformat-dev libswscale-dev libavutil-dev libv4l-dev libbz2-dev libtool libsys-mmap-perl libav-tools libnetpbm10-dev libavdevice-dev libdevice-serialport-perl libpcre3 libarchive-zip-perl libmime-lite-perl libjpeg8 dh-autoreconf libvlccore-dev libvlc-dev libcurl4-openssl-dev libgcrypt11-dev libfile-fcntllock-perl git-core build-essential libpolkit-gobject-1-dev

#check if newer version exists 

    wget --trust-server-names http://sourceforge.net/projects/libjpeg-turbo/files/1.3.90%20%281.4%20beta1%29/libjpeg-turbo-official_1.3.90_amd64.deb/download
    dpkg -i libjpeg-turbo-official_1.3.90_amd64.deb

# Imstall perl modules

    perl -MCPAN -e shell
    install CPAN
    install Date::Manip
    install LWP::UserAgent
    install Sys::Mmap
    install Device::SerialPort
    install Net::FTP
    install Net::SFTP::Foreign
    install Archive::Tar
    install Archive::Zip
    install Net::SMTP
    install MIME::Lite
    install MIME::Entity
    install X10::ActiveHome
    exit
    cd ZoneMinder
    git clone https://github.com/cptjhmiller/omv-zoneminder.git /tmp/ZoneMinder/debian
    dpkg-checkbuilddeps
#apt-get any missing packages

#build the package

    dpkg-buildpackage
