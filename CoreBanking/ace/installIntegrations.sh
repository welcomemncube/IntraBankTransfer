#!/bin/bash

namespace=${1:-"cp4i"}

#Deploy echo Integration Server
oc apply -f transferIntegrationServer.yaml -n $namespace
oc apply -f balanceIntegrationServer.yaml -n $namespace
