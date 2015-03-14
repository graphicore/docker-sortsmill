FROM arch/base

COPY mirrorlist /etc/pacman.d/mirrorlist

# this takes forever because there's not enough entropy created by docker
# maybe playing with the keybord helps a bit, if not at least it feels like ;)
RUN	pacman-key --init \
	&& pacman-key --populate archlinux

# update everything
RUN	pacman -Syy --noconfirm \
	&& pacman -S archlinux-keyring --noconfirm \
	&& pacman -Syyu --noconfirm

# install packagei
RUN pacman -S --noconfirm \
	base-devel \
	git \
	gperf \
	guile \
	libatomic_ops \
	mono \
	libunistring \
	gsl \
	vim \
	wget \
	apache-ant \
	autoconf \
	intltool \
	pcre \
	libtool \
	gawk \
	freetype2 \
	libpng \
	libxml2 \
	libspiro \
	cairo \
	pango \
	libxcursor \
	libunicodenames \
	python2 \
	python2-pip \
	cython2 \
	&&  pip2 install gmpy


RUN useradd abs

RUN	mkdir /var/abs \
	&& chown abs /var/abs

USER abs

RUN	cd /var/abs \
	&& wget https://aur.archlinux.org/packages/gp/gpp-preprocessor/gpp-preprocessor.tar.gz \
	&& tar -xf gpp-preprocessor.tar.gz \
	&& cd gpp-preprocessor \
	&& makepkg -s 

USER root

RUN pacman -U --noconfirm /var/abs/gpp-preprocessor/*.pkg.tar.xz

RUN mkdir /var/sortsmill \
        && cd /var/sortsmill \
        && mkdir build \
        && git clone git://git.sv.gnu.org/gnulib.git \
        && ln -s `pwd`/gnulib/gnulib-tool /usr/local/bin/ \
        && git clone https://bitbucket.org/sortsmill/sortsmill-tig.git \
        && git clone https://bitbucket.org/sortsmill/sortsmill-core.git

RUN cd /var/sortsmill \
        && git clone https://bitbucket.org/sortsmill/sortsmill-core-guile.git \
        && git clone https://bitbucket.org/sortsmill/sortsmill-tools.git

RUN cd /var/sortsmill/sortsmill-tig \
        && ./autogen.sh \
        && mkdir ../build/sortsmill-tig \
        && cd ../build/sortsmill-tig \
        && ../../sortsmill-tig/configure \
        && make install
	
RUN cd /var/sortsmill/sortsmill-core \
        && ./autogen.sh \
        && mkdir .build \
        && cd .build \
        && ../configure \
        && make \
        && make install \
	&& ldconfig

ENV PKG_CONFIG_PATH /usr/local/lib/pkgconfig:$PKG_CONFIG_PATH

# ENV LIBRARY_PATH /usr/local/lib:$LIBRARY_PATH
ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:/usr/local/lib

RUN cd /var/sortsmill/sortsmill-core-guile \
	&& ./autogen.sh \
	&& mkdir .build \
	&& cd .build \
	&& ../configure \
	&& make \
	&& make install
	&& ldconfig

RUN cd /var/sortsmill/sortsmill-tools \
        && ./autogen.sh \
        && mkdir .build \
        && cd .build \
        && env PYTHON=`which python2` CYTHON=cython2 ../configure \
        && make \
        && make install
	&& ldconfig

ENV  PYTHONPATH /usr/local/lib/python2.7/site-packages:$PYTHONPATH

ENV GUILE_LOAD_PATH /usr/local/share/guile/site/2.0/:$GUILE_LOAD_PATH

# it's nice to have all guile files precompiled already
RUN find /usr/local/ -name *.scm -exec guild compile {} \; \
	&& python2 -c "import sortsmill"


CMD /bin/bash
