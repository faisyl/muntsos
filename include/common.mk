# Global definitions for embedded Linux microcomputer framework

# Copyright (C)2013-2023, Philip Munts dba Munts Technologies.
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

.PHONY: common_mk_default

TEMP		?= /tmp

DOWNLOADPREFIX	?= http://repo.munts.com/muntsos

KERNEL_WORK	= $(MUNTSOS)/bootkernel/kernel/work
KERNEL_SRC	= $(KERNEL_WORK)/$(KERNEL_NAME)
KERNEL_DTC	= $(KERNEL_SRC)/scripts/dtc/dtc
KERNEL_PATCH	= $(BOARDNAME).patch
KERNEL_CONFIG	= $(BOARDNAME).config

LIBSIMPLEIO	?= /usr/local/share/libsimpleio

common_mk_default: default

# Build a kernel source archive

ifeq ($(PLATFORM_NAME), raspberrypi)
KERNEL_TREEISH	?= rpi-$(KERNEL_BRANCH).y
else
KERNEL_TREEISH	?= $(KERNEL_BRANCH)
endif

$(KERNEL_DIST):
	if [ ! -d $(KERNEL_CLONE) ]; then git clone --depth 1 $(KERNEL_REPO) -b $(KERNEL_TREEISH) $(KERNEL_CLONE) ; fi
	cd $(KERNEL_CLONE) ; git archive --output=$(KERNEL_DIST) --prefix=$(KERNEL_NAME)/ $(KERNEL_TREEISH)
	cd $(KERNEL_CLONE) ; git show $(KERNEL_TREEISH) | head -n 1 | awk '{ print $$2 }' >$(KERNEL_COMMIT)
	if [ "$(shell dirname $(KERNEL_CLONE))" = "$(TEMP)" ]; then rm -rf $(KERNEL_CLONE) ; fi
	touch $@
