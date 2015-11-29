
@SETLOCAL

@SET THIS=%0
@SET THIS_DIR=%~dp0

@SET PRJ_ARG=%1
@IF NOT "%PRJ_ARG%"=="" GOTO :found_prj_arg
@ECHO *** MISSING PROJECT NAME ARGUMENT!!! ***
@GOTO :eof

:found_prj_arg
@SET BUILDNO=%APPVEYOR_BUILD_NUMBER%
@IF "%BUILDNO%"=="" SET BUILDNO=0


@SET NUGET="%THIS_DIR%..\..\..\nuget\nuget.exe"
@IF NOT EXIST %NUGET% SET NUGET=nuget


@SET NUGET_PRJ="%THIS_DIR%%PRJ_ARG%\%PRJ_ARG%.csproj"
@SET NUGET_OUT="%THIS_DIR%dist\nuget"

@IF NOT EXIST %NUGET_OUT% MD %NUGET_OUT%

@SET NUGET_PROPS=nugetCwd=%CD%
@SET NUGET_PROPS=%NUGET_PROPS%;nugetDate=%DATE%
@SET NUGET_PROPS=%NUGET_PROPS%;nugetTime=%Time%
@SET NUGET_PROPS=%NUGET_PROPS%;buildNum=%BUILDNO%
@SET NUGET_PROPS=%NUGET_PROPS%;versionLabel=-EA


%NUGET% pack -Properties "%NUGET_PROPS%" -OutputDirectory %NUGET_OUT% %NUGET_PRJ%
