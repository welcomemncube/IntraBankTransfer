#!/bin/bash

oc delete builds corebanking-1
oc delete buildconfig corebanking
oc delete imagestream corebanking
oc delete deployment corebanking
oc delete service corebanking
