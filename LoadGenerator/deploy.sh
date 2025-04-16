#!/bin/bash

namespace=${1:-"cp4i"}
hostname=`oc get route bankui -n $namespace -o jsonpath='{.spec.host}' | cut -d "." -f2-`
echo $hostname

echo "Deploying to $namespace"

oc new-project $namespace
oc project $namespace
oc new-build --name loadgenerator --binary --strategy docker
oc start-build loadgenerator --from-dir . --follow

cat deployment.yaml_template |
  sed "s#{{NAMESPACE}}#$namespace#g;" > deployment.yaml

oc apply -f deployment.yaml -n $namespace
oc apply -f service.yaml -n $namespace

oc create serviceaccount deletedb2 -n $namespace
oc create clusterrolebinding deletedb2-crb --clusterrole=cluster-admin --serviceaccount=$namespace:deletedb2

cat CronJob.yaml_template |
  sed "s#{{NAMESPACE}}#$namespace#g;" > CronJob.yaml
oc apply -f CronJob.yaml

cat CronJobDeleteLoadGenerator.yaml_template |
  sed "s#{{NAMESPACE}}#$namespace#g;" > CronJobDeleteLoadGenerator.yaml
oc apply -f CronJobDeleteLoadGenerator.yaml

rm CronJob.yaml CronJobDeleteLoadGenerator.yaml deployment.yaml