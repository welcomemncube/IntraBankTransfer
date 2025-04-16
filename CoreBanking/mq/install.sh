#! /bin/bash

export TARGET_NAMESPACE=${1:-"cp4i"}

( echo "cat <<EOF" ; cat corebankingqmgr.yaml_template ; echo EOF ) | sh > corebankingqmgr.yaml

oc apply -f corebankingqmgr.yaml
