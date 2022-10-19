#! /bin/bash

BOARDNAME=${1:-RaspberryPi2Gadget}

docker run -it --rm -v `pwd`/..:/muntsos -v `pwd`/../../linux-rpi:/usr/src/linux-rpi -v `pwd`/tmp:/tmp -e BOARDNAME=$BOARDNAME -e MUNTSOS=/muntsos muntsos-dev bash
