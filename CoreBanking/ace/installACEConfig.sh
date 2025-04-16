#!/bin/bash

namespace=${1:-"cp4i"}

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $SCRIPT_DIR

rm $SCRIPT_DIR/configuration

#Deploy authentication policy for bar file retrieval from githubusercontent
cp $SCRIPT_DIR/GitHubCredentials $SCRIPT_DIR/configuration
oc create secret generic github-creds --from-file=$SCRIPT_DIR/configuration -n $namespace
oc apply -f $SCRIPT_DIR/credentialsForGitHub.yaml -n $namespace
rm $SCRIPT_DIR/configuration

# Create MQ Policy Project
export POLICY_PROJECT=`cat $SCRIPT_DIR/PolicyLibproject.generated.bar | base64 -w10000`
( echo "cat <<EOF" ; cat $SCRIPT_DIR/policyProject.yaml_template ; echo EOF ) | sh > $SCRIPT_DIR/policyProject.yaml
oc apply -f $SCRIPT_DIR/policyProject.yaml -n $namespace

#Deploy integration server configuration
export SERVER_CONFIG=`cat server.conf.yaml | base64 -w10000`
( echo "cat <<EOF" ; cat serverConfig.yaml_template ; echo EOF ) | sh > serverConfig.yaml
oc apply -f serverConfig.yaml -n $namespace

