#! /bin/sh

ARCH_URL=http://mirrors.kernel.org/archlinux/iso/2015.03.01/archlinux-bootstrap-2015.03.01-x86_64.tar.gz

wget -O arch-original.tar.gz $ARCH_URL

# repack the download
tar -xf arch-original.tar.gz

cd root.x86_64 && tar -czf ../arch.tar.gz * && cd ..

chmod -R +w root.x86_64

cat arch.tar.gz | docker import - arch/base

# clean up
unlink arch-original.tar.gz
unlink arch.tar.gz
rm -rf root.x86_64

