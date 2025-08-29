@echo off
REM === Batchfile Language Build System ===
setlocal enabledelayedexpansion

echo ╔══════════════════════════════════════════════╗
echo ║        BATCHFILE LANGUAGE BUILD SYSTEM       ║
echo ╚══════════════════════════════════════════════╝

echo [BUILD] Starting Batchfile language build...
echo [BUILD] Timestamp: %DATE% %TIME%

REM Step 1: Validate core components
if not exist "batch.batch" (
    echo [ERROR] Core runtime batch.batch not found!
    exit /b 1
)

REM Step 2: Run sanitization on all .batch files
for %%f in (*.batch) do (
    echo [BUILD] Sanitizing: %%f
    call "scripts\contextual-file-sanitizer.bat" "%%f"
)

REM Step 3: Validate ALN integration
if exist "aln.ps1" (
    echo [BUILD] Testing ALN integration...
    powershell -File "aln.ps1" -task validate
)

REM Step 4: Run humor audit (quality assurance)
if exist "ai-jokes.txt" (
    echo [BUILD] Running humor compliance audit...
    call "scripts\ai-humor-auditor.bat" "ai-jokes.txt"
)

echo [BUILD] Build completed successfully!
exit /b 0
