# Global make definitions for Raspberry Pi 3 BCM2837 ARM Linux microcomputer

# Copyright (C)2019-2022, Philip Munts, President, Munts AM Corp.
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

TOOLCHAIN_BUILDER ?= crosstool

include $(MUNTSOS)/include/AArch64.mk
include $(MUNTSOS)/include/RaspberryPi.mk
include $(MUNTSOS)/include/$(TOOLCHAIN_BUILDER).mk

BOARDBASE	:= RaspberryPi3

KERNEL_DTB	+= broadcom/bcm2710-rpi-3-b-plus
KERNEL_DTB	+= broadcom/bcm2710-rpi-cm3
KERNEL_DTB	+= broadcom/bcm2710-rpi-zero-2


LOADER		= ld-linux-aarch64.so.1

include $(MUNTSOS)/include/common.mk
