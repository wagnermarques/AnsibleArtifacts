#!/bin/bash

thisScriptDir=$(dirname $0)
cd $thisScriptDir
thisScriptDirFullPath=$(pwd)

docker run --name rscripting -it --rm -v $thisScriptDirFullPath:/scripts wagnermarques/fzl_r:0.0.1 /scripts/script.R
