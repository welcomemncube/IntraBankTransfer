#!/bin/bash

mvn clean package liberty:create liberty:install-feature liberty:deploy
