import os, strutils

var cacheDirName = "cache"

if not existsDir(cacheDirName):
  echo "Directory ", cacheDirName, " does not exist"
  createDir cacheDirName
  
setCurrentDir(cacheDirName)

var gccVer = "gcc-4.9.2"
var gccUrl = "https://ftp.gnu.org/gnu/gcc/gcc-4.9.2/"
var binutilsVer = "binutils-2.25"
var binutilsUrl = "https://ftp.gnu.org/gnu/binutils/"
var rootDir = getCurrentDir()

proc downloadAndUnzip(v: string,  u: string) =
  if not existsFile("$1.tar.bz2" % v):
    echo "Downloading $2$1.tar.bz2" % [v, u]
    discard execShellCmd("curl -O $2$1.tar.bz2" % [v, u])
  if not existsDir(v):
    echo "Unzipping $1.tar.bz2" % [v, u]
    discard execShellCmd("tar xjf $1.tar.bz2" % [v, u])
      

downloadAndUnzip(gccVer, gccUrl)
downloadAndUnzip(binutilsVer, binutilsUrl)
    
createDir("build-$1" % gccVer)
createDir("build-$1" % binutilsVer)

setCurrentDir("build-$1" % binutilsVer)
discard execShellCmd("../$1/configure --target=x86_64-elf --prefix=$2/install --disable-multilib" % [binutilsVer, rootDir])
discard execShellCmd("make -j4")
discard execShellCmd("make install")


