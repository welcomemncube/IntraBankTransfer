#!/bin/bash

oc delete builds audit-1 
oc delete buildconfig audit
oc delete imagestream audit
oc delete deployment audit
oc delete service audit
