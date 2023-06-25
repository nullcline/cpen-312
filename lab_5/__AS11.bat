@echo off
C:
cd "\Users\andre\School\Spring 2021\CPEN312\Labs\Lab5\"
if exist calc32.lst del calc32.lst
if exist calc32.s19 del calc32.s19
if exist __err.txt del __err.txt
"C:\Users\andre\School\Spring 2021\CPEN312\Labs\CrossIDE\Call51\Bin\a51.exe"  calc32.asm > __err.txt
"C:\Users\andre\School\Spring 2021\CPEN312\Labs\CrossIDE\Call51\Bin\a51.exe"  calc32.asm -l > calc32.lst
if not exist s2mif.exe goto done
if exist calc32.s19 s2mif calc32.s19 calc32.mif > nul
:done
