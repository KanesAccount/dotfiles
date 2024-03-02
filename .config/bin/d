#!/bin/sh

# if current dir has 'sfdx-project.json` file, then deploy source to org
if [ -f sfdx-project.json ]; then
    echo 'sfdx push -f'
    sfdx force:source:push -f
    exit 0
fi
