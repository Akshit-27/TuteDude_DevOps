#!/bin/bash
set -e

echo -e "Pushing codebase to github.."
git status
git add .

if git diff --cached --quiet; then
	echo "No New Changes to commit"
else
	git commit -m "Sync : $(date '+%Y-%m-%d %H:%M:%S')"
	git push origin main
fi
