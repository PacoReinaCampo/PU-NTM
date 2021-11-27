#*************************
# VERIFICATION COMPILATION
#*************************

# MODELSIM 10.4d

do ./variables.do

##################################################################################################
# TEST SOURCES ###################################################################################
##################################################################################################

##################################################################################################
# NTM_SCALAR_MOD_TEST 
##################################################################################################

alias ntm_scalar_mod_verification_compilation {
  echo "TEST: NTM_SCALAR_MOD_TEST"

  vcom -2008 -reportprogress 300 -work work $verification_path/math/arithmetic/ntm_arithmetic_pkg.vhd
  vcom -2008 -reportprogress 300 -work work $verification_path/math/arithmetic/ntm_arithmetic_stimulus.vhd
  vcom -2008 -reportprogress 300 -work work $verification_path/math/arithmetic/ntm_arithmetic_testbench.vhd

  vsim -g /ntm_arithmetic_testbench/ENABLE_NTM_SCALAR_MOD_TEST=true -t ps +notimingchecks -L unisim work.ntm_arithmetic_testbench

  #MACROS
  add log -r sim:/ntm_arithmetic_testbench/*

  #WAVES
  view -title ntm_scalar_mod wave
  do $simulation_path/mpsoc/math/arithmetic/msim/waves/ntm_scalar_mod.do

  force -freeze sim:/ntm_arithmetic_pkg/STIMULUS_NTM_SCALAR_MOD_TEST true 0
  force -freeze sim:/ntm_arithmetic_pkg/STIMULUS_NTM_SCALAR_MOD_CASE_0 true 0

  onbreak {resume}
  run -all

  dataset save sim ntm_scalar_mod_test.wlf
}

##################################################################################################
# NTM_SCALAR_ADDER_TEST 
##################################################################################################

alias ntm_scalar_adder_verification_compilation {
  echo "TEST: NTM_SCALAR_ADDER_TEST"

  vcom -2008 -reportprogress 300 -work work $verification_path/math/arithmetic/ntm_arithmetic_pkg.vhd
  vcom -2008 -reportprogress 300 -work work $verification_path/math/arithmetic/ntm_arithmetic_stimulus.vhd
  vcom -2008 -reportprogress 300 -work work $verification_path/math/arithmetic/ntm_arithmetic_testbench.vhd

  vsim -g /ntm_arithmetic_testbench/ENABLE_NTM_SCALAR_ADDER_TEST=true -t ps +notimingchecks -L unisim work.ntm_arithmetic_testbench

  #MACROS
  add log -r sim:/ntm_arithmetic_testbench/*

  #WAVES
  view -title ntm_scalar_adder wave
  do $simulation_path/mpsoc/math/arithmetic/msim/waves/ntm_scalar_adder.do

  force -freeze sim:/ntm_arithmetic_pkg/STIMULUS_NTM_SCALAR_ADDER_TEST true 0
  force -freeze sim:/ntm_arithmetic_pkg/STIMULUS_NTM_SCALAR_ADDER_CASE_0 true 0

  onbreak {resume}
  run -all

  dataset save sim ntm_scalar_adder_test.wlf
}

##################################################################################################
# NTM_SCALAR_MULTIPLIER_TEST 
##################################################################################################

alias ntm_scalar_multiplier_verification_compilation {
  echo "TEST: NTM_SCALAR_MULTIPLIER_TEST"

  vcom -2008 -reportprogress 300 -work work $verification_path/math/arithmetic/ntm_arithmetic_pkg.vhd
  vcom -2008 -reportprogress 300 -work work $verification_path/math/arithmetic/ntm_arithmetic_stimulus.vhd
  vcom -2008 -reportprogress 300 -work work $verification_path/math/arithmetic/ntm_arithmetic_testbench.vhd

  vsim -g /ntm_arithmetic_testbench/ENABLE_NTM_SCALAR_MULTIPLIER_TEST=true -t ps +notimingchecks -L unisim work.ntm_arithmetic_testbench

  #MACROS
  add log -r sim:/ntm_arithmetic_testbench/*

  #WAVES
  view -title ntm_scalar_multiplier wave
  do $simulation_path/mpsoc/math/arithmetic/msim/waves/ntm_scalar_multiplier.do

  force -freeze sim:/ntm_arithmetic_pkg/STIMULUS_NTM_SCALAR_MULTIPLIER_TEST true 0
  force -freeze sim:/ntm_arithmetic_pkg/STIMULUS_NTM_SCALAR_MULTIPLIER_CASE_0 true 0

  onbreak {resume}
  run -all

  dataset save sim ntm_scalar_multiplier_test.wlf
}

##################################################################################################
# NTM_SCALAR_INVERTER_TEST 
##################################################################################################

alias ntm_scalar_inverter_verification_compilation {
  echo "TEST: NTM_SCALAR_INVERTER_TEST"

  vcom -2008 -reportprogress 300 -work work $verification_path/math/arithmetic/ntm_arithmetic_pkg.vhd
  vcom -2008 -reportprogress 300 -work work $verification_path/math/arithmetic/ntm_arithmetic_stimulus.vhd
  vcom -2008 -reportprogress 300 -work work $verification_path/math/arithmetic/ntm_arithmetic_testbench.vhd

  vsim -g /ntm_arithmetic_testbench/ENABLE_NTM_SCALAR_INVERTER_TEST=true -t ps +notimingchecks -L unisim work.ntm_arithmetic_testbench

  #MACROS
  add log -r sim:/ntm_arithmetic_testbench/*

  #WAVES
  view -title ntm_scalar_inverter wave
  do $simulation_path/mpsoc/math/arithmetic/msim/waves/ntm_scalar_inverter.do

  force -freeze sim:/ntm_arithmetic_pkg/STIMULUS_NTM_SCALAR_INVERTER_TEST true 0
  force -freeze sim:/ntm_arithmetic_pkg/STIMULUS_NTM_SCALAR_INVERTER_CASE_0 true 0

  onbreak {resume}
  run -all

  dataset save sim ntm_scalar_inverter_test.wlf
}

##################################################################################################
# NTM_SCALAR_DIVIDER_TEST 
##################################################################################################

alias ntm_scalar_divider_verification_compilation {
  echo "TEST: NTM_SCALAR_DIVIDER_TEST"

  vcom -2008 -reportprogress 300 -work work $verification_path/math/arithmetic/ntm_arithmetic_pkg.vhd
  vcom -2008 -reportprogress 300 -work work $verification_path/math/arithmetic/ntm_arithmetic_stimulus.vhd
  vcom -2008 -reportprogress 300 -work work $verification_path/math/arithmetic/ntm_arithmetic_testbench.vhd

  vsim -g /ntm_arithmetic_testbench/ENABLE_NTM_SCALAR_DIVIDER_TEST=true -t ps +notimingchecks -L unisim work.ntm_arithmetic_testbench

  #MACROS
  add log -r sim:/ntm_arithmetic_testbench/*

  #WAVES
  view -title ntm_scalar_divider wave
  do $simulation_path/mpsoc/math/arithmetic/msim/waves/ntm_scalar_divider.do

  force -freeze sim:/ntm_arithmetic_pkg/STIMULUS_NTM_SCALAR_DIVIDER_TEST true 0
  force -freeze sim:/ntm_arithmetic_pkg/STIMULUS_NTM_SCALAR_DIVIDER_CASE_0 true 0

  onbreak {resume}
  run -all

  dataset save sim ntm_scalar_divider_test.wlf
}

##################################################################################################
# NTM_SCALAR_EXPONENTIATOR_TEST 
##################################################################################################

alias ntm_scalar_exponentiator_verification_compilation {
  echo "TEST: NTM_SCALAR_EXPONENTIATOR_TEST"

  vcom -2008 -reportprogress 300 -work work $verification_path/math/arithmetic/ntm_arithmetic_pkg.vhd
  vcom -2008 -reportprogress 300 -work work $verification_path/math/arithmetic/ntm_arithmetic_stimulus.vhd
  vcom -2008 -reportprogress 300 -work work $verification_path/math/arithmetic/ntm_arithmetic_testbench.vhd

  vsim -g /ntm_arithmetic_testbench/ENABLE_NTM_SCALAR_EXPONENTIATOR_TEST=true -t ps +notimingchecks -L unisim work.ntm_arithmetic_testbench

  #MACROS
  add log -r sim:/ntm_arithmetic_testbench/*

  #WAVES
  view -title ntm_scalar_exponentiator wave
  do $simulation_path/mpsoc/math/arithmetic/msim/waves/ntm_scalar_exponentiator.do

  force -freeze sim:/ntm_arithmetic_pkg/STIMULUS_NTM_SCALAR_EXPONENTIATOR_TEST true 0
  force -freeze sim:/ntm_arithmetic_pkg/STIMULUS_NTM_SCALAR_EXPONENTIATOR_CASE_0 true 0

  onbreak {resume}
  run -all

  dataset save sim ntm_scalar_exponentiator_test.wlf
}

##################################################################################################
# NTM_SCALAR_LCM_TEST 
##################################################################################################

alias ntm_scalar_lcm_verification_compilation {
  echo "TEST: NTM_SCALAR_LCM_TEST"

  vcom -2008 -reportprogress 300 -work work $verification_path/math/arithmetic/ntm_arithmetic_pkg.vhd
  vcom -2008 -reportprogress 300 -work work $verification_path/math/arithmetic/ntm_arithmetic_stimulus.vhd
  vcom -2008 -reportprogress 300 -work work $verification_path/math/arithmetic/ntm_arithmetic_testbench.vhd

  vsim -g /ntm_arithmetic_testbench/ENABLE_NTM_SCALAR_LCM_TEST=true -t ps +notimingchecks -L unisim work.ntm_arithmetic_testbench

  #MACROS
  add log -r sim:/ntm_arithmetic_testbench/*

  #WAVES
  view -title ntm_scalar_lcm wave
  do $simulation_path/mpsoc/math/arithmetic/msim/waves/ntm_scalar_lcm.do

  force -freeze sim:/ntm_arithmetic_pkg/STIMULUS_NTM_SCALAR_LCM_TEST true 0
  force -freeze sim:/ntm_arithmetic_pkg/STIMULUS_NTM_SCALAR_LCM_CASE_0 true 0

  onbreak {resume}
  run -all

  dataset save sim ntm_scalar_lcm_test.wlf
}

##################################################################################################
# NTM_SCALAR_GCD_TEST 
##################################################################################################

alias ntm_scalar_gcd_verification_compilation {
  echo "TEST: NTM_SCALAR_GCD_TEST"

  vcom -2008 -reportprogress 300 -work work $verification_path/math/arithmetic/ntm_arithmetic_pkg.vhd
  vcom -2008 -reportprogress 300 -work work $verification_path/math/arithmetic/ntm_arithmetic_stimulus.vhd
  vcom -2008 -reportprogress 300 -work work $verification_path/math/arithmetic/ntm_arithmetic_testbench.vhd

  vsim -g /ntm_arithmetic_testbench/ENABLE_NTM_SCALAR_GCD_TEST=true -t ps +notimingchecks -L unisim work.ntm_arithmetic_testbench

  #MACROS
  add log -r sim:/ntm_arithmetic_testbench/*

  #WAVES
  view -title ntm_scalar_gcd wave
  do $simulation_path/mpsoc/math/arithmetic/msim/waves/ntm_scalar_gcd.do

  force -freeze sim:/ntm_arithmetic_pkg/STIMULUS_NTM_SCALAR_GCD_TEST true 0
  force -freeze sim:/ntm_arithmetic_pkg/STIMULUS_NTM_SCALAR_GCD_CASE_0 true 0

  onbreak {resume}
  run -all

  dataset save sim ntm_scalar_gcd_test.wlf
}

##################################################################################################
# NTM_VECTOR_MOD_TEST 
##################################################################################################

alias ntm_vector_mod_verification_compilation {
  echo "TEST: NTM_VECTOR_MOD_TEST"

  vcom -2008 -reportprogress 300 -work work $verification_path/math/arithmetic/ntm_arithmetic_pkg.vhd
  vcom -2008 -reportprogress 300 -work work $verification_path/math/arithmetic/ntm_arithmetic_stimulus.vhd
  vcom -2008 -reportprogress 300 -work work $verification_path/math/arithmetic/ntm_arithmetic_testbench.vhd

  vsim -g /ntm_arithmetic_testbench/ENABLE_NTM_VECTOR_MOD_TEST=true -t ps +notimingchecks -L unisim work.ntm_arithmetic_testbench

  #MACROS
  add log -r sim:/ntm_arithmetic_testbench/*

  #WAVES
  view -title ntm_vector_mod wave
  do $simulation_path/mpsoc/math/arithmetic/msim/waves/ntm_vector_mod.do

  force -freeze sim:/ntm_arithmetic_pkg/STIMULUS_NTM_VECTOR_MOD_TEST true 0
  force -freeze sim:/ntm_arithmetic_pkg/STIMULUS_NTM_VECTOR_MOD_CASE_0 true 0

  onbreak {resume}
  run -all

  dataset save sim ntm_vector_mod_test.wlf
}

##################################################################################################
# NTM_VECTOR_ADDER_TEST 
##################################################################################################

alias ntm_vector_adder_verification_compilation {
  echo "TEST: NTM_VECTOR_ADDER_TEST"

  vcom -2008 -reportprogress 300 -work work $verification_path/math/arithmetic/ntm_arithmetic_pkg.vhd
  vcom -2008 -reportprogress 300 -work work $verification_path/math/arithmetic/ntm_arithmetic_stimulus.vhd
  vcom -2008 -reportprogress 300 -work work $verification_path/math/arithmetic/ntm_arithmetic_testbench.vhd

  vsim -g /ntm_arithmetic_testbench/ENABLE_NTM_VECTOR_ADDER_TEST=true -t ps +notimingchecks -L unisim work.ntm_arithmetic_testbench

  #MACROS
  add log -r sim:/ntm_arithmetic_testbench/*

  #WAVES
  view -title ntm_vector_adder wave
  do $simulation_path/mpsoc/math/arithmetic/msim/waves/ntm_vector_adder.do

  force -freeze sim:/ntm_arithmetic_pkg/STIMULUS_NTM_VECTOR_ADDER_TEST true 0
  force -freeze sim:/ntm_arithmetic_pkg/STIMULUS_NTM_VECTOR_ADDER_CASE_0 true 0

  onbreak {resume}
  run -all

  dataset save sim ntm_vector_adder_test.wlf
}

##################################################################################################
# NTM_VECTOR_MULTIPLIER_TEST 
##################################################################################################

alias ntm_vector_multiplier_verification_compilation {
  echo "TEST: NTM_VECTOR_MULTIPLIER_TEST"

  vcom -2008 -reportprogress 300 -work work $verification_path/math/arithmetic/ntm_arithmetic_pkg.vhd
  vcom -2008 -reportprogress 300 -work work $verification_path/math/arithmetic/ntm_arithmetic_stimulus.vhd
  vcom -2008 -reportprogress 300 -work work $verification_path/math/arithmetic/ntm_arithmetic_testbench.vhd

  vsim -g /ntm_arithmetic_testbench/ENABLE_NTM_VECTOR_MULTIPLIER_TEST=true -t ps +notimingchecks -L unisim work.ntm_arithmetic_testbench

  #MACROS
  add log -r sim:/ntm_arithmetic_testbench/*

  #WAVES
  view -title ntm_vector_multiplier wave
  do $simulation_path/mpsoc/math/arithmetic/msim/waves/ntm_vector_multiplier.do

  force -freeze sim:/ntm_arithmetic_pkg/STIMULUS_NTM_VECTOR_MULTIPLIER_TEST true 0
  force -freeze sim:/ntm_arithmetic_pkg/STIMULUS_NTM_VECTOR_MULTIPLIER_CASE_0 true 0

  onbreak {resume}
  run -all

  dataset save sim ntm_vector_multiplier_test.wlf
}

##################################################################################################
# NTM_VECTOR_INVERTER_TEST 
##################################################################################################

alias ntm_vector_inverter_verification_compilation {
  echo "TEST: NTM_VECTOR_INVERTER_TEST"

  vcom -2008 -reportprogress 300 -work work $verification_path/math/arithmetic/ntm_arithmetic_pkg.vhd
  vcom -2008 -reportprogress 300 -work work $verification_path/math/arithmetic/ntm_arithmetic_stimulus.vhd
  vcom -2008 -reportprogress 300 -work work $verification_path/math/arithmetic/ntm_arithmetic_testbench.vhd

  vsim -g /ntm_arithmetic_testbench/ENABLE_NTM_VECTOR_INVERTER_TEST=true -t ps +notimingchecks -L unisim work.ntm_arithmetic_testbench

  #MACROS
  add log -r sim:/ntm_arithmetic_testbench/*

  #WAVES
  view -title ntm_vector_inverter wave
  do $simulation_path/mpsoc/math/arithmetic/msim/waves/ntm_vector_inverter.do

  force -freeze sim:/ntm_arithmetic_pkg/STIMULUS_NTM_VECTOR_INVERTER_TEST true 0
  force -freeze sim:/ntm_arithmetic_pkg/STIMULUS_NTM_VECTOR_INVERTER_CASE_0 true 0

  onbreak {resume}
  run -all

  dataset save sim ntm_vector_inverter_test.wlf
}

##################################################################################################
# NTM_VECTOR_DIVIDER_TEST 
##################################################################################################

alias ntm_vector_divider_verification_compilation {
  echo "TEST: NTM_VECTOR_DIVIDER_TEST"

  vcom -2008 -reportprogress 300 -work work $verification_path/math/arithmetic/ntm_arithmetic_pkg.vhd
  vcom -2008 -reportprogress 300 -work work $verification_path/math/arithmetic/ntm_arithmetic_stimulus.vhd
  vcom -2008 -reportprogress 300 -work work $verification_path/math/arithmetic/ntm_arithmetic_testbench.vhd

  vsim -g /ntm_arithmetic_testbench/ENABLE_NTM_VECTOR_DIVIDER_TEST=true -t ps +notimingchecks -L unisim work.ntm_arithmetic_testbench

  #MACROS
  add log -r sim:/ntm_arithmetic_testbench/*

  #WAVES
  view -title ntm_vector_divider wave
  do $simulation_path/mpsoc/math/arithmetic/msim/waves/ntm_vector_divider.do

  force -freeze sim:/ntm_arithmetic_pkg/STIMULUS_NTM_VECTOR_DIVIDER_TEST true 0
  force -freeze sim:/ntm_arithmetic_pkg/STIMULUS_NTM_VECTOR_DIVIDER_CASE_0 true 0

  onbreak {resume}
  run -all

  dataset save sim ntm_vector_divider_test.wlf
}

##################################################################################################
# NTM_VECTOR_EXPONENTIATOR_TEST 
##################################################################################################

alias ntm_vector_exponentiator_verification_compilation {
  echo "TEST: NTM_VECTOR_EXPONENTIATOR_TEST"

  vcom -2008 -reportprogress 300 -work work $verification_path/math/arithmetic/ntm_arithmetic_pkg.vhd
  vcom -2008 -reportprogress 300 -work work $verification_path/math/arithmetic/ntm_arithmetic_stimulus.vhd
  vcom -2008 -reportprogress 300 -work work $verification_path/math/arithmetic/ntm_arithmetic_testbench.vhd

  vsim -g /ntm_arithmetic_testbench/ENABLE_NTM_VECTOR_EXPONENTIATOR_TEST=true -t ps +notimingchecks -L unisim work.ntm_arithmetic_testbench

  #MACROS
  add log -r sim:/ntm_arithmetic_testbench/*

  #WAVES
  view -title ntm_vector_exponentiator wave
  do $simulation_path/mpsoc/math/arithmetic/msim/waves/ntm_vector_exponentiator.do

  force -freeze sim:/ntm_arithmetic_pkg/STIMULUS_NTM_VECTOR_EXPONENTIATOR_TEST true 0
  force -freeze sim:/ntm_arithmetic_pkg/STIMULUS_NTM_VECTOR_EXPONENTIATOR_CASE_0 true 0

  onbreak {resume}
  run -all

  dataset save sim ntm_vector_exponentiator_test.wlf
}

##################################################################################################
# NTM_VECTOR_LCM_TEST 
##################################################################################################

alias ntm_vector_lcm_verification_compilation {
  echo "TEST: NTM_VECTOR_LCM_TEST"

  vcom -2008 -reportprogress 300 -work work $verification_path/math/arithmetic/ntm_arithmetic_pkg.vhd
  vcom -2008 -reportprogress 300 -work work $verification_path/math/arithmetic/ntm_arithmetic_stimulus.vhd
  vcom -2008 -reportprogress 300 -work work $verification_path/math/arithmetic/ntm_arithmetic_testbench.vhd

  vsim -g /ntm_arithmetic_testbench/ENABLE_NTM_VECTOR_LCM_TEST=true -t ps +notimingchecks -L unisim work.ntm_arithmetic_testbench

  #MACROS
  add log -r sim:/ntm_arithmetic_testbench/*

  #WAVES
  view -title ntm_vector_lcm wave
  do $simulation_path/mpsoc/math/arithmetic/msim/waves/ntm_vector_lcm.do

  force -freeze sim:/ntm_arithmetic_pkg/STIMULUS_NTM_VECTOR_LCM_TEST true 0
  force -freeze sim:/ntm_arithmetic_pkg/STIMULUS_NTM_VECTOR_LCM_CASE_0 true 0

  onbreak {resume}
  run -all

  dataset save sim ntm_vector_lcm_test.wlf
}

##################################################################################################
# NTM_VECTOR_GCD_TEST 
##################################################################################################

alias ntm_vector_gcd_verification_compilation {
  echo "TEST: NTM_VECTOR_GCD_TEST"

  vcom -2008 -reportprogress 300 -work work $verification_path/math/arithmetic/ntm_arithmetic_pkg.vhd
  vcom -2008 -reportprogress 300 -work work $verification_path/math/arithmetic/ntm_arithmetic_stimulus.vhd
  vcom -2008 -reportprogress 300 -work work $verification_path/math/arithmetic/ntm_arithmetic_testbench.vhd

  vsim -g /ntm_arithmetic_testbench/ENABLE_NTM_VECTOR_GCD_TEST=true -t ps +notimingchecks -L unisim work.ntm_arithmetic_testbench

  #MACROS
  add log -r sim:/ntm_arithmetic_testbench/*

  #WAVES
  view -title ntm_vector_gcd wave
  do $simulation_path/mpsoc/math/arithmetic/msim/waves/ntm_vector_gcd.do

  force -freeze sim:/ntm_arithmetic_pkg/STIMULUS_NTM_VECTOR_GCD_TEST true 0
  force -freeze sim:/ntm_arithmetic_pkg/STIMULUS_NTM_VECTOR_GCD_CASE_0 true 0

  onbreak {resume}
  run -all

  dataset save sim ntm_vector_gcd_test.wlf
}

##################################################################################################

alias v01 {
  ntm_scalar_mod_verification_compilation
}

alias v02 {
  ntm_scalar_adder_verification_compilation 
}

alias v03 {
  ntm_scalar_multiplier_verification_compilation 
}

alias v04 {
  ntm_scalar_inverter_verification_compilation 
}

alias v05 {
  ntm_scalar_divider_verification_compilation 
}

alias v06 {
  ntm_scalar_exponentiator_verification_compilation 
}

alias v07 {
  ntm_scalar_lcm_verification_compilation 
}

alias v08 {
  ntm_scalar_gcd_verification_compilation 
}

alias v09 {
  ntm_vector_mod_verification_compilation
}

alias v10 {
  ntm_vector_adder_verification_compilation 
}

alias v11 {
  ntm_vector_multiplier_verification_compilation 
}

alias v12 {
  ntm_vector_inverter_verification_compilation 
}

alias v13 {
  ntm_vector_divider_verification_compilation 
}

alias v14 {
  ntm_vector_exponentiator_verification_compilation 
}

alias v15 {
  ntm_vector_lcm_verification_compilation 
}

alias v16 {
  ntm_vector_gcd_verification_compilation 
}

echo "************************************************************"
echo "v01 . NTM-SCALAR-MOD-TEST"
echo "v02 . NTM-SCALAR-ADDER-TEST"
echo "v03 . NTM-SCALAR-MULTIPLIER-TEST"
echo "v04 . NTM-SCALAR-INVERTER-TEST"
echo "v05 . NTM-SCALAR-DIVIDER-TEST"
echo "v06 . NTM-SCALAR-EXPONENTIATOR-TEST"
echo "v07 . NTM-SCALAR-LCM-TEST"
echo "v08 . NTM-SCALAR-GCD-TEST"
echo "v09 . NTM-VECTOR-MOD-TEST"
echo "v10 . NTM-VECTOR-ADDER-TEST"
echo "v11 . NTM-VECTOR-MULTIPLIER-TEST"
echo "v12 . NTM-VECTOR-INVERTER-TEST"
echo "v13 . NTM-VECTOR-DIVIDER-TEST"
echo "v14 . NTM-VECTOR-EXPONENTIATOR-TEST"
echo "v15 . NTM-VECTOR-LCM-TEST"
echo "v16 . NTM-VECTOR-GCD-TEST"
echo "************************************************************"