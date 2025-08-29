@echo off
REM === Batchfile Language Test Suite ===
setlocal enabledelayedexpansion

echo ╔══════════════════════════════════════════════╗
echo ║         BATCHFILE LANGUAGE TEST SUITE        ║
echo ╚══════════════════════════════════════════════╝

set "PASSED=0"
set "FAILED=0"

REM Test 1: Core runtime execution
echo [TEST] Testing core runtime...
call batch.batch >nul 2>&1
if !errorlevel! equ 0 (
    echo [PASS] Core runtime execution
    set /a PASSED+=1
) else (
    echo [FAIL] Core runtime execution
    set /a FAILED+=1
)

REM Test 2: Data ingestion script
echo [TEST] Testing data ingestion...
call "scripts\aln-data-ingest.bat" >nul 2>&1
if !errorlevel! leq 1 (
    echo [PASS] Data ingestion script
    set /a PASSED+=1
) else (
    echo [FAIL] Data ingestion script  
    set /a FAILED+=1
)

REM Test 3: File sanitizer
echo [TEST] Testing file sanitizer...
echo "test content" > temp_test.txt
call "scripts\contextual-file-sanitizer.bat" "temp_test.txt" >nul 2>&1
if exist "temp_test.txt.safe" (
    echo [PASS] File sanitizer
    set /a PASSED+=1
    del temp_test.txt temp_test.txt.safe
) else (
    echo [FAIL] File sanitizer
    set /a FAILED+=1
    del temp_test.txt 2>nul
)

echo.
echo ╔══════════════════════════════════════════════╗
echo ║                TEST RESULTS                  ║
echo ║  Passed: !PASSED!                                    ║
echo ║  Failed: !FAILED!                                    ║
echo ╚══════════════════════════════════════════════╝

if !FAILED! gtr 0 exit /b 1
exit /b 0
```
**Function:** Automates cross-component tests, error-level assertion, and real-world validation logic.[3][4]

***

## 3. Deployment Script

**GitHub Path:** `/build/deploy.bat`
