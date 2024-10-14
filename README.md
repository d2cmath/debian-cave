# debian-cave
Pull various resources to make debian packages for Google Cave devices (ASUS C302CA)

Inspired by [Devendor](https://github.com/devendor/c302ca)'s work and 
the [chrultrabook](https://docs.chrultrabook.com/) project.  

# build packages for keyboard mapping and sound driver 
Make sure your system (or docker container/image) have the following packages 
then just run `make`: 

```
fakeroot git wget scdoc alsa-utils 
libboost-filesystem-dev libboost-program-options-dev 
dotnet-sdk-6.0

```

To get `dotnet-sdk-6.0` follows the instruction at [Microsoft](https://learn.microsoft.com/en-us/dotnet/core/install/linux),
e.g. on Debian
```
wget https://packages.microsoft.com/config/debian/12/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
dpkg -i packages-microsoft-prod.deb

apt update && apt install dotnet-sdk-6.0
```

# build a custom kernel to support the drivers
To build the debian kernel, we need the following packages  
```
build-essential ncurses-dev debhelper xz-utils zstd
libssl-dev bc flex libelf-dev bison binutils lsb-release rsync cpio
```
then run  
```
make kernel
```
