@echo off
REM === Contextual File Sanitization & Language Bridge ===
REM Context-aware file sanitizer for ALN, Lisp, Batchfile; links cross-language corrections.

setlocal enabledelayedexpansion
set "FILE=%~1"
if "%FILE%"=="" set "FILE=data.txt"

echo [Sanitizer] Processing file: %FILE%
REM Remove any potentially unsafe, non-compliant lines (gore/adult etc.)
set "SAFEFILE=%FILE%.safe"
type nul > "%SAFEFILE%"
for /f "usebackq tokens=*" %%L in ("%FILE%") do (
    echo %%L|findstr /i /v "uncompliant explicit illegal" >nul && (
        echo %%L>>"%SAFEFILE%"
    ) || (
        echo [FILTER] Non-compliant line removed: %%L
    )
)

REM Librarian: Link output with context tags for ALN/Lisp compat
echo [Sanitizer] Linking to Lisp & ALN via compatible tags
echo ;; [Lisp-Link] [Batchfile sanitized from %FILE%] >> "%SAFEFILE%"
echo # [ALN-Link] [Sanitized batch output] >> "%SAFEFILE%"

echo [Sanitizer] Output stored in: %SAFEFILE%
exit /b 0
