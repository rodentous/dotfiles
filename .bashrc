#!/bin/env bash

for file in shell/*; do
    . $file
done

neofetch
