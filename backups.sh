#!/bin/bash

cp ../_config.yml ./
cp -r ../themes ./
cp -r ../source ./
cp -r ../scaffolds/ ./
cp ../package.json ./
cp ../.gitignore ./

git add . 
git commit -m "`date`"
git push origin save
