#!/bin/bash

cd $(dirname $0)
ansible-playbook -i ./hosts site.yml -e "@extra-vars-debian10slim.json" --ask-become-pass
