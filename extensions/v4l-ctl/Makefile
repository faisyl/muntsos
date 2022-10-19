# Makefile for building the v4l-utils package for MuntsOS

# Copyright (C)2020-2021, Philip Munts, President, Munts AM Corp.
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

SRCNAME		= v4l-utils
SRCVER		= 1.22.1
SRCDIR		= $(SRCNAME)-$(SRCVER)
SRCTARBALL	= $(SRCDIR).tar.bz2
SRCSERVER	= http://linuxtv.org/downloads/v4l-utils
SRCURL		= $(SRCSERVER)/$(SRCTARBALL)
SRCDIST		= $(TEMP)/$(SRCTARBALL)

OSNAME		= muntsos-$(BOARDBASE)
PKGNAME		= $(SRCNAME)
PKGVERSION	= $(SRCVER)-$(shell date +%Y.%j)
PKGARCH		= $(DEBARCH)
PKGDIR		= $(PKGNAME)-$(OSNAME)
PKGFILE		= $(PKGDIR).deb

default: package.deb

# Download the source distribution

$(SRCDIST):
	wget -nv -P $(TEMP) $(SRCURL)

# Unpack the source distribution

src.done: $(SRCDIST)
	tar jxf $^
	touch $@

# Compile sources

build.done: src.done
	cd $(SRCDIR) ; ./configure $(BUILDOS) $(TARGETOS) --disable-gui --disable-ipv6 --disable-v4l2-ctl-libv4l --disable-bpf CC=$(CROSS_COMPILE)gcc CXX=$(CROSS_COMPILE)g++ LD=$(CROSS_COMPILE)ld --disable-shared
	$(MAKE) -C $(SRCDIR)/utils/v4l2-ctl
	touch $@

# Build the Debian package file

$(PKGDIR): build.done
	mkdir -p						$(PKGDIR)/DEBIAN
	mkdir -p						$(PKGDIR)/usr/local/sbin
	chmod 0755						$(PKGDIR)/usr/local/sbin
	install -cm 0644 control				$(PKGDIR)/DEBIAN
	sed -i s/@@ARCH@@/$(PKGARCH)/g				$(PKGDIR)/DEBIAN/control
	sed -i s/@@NAME@@/$(PKGNAME)/g				$(PKGDIR)/DEBIAN/control
	sed -i s/@@VERSION@@/$(PKGVERSION)/g			$(PKGDIR)/DEBIAN/control
	install -cm 0755 $(SRCDIR)/utils/v4l2-ctl/v4l2-ctl	$(PKGDIR)/usr/local/sbin
	$(CROSS_COMPILE)strip					$(PKGDIR)/usr/local/sbin/*
	touch $@

package.deb: $(PKGFILE)

# Download prebuilt package

download_prebuilt: $(PKGFILE).downloaded

$(PKGFILE).downloaded:
	wget -q -nc $(DOWNLOADPREFIX)/extensions/$(PKGFILE)
	touch $(PKGFILE).downloaded

# Remove working files

clean:
	-$(MAKE) -C $(SRCDIR) distclean
	rm -rf build.done $(PKGDIR)
	if [ ! -f $(PKGFILE).downloaded ]; then rm -f $(PKGFILE) ; fi

reallyclean: clean
	rm -rf src.done $(SRCDIR) $(PKGFILE) $(PKGFILE).downloaded

distclean: reallyclean
	rm -rf $(SRCDIST)
