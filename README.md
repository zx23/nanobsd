# ZX NanoBSD

NanoBSD Vagrant build and config for various embedded systems.

Supported systems:
 * PCEngines ALIX
 * PCEngines APU2

Official NanoBSD howto: https://www.freebsd.org/doc/en/articles/nanobsd/howto.html

## Prerequisites

You'll need vagrant installed with either VirtualBox or VMware.

## Build

```
vagrant up
./build.sh apu2.conf
```

Once world/kernel is buit, it can be skipped on subsequent runs:

```
Usage: ./build.sh cfg_file [-v] [-bhiknw]
-i : skip image build
-w : skip buildworld step
-k : skip buildkernel step
-b : skip buildworld and buildkernel step
-v : build an image suitable for vagrant
```

## Install

Write full image directly to CF:

```
dd if=nanobsd.full of=/dev/da0 bs=64k
```

## Update

Run as root from the box you're updating.  Change update partition as required
(updatep1/updatep2)


```
ssh sourcehost cat nanobsd.image.gz | zcat | sh updatep1
```

## Generating vagrant base box

When run with the '-v' flag the NanoBSD image will be configured for use with vagrant.
i.e. vagrant user installed, configured ssh keys, sudo etc.

To create a base box:

```
vagrant up
./build.sh apu2.conf -v
```

This should spit out a nanobsd.box file in cwd.  Add to to vagrant as usual:

```
vagrant box add nanobsd.box --name apu2
```


## Manually converting NanoBSD imagapu2 VirtualBox VDI

Can be useful for testing without vagrant

```
VBoxManage convertdd nanobsd.full nanobsd.vdi --format VDI
```
