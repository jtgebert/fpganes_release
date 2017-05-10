set_global_assignment -entity "VGAClock" -library "lib_VGAClock" -name IP_TOOL_NAME "altera_pll"
set_global_assignment -entity "VGAClock" -library "lib_VGAClock" -name IP_TOOL_VERSION "16.0"
set_global_assignment -entity "VGAClock" -library "lib_VGAClock" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_VGAClock" -name SPD_FILE [file join $::quartus(sip_path) "VGAClock.spd"]

set_global_assignment -library "lib_VGAClock" -name MISC_FILE [file join $::quartus(sip_path) "VGAClock_sim/VGAClock.vo"]
