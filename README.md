# NanoBSD Alix

Vagrant build environment for NanoBSD and config for Alix boards.

Official NanoBSD howto: https://www.freebsd.org/doc/en/articles/nanobsd/howto.html

## Prerequisites

You'll need vagrant and VirtualBox installed.

## Build

```
vagrant up
./build.sh alix.conf
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

As root from the alix box.  Change update partition as required
(updatep1/updatep2)


```
ssh myhost cat nanobsd.image.gz | zcat | sh updatep1
```

## Generating vagrant base box

When run with the '-v' flag the NanoBSD image will be configured for use with vagrant.
i.e. vagrant user installed, configured ssh keys, sudo etc.

To create a base box:

``
vagrant up
./build.sh alix.conf -v
```

This should spit out a nanobsd.box file in cwd.  Add to to vagrant as usual:

```
vagrant box add nanobsd.box --name alix
```


## Manually converting NanoBSD image to VirtualBox VDI

Can be useful for testing without vagrant

```
VBoxManage convertdd nanobsd.full nanobsd.vdi --format VDI
```
