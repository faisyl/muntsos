# Makefile for building the ALSA library for MuntsOS

# Copyright (C)2020-2022, Philip Munts, President, Munts AM Corp.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# * Redistributions of source code must retain the above copyright notice,
#   this list of conditions and the following disclaimer.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.

BOARDNAME	?= UNDEFINED
MUNTSOS		?= $(shell pwd)/../..

include $(MUNTSOS)/include/$(BOARDNAME).mk
include $(LIBSIMPLEIO)/include/dpkg.mk

BUILDOS		= --build=`uname -m`
TARGETOS	= --host=$(CONFIGURE_NAME)

SRCNAME		= alsa-utils
SRCVER		= 1.2.7
SRCDIR		= $(SRCNAME)-$(SRCVER)
SRCTARBALL	= $(SRCDIR).tar.bz2
SRCSERVER	= https://www.alsa-project.org/files/pub/utils/
SRCURL		= $(SRCSERVER)/$(SRCTARBALL)
SRCDIST		= $(TEMP)/$(SRCTARBALL)

OSNAME		= muntsos-$(BOARDBASE)
PKGNAME		= alsa
PKGARCH		= $(DEBARCH)

default: build.done

# Download the source distribution

$(SRCDIST):
	wget -nv -P $(TEMP) $(SRCURL)

# Unpack the source distribution

src.done: $(SRCDIST)
	tar xjf $(SRCDIST)
	touch $@

# Compile sources

build.done: src.done
	cd $(SRCDIR) ; ./configure \
		--with-alsa-prefix=`pwd`/../../DIST/usr/lib \
		--with-alsa-inc-prefix=`pwd`/../../DIST/usr/include \
		--prefix=`pwd`/../../DIST/usr \
		--without-curses \
		--disable-rpath --disable-alsamixer --disable-nls \
		$(BUILDOS) $(TARGETOS) CC=$(CROSS_COMPILE)gcc CFLAGS=-I$(LIBSINCDIR)
	make -C $(SRCDIR) install
	touch $@

# Remove working files

clean:
	rm -rf build.done sndfile.done
	if [ ! -f $(PKGFILE).downloaded ]; then rm -f $(PKGFILE) ; fi
	-$(MAKE) -C $(SRCDIR) distclean

reallyclean: clean
	rm -rf src.done $(SRCDIR) $(PKGFILE) $(PKGFILE).downloaded

distclean: reallyclean
	rm -rf $(SRCDIST)
