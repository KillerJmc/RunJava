:: Author: Jmc
:: Creation Date: 2021.2.21
:: Last Modified Date: 2021.3.2
@echo off

if not exist jdk (
    :: change to Red foreground
    color 04
    echo jdk doesn't exist!
    goto :end
)

:: if there is an arg, it'll run.
if not "%1" == "" call :run %1

:: if there doesn't exist DEFAULT file
if not exist DEFAULT goto :help

:: if there is a default file path in DEFAULT, it'll run.
set /p DEFAULT=<DEFAULT
if not "%DEFAULT%" == "" call :run %DEFAULT%

:help
    :: change to Blue foreground
    color 17
    echo You can try one of these:
    echo 1. Drag a java or jar file to me and then it'll run immediately.
    echo 2. Start me directly after writing a default java or jar file path to the DEFAULT file whose located in the root path.
    goto :end

:run
    :: concert the arg to a var
    set path=%1

    :: get the last several chars to judge what type to run
    if "%path:~-4%" == ".jar" call :runJar %1
    if "%path:~-5%" == ".java" call :runSrc %1

    :: change to Red foreground
    color 04
    echo Error type!
    echo this exe only supports java or jar file.
    goto :end

:runJar
    jdk\bin\java.exe -jar %1
    goto :end

:runSrc
    jdk\bin\java.exe %1
    goto :end

:end
    echo.
    pause & exit