#!/bin/bash

cp ../_config.yml ./
cp -r ../themes ./
cp -r ../source ./
cp -r ../scaffolds/ ./
cp ../package.json ./
cp ../.gitignore ./

DATE=`date`
echo ${DATE}
git add . 
git commit -m ${DATE}
#git push origin save
