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
	libgsl0-dev python-gmpy \
	cython \
	gpp \
	ant \
	autoconf \
	intltool \
	libpcre3 \
	libpcre3-dev \
	libtool \
	gawk \
	wget \
	libgettextpo0 \
	libgettextpo-dev \
	vim libglib2.0-dev \
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

RUN mkdir /var/sortsmill \
	&& cd /var/sortsmill \
	&& mkdir build \
        && git clone git://git.sv.gnu.org/gnulib.git \
        && ln -s `pwd`/gnulib/gnulib-tool /usr/local/bin/ \
        && git clone https://bitbucket.org/sortsmill/sortsmill-tig.git \
	&& git clone https://bitbucket.org/sortsmill/sortsmill-core.git

COPY libunicodenames-1.1.0_beta1.tar.xz /var/sortsmill/
RUN cd /var/sortsmill \
	&& tar xf libunicodenames-1.1.0_beta1.tar.xz

RUN cd /var/sortsmill \
	&& git clone https://bitbucket.org/sortsmill/sortsmill-core-guile.git \
	&& git clone https://bitbucket.org/sortsmill/sortsmill-tools.git

RUN	cd /var/sortsmill/libunicodenames-1.1.0_beta1 \
	&& mkdir .build \
	&& cd .build \
	&& ../configure \
	&& make \
	&& make install
	&& ldconfig

RUN cd /var/sortsmill/sortsmill-tig \
	&& ./autogen.sh \
	&& mkdir .build \
	&& cd .build \
	&& ../configure \
	&& make install

ENV PKG_CONFIG_PATH /usr/local/lib/pkgconfig

RUN cd /var/sortsmill/sortsmill-core \
	&& ./autogen.sh \
	&& mkdir .build \
	&& cd .build \
	&& ../configure \
	&& make \
	&& make install \
	&& ldconfig

RUN cd /var/sortsmill/sortsmill-core-guile \
	&& ./autogen.sh \
	&& mkdir .build \
	&& cd .build \
	&& ../configure \
	&& make \
	&& make install \
	&& ldconfig

RUN cd /var/sortsmill/sortsmill-tools \
	&& ./autogen.sh \
	&& mkdir .build \
	&& cd .build \
	&& ../configure \
	&& make \
	&& make install

RUN ldconfig

ENV  PYTHONPATH /usr/local/lib/python2.7/site-packages/

ENV GUILE_LOAD_PATH /usr/local/share/guile/site/2.0:$GUILE_LOAD_PATH

# it's nice to have all guile files precompiled already
RUN find /usr/local/ -name *.scm -exec guild compile {} \; \
	&& python -c "import sortsmill"


