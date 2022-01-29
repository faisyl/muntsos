# Global definitions for Debian cross-toolchains

# Copyright (C)2022, Philip Munts, President, Munts AM Corp.
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

CONFIGURE_NAME	= $(GCCARCH)-linux-$(GCCABI)
TOOLCHAIN_NAME	= $(CONFIGURE_NAME)-muntsos-$(TOOLCHAIN_BUILDER)
TOOLCHAIN_DIR	= /usr
CROSS_COMPILE	= $(TOOLCHAIN_DIR)/bin/$(CONFIGURE_NAME)-
GCCLIBDIR1	= /usr/$(CONFIGURE_NAME)/lib
GCCLIBDIR2	= /usr/$(CONFIGURE_NAME)/lib
GCCLDLINUX	= $(GCCLIBDIR2)/$(LOADER)
GCCMAJOR	= 10
GLIBCCOPYRIGHT	= /usr/share/doc/libc6-$(DEBARCH)-cross/copyright
LIBSETCDIR	= /usr/local/$(CONFIGURE_NAME)-muntsos-$(TOOLCHAIN_BUILDER)/etc
LIBSINCDIR	= /usr/local/$(CONFIGURE_NAME)-muntsos-$(TOOLCHAIN_BUILDER)/include
LIBSLIBDIR	= /usr/local/$(CONFIGURE_NAME)-muntsos-$(TOOLCHAIN_BUILDER)/lib

# C/C++

CFLAGS		+= -DMUNTSOS

# Free Pascal

ifeq ($(GCCARCH), aarch64)
FPC_COMMAND	= ppcrossa64
else
FPC_COMMAND	= ppcross$(ARCH)
endif
FPC_FLAGS	+= -dMUNTSOS
FPC		= /usr/local/fpc-$(TOOLCHAIN_NAME)/bin/$(FPC_COMMAND)

# GNAT Ada

GNATPREFIX	= $(CROSS_COMPILE)
GPRBUILDCONFIG	= --config=$(LIBSIMPLEIO)/ada/projects/$(CONFIGURE_NAME).cgpr
