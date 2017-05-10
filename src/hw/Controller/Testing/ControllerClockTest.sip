set_global_assignment -entity "ControllerClockTest" -library "lib_ControllerClockTest" -name IP_TOOL_NAME "altera_pll"
set_global_assignment -entity "ControllerClockTest" -library "lib_ControllerClockTest" -name IP_TOOL_VERSION "16.0"
set_global_assignment -entity "ControllerClockTest" -library "lib_ControllerClockTest" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_ControllerClockTest" -name SPD_FILE [file join $::quartus(sip_path) "ControllerClockTest.spd"]

set_global_assignment -library "lib_ControllerClockTest" -name MISC_FILE [file join $::quartus(sip_path) "ControllerClockTest_sim/ControllerClockTest.vo"]
