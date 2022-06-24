#!/bin/bash
# use curl or wget to download the version 2 of the total counts file, googlebooks-eng-all-totalcounts-20120701.txt
curl https://raw.githubusercontent.com/nychealth/coronavirus-data/9e26adc2c475d3378d7579e48e936f8a807b254b/tests-by-zcta.csv > tests-by-zcta_may1st.csv
# update the timestamp on the resulting file using touch
# do not remove, this will keep make happy and avoid re-downloading of the data once you have it
touch tests-by-zcta_may1st.csv