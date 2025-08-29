@echo off
REM === Batchfile Language Deployment ===
setlocal enabledelayedexpansion

set "DEPLOY_DIR=%~1"
if "%DEPLOY_DIR%"=="" set "DEPLOY_DIR=dist"

echo ╔══════════════════════════════════════════════╗
echo ║        BATCHFILE LANGUAGE DEPLOYMENT         ║
echo ╚══════════════════════════════════════════════╝

REM Create deployment directory
if not exist "%DEPLOY_DIR%" mkdir "%DEPLOY_DIR%"

REM Copy core files
echo [DEPLOY] Copying core runtime...
copy "batch.batch" "%DEPLOY_DIR%\" >nul
copy "README.md" "%DEPLOY_DIR%\" >nul
copy "LICENSE" "%DEPLOY_DIR%\" >nul

REM Copy scripts
echo [DEPLOY] Copying utility scripts...
if not exist "%DEPLOY_DIR%\scripts" mkdir "%DEPLOY_DIR%\scripts"
copy "scripts\*.bat" "%DEPLOY_DIR%\scripts\" >nul

REM Create package info
echo [DEPLOY] Creating package metadata...
echo Batchfile Language v1.0 > "%DEPLOY_DIR%\VERSION"
echo Deployed: %DATE% %TIME% >> "%DEPLOY_DIR%\VERSION"

echo [DEPLOY] Deployment complete! Package ready in: %DEPLOY_DIR%
exit /b 0
