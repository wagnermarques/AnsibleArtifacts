#!/bin/bash

#inside the container imagem  WORKDIR = /projeto
projDir=./c++_projexample
cd $projDir
projDirFullPath=$(pwd)
echo projDirFullPath

docker run -it --rm -v $projDirFullPath:/projeto wagnermarques/ccppdeb10:0.0.1 g++ -Wall $@
