@echo off

rd /s /q "%USERPROFILE%\.lem\quicklisp"

set PATH=%~dp0lib;%PATH%

start "" "lem-internal.exe"
exit
