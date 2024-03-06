#! /bin/bash

pkill discoverymaster
pkill discoveryslave
pkill orderingclient
pkill orderingpeer
pkill globalorderpeer
rm -r experiment-output-local/
go install ../...
