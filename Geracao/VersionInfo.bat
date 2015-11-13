REM CommandInterpreter: cmd.exe
@echo off
echo Gerando arquivos .RC
call "%gitcmd%\git" rev-list HEAD --count > Debug\UltimaRevisaoGit.txt
call "%gitcmd%\git" rev-parse HEAD >> Debug\UltimaRevisaoGit.txt
wscript bin\VersionInfo.wsf

echo.
echo Compilando arquivo VersionInfoGlobalFinanceiro.rc
brcc32 ..\VersionInfoGlobalFinanceiro.rc
