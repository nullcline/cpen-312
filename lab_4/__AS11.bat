@echo off
C:
cd "\Users\andre\School\Spring 2021\CPEN312\Labs\Lab4\"
if exist Lab4.lst del Lab4.lst
if exist Lab4.s19 del Lab4.s19
if exist __err.txt del __err.txt
"C:\Users\andre\School\Spring 2021\CPEN312\Labs\CrossIDE\Call51\Bin\a51.exe"  Lab4.asm > __err.txt
"C:\Users\andre\School\Spring 2021\CPEN312\Labs\CrossIDE\Call51\Bin\a51.exe"  Lab4.asm -l > Lab4.lst
if not exist s2mif.exe goto done
if exist Lab4.s19 s2mif Lab4.s19 Lab4.mif > nul
:done
