setlocal EnableDelayedExpansion

XCOPY bin\* %LIBRARY_BIN% /s /i /y
if errorlevel 1 exit 1

XCOPY include\* %LIBRARY_INC% /s /i /y
if errorlevel 1 exit 1

XCOPY lib\* %LIBRARY_LIB% /s /i /y
if errorlevel 1 exit 1

XCOPY DISCLAIMER %PREFIX% /s /i /y
if errorlevel 1 exit 1

XCOPY conf\* %PREFIX% /s /i /y
if errorlevel 1 exit 1

XCOPY jmods\* %PREFIX% /s /i /y
if errorlevel 1 exit 1

XCOPY legal\* %PREFIX% /s /i /y
if errorlevel 1 exit 1

:: Copy the [de]activate scripts to %PREFIX%\etc\conda\[de]activate.d.
:: This will allow them to be run on environment activation.
FOR %%F IN (activate deactivate) DO (
    if not exist %PREFIX%\etc\conda\%%F.d MKDIR %PREFIX%\etc\conda\%%F.d
    if errorlevel 1 exit 1
    copy %RECIPE_DIR%\scripts\%%F.bat %PREFIX%\etc\conda\%%F.d\%PKG_NAME%_%%F.bat
    if errorlevel 1 exit 1
)