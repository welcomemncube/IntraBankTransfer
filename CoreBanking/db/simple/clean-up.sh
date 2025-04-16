#!/bin/bash

export TARGET_NAMESPACE=${1:-"cp4i"}

oc delete builds coredb-1
oc delete buildconfig coredb
oc delete imagestream coredb
oc delete -f deployment.yaml -n $TARGET_NAMESPACE
oc delete -f service.yaml -n $TARGET_NAMESPACE
