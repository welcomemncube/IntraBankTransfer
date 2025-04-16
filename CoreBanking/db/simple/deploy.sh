#!/bin/bash

namespace=${1:-"cp4i"}

echo "Deploying to $namespace"

oc new-project $namespace
oc project $namespace

oc new-build --name coredb --binary --strategy docker
oc start-build coredb --from-dir . --follow

oc adm policy add-scc-to-user anyuid -z $namespace
oc adm policy add-scc-to-user anyuid -z default

oc create sa coresvcacct
oc adm policy add-scc-to-user anyuid -z coresvcacct -n $namespace
oc adm policy add-scc-to-user privileged -z default -n $namespace
oc adm policy add-scc-to-user privileged -z coresvcacct -n $namespace
cat deployment.yaml_template |
  sed "s#{{NAMESPACE}}#$namespace#g;" > deployment.yaml
oc apply -f deployment.yaml -n $namespace
oc apply -f service.yaml -n $namespace
