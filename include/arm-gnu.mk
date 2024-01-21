# Global definitions for Arm GNU cross-toolchains built with Linaro ABE

# Copyright (C)2023-2024, Philip Munts dba Munts Technologies.
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

CONFIGURE_NAME	= $(GCCARCH)-muntsos-linux-$(GCCABI)
ifeq ($(GCCARCH), aarch64)
TOOLCHAIN_NAME	= $(CONFIGURE_NAME)-abe
else
TOOLCHAIN_NAME	= $(CONFIGURE_NAME)-abe-$(BOARDBASELC)
endif
TOOLCHAIN_DIR	= /usr/local/gcc-$(TOOLCHAIN_NAME)
TOOLCHAIN_REV	= 8
CROSS_COMPILE	= $(TOOLCHAIN_DIR)/bin/$(CONFIGURE_NAME)-
GCCSYSROOT	= $(TOOLCHAIN_DIR)/$(CONFIGURE_NAME)/libc
LIBSDIR		= $(GCCSYSROOT)/usr
LIBSBINDIR	= $(GCCSYSROOT)/usr/bin
LIBSETCDIR	= $(GCCSYSROOT)/usr/etc
LIBSINCDIR	= $(GCCSYSROOT)/usr/include
LIBSLIBDIR	= $(GCCSYSROOT)/usr/lib
LIBSSHAREDIR	= $(GCCSYSROOT)/usr/share

GCCVER		= $(shell $(CROSS_COMPILE)gcc --version | awk '/muntsos/ { print $$3 }')

# C/C++

CFLAGS		+= -DMUNTSOS

# Free Pascal

FPC		= /usr/local/fpc-$(TOOLCHAIN_NAME)/bin/fpc
FPC_FLAGS	+= -dMUNTSOS

# GNAT Ada

GNATPREFIX	= $(CROSS_COMPILE)

ifeq ($(GCCARCH), aarch64)
GPRBUILDCONFIG	= --config=$(TOOLCHAIN_DIR)/share/gpr/AArch64.cgpr
else
GPRBUILDCONFIG	= --config=$(TOOLCHAIN_DIR)/share/gpr/$(BOARDBASE).cgpr
endif

# Alire

ALRFLAGS	+= -- $(GPRBUILDCONFIG)
