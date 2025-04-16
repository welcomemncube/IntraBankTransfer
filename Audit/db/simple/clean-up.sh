#!/bin/bash

export TARGET_NAMESPACE=${1:-"cp4i"}

oc delete builds auditdb-1 
oc delete buildconfig auditdb
oc delete imagestream auditdb
oc delete -f deployment.yaml -n $TARGET_NAMESPACE
oc delete -f service.yaml -n $TARGET_NAMESPACE

