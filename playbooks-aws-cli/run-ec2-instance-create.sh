#!/bin/bash

cd $(dirname $0)
ansible-playbook -i ./hosts create-ec2-instance.yml -e "@create-ec2-instance.json" --ask-become-pass
