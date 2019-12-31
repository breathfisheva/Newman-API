#!/bin/sh

while IFS=';' read collectionName dataFile environmentFile; do
    echo "${collectionName}"
    echo "${dataFile}" 
    newman run ${collectionName} -r htmlextra --reporter-htmlextra-export test${collectionName}.html  -d ${dataFile}
done < collection_dir
