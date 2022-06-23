#!/bin/bash
# use curl or wget to download the version 2 1gram file with all terms starting with "1", googlebooks-eng-all-1gram-20120701-1.gz
curl https://raw.githubusercontent.com/erikgregorywebb/nyc-housing/master/Data/nyc-zip-codes.csv > zipcodes_nyc.csv
# update the timestamp on the resulting file using touch, dos2unix for errors
# do not remove, this will keep make happy and avoid re-downloading of the data once you have it
touch zipcodes_nyc.csv