onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/clock
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/address
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/data_in
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/rw
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/enable
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/rw_fetch
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/pc_fetch
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/enable_fetch
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/fetch_not_enabled
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/decode_not_enabled
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/execute_not_enabled
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/rsOut_regfile
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/rtOut_regfile
add wave -noupdate /F_D_X_M_W_tb/D0/rdIn_regfile
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/dVal_regfile
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/we_regfile
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/enable_decode
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/imm_out_sx_decode
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/pc_decode
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/insn_decode
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/ALUOp_decode
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/pc_from_fetch_temp
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/pc_from_decode_temp
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/opcode_out
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/rs_out
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/rt_out
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/rd_out
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/sa_out
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/func_out
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/imm_out
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/pc_out
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/insn_decode_out
add wave -noupdate /F_D_X_M_W_tb/enable_execute
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/pc_execute
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/insn_execute
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/imm_execute
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/rsData_execute
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/rtData_execute
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/saData_execute
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/ALUOp_execute
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/dataOut_execute
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/stall
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/busy
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {101 ps} 0}
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
WaveRestoreZoom {68 ps} {97 ps}
