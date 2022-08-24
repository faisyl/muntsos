MuntsOS Embedded Linux
======================

This framework supports Linux on several single board microcomputers.
The goal of the MuntsOS project is to deliver a turnkey, RAM resident
Linux operating system for very low cost single board microcomputers.
With MuntsOS installed, such microcomputers can treated as components,
as *Linux microcontrollers*, and integrated into other projects just
like traditional single chip microcontrollers.

News
----

-   24 August 2022 -- Migrated Raspberry Pi 2, 3, 4 to Linux kernel
    5.15.x. Migrating to 5.15.x has proved to be a grueling exercise,
    easily the most difficult kernel migration in the history of MuntsOS
    Embedded Linux. Linux kernel 5.15.x still doesn't work right on
    Raspberry Pi 1 boards, so they are still frozen at kernel 5.10.95 for
    the moment.

Quick Setup Instructions for the Impatient
------------------------------------------

Instructions for installing the MuntsOS cross-toolchain development
environment onto a **host computer** are found in [Application Note
\#1](http://git.munts.com/muntsos/doc/AppNote1-Setup-Debian.pdf) and
[Application Note
\#2](http://git.munts.com/muntsos/doc/AppNote2-Setup-Other.pdf).

Instructions for installing MuntsOS to a **target computer** are found
in [Application Note
\#3](http://git.munts.com/muntsos/doc/AppNote3-Installation-from-Linux.pdf)
and [Application Note
\#15](http://git.munts.com/muntsos/doc/AppNote15-Installation-from-Windows.pdf).

Documentation
-------------

The documentation for MuntsOS (mostly application notes) is available
online at:

<http://git.munts.com/muntsos/doc>

Embedded Linux Distribution in a Kernel
---------------------------------------

MuntsOS is a stripped down Linux distribution that includes a small
compressed root file system within the kernel image binary itself. At
boot time the root file system is unpacked into RAM and thereafter the
system runs entirely in RAM.

Each kernel release tarball contains a kernel image file (**`.img`**),
which may be common to several different microcomputer boards, and one
or more [device tree](http://elinux.org/Device_Tree_Reference) files
(**`.dtb`**) that are specific to particular microcomputer boards. Some
kernel release tarballs also contain one or more device tree overlay
files (**`.dtbo`**) that can make small changes to the device tree at
boot time.

Prebuilt MuntsOS kernel release tarballs are available at:

<http://repo.munts.com/muntsos/kernels>

Extensions
----------

The MuntsOS root file system can be *extended* at boot time using any of
three mechanisms:

First, if **`/boot/tarballs`** exists, any **`gzip`** tarball files
(**`.tgz`**) in it will be extracted on top of the root file system.
Typically you would use this mechanism for customized **`/etc/passwd`**,
**`.ssh/authorized_keys`**, and similiar system configuration files.

Second, if **`/boot/packages/${BOARDBASE}`** exists, any Debian package
files (**`.deb`**) in it will be installed into the root file system.
Note that packages from the [Debian](http://www.debian.org) project will
probably not work with MuntsOS. Packages should be built specifically
for MuntsOS. (The **`.deb`** package file format is simply convenient to
use, as it is supported by BusyBox.)

The [GPIO Server](http://git.munts.com/muntsos/extensions/GPIO)
extension package demonstrates how to build a Debian package that adds
application specific software to MuntsOS.

Thirdly, the system startup script **`/etc/rc`** can be configured via a
kernel command line option to search for a subdirectory called
**`autoexec.d`** in various places, such as SD card, USB flash drive,
USB CD-ROM or NFS mount. If an **`autoexec.d`** subdirectory is found,
each executable program or script in it will be executed when the system
boots.

The idea is to build a MuntsOS kernel (which takes a long time) once and
install it to the target platform. Then application specific software
can be built after the fact and installed as one or more tarball files
in **`/boot/tarballs`**, Debian package files in
**`/boot/packages/${BOARDBASE}`**, or extension programs in
**`/boot/autoexec.d`**.

Prebuilt MuntsOS extension packages and programs are available at:

<http://repo.munts.com/muntsos/extensions>

Thin Servers
------------

### Boot Files + Kernel Files + Extensions = Thin Server

The *Thin Server* is a system design pattern that is little more than a
network interface for a single I/O device. Ideally, a Thin Server will
be built from a cheap and ubiquitous network microcomputer like the
Raspberry Pi. The software must be easy to install from a user's PC or
Mac without requiring any special programming tools. It must be able to
run headless, administered via the network. It must be able to survive
without orderly shutdowns, and must not write much to flash media. It
must provide a network based API (Application Programming Interface)
using HTTP as a lowest common denominator.

MuntsOS, with its operating system running entirely from RAM, serves
well for the Thin Server, and the two concepts have evolved together
over the past few years. The simplest way to use MuntsOS is to download
one of the prebuilt Thin Server **`.zip`** files and extract it to a
freshly formatted FAT32 SD card. You can then modify
**`autoexec.d/00-wlan-init`** on the SD card to pre-configure it for
your wireless network environment, if desired, before inserting it in
the target board. After booting MuntsOS, log in from the console or via
SSH (user "**`root`**", password "**`default`**") and run
**`sysconfig`** to perform more system configuration.

*Note: BeagleBone boards require the [boot
flag](https://en.wikipedia.org/wiki/Boot_flag) to be set on the FAT32
boot partition on the SD card or on-board eMMC. The ROM boot loader in
the CPU will ignore any partitions that are not marked as bootable.*

MuntsOS Application Notes
[3](http://git.munts.com/muntsos/doc/AppNote3-Installation-from-Linux.pdf)
and
[15](http://git.munts.com/muntsos/doc/AppNote15-Installation-from-Windows.pdf)
contain more detailed instructions about how to install a MuntsOS Thin
Server.

Prebuilt MuntsOS Thin Servers are at available at:

<http://repo.munts.com/muntsos/thinservers>

|                                       |                                                                                                    |
|---------------------------------------|----------------------------------------------------------------------------------------------------|
| **`muntsos*BeagleBone.zip`**          | For BeagleBone (White), Black, Black Wireless, Green, Green Wireless, PocketBeagle -- ARMv7 32-bit |
| **`muntsos*RaspberryPi.zip`**         | For all Raspberry Pi -- USB master                                                                 |
| **`muntsos*RaspberryPiGadget.zip`**   | For all Raspberry Pi -- USB slave                                                                  |
| **`muntsos*RaspberryPi1.zip`**        | For all Raspberry Pi 1 -- ARMv6 32-bit, USB master                                                 |
| **`muntsos*RaspberryPi1Gadget.zip `** | For Raspberry Pi 1 A, A+, CM1, Zero, Zero W -- ARMv6 32-bit, USB slave                             |
| **`muntsos*RaspberryPi2.zip`**        | For all Raspberry Pi 2, 3, Zero 2 -- ARMv7 32-bit, USB master                                      |
| **`muntsos*RaspberryPi2Gadget.zip `** | For Raspberry Pi 3 A+, CM3, and Zero 2 -- ARMv7 32-bit, USB slave                                  |
| **`muntsos*RaspberryPi3.zip`**        | For all Raspberry Pi 3, Zero 2 -- ARMv8 64-bit, USB master                                         |
| **`muntsos*RaspberryPi3Gadget.zip `** | For Raspberry Pi 3 A+, CM3, and Zero 2 -- ARMv8 64-bit, USB slave                                  |
| **`muntsos*RaspberryPi4.zip`**        | For all Raspberry Pi 4 -- ARMv8 64-bit, USB master                                                 |
| **`muntsos*RaspberryPi4Gadget.zip`**  | For all Raspberry Pi 4 -- ARMv8 64-bit, USB slave                                                  |

Boards
------

### BeagleBone

The [BeagleBone](http://beagleboard.org/bone-original) was one of the
first low cost Linux microcomputers. It originally sold for USD $89 at
its launch in October 2011.

The BeagleBone has a Texas Instruments [Sitara
AM3359](http://www.ti.com/product/AM3359) processor running at 720 MHz
and 256 MB of RAM. It has two USB port sockets: One type A host port and
one type mini-B device port. Unlike any of its successors, the original
BeagleBone has its USB device port connected to a USB hub instead of
directly to the AM3359. Three distinct USB devices are visible to the
host on the device port socket: The AM3359 device port, a USB JTAG
device, and a USB serial port device connected to the AM3359 console
serial port. The BeagleBone also has two
[PRU](http://beagleboard.org/pru) (Programmable Realtime Unit) I/O
processors on board that are capable of very fast I/O operations.

MuntsOS includes device tree overlays than can be enabled by
**`sysconfig`** that allow configuring any of the expansion header GPIO
pins with **`config-pin`**. The system startup script **`/etc/rc`** will
initialize GPIO pin modes according to **`/etc/pinmux.conf`**. By
default, the following devices are are enabled on the two 46-pin
[expansion
headers](http://git.munts.com/muntsos/doc/BeagleBonePinout.pdf):

-   I<sup>2</sup>C bus controller device **`/dev/i2c-2`**
-   Serial port device **`/dev/ttyS1`**
-   Serial port device **`/dev/ttyS2`**
-   Serial port device **`/dev/ttyS4`**
-   Serial port device **`/dev/ttyS5`**
-   SPI slave device **`/dev/spidev2.0`**
-   SPI slave device **`/dev/spidev2.1`**

Newly manufactured BeagleBone boards assembled with a 1 GHz AM3358
processor are apparently still available from [Special
Computing](https://specialcomp.com/beagleboard/bone.htm).

### BeagleBone Black

The [BeagleBone Black](http://beagleboard.org/black) is a cost reduced
version of the BeagleBone. It currently sells for about USD $55. The
BeagleBone Black originally sold for USD $45 at its launch in April
2013, which would have been an impressive feat except that the Raspberry
Pi had already arrived on the market a few months earlier at USD $35.
Although the BeagleBone Black was more capable
thttp://git.munts.com/muntsos/doc/han the first couple of Raspberry Pi
generations, it has been overshadowed by the Raspberry Pi Model 2 and 3,
which sport quad-core processors. The great strength of the BeagleBone
Black and its kin compared to the Raspberry Pi family is the sheer
number of GPIO pins and peripheral ports available on its two 46-pin
[expansion
headers](http://git.munts.com/muntsos/doc/BeagleBonePinout.pdf). Even
after eMMC, I<sup>2</sup>C, SPI, and UART pins have been allocated,
there are 42 GPIO pins available.

The BeagleBone Black has a Texas Instruments [Sitara
AM3358](http://www.ti.com/product/AM3358) processor running at 1 GHz,
512 MB of RAM and 4 GB eMMC flash on board. It uses the same kernel as
the BeagleBone, with a different device tree.

Unlike the original BeagleBone (above) and the BeagleBone Green (below),
the BeagleBone Black has an HDMI video output (though with a pesky micro
HDMI connecteor). The HDMI interface consumes a large number of GPIO
pins when it is enabled. This MuntsOS port does not enable the HDMI
interface.

### BeagleBone Black Wireless

The [BeagleBone Black Wireless](https://beagleboard.org/black-wireless)
is a variant of the BeagleBone Black that has replaced the wired
Ethernet interface with a built-in Wifi radio. It also has replaced the
mini-B slave USB receptacle with a more modern micro-B receptacle. It is
otherwise highly compatible with the BeagleBone Black. It sells for
about USD $70, considerably more than any of the other boards supported
by MuntsOS, and also considerably more than a BeagleBone Green plus a
USB WiFi adapter.

The BeagleBone Black Wireless uses the same kernel as the BeagleBone,
with a different device tree.

MuntsOS does not currently support the on-board Bluetooth radio.

### BeagleBone Green

The [BeagleBone Green](https://beagleboard.org/green) is a cost reduced
version of the BeagleBone Black, from Chinese manufacturer [Seeed
Studio](https://www.seeedstudio.com), that sells for about USD $44.
Changes from the BeagleBone Black design are:

-   Removed coaxial power jack . (+5V can be supplied via the slave USB
    port or **P9** expansion header instead.)
-   Removed HDMI receptacle and support circuitry.
-   Changed the slave USB receptacle from mini-B to micro-B.
-   Added two [Grove System](http://wiki.seeed.cc/Grove_System)
    connectors, one carrying 3.3V
    [I<sup>2</sup>C](https://en.wikipedia.org/wiki/I2C) signals and one
    carrying 3.3V logic level [serial
    port](https://en.wikipedia.org/wiki/Serial_port) signals.

The BeagleBone Green uses the same kernel as the BeagleBone, with a
different device tree.

The BeagleBone Green http://git.munts.com/muntsos/doc/is cost
competitive with the Raspberry Pi, costing only a little more but
including on board eMMC and a USB cable. It has only a single core
processor, compared to the quad-core Raspberry Pi 3, but provides many
more GPIO pins on its two 46-pin [expansion
headers](http://git.munts.com/muntsos/doc/BeagleBonePinout.pdf). It also
has separate dedicated host and slave USB ports as well as the two Grove
sockets.

The BeagleBone Green plus a USB WiFi adapter is about USD $20 cheaper
than a BeagleBone Black Wireless, while retaining the possibility for
wired Ethernet.

### BeagleBone Green Wireless

The [BeagleBone Green Wireless](https://beagleboard.org/green-wireless)
is a variant of the BeagleBone Green that has replaced the wired
Ethernet interface with a built-in Wifi radio. It is otherwise highly
compatible with the BeagleBone Green. It sells for about USD $53.

The BeagleBone Green http://git.munts.com/muntsos/doc/Wireless uses the
same kernel as the BeagleBone, with a different device tree.

MuntsOS does not currently support the on-board Bluetooth radio.

The BeagleBone Green Wireless is a mixed blessing: It has 4 USB ports
and on-board WiFi, but commandeers quite a few of the expansion header
GPIO pins for the on-board radios. Among other things, this seems to
prohibit using **`SPI1`**. Also, the physical layout prevents using the
[BeagleBone Click Shield](https://www.mikroe.com/beaglebone), which has
some advantages over the newer [mikroBus
Cape](https://www.mikroe.com/beaglebone-mikrobus-cape).

### PocketBeagle

The [PocketBeagle](https://beagleboard.org/pocket) is a cost and size
reduced version of the BeagleBone Black. It currently sells for about
USD $25 and is intended for the same market niche as the Rasperry Pi
Zero. Although considerably more expensive than either version of the
Raspberry Pi Zero, the PocketBeagle has many more I/O devices directly
accessible from its expansion headers.

The PocketBeagle uses the same kernel as the BeagleBone, with a
different device tree. The PocketBeagle device tree enables the
following devices on its two 36-pin [expansion
headers](http://git.munts.com/muntsos/doc/PocketBeaglePinout.pdf):

-   USB host port
-   I<sup>2</sup>C bus controller device **`/dev/i2c-1`**
-   I<sup>2</sup>C bus controller device **`/dev/i2c-2`**
-   PWM output **`0:0`**
-   PWM output **`2:0`**
-   Serial port device **`/dev/ttyS0`**
-   Serial port device **`/dev/ttyS4`**
-   SPI slave device **`/dev/spidev1.0`**
-   SPI slave device **`/dev/spidev2.1`**

The expansion headers are cleverly arranged such that the two inner rows
match the [MikroElektronika mikroBUS](https://www.mikroe.com/mikrobus)
specification. If female sockets are installed on the top of the
PocketBeagle, two [Click Boards](https://shop.mikroe.com/click) can be
plugged directly into the expansion headers.

Like the Raspberry Pi Zero, the PocketBeagle comes without on-board
eMMC, USB cable, micro-SD card, or expansion headers.

Unlike the Raspberry Pi Zero, the PocketBeagle expansion headers do not
match its progenitors, so BeagleBone capes cannot be used on it.

### Raspberry Pi

The [Raspberry Pi](http://www.raspberrypi.com) is a family of low cost
Linux microcomputers selling for USD $5 to $75 (depending on model).
There have been four generations of Raspberry Pi microcomputers, each
using a successively more sophisticated Broadcom ARM core CPU.

Some Raspberry Pi models have an on-board Bluetooth radio that uses the
serial port signals that are brought out to the expansion header. By
default, MuntsOS port disables the on-board Bluetooth radio, in favor of
the serial port on the expansion header.

#### Raspberry Pi 1

Raspberry Pi 1 models have a BCM2708 ARMv6 single-core CPU running at
700 to 1000 MHz and come with with 256 MB to 512 MB of RAM. They have
10/100 Ethernet, 1 to 4 USB ports, HDMI, RCA composite video and a
stereo headphone or three-pole A/V jack. They also have several
miniature connectors for camera and LCD display modules as well as a
single 26 or 40 pin 2.54 mm pitch GPIO expansion connector.

All Raspberry Pi 1 models use the same 32-bit ARMv6 kernel and
toolchains, with different device trees.

With the advent of the [Raspberry Pi Zero
2](https://www.raspberrypi.com/products/raspberry-pi-zero-2-w), all
Raspberry Pi 1 models are now obsolete. MuntsOS Embedded Linux will
continue to support all Raspberry Pi 1 models.

#### Raspberry Pi 2 and 3

The [Rasbperry Pi 2 Model
B](https://www.raspberrypi.com/products/raspberry-pi-2-model-b) has a
900 MHz BCM2709 ARMv7 Cortex-A7 (900 MHz BCM2710 ARMv8 Cortex-A53 on
later production boards) quad-core CPU and comes with 1 GB of RAM. It is
mechanically compatible with the Raspberry Pi 1 Model B+, with 10/100
Ethernet, 4 USB ports, 3.5 mm A/V jack, and a 40-pin GPIO expansion
header.

The [Rasbperry Pi 3 Model
B](https://www.raspberrypi.com/products/raspberry-pi-3-model-b) has a
1200 MHz BCM2710 ARMv8 Cortex-A53 quad-core CPU and has 1 GB of RAM
along with on-board Bluetooth and WiFi radios.

The [Raspberry Pi 3 Model
A+](https://www.raspberrypi.com/products/raspberry-pi-3-model-a-plus)
has the same form factor as the Raspberry Pi 1 Model A+, with only one
USB host port and no wired Ethernet. It has a 1400 MHz BCM2710 ARMv8
Cortex-A53 quad-core CPU and has 512 MB of RAM along with on-board
Bluetooth and WiFi radios.

The [Raspberry Pi 3 Model
B+](https://www.raspberrypi.com/products/raspberry-pi-3-model-b-plus)
has a 1400 MHz BCM2710 ARMv8 Cortex-A53 quad-core CPU and has improved
power management and networking components.

The [Raspberry Pi Zero
2](https://www.raspberrypi.com/products/raspberry-pi-zero-2-w) has the
same form factor as the Raspberry Pi Zero W, with a 1000 MHz BCM2710
ARMv8 Cortex-A53 quad core CPU and 512 MB of RAM along with on-board
Bluetooth and WiFi radios.

All Raspberry Pi 2 and 3 models can use the same 32-bit ARMv7 kernel and
toolchains, with different device trees. There are also 64-bit AArch64
toolchains and ARMv8 kernels available for the Raspberry Pi 3, though
with 1 GB or less of RAM there is no particular advantage in running
64-bit.

#### Raspberry Pi 4

The [Raspberry Pi 4 Model
B](https://www.raspberrypi.com/products/raspberry-pi-4-model-b) has a
1500 MHz BCM2711 ARMv8 Cortex-A72 quad-core CPU and is available with 1
to 8 GB of RAM. It diverged significantly from the Raspberry Pi 1 B+
form factor, with the USB and Ethernet ports reversed, two micro-HDMI
connectors instead of a single full size HDMI connector, and a USB-C
power connector instead of micro-USB. Two of the USB ports are 3.0 and
two are 2.0. A major improvement is a Gigabit Ethernet controller
connected via PCI Express instead of the USB connected Ethernet used for
all earlier models. The Raspberry Pi 4 Model B uses the same wireless
chip set as the 3+.

The Raspberry Pi Model 4 B is much more powerful than any previous
Raspberry Pi, and is completely usable as a general purpose desktop
computer. It does require significantly more power and generates
significantly more heat. It supports dual monitors, which is mostly
irrelevant for embedded systems. I have some doubt about the long term
physical robustness of the micro-HDMI connectors.

#### Raspberry Pi USB Gadget Kernels

MuntsOS also provides Raspberry Pi kernels with dedicated [USB
Gadget](http://www.linux-usb.org/gadget) support enabled. These kernels
run on Models 1 A, A+, CM1, Zero, Zero Wireless, 3 A+, CM3, Zero 2, 4 B,
and CM4. You can supply power to and communicate with a compatible
Raspberry Pi solely through the USB port. This kernel supports USB
Network, Raw HID, and Serial Port gadgets, selected by bits in the
**`OPTIONS`** word passed on the kernel command line. The USB Gadget
Thin Servers have USB Network Gadget selected by default.

The absolute minimum possible usable Raspberry Pi kit consists of a
Raspberry Pi Zero, Zero W, or Zero 2, a micro-USB cable, and a micro-SD
card with one of the MuntsOS Raspberry Pi USB Gadget Thin Servers
installed.

Cross-Toolchains
----------------

I build a custom Ada/C/C++/Fortran/Go cross-toolchain (using
[Crosstool-NG](https://crosstool-ng.github.io)) for each MuntsOS
platform family. Each cross-toolchain requires a number of additional
software component libraries, which are packaged and distributed
separately but installed into the same directory tree as the parent
cross-toolchain.

I also build [Free Pascal](https://www.freepascal.org) cross-compilers.
These rely on the libraries in the Ada/C/C++/Fortran/Go cross-toolchain,
which must be installed first.

Sometimes cross-toolchains can be shared among different platforms: For
example, the Raspberry Pi 2 and Raspberry Pi 3 can use the same
cross-toolchains (the 32-bit ARMv7 cross-toolchains nominally built for
the Raspberry Pi 2), and the Raspberry Pi 3 and Raspberry Pi 4 can also
use the same cross-toolchains (the 64-bit AArch64 cross-toolchains
nominally built for the Raspberry Pi 3).

Cross-toolchain packages built for [Debian](https://www.debian.org)
Linux are available at:

<http://repo.munts.com/debian11>

Since they are statically linked, it may be possible to use these
cross-toolchain packages on other Linux distributions (possibly with the
help off a conversion utility like
[**`alien`**](https://admin.fedoraproject.org/pkgdb/package/rpms/alien)).

For the convenience of users of Linux distributions other than Debian,
snapshot toolchain tarballs for each platform family are available at:

<http://repo.munts.com/muntsos/toolchains>

Git Repository
--------------

The source code for MuntsOS is available at:

<https://github.com/pmunts/muntsos>

Use the following command to clone it:

    git clone https://github.com/pmunts/muntsos.git

File Repository
---------------

Prebuilt binaries for MuntsOS are available at:

<http://repo.munts.com/muntsos>

[Make With Ada](https://www.makewithada.org/) Projects
------------------------------------------------------

-   2017 [Ada Embedded Linux
    Framework](https://www.makewithada.org/entry/ada_linux_sensor_framework)
-   2019 [Modbus RTU Framework for
    Ada](https://www.hackster.io/philip-munts/modbus-rtu-framework-for-ada-f33cc6)
    (Prize Winner!)

------------------------------------------------------------------------

Questions or comments to Philip Munts <phil@munts.net>

I am available for custom system development (hardware and software) of
products based on embedded Linux microcomputers or other processors.
