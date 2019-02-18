#!/usr/bin/env bash

until mc; do
    echo "Process 'mc' crashed with exit code $?.  Respawning.." >&2
    sleep 1
done
