#! /bin/sh

sudo /usr/share/docker.io/contrib/mkimage.sh -t debian/jessie debootstrap \
    --variant=minbase jessie

