FROM ubuntu/utopic


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
	&& git clone https://bitbucket.org/sortsmill/sortsmill-core.git \
	&& cd sortsmill-core && git checkout cd0f072141fcd963adf && cd .. \
	&& wget https://bitbucket.org/sortsmill/libunicodenames/downloads/libunicodenames-1.1.0_beta1.tar.xz \
	&& tar xf libunicodenames-1.1.0_beta1.tar.xz \
	&& git clone https://bitbucket.org/sortsmill/sortsmill-core-guile.git \
	&& cd sortsmill-core-guile && git checkout 1278d7dac26f3572d && cd .. \
	&& git clone https://bitbucket.org/sortsmill/sortsmill-tools.git \
	&& cd sortsmill-tools && git checkout d8f83be51a49d0a6 && cd .. \
	&& cd /var/sortsmill/build \
	&& mkdir libunicodenames \
	&& cd libunicodenames \
	&& ../../libunicodenames-1.1.0_beta1/configure \
	&& make \
	&& make install \
	&& cd /var/sortsmill/sortsmill-tig \
	&& ./autogen.sh \
	&& mkdir ../build/sortsmill-tig \
	&& cd ../build/sortsmill-tig \
	&& ../../sortsmill-tig/configure \
	&& make install \
	&& mkdir /var/sortsmill/target \
	&& cd /var/sortsmill/sortsmill-core \
	&& ./autogen.sh \
	&& mkdir ../build/sortsmill-core \
	&& cd ../build/sortsmill-core \
	&& ../../sortsmill-core/configure --prefix=/var/sortsmill/target \
	&& make \
	&& make install

ENV PKG_CONFIG_PATH /var/sortsmill/target/lib/pkgconfig

ENV PATH /var/sortsmill/target/bin:$PATH

ENV GUILE_LOAD_PATH /var/sortsmill/target/share/guile/site/2.0


RUN cd /var/sortsmill/sortsmill-core-guile \
	&& ./autogen.sh \
	&& mkdir ../build/sortsmill-core-guile \
	&& cd ../build/sortsmill-core-guile \
	&& ../../sortsmill-core-guile/configure --prefix=/var/sortsmill/target \
	&& make \
	&& make install
	
RUN cd /var/sortsmill/sortsmill-tools \
	&& ./autogen.sh \
	&& mkdir ../build/sortsmill-tools \
	&& cd ../build/sortsmill-tools \
	&& ../../sortsmill-tools/configure --prefix=/var/sortsmill/target \
	&& make \
	&& make install

# ENV  PYTHONPATH /var/sortsmll/target/lib/python2.7/site-packages/

# RUN  python -c "from sortsmill import ffcompat as fontforge"
