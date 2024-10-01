@echo off
setlocal enabledelayedexpansion

if not exist "Notes" (
  mkdir "Notes"
  if errorlevel 1 (
    echo Failed to create the "Notes" directory. Check your permissions.
    exit /b 1
  )
)

cd Notes
if errorlevel 1 (
  echo Failed to change to "Notes" directory. Check your permissions.
  exit /b 1
)

set /p "filename=Enter the filename to create (without extension): "
set "filename=%cd%\%filename%.txt"

if exist "%filename%" (
  echo File "%filename%" already exists. Using the existing file.
) else (
  echo. > "%filename%"
  if errorlevel 1 (
    echo Failed to create file "%filename%". Check your permissions.
    exit /b 1
  )
  echo File "%filename%" created in the "Notes" folder.
)

echo Type and press Enter to save. Press Ctrl + C to stop.
echo Type "skip" and press Enter to add a blank line.

:loop
set "line="
set /p "line=>> "
if "!line!" neq "" (
  if /i "!line!"=="skip" (
    echo. >> "%filename%"
  ) else (
    echo !line! >> "%filename%"
  )
)
goto loop

pause
