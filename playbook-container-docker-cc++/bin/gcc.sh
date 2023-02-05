#!/bin/bash

#inside the container imagem  WORKDIR = /projeto
projDirFullPath=$1
echo projDirFullPath

docker run -it --rm -v $projDirFullPath:/projeto wagnermarques/ccppdeb10:0.0.1 gcc -Wall $@
