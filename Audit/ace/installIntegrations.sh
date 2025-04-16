#!/bin/bash

namespace=${1:-"cp4i"}

#Deploy echo Integration Server
oc apply -f auditIntegrationServer.yaml -n $namespace
