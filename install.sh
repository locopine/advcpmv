#!/bin/sh

set -e

ADVCPMV_VERSION=${1:-0.9}
CORE_UTILS_VERSION=${2:-9.0}

wget http://ftp.gnu.org/gnu/coreutils/coreutils-$CORE_UTILS_VERSION.tar.xz
tar xvJf coreutils-$CORE_UTILS_VERSION.tar.xz
rm coreutils-$CORE_UTILS_VERSION.tar.xz
(
    cd coreutils-$CORE_UTILS_VERSION/
    wget https://raw.githubusercontent.com/jarun/advcpmv/master/advcpmv-$ADVCPMV_VERSION-$CORE_UTILS_VERSION.patch
    patch -p1 -i advcpmv-$ADVCPMV_VERSION-$CORE_UTILS_VERSION.patch
    ./configure
    make
    cp ./src/cp ../advcp
    cp ./src/mv ../advmv

    sudo mv ./advcp /usr/local/bin/
    sudo mv ./advmv /usr/local/bin/
    echo alias cp '/usr/local/bin/advcp -g' >> ~/.bashrc
    echo alias cp '/usr/local/bin/advcp -g' >> ~/.zshrc
    echo alias mv '/usr/local/bin/advmv -g' >> ~/.bashrc
    echo alias mv '/usr/local/bin/advmv -g' >> ~/.zshrc
)
rm -rf coreutils-$CORE_UTILS_VERSION
