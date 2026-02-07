#!/bin/bash
set -e

echo -e "Pushing codebase to github.."
echo -e "----------------------------"
echo -e " Enter the commit msg : "
read msg

git status
git add .
git commit -m "$msg commited at  $(date '+%Y-%m-%d %H:%M:%S')"
git branch -M main
git push origin main

