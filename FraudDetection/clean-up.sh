#!/bin/bash

oc delete builds fraud-1 
oc delete buildconfig fraud
oc delete imagestream fraud
oc delete deployment fraud
oc delete service fraud
