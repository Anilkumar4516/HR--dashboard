@echo off
title Push Power BI Project to GitHub
color 0b
echo ==========================================================
echo        PUSHING POWER BI SUITE TO GITHUB REPOSITORY
echo  Target: https://github.com/Anilkumar4516/Dashboard.git
echo ==========================================================
echo.

cd /d "%~dp0"

echo [1/3] Checking Git Status...
git status -s
echo.

echo [2/3] Verifying Remote Repository...
git remote -v
echo.

echo [3/3] Pushing to GitHub (Branch: main)...
echo If a GitHub login window appears, please click "Sign in with your browser".
echo.
git push -u origin main

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ==========================================================
    echo [SUCCESS] All files successfully pushed to GitHub!
    echo Visit: https://github.com/Anilkumar4516/Dashboard
    echo ==========================================================
) else (
    echo.
    echo ==========================================================
    echo [ERROR] Git push failed. Please check your credentials.
    echo ==========================================================
)

echo.
pause
