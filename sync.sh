#!/bin/bash
set -e

echo -e "Pushing codebase to github.."
git status
git add .
git commit -m "Sync : $(date '+%Y-%m-%d %H:%M:%S')"
git branch -M main
git push origin main

