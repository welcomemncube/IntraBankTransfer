#! /bin/bash

export TARGET_NAMESPACE=${1:-"cp4i"}

oc delete queuemanager audit -n $TARGET_NAMESPACE
oc delete configmap auditmqsc -n $TARGET_NAMESPACE
