#!/bin/bash

oc delete builds notification-1 
oc delete buildconfig notification
oc delete imagestream notification
oc delete deployment notification
oc delete service notification
