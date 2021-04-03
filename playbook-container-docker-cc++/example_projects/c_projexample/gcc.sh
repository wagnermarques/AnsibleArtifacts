#!/bin/bash

projDirFullPath=$(pwd)
docker run -it --rm -v $projDirFullPath:/projeto wagnermarques/ccppdeb10:0.0.1 gcc -Wall $@
