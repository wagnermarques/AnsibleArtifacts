#!/bin/bash

thisScriptDir=$(dirname $0)
cd $thisScriptDir

docker stop fzl_postgresql; docker rm fzl_postgresql

python3 $(which ansible-playbook) -i ./hosts site.yml -e "@extra-vars.json" --ask-become-pass
