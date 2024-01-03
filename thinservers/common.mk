# Makefile for building a MuntsOS SSH Thin Server

# Copyright (C)2018-2024, Philip Munts dba Munts Technologies.
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

include $(MUNTSOS)/include/$(BOARDNAME).mk

SED		?= sed
TAR		?= tar
ZIP		?= zip

ZIPDIR		= zipdir
ZIPFILE		?= muntsos-$(THINSERVERNAME)-$(BOARDNAME).zip

common_mk_default: default

###############################################################################

# Download prebuilt binaries

common_mk_prebuilt:
	$(MAKE) -C $(MUNTSOS)/bootkernel download_prebuilt MUNTSOS=$(MUNTSOS) BOARDNAME=$(BOARDBASE)

###############################################################################

# Populate the boot file system for a MuntsOS Thin Server

common_mk_populate:
	mkdir -p					$(ZIPDIR)/autoexec.d/$(BOARDBASE)
	mkdir -p					$(ZIPDIR)/tarballs
	mkdir -p					$(ZIPDIR)/packages/$(BOARDBASE)
	$(TAR) xzf $(BOOTFILESTGZ) -C			$(ZIPDIR)
	$(TAR) xzf $(MUNTSOS)/bootkernel/$(BOARDNAME)-Kernel.tgz --skip-old-files -C $(ZIPDIR)
ifneq ($(findstring RaspberryPi, $(BOARDNAME)),)
	cp $(BOOTFILESDIR)/cmdline.txt.$(BOARDNAME)	$(ZIPDIR)/cmdline.txt
endif
	cp $(BOOTFILESDIR)/config.txt.$(BOARDNAME)	$(ZIPDIR)/config.txt
	cp $(MUNTSOS)/scripts/00-wlan-init		$(ZIPDIR)/autoexec.d
	find $(ZIPDIR) -type f -exec chmod 644 {} ";"
	find $(ZIPDIR)/autoexec.d -type f -exec chmod 755 {} ";"

###############################################################################

# Create MuntsOS Thin Server installation zip file

$(ZIPFILE): populate.done
	chmod -R -w $(ZIPDIR)
	cd $(ZIPDIR) ; $(ZIP) -r ../$(ZIPFILE) *
	chmod -R +w $(ZIPDIR)

###############################################################################

# Clean out working files

common_mk_clean:
	rm -rf $(ZIPFILE) $(ZIPDIR) populate.done

common_mk_reallyclean: common_mk_clean
	$(MAKE) -C $(MUNTSOS)/bootkernel clean

common_mk_distclean: common_mk_reallyclean
	$(MAKE) -C $(MUNTSOS)/bootkernel reallyclean
	rm -rf prebuilt.done
