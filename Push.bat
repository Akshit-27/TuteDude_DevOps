@echo off
echo Pushing codebase to github..
echo ----------------------------
set /p msg="Enter the commit msg: "

:: Get current date and time
set timestamp=%date% %time%

git status
git add .
git commit -m "%msg% committed at %timestamp%"
git branch -M main
git push origin main

pause