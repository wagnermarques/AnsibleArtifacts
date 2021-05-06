#!/bin/bash

cd $(dirname $0)
python3 $(which ansible-playbook) -i ./hosts site.yml -u administrador -e "@extra-vars.json" --ask-become-pass
