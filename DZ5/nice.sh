#!/usr/bin/env bash

ddhigh() {
nice -n -19 dd if=/dev/random bs=1000M count=2 of=../low.dat
echo "low:" `date`
}

ddlow() {
nice -n 20 dd if=/dev/random bs=1000M count=2 of=../high.dat
echo "high:" `date`
}

ddlow &
ddhigh &
