#!/bin/bash

if [[ $(dpkg-query -s python3-venv 2>&1) == *'is not installed'* ]]; then
    printf "\nPackage python3-venv is missing.\nOn Debian-like distros, run:\n\napt install python3-venv\n\n"
    exit 1
fi

if [[ $(cat /etc/udev/rules.d/20-hw1.rules) == *'ATTRS{idVendor}=="2c97", ATTRS{idProduct}=="0004"'* ]]; then
    printf "\nMissing udev rules. Please refer to https://support.ledger.com/hc/en-us/articles/115005165269-Fix-connection-issues\n\n"
    exit 1
fi


mkdir tmp
mkdir dev-env
mkdir dev-env/SDK
mkdir dev-env/CC
mkdir dev-env/CC/others
mkdir dev-env/CC/nanox

cd tmp

if [ ! -e "gcc-arm-none-eabi.tar.bz2" ]; then
    wget https://developer.arm.com/-/media/Files/downloads/gnu-rm/10-2020q4/gcc-arm-none-eabi-10-2020-q4-major-x86_64-linux.tar.bz2 -O gcc-arm-none-eabi.tar.bz2
fi
tar xf gcc-arm-none-eabi.tar.bz2 &&
cp -r gcc-arm-none-eabi-10-2020-q4-major ../dev-env/CC/nanox/gcc-arm-none-eabi-10 &&
mv gcc-arm-none-eabi-10-2020-q4-major ../dev-env/CC/others/gcc-arm-none-eabi-10

if [ ! -e "clang+llvm_4.tar.xz" ]; then
    wget http://releases.llvm.org/4.0.0/clang+llvm-4.0.0-x86_64-linux-gnu-ubuntu-16.10.tar.xz -O clang+llvm_4.tar.xz 
fi
tar xf clang+llvm_4.tar.xz &&
mv clang+llvm-4.0.0-x86_64-linux-gnu-ubuntu-16.10 ../dev-env/CC/others/clang-arm-fropi

if [ ! -e "clang+llvm_9.tar.xz" ]; then
    wget http://releases.llvm.org/9.0.0/clang+llvm-9.0.0-x86_64-linux-gnu-ubuntu-16.04.tar.xz -O clang+llvm_9.tar.xz 
fi
tar xf clang+llvm_9.tar.xz &&
mv clang+llvm-9.0.0-x86_64-linux-gnu-ubuntu-16.04 ../dev-env/CC/nanox/clang-arm-fropi

if [ ! -e "nanos-secure-sdk.tar.gz" ]; then
    wget https://github.com/LedgerHQ/nanos-secure-sdk/archive/refs/tags/2.0.0-1.tar.gz -O nanos-secure-sdk.tar.gz 
fi
tar xf nanos-secure-sdk.tar.gz &&
mv nanos-secure-sdk-2.0.0-1 ../dev-env/SDK/nanos-secure-sdk

if [ ! -e "nanox-secure-sdk.tar.gz" ]; then
    wget https://github.com/LedgerHQ/nanox-secure-sdk/archive/refs/tags/2.0.0.tar.gz -O nanox-secure-sdk.tar.gz 
fi
tar xf nanox-secure-sdk.tar.gz &&
mv nanox-secure-sdk-2.0.0 ../dev-env/SDK/nanox-secure-sdk

cd ..

python3 -m venv dev-env/ledger_py3 &&
source dev-env/ledger_py3/bin/activate &&
pip3 install -r requirements.txt
