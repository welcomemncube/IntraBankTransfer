#! /bin/bash

export TARGET_NAMESPACE=${1:-"cp4i"}

oc delete queuemanager corebanking -n $TARGET_NAMESPACE
oc delete configmap corebankingmqsc -n $TARGET_NAMESPACE
