#!/usr/bin/env bash

for file in ~/config/shell/*.sh; do
    . $file
done

clear
ff
