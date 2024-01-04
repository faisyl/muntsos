# Global make definitions for Raspberry Pi BCM283x ARM Linux microcomputer

# Copyright (C)2013-2024, Philip Munts dba Munts Technologies.
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

# The original Raspberry Pi (1) is obsolete, but it still serves as the
# base upon which software for the newer boards is built.  Their makefiles
# will include this one and override macros as necessary.

PLATFORM_NAME	= raspberrypi

KERNEL_IMGSRC	= Image
KERNEL_IMG	= $(BOARDNAME).img
KERNEL_TARGETS	= $(KERNEL_IMGSRC) dtbs

BOOTFILESDIR	= $(MUNTSOS)/boot/RaspberryPi
ifeq ($(GCCARCH), aarch64)
BOOTFILESTGZ	= $(BOOTFILESDIR)/bootfiles64.tgz
else
BOOTFILESTGZ	= $(BOOTFILESDIR)/bootfiles32.tgz
endif
BOOTKERNELDIR	= $(MUNTSOS)/bootkernel
BOOTKERNELTGZ	= $(BOOTKERNELDIR)/$(BOARDNAME)-Kernel.tgz

# Definitions for the Raspberry Pi kernel repository

KERNEL_REPO	= https://github.com/raspberrypi/linux.git
ifeq ($(GCCARCH), aarch64)
KERNEL_BRANCH	?= 6.1
else
KERNEL_BRANCH	?= 5.15
endif
KERNEL_TREEISH	= rpi-$(KERNEL_BRANCH).y
KERNEL_NAME	= linux-$(PLATFORM_NAME)-$(KERNEL_BRANCH)
KERNEL_CLONE	= $(TEMP)/$(KERNEL_NAME)
KERNEL_DIST	= $(TEMP)/$(KERNEL_NAME).tgz
KERNEL_COMMIT	= $(TEMP)/$(KERNEL_NAME).commit

CFLAGS		+= -DRASPBERRYPI
