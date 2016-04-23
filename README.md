# NanoBSD Alix


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

## Converting disk image to VirtualBox VDI

Useful for testing

```
VBoxManage convertdd nanobsd.full nanobsd.vdi --format VDI
```
