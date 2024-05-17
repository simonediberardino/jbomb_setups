@echo off
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~sdp0"" && ""%~s0"" %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )
:runScript
setlocal

:: Set variables
set "REPO_URL=https://github.com/simonediberardino/BomberMan/releases/latest/download/JBomb.jar"
set "FILENAME=bin\JBomb.jar"

:: Create the bin directory if it doesn't exist
if not exist "bin" (
    mkdir "bin"
)

:: Display ASCII art bomb
echo ======================================================================
echo.
echo                    JBomb Game Updater
echo.
echo This prompt will download the latest version of JBomb. Ensure you have
echo an active internet connection.
echo.
echo ======================================================================
echo.

:: Download the file with progress bar
echo Downloading JBomb update...
curl -L -o "%FILENAME%" --progress-bar %REPO_URL%

if %errorlevel% neq 0 (
    echo Download failed.
    exit /b 1
)

echo.
echo Download completed successfully.
echo JBomb has been updated to the latest version.

endlocal
pause
