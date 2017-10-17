#!/bin/bash

fly -t faas set-pipeline -p sk8s -c $(dirname $0)/pipeline.yml -l <(lpass show --note 'Shared-pfs-eng/pfs-ci-gitbot')
