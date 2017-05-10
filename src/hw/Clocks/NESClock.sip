set_global_assignment -entity "NESClock" -library "lib_NESClock" -name IP_TOOL_NAME "altera_pll"
set_global_assignment -entity "NESClock" -library "lib_NESClock" -name IP_TOOL_VERSION "16.0"
set_global_assignment -entity "NESClock" -library "lib_NESClock" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_NESClock" -name SPD_FILE [file join $::quartus(sip_path) "NESClock.spd"]

set_global_assignment -library "lib_NESClock" -name MISC_FILE [file join $::quartus(sip_path) "NESClock_sim/NESClock.vo"]
