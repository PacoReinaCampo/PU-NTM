@echo off
call ../../../../../../../settings64_vivado.bat

xvlog -prj system.prj
xelab ntm_modular_testbench
xsim -R ntm_modular_testbench
pause