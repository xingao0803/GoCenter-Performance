#!/usr/bin/env zsh

# Description: testscript
# Author: retgits
# Last Updated: 2019-02-15

#--- Variables ---
project=${PWD##*/}
resultFile="timings.txt"
sleepInterval=60

export TIMEFMT="%J  %U user %S system %P cpu %*E total"

runWithProxy() {
    goProxy=${1}
    cmd=${2}
    echo "Setting GoProxy to ${goProxy}"
    echo "Setting GoProxy to ${goProxy}" >> ${resultFile}

    for i in {1..10}
    do
        echo "Ready to perform run ${i}"
        sudo rm -rf $GOPATH/pkg/mod
        rm go.sum
        export GOPROXY=${goProxy}
        { time ${cmd} get ./... 2>> go.stderr ; } 2>> ${resultFile}
        sleep ${sleepInterval}
    done
}

runWithProxy "" "go"
runWithProxy "https://gocenter.io" "go"