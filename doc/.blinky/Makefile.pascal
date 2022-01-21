.PHONY: default clean

LIBSIMPLEIO	?= /usr/local/share/libsimpleio
MUNTSOS		?= $(HOME)/muntsos

include $(LIBSIMPLEIO)/freepascal/include/freepascal.mk
include $(LIBSIMPLEIO)/freepascal/include/libsimpleio.mk

PROGRAMS	+= blinky

default: $(PROGRAMS)

clean: freepascal_mk_clean
	rm -f $(PROGRAMS)
