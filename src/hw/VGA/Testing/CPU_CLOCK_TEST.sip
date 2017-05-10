set_global_assignment -entity "CPU_CLOCK_TEST" -library "lib_CPU_CLOCK_TEST" -name IP_TOOL_NAME "altera_pll"
set_global_assignment -entity "CPU_CLOCK_TEST" -library "lib_CPU_CLOCK_TEST" -name IP_TOOL_VERSION "16.0"
set_global_assignment -entity "CPU_CLOCK_TEST" -library "lib_CPU_CLOCK_TEST" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_CPU_CLOCK_TEST" -name SPD_FILE [file join $::quartus(sip_path) "CPU_CLOCK_TEST.spd"]

set_global_assignment -library "lib_CPU_CLOCK_TEST" -name MISC_FILE [file join $::quartus(sip_path) "CPU_CLOCK_TEST_sim/CPU_CLOCK_TEST.vo"]
