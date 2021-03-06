FROM debian/jessie

RUN apt-get update && apt-get install -y \
	build-essential \
	git \
	gperf \
	guile-2.0 \
	guile-2.0-libs \
	guile-2.0-dev \
	libatomic-ops-dev \
	libmonoboehm-2.0-1 \
	libmonoboehm-2.0-dev \
	libunistring0 \
	libunistring-dev \
	libgsl0-dev  \
	python-gmpy \
	cython \
	gpp \
	autoconf \
	intltool \
	libpcre3 \
	libpcre3-dev \
	libtool \
	gawk \
	libgettextpo0 \
	libgettextpo-dev \
	vim \
	libglib2.0-dev \
	libpng12-0 \
	libpng12-dev \
	libxml2 \
	libxml2-dev \
	libfreetype6 \
	libfreetype6-dev \
	libspiro0 \
	libspiro-dev \
	libcairo2 \
	libcairo2-dev \
	libpango1.0-dev \
	libpango1.0-0 \
	libxcursor-dev \
	&& rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/build \
	&& cd /var/build \
	&& echo "Versions used:" > versions.txt

RUN cd /var/build \
	&& git clone git://git.sv.gnu.org/gnulib.git \
	&& ln -s `pwd`/gnulib/gnulib-tool /usr/local/bin/ \
	&& cd gnulib \
	&& echo `git config --get remote.origin.url` at `git rev-parse HEAD` >> /var/build/versions.txt

ADD https://bitbucket.org/sortsmill/libunicodenames/downloads/libunicodenames-1.1.0_beta1.tar.xz  /var/build/

RUN cd /var/build \
	&& tar xf libunicodenames-1.1.0_beta1.tar.xz \
	&& cd /var/build/libunicodenames-1.1.0_beta1 \
	&& mkdir .build \
	&& cd .build \
	&& ../configure \
	&& make \
	&& make install \
	&& ldconfig \
	&& cd /var/build \
	&& rm -rf libunicodenames-1.1.0_beta1

RUN cd /var/build/ \
	&& git clone https://bitbucket.org/sortsmill/sortsmill-tig.git \
	&& cd sortsmill-tig \
	&& echo `git config --get remote.origin.url` at `git rev-parse HEAD` >> /var/build/versions.txt \
	&& ./autogen.sh \
	&& mkdir .build \
	&& cd .build \
	&& ../configure \
	&& make install \
	&& cd /var/build \
	&& rm -rf sortsmill-tig

ENV PKG_CONFIG_PATH /usr/local/lib/pkgconfig

RUN cd /var/build \
	&& git clone https://bitbucket.org/sortsmill/sortsmill-core.git \
	&& cd sortsmill-core \
	&& echo `git config --get remote.origin.url` at `git rev-parse HEAD` >> /var/build/versions.txt \
	&& ./autogen.sh \
	&& mkdir .build \
	&& cd .build \
	&& ../configure \
	&& make \
	&& make install \
	&& ldconfig \
	&& cd /var/build \
	&& rm -rf sortsmill-core

RUN cd /var/build \
	&& git clone https://bitbucket.org/sortsmill/sortsmill-core-guile.git \
	&& cd sortsmill-core-guile \
	&& echo `git config --get remote.origin.url` at `git rev-parse HEAD` >> /var/build/versions.txt \
	&& ./autogen.sh \
	&& mkdir .build \
	&& cd .build \
	&& ../configure \
	&& make \
	&& make install \
	&& ldconfig \
	&& cd /var/build \
	&& rm -rf sortsmill-core-guile

RUN cd /var/build \
	&& git clone https://bitbucket.org/sortsmill/sortsmill-tools.git \
	&& cd sortsmill-tools \
	&& echo `git config --get remote.origin.url` at `git rev-parse HEAD` >> /var/build/versions.txt \
	&& ./autogen.sh \
	&& mkdir .build \
	&& cd .build \
	&& ../configure \
	&& make \
	&& make install \
	&& ldconfig \
	&& \
	   # see: https://github.com/docker/docker/issues/13451
	   mv confdir3/confdir3/confdir3/confdir3/confdir3/ deleteable \
	&& cd /var/build \
	&& rm -rf sortsmill-tools

ENV  PYTHONPATH /usr/local/lib/python2.7/site-packages/

ENV GUILE_LOAD_PATH /usr/local/share/guile/site/2.0:$GUILE_LOAD_PATH

ENV LD_LIBRARY_PATH /usr/local/lib:$LD_LIBRARY_PATH

# It's nice to have all as many as possible guile files precompiled
# because this will become the state of the container.
RUN find /usr/local/ -name *.scm -exec guild compile {} \; \
	&& python -c "import sortsmill"


