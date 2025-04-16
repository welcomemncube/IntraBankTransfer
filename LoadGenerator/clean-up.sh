#!/bin/bash

oc delete builds loadgenerator-1
oc delete buildconfig loadgenerator
oc delete imagestream loadgenerator
oc delete deployment loadgenerator
oc delete service loadgenerator
oc delete route loadgenerator
