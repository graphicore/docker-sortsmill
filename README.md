# Compile Sorts Mill-Tools in Docker images

[Sorts Mill-Tools](https://bitbucket.org/sortsmill/sortsmill-tools): a font editing system derived from FontForge.

It is hard to build at the moment, so I made this project.

This repository has two purposes:

 * Document how to compile Sorts Mill Tools on Gnu/Linux.
 * Create a reusable recipe that compiles Sortsmill using [Docker](https://www.docker.com/).

The Sorts Mill Docker images will then be usable to build fonts depending on Sorts Mill-Tools, like
[Amiri](http://amirifont.org) ([github](https://github.com/khaledhosny/amiri-font)) or
[Jomhuria](https://github.com/Tarobish/Jomhuria).


There are currently two supported Gnu/Linux distrubutions:

 * Debian Jessie (current testing)
 * Arch Linux

**The builds may not be perfect, Pull Requests for improvements etc. are welcome!**

## Documentation

If you are interested in what you need to compile Sortsmill for your
system, the files `dockerfiles/arch_sortsmill/Dockerfile` and
`dockerfiles/arch_debian/Dockerfile` should give you a good understanding.
[Dockerfile Reference](https://docs.docker.com/reference/builder/)

## Builds

### Sortsmill Tools on Debian Jessie/testing

You will need `debian/jessie` to build `debian/sortsmill`.

#### Build Docker-Image `debian/jessie`

*depends on `debootstrap`, `tar`, `docker`, mkimage.sh¹*

```sh
$ sudo ./tools/make-base-debian-jessie.sh
```

¹NOTE: Docker has a script to bootstrap Debian (and more) base images, we use this here. You
should have on your system: `/usr/share/docker.io/contrib/mkimage.sh`.

#### Build Docker-Image `debian/sortsmill`

*depends on `debian/jessie`*

This will download all dependencies of Sorts Mill-Tools and install them; either via the packet manager or via git/make etc.

Then it fetches all needed sortsmill-* git repositories, compiles and installs one after another.

```sh
$ cd dockerfiles/debian_sortsmill
$ sudo docker build -t debian/sortsmill .
```

### Sorts Mill-Tools on Arch Linux

You will need `arch/base` to build `arch/minimal`.

You will need `arch/minimal` to build `arch/sortsmill`

#### Build Docker-Image `arch/base`

*depends on `wget`, `tar`, `docker`*

```sh
$ sudo ./tools/make-base-arch.sh
```

#### Build Docker-Image `arch/minimal`

*depends on `arch/base`*

First: open the file `arch/minimal/mirrorlist` in a text editor and
choose a set of arch package mirror servers that suit you best; i.e.
that are close to your location.


```sh
$ cd dockerfiles/arch_minimal
$ sudo docker build -t arch/minimal .
```

#### Build Docker-Image `arch/sortsmill`

*depends on `arch/minimal`*

This will download all dependencies of Sorts Mill-Tools and install them;
either via the packet manager or via git/make etc.

Then it fetches all needed sortsmill-* git repositories, compiles and
installs one after another.

```sh
$ cd dockerfiles/arch_sortsmill
$ sudo docker build -t arch/sortsmill .
```
<hr />
Copyright (c) 2015 Lasse Fister, GPLv3 applies, see LICENSE

![GPLv3](http://www.gnu.org/graphics/gplv3-127x51.png)

