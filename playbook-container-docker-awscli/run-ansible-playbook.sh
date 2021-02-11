#!/bin/bash

docker stop fzl_awscli ; docker rm fzl_awscli

cd $(dirname $0)
ansible-playbook -i ./hosts site.yml -e "@extra-vars.json" --ask-become-pass
