#!/bin/bash

apic_namespace=${1:-"cp4i"}
namespace=${2:-"cp4i"}
apic_release=${3:-"ademo"}

echo "Deploying to $namespace"

GATEWAY_HOSTNAME=$(oc get route -n $apic_namespace ${apic_release}-gw-gateway -o jsonpath='{.spec.host}')
cat code/server.js_template |
  sed "s#{{GATEWAY_HOSTNAME}}#$GATEWAY_HOSTNAME#g;" > code/server.js

oc new-project $namespace
oc project $namespace
oc new-build --name bankui --binary --strategy docker
oc start-build bankui --from-dir . --follow

cat deployment.yaml_template |
  sed "s#{{NAMESPACE}}#$namespace#g;" > deployment.yaml
  
oc apply -f deployment.yaml -n $namespace
oc apply -f service.yaml -n $namespace
