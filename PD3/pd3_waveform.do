onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /F_D_M_tb/clock
add wave -noupdate -radix hexadecimal /F_D_M_tb/address
add wave -noupdate -radix hexadecimal /F_D_M_tb/data_in
add wave -noupdate -radix hexadecimal /F_D_M_tb/access_size
add wave -noupdate -radix hexadecimal /F_D_M_tb/rw
add wave -noupdate -radix hexadecimal /F_D_M_tb/enable
add wave -noupdate -radix hexadecimal /F_D_M_tb/enable_fetch
add wave -noupdate -radix hexadecimal /F_D_M_tb/enable_decode
add wave -noupdate -radix hexadecimal /F_D_M_tb/pc_decode
add wave -noupdate -radix hexadecimal /F_D_M_tb/insn_decode
add wave -noupdate -radix hexadecimal /F_D_M_tb/pc_execute
add wave -noupdate -radix hexadecimal /F_D_M_tb/insn_execute
add wave -noupdate -radix hexadecimal /F_D_M_tb/imm_execute
add wave -noupdate -radix hexadecimal /F_D_M_tb/rsData_execute
add wave -noupdate -radix hexadecimal /F_D_M_tb/rtData_execute
add wave -noupdate -radix hexadecimal /F_D_M_tb/saData_execute
add wave -noupdate -radix hexadecimal /F_D_M_tb/ALUOp_execute
add wave -noupdate -radix hexadecimal /F_D_M_tb/stall
add wave -noupdate -radix hexadecimal /F_D_M_tb/busy
add wave -noupdate -radix hexadecimal /F_D_M_tb/data_out
add wave -noupdate -radix hexadecimal /F_D_M_tb/pc_fetch
add wave -noupdate -radix hexadecimal /F_D_M_tb/opcode_out
add wave -noupdate -radix hexadecimal /F_D_M_tb/rs_out
add wave -noupdate -radix hexadecimal /F_D_M_tb/rt_out
add wave -noupdate -radix hexadecimal /F_D_M_tb/rd_out
add wave -noupdate -radix hexadecimal /F_D_M_tb/sa_out
add wave -noupdate -radix hexadecimal /F_D_M_tb/func_out
add wave -noupdate -radix hexadecimal /F_D_M_tb/imm_out
add wave -noupdate -radix hexadecimal /F_D_M_tb/pc_out
add wave -noupdate -radix hexadecimal /F_D_M_tb/insn_decode_out
add wave -noupdate -radix hexadecimal /F_D_M_tb/rsOut_regfile
add wave -noupdate -radix hexadecimal /F_D_M_tb/rtOut_regfile
add wave -noupdate -radix hexadecimal /F_D_M_tb/dVal_regfile
add wave -noupdate -radix hexadecimal /F_D_M_tb/imm_out_sx_decode
add wave -noupdate -radix hexadecimal /F_D_M_tb/rw_fetch
add wave -noupdate -radix hexadecimal /F_D_M_tb/access_size_fetch
add wave -noupdate -radix hexadecimal /F_D_M_tb/dataOut_execute
add wave -noupdate -radix hexadecimal /F_D_M_tb/ALUOp_decode
add wave -noupdate -radix hexadecimal /F_D_M_tb/fd
add wave -noupdate -radix hexadecimal /F_D_M_tb/scan_fd
add wave -noupdate -radix hexadecimal /F_D_M_tb/status_read
add wave -noupdate -radix hexadecimal /F_D_M_tb/status_write
add wave -noupdate -radix hexadecimal /F_D_M_tb/sscanf_ret
add wave -noupdate -radix hexadecimal /F_D_M_tb/line
add wave -noupdate -radix hexadecimal /F_D_M_tb/opcode_out_tb
add wave -noupdate -radix hexadecimal /F_D_M_tb/rs_out_tb
add wave -noupdate -radix hexadecimal /F_D_M_tb/rt_out_tb
add wave -noupdate -radix hexadecimal /F_D_M_tb/rd_out_tb
add wave -noupdate -radix hexadecimal /F_D_M_tb/sa_out_tb
add wave -noupdate -radix hexadecimal /F_D_M_tb/func_out_tb
add wave -noupdate -radix hexadecimal /F_D_M_tb/imm_out_tb
add wave -noupdate -radix hexadecimal /F_D_M_tb/pc_out_tb
add wave -noupdate -radix hexadecimal /F_D_M_tb/insn_out_tb
add wave -noupdate -radix hexadecimal /F_D_M_tb/dataOut_execute_tb
add wave -noupdate -radix hexadecimal /F_D_M_tb/pc_from_fetch_temp
add wave -noupdate -radix hexadecimal /F_D_M_tb/pc_from_decode_temp
add wave -noupdate -radix hexadecimal /F_D_M_tb/rsOut_regfile_tb
add wave -noupdate -radix hexadecimal /F_D_M_tb/rtOut_regfile_tb
add wave -noupdate -radix hexadecimal /F_D_M_tb/imm_out_sx_decode_tb
add wave -noupdate -radix hexadecimal /F_D_M_tb/we_regfile
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {232 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 340
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {178 ps} {280 ps}
