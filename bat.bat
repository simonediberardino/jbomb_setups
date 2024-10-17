@echo off
setlocal

:: Set variables
set "javaInstaller=https://javadl.oracle.com/webapps/download/AutoDL?BundleId=236886_42970487e3af4f5aa5bca3f542482c60"
set "jbombJarUrl=https://raw.githubusercontent.com/simonediberardino/jbomb_setups/main/jbomblauncher.jar"
set "jbombDir=C:\Program Files\jbomb"
set "jbombJar=%jbombDir%\jbomblauncher.jar"
set "installer=jdk8.exe"

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

:: Use curl to download the Java installer
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
echo Creating a shortcut on the desktop...
goto :EOF

:end
endlocal
exit /b 0
