@echo off
setlocal

:: Set variables
set "javaInstaller=https://javadl.oracle.com/webapps/download/AutoDL?BundleId=236886_42970487e3af4f5aa5bca3f542482c60"
set "owner=simonediberardino"
set "repo=JBombLauncher"
set "fileName=JBombLauncher.jar"
set "jbombJarUrl=https://github.com/%owner%/%repo%/releases/latest/download/%fileName%"
set "jbombDir=C:\Program Files\jbomb"
set "jbombJar=%jbombDir%\%fileName%"
set "tempDir=%TEMP%\jbomb_temp"
set "installer=%tempDir%\jdk8.exe"

:: Create temporary directory
mkdir "%tempDir%" 2>NUL

:: Check for installed Java version
where java 2>NUL
if "%ERRORLEVEL%"=="0" (
    echo Java found, skipping installation.
) else (
    echo Java not found, installing Java 8...
    call :installJava
)

goto :checkJBomb

:::::::::::::::::::::::::::::::::::::::::
:installJava
echo Downloading Java installer...

:: Use curl to download the Java installer to the temporary directory
curl -o "%installer%" -L "%javaInstaller%"

if exist "%installer%" (
    echo Installing Java 8...
    start /wait "%installer%" /s
    del "%installer%"
) else (
    echo Failed to download Java installer. Exiting...
    exit /b 1
)

goto :checkJBomb

:::::::::::::::::::::::::::::::::::::::::
:checkJBomb
:: Check for jbomblauncher.jar
if exist "%jbombJar%" (
    echo JBomb Launcher is already installed.
) else (
    echo Downloading JBomb Launcher...
    call :downloadJBomb
)

:: Create shortcut on the desktop
call :createShortcut

echo Setup complete.
goto :EOF

:::::::::::::::::::::::::::::::::::::::::
:downloadJBomb
mkdir "%jbombDir%"
echo Downloading JBomb Launcher...

:: Use curl to download the JBomb launcher jar file
curl -o "%jbombJar%" -L "%jbombJarUrl%"

if exist "%jbombJar%" (
    echo JBomb Launcher downloaded successfully.
) else (
    echo Failed to download JBomb Launcher. Exiting...
    exit /b 1
)

goto :EOF

:::::::::::::::::::::::::::::::::::::::::
:createShortcut
goto :EOF

:end
endlocal
exit /b 0
