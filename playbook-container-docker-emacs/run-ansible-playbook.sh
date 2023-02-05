#!/bin/bash

cd $(dirname $0)
ansible-playbook -i ./hosts site.yml -e "@extra-vars.json" --ask-become-pass
