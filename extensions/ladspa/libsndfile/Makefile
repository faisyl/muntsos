# Makefile for building the libsndfile extension package for MuntsOS

# Copyright (C)2021-2022, Philip Munts, President, Munts AM Corp.
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

SRCURL		= https://github.com/libsndfile/libsndfile.git
SRCDIR		= libsndfile.src
SRCDIST		= /tmp/libsndfile.tgz

OSNAME		= muntsos-$(BOARDBASE)
PKGNAME		= libsndfile
PKGVERSION	= $(shell date +%Y.%j)
PKGARCH		= $(DEBARCH)
PKGDIR		= $(PKGNAME)-$(OSNAME)
PKGFILE		= $(PKGDIR).deb


default: build.done

# Clone source repo and create source tarball

$(SRCDIST):
	git clone --recurse-submodules $(SRCURL) $(SRCDIR)
	tar czf $@ --exclude='.*' $(SRCDIR)
	rm -rf $(SRCDIR)

# Unpack source tarball

source.done: $(SRCDIST)
	tar xzf $^
	touch $@

# Compile sources

build.done: source.done
	[ -f $(SRCDIR)/configure ] || (cd $(SRCDIR) ; autoreconf -vif )
	cd $(SRCDIR) ; ./configure --prefix=`pwd`/../inst $(BUILDOS) $(TARGETOS) CC=$(CROSS_COMPILE)gcc CFLAGS=-I$(LIBSINCDIR)
	# Workaround for a cmake bug
	#sed -i 's@/usr/lib/x86_64-linux-gnu@$(LIBSLIBDIR)@g' libsndfile.src/CMakeFiles/libsndfile.dir/link.txt
	$(MAKE) -C $(SRCDIR) install
	touch $@

# Remove working files

clean:
	rm -rf $(PKGDIR)
	if [ ! -f $(PKGFILE).downloaded ]; then rm -f $(PKGFILE) ; fi

reallyclean: clean
	rm -rf build.done source.done $(SRCDIR) $(PKGFILE) $(PKGFILE).downloaded inst

distclean: reallyclean
