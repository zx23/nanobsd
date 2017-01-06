#!/bin/sh

set -e

if [ -z "${1}" -o \! -f "${1}" ]; then
  echo "Usage: $0 cfg_file [-v] [-bhiknw]"
  echo "-i : skip image build"
  echo "-w : skip buildworld step"
  echo "-k : skip buildkernel step"
  echo "-b : skip buildworld and buildkernel step"
  echo "-v : build an image suitable for vagrant"
  exit
fi

CFG="${1}"
shift;

if [ "${1}" = '-v' ]; then
    echo 'Vagrant box build enabled'
    VAGRANT_IMAGE=true
    shift
else
    VAGRANT_IMAGE=false
fi

vagrant ssh -c "cd /vagrant && sudo VAGRANT_IMAGE=${VAGRANT_IMAGE} sh /usr/src/tools/tools/nanobsd/nanobsd.sh $* -c ${CFG}"

echo "## Compressing image"
gzip -f nanobsd.image

if [ "${VAGRANT_IMAGE}" = true ] ; then
    echo '## Creating vagrant box'
    echo '### Converting disk image to VDI'
    rm -f nanobsd.vdi && VBoxManage convertdd nanobsd.full nanobsd.vdi --format VDI

    echo '### Creating VirtualBox VM'
    VBoxManage createvm --name alixbasebox --register
    VBoxManage modifyvm alixbasebox --ostype FreeBSD --memory 256 \
        --nic1 nat --nictype1 82540EM --nic2 intnet --nictype2 82540EM --nic3 intnet --nictype3 82540EM \
        --cableconnected1 on --cableconnected2 on --cableconnected3 on \
        --uart1 0x3F8 4 --uartmode1 disconnected
    VBoxManage storagectl alixbasebox --name IDE --add ide --controller PIIX4
    VBoxManage storageattach alixbasebox --storagectl IDE --port 0 --device 0 --type hdd --medium nanobsd.vdi

    echo '### Packaging vagrant base box'
    rm -f nanobsd.box && vagrant package --base alixbasebox --output nanobsd.box

    echo '## Cleaning up'
    VBoxManage unregistervm alixbasebox --delete
fi
