@echo off
call ../../../../../../../settings64_vivado.bat

xvlog -prj system.prj
xelab ntm_write_heads_testbench
xsim -R ntm_write_heads_testbench
pause
