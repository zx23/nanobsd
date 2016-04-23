# NanoBSD Alix

Official NanoBSD howto: https://www.freebsd.org/doc/en/articles/nanobsd/howto.html

## Build

```
vagrant up
./build.sh alix.conf
```

Once world/kernel is buit, it can be skipped on subsequent runs:

```
Usage: ./build.sh cfg_file [-bhiknw]
-i : skip image build
-w : skip buildworld step
-k : skip buildkernel step
-b : skip buildworld and buildkernel step
```

## Install

Write full image directly to CF:

```
dd if=nanobsd.full of=/dev/da0 bs=64k
```

## Update

Change update partition as required (updatep1/updatep2)


```
ssh -t myhost cat nanobsd.image.gz | zcat | sudo sh /root/updatep1
```


## Converting disk image to VirtualBox VDI

Useful for testing

```
VBoxManage convertdd nanobsd.full nanobsd.vdi --format VDI
```

