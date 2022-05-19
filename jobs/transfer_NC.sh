#! /bin/sh

file = $1

filetype = $2

newdir = /rds/general/project/pathogen_surveillance/live/12F_epidemiology/sf_msc/$filetype/$(date +%d-%m-%y)

cp -r file newdir