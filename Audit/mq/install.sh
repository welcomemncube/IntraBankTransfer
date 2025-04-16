#! /bin/bash

export TARGET_NAMESPACE=${1:-"cp4i"}

( echo "cat <<EOF" ; cat auditqmgr.yaml_template ; echo EOF ) | sh > auditqmgr.yaml

oc apply -f auditqmgr.yaml
