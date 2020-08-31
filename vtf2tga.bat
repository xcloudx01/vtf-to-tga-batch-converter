@echo off
mkdir temp
for %%f in (*.vtf) do vtf2tga %%f temp\%%f
ren temp\*.vtf *.tga
move temp\* 
rmdir \q temp
cls
set /p userinp=Delete originals?(y/n)
set userinp=%userinp:~0,1%
if "%userinp%"=="y" goto delete
goto end
:delete
del *.vtf
:end