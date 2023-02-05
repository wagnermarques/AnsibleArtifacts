#!/bin/bash

docker stop fzl_postgresql ; docker rm fzl_postgresql

cd $(dirname $0)
ansible-playbook -i ./hosts site.yml -e "@extra-vars.json" --ask-become-pass
