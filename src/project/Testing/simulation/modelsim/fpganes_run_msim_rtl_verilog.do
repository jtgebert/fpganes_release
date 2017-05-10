transcript on
if ![file isdirectory fpganes_iputf_libs] {
	file mkdir fpganes_iputf_libs
}

if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

###### Libraries for IPUTF cores 
###### End libraries for IPUTF cores 
###### MIF file copy and HDL compilation commands for IPUTF cores 


vlog "I:/554/CPU/fpganes/src/hw/Clocks/NESClock_sim/NESClock.vo"

vlog -vlog01compat -work work +incdir+I:/554/CPU/fpganes/src/hw/Clocks {I:/554/CPU/fpganes/src/hw/Clocks/VGAClock.vo}
vlog -vlog01compat -work work +incdir+I:/554/CPU/fpganes/src/hw/Clocks {I:/554/CPU/fpganes/src/hw/Clocks/VGAClock.v}
vlog -vlog01compat -work work +incdir+I:/554/CPU/fpganes/src/hw/Memory {I:/554/CPU/fpganes/src/hw/Memory/ProgramRom.v}
vlog -vlog01compat -work work +incdir+I:/554/CPU/fpganes/src/hw/Memory {I:/554/CPU/fpganes/src/hw/Memory/ProgramRam.v}
vlog -vlog01compat -work work +incdir+I:/554/CPU/fpganes/src/hw/Memory {I:/554/CPU/fpganes/src/hw/Memory/VGARam.v}
vlog -vlog01compat -work work +incdir+I:/554/CPU/fpganes/src/hw/Memory {I:/554/CPU/fpganes/src/hw/Memory/LoadScreenRom.v}
vlog -vlog01compat -work work +incdir+I:/554/CPU/fpganes/src/project {I:/554/CPU/fpganes/src/project/fpganes.v}
vlog -vlog01compat -work work +incdir+I:/554/CPU/fpganes/src/hw/Clocks/VGAClock {I:/554/CPU/fpganes/src/hw/Clocks/VGAClock/VGAClock_0002.v}
vlog -sv -work work +incdir+I:/554/CPU/fpganes/src/hw/Controller {I:/554/CPU/fpganes/src/hw/Controller/SPART_tx.sv}
vlog -sv -work work +incdir+I:/554/CPU/fpganes/src/hw/Controller {I:/554/CPU/fpganes/src/hw/Controller/SPART_rx.sv}
vlog -sv -work work +incdir+I:/554/CPU/fpganes/src/hw/Controller {I:/554/CPU/fpganes/src/hw/Controller/spart.sv}
vlog -sv -work work +incdir+I:/554/CPU/fpganes/src/hw/Controller {I:/554/CPU/fpganes/src/hw/Controller/driver.sv}
vlog -sv -work work +incdir+I:/554/CPU/fpganes/src/hw/Controller {I:/554/CPU/fpganes/src/hw/Controller/Controller.sv}
vlog -sv -work work +incdir+I:/554/CPU/fpganes/src/hw/Controller {I:/554/CPU/fpganes/src/hw/Controller/bus_intf.sv}
vlog -sv -work work +incdir+I:/554/CPU/fpganes/src/hw/Controller {I:/554/CPU/fpganes/src/hw/Controller/baud_rate_gen.sv}
vlog -sv -work work +incdir+I:/554/CPU/fpganes/src/hw/Memory {I:/554/CPU/fpganes/src/hw/Memory/MemoryWrapper.sv}
vlog -sv -work work +incdir+I:/554/CPU/fpganes/src/hw/Memory {I:/554/CPU/fpganes/src/hw/Memory/HardwareDecoder.sv}
vlog -sv -work work +incdir+I:/554/CPU/fpganes/src/hw/PPU {I:/554/CPU/fpganes/src/hw/PPU/PPU_sprite.sv}
vlog -sv -work work +incdir+I:/554/CPU/fpganes/src/hw/PPU {I:/554/CPU/fpganes/src/hw/PPU/PPU_oam.sv}
vlog -sv -work work +incdir+I:/554/CPU/fpganes/src/hw/PPU {I:/554/CPU/fpganes/src/hw/PPU/PPU_background.sv}
vlog -sv -work work +incdir+I:/554/CPU/fpganes/src/hw/PPU {I:/554/CPU/fpganes/src/hw/PPU/PPU.sv}
vlog -sv -work work +incdir+I:/554/CPU/fpganes/src/hw/VGA {I:/554/CPU/fpganes/src/hw/VGA/VGA.sv}
vlog -sv -work work +incdir+I:/554/CPU/fpganes/src/hw/VGA {I:/554/CPU/fpganes/src/hw/VGA/TimeGen.sv}
vlog -sv -work work +incdir+I:/554/CPU/fpganes/src/hw/VGA {I:/554/CPU/fpganes/src/hw/VGA/RAM_wrapper.sv}
vlog -sv -work work +incdir+I:/554/CPU/fpganes/src/hw/VGA {I:/554/CPU/fpganes/src/hw/VGA/DisplayPlane.sv}
vlog -sv -work work +incdir+I:/554/CPU/fpganes/src/hw/DMA {I:/554/CPU/fpganes/src/hw/DMA/OAM_dma.sv}
vlog -sv -work work +incdir+/554/cpu/fpganes/src/hw/cpu {/554/cpu/fpganes/src/hw/cpu/constants.sv}
vlog -sv -work work +incdir+/554/cpu/fpganes/src/hw/cpu {/554/cpu/fpganes/src/hw/cpu/cpu_switchcase.sv}
vlog -sv -work work +incdir+I:/554/CPU/fpganes/src/hw/CPU {I:/554/CPU/fpganes/src/hw/CPU/Enums.sv}
vlog -sv -work work +incdir+I:/554/CPU/fpganes/src/hw/PPU {I:/554/CPU/fpganes/src/hw/PPU/PPU_palette_mem.sv}
vlog -sv -work work +incdir+I:/554/CPU/fpganes/src/hw/VGA {I:/554/CPU/fpganes/src/hw/VGA/RamReader.sv}
vlog -sv -work work +incdir+I:/554/CPU/fpganes/src/hw/CPU {I:/554/CPU/fpganes/src/hw/CPU/Registers.sv}
vlog -sv -work work +incdir+I:/554/CPU/fpganes/src/hw/CPU {I:/554/CPU/fpganes/src/hw/CPU/Mem.sv}
vlog -sv -work work +incdir+I:/554/CPU/fpganes/src/hw/CPU {I:/554/CPU/fpganes/src/hw/CPU/decoder.sv}
vlog -sv -work work +incdir+I:/554/CPU/fpganes/src/hw/CPU {I:/554/CPU/fpganes/src/hw/CPU/control.sv}
vlog -sv -work work +incdir+I:/554/CPU/fpganes/src/hw/CPU {I:/554/CPU/fpganes/src/hw/CPU/ALU_Input.sv}
vlog -sv -work work +incdir+I:/554/CPU/fpganes/src/hw/CPU {I:/554/CPU/fpganes/src/hw/CPU/ALU.sv}
vlog -sv -work work +incdir+I:/554/CPU/fpganes/src/hw/CPU {I:/554/CPU/fpganes/src/hw/CPU/CPU.sv}

