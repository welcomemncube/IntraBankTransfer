#!/bin/bash
#******************************************************************************
# Licensed Materials - Property of IBM
# (c) Copyright IBM Corporation 2023. All Rights Reserved.
#
# Note to U.S. Government Users Restricted Rights:
# Use, duplication or disclosure restricted by GSA ADP Schedule
# Contract with IBM Corp.
#******************************************************************************
#******************************************************************************
# 
# PREREQUISITES:
#   - Logged into cluster on the OC CLI (https://docs.openshift.com/container-platform/4.4/cli_reference/openshift_cli/getting-started-cli.html)
#
# PARAMETERS:
#   -n : <APIC_NAMESPACE> (string), Defaults to "cp4i"
#   -r : <APIC_RELEASE_NAME> (string), Defaults to "ademo"
#   -t : <TARGET_NAMESPACE> (string), Defaults to "cp4i"
#
# USAGE:
#   With default values
#     ./deployAll.sh
#
#   Overriding the NAMESPACE and release-name
#     ./deployAll.sh -n cp4i-apic -r prod -t cp4i-apps

CURRENT_DIR=$(dirname $0)

NAMESPACE="cp4i"
TARGET_NAMESPACE="cp4i"
RELEASE_NAME="ademo"
ORG_NAME="banking-demo"

function usage() {
  echo "Usage: $0 -n <NAMESPACE> -r <RELEASE_NAME> -t <TARGET_NAMESPACE>"
}

while getopts "t:n:r:" opt; do
  case ${opt} in
  n)
    NAMESPACE="$OPTARG"
    ;;
  r)
    RELEASE_NAME="$OPTARG"
    ;;
  t)
    TARGET_NAMESPACE="$OPTARG"
    ;;
  \?)
    usage
    exit
    ;;
  esac
done

NAMESPACE="${NAMESPACE}"

echo ################## CREATING TARGET NAMESPACE #####################
oc new-project $TARGET_NAMESPACE
kubectl get secret ibm-entitlement-key --namespace=$NAMESPACE -o yaml | sed "s/namespace: .*/namespace: $TARGET_NAMESPACE/" | kubectl apply -f -

echo ################## INSTALL AUDIT APP ######################
cd Audit/db/simple
./deploy.sh $TARGET_NAMESPACE

cd ../../mq
./install.sh $TARGET_NAMESPACE

cd ../ace
./installACEConfig.sh $TARGET_NAMESPACE
./installIntegrations.sh $TARGET_NAMESPACE

cd ..
./deploy.sh $TARGET_NAMESPACE

echo ################## INSTALL AUTHENTICATION APP ######################
cd ../Authentication
./deploy.sh $TARGET_NAMESPACE

echo ################## INSTALL BACKENDFORFRONTEND APP ######################
cd ../BackendForFrontend
./deploy.sh $NAMESPACE $TARGET_NAMESPACE $RELEASE_NAME

echo ################## INSTALL COREBANKING APP ######################
cd ../CoreBanking
cd db/simple
./deploy.sh $TARGET_NAMESPACE

cd ../../mq
./install.sh $TARGET_NAMESPACE

cd ../ace
./installACEConfig.sh $TARGET_NAMESPACE
./installIntegrations.sh $TARGET_NAMESPACE

cd ..
./deploy.sh $TARGET_NAMESPACE

echo ################## INSTALL FRAUD DETECTION APP ######################
cd ../FraudDetection
./deploy.sh $TARGET_NAMESPACE

echo ################## INSTALL NOTIFICATION APP ######################
cd ../Notification
./deploy.sh $TARGET_NAMESPACE

echo ################## INSTALL API CONNECT ORGANIZATION #################
cd ../API\ Connect/
./deploy.sh -n $NAMESPACE -r $RELEASE_NAME -t $TARGET_NAMESPACE

echo ################## INSTALL LOAD GENERATOR #################
cd ../LoadGenerator
./deploy.sh $TARGET_NAMESPACE
  