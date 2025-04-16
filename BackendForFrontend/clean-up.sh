#!/bin/bash

oc delete builds bankui-1
oc delete buildconfig bankui
oc delete imagestream bankui
oc delete deployment bankui
oc delete service bankui
oc delete route bankui
