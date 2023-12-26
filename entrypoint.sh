#!/bin/sh -e

if [ -d /miktex/build ]; then
    dnf install -y /miktex/build/*.rpm
else
    sudo rpm --import "https://miktex.org/download/key"
    curl -L -o /etc/yum.repos.d/miktex.repo https://miktex.org/download/fedora/39/miktex.repo
    dnf -y install miktex
fi

# libQt5Core.so.5 is build for Linux kernel 4.11 which is by far too new
# see: https://github.com/Microsoft/WSL/issues/3023
strip --remove-section=.note.ABI-tag /usr/lib64/libQt5Core.so.5

GROUP_ID=${GROUP_ID:-1001}
USER_ID=${USER_ID:-1001}

groupadd -g $GROUP_ID -o joe
useradd --shell /bin/bash -u $USER_ID -g $GROUP_ID -o -c "" -m joe
export HOME=/home/joe
exec gosu joe "$@"
