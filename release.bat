@ECHO OFF

ECHO This script will release a new version of the firmware, e.g. 1.0.0
ECHO Type release version number and press ENTER
SET /P new_version=

SET home_dir=%~dp0
SET release_folder=releases\%new_version%

IF NOT EXIST %release_folder% (
	MKDIR %release_folder%

    CD src
    CALL compile.bat || GOTO :error
    CD %home_dir%
    COPY .\src\main.ihx %release_folder%\TSDZ2-v%new_version%.hex

    ECHO:
    ECHO Release %new_version% has been created in %home_dir%%release_folder%
    ECHO:

    GOTO :EOF
) ELSE (
    ECHO:
    ECHO Release %new_version% already exists!
    ECHO:
)

:error
ECHO:
ECHO Failed with error code %errorlevel%.
PAUSE
ECHO:
EXIT /b %errorlevel%

@ECHO ON
