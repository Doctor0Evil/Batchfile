@echo off
REM === ALN Universal Data Ingestion Trigger ===
REM Triggers ingest, sync, or intelligent reset for machine learning pipelines.

setlocal enabledelayedexpansion
if "%ALN_HOME%"=="" set "ALN_HOME=%~dp0"

echo --------------------------------------------
echo   [ALN] DATA INGEST/RESYNC BATCH RUNNER
echo   Time: %DATE% %TIME%
echo   ALN_HOME: %ALN_HOME%
echo --------------------------------------------

REM Main PowerShell bootstrap with error correction
if exist "%ALN_HOME%aln.ps1" (
    powershell -File "%ALN_HOME%aln.ps1" -task ingest
    if !errorlevel! neq 0 (
        echo [WARN] Data ingestion failed (!errorlevel!). Auto-correcting...
        powershell -File "%ALN_HOME%aln.ps1"
        if !errorlevel! neq 0 (
            echo [ERROR] ALN bootstrap failed. Contact: AI-Resilience
            exit /b !errorlevel!
        )
    )
) else (
    echo [ERROR] aln.ps1 missing in %ALN_HOME%. Correction hint: Sync repo root.
    exit /b 1
)

REM Cascade to Unix-like scripts if available
if exist "%ALN_HOME%resync-ingestion.sh" (
    echo [ALN] Executing shell pipeline...
    bash "%ALN_HOME%resync-ingestion.sh"
)

REM Optional status
if exist "%ALN_HOME%show-status.ps1" (
    powershell -File "%ALN_HOME%show-status.ps1"
)

echo [ALN] Batch ingestion complete. Time for a coffee... or a recursive audit.
exit /b 0
