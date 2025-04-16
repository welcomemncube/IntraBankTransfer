#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

export TARGET_NAMESPACE=${1:-"cp4i"}

oc delete integrationserver.appconnect.ibm.com balance -n $TARGET_NAMESPACE
oc delete integrationserver.appconnect.ibm.com transfer -n $TARGET_NAMESPACE

oc delete configuration corebanking-mq-policy-project -n $TARGET_NAMESPACE

oc delete secret github-creds -n $TARGET_NAMESPACE
oc delete configuration cred-for-github -n $TARGET_NAMESPACE

rm $SCRIPT_DIR/policyProject.yaml
