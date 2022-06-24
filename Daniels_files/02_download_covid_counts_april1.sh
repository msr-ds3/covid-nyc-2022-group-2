#!/bin/bash
# use curl or wget to download the version 2 of the total counts file, googlebooks-eng-all-totalcounts-20120701.txt
curl https://raw.githubusercontent.com/nychealth/coronavirus-data/097cbd70aa00eb635b17b177bc4546b2fce21895/tests-by-zcta.csv > tests-by-zcta_april1st.csv
# update the timestamp on the resulting file using touch
# do not remove, this will keep make happy and avoid re-downloading of the data once you have it
touch tests-by-zcta_april1st.csv