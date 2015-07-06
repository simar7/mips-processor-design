onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/clock
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/address
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/data_in
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/access_size
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/rw
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/enable
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/enable_fetch
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/enable_decode
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/enable_execute
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/pc_decode
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/insn_decode
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/pc_execute
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/insn_execute
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/imm_execute
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/rsData_execute
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/rtData_execute
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/saData_execute
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/ALUOp_execute
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/we_regfile
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/stall
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/dVal_regfile
add wave -noupdate -radix hexadecimal -childformat {{{/F_D_X_M_W_tb/D0/REGFILE[31]} -radix hexadecimal} {{/F_D_X_M_W_tb/D0/REGFILE[30]} -radix hexadecimal} {{/F_D_X_M_W_tb/D0/REGFILE[29]} -radix hexadecimal} {{/F_D_X_M_W_tb/D0/REGFILE[28]} -radix hexadecimal} {{/F_D_X_M_W_tb/D0/REGFILE[27]} -radix hexadecimal} {{/F_D_X_M_W_tb/D0/REGFILE[26]} -radix hexadecimal} {{/F_D_X_M_W_tb/D0/REGFILE[25]} -radix hexadecimal} {{/F_D_X_M_W_tb/D0/REGFILE[24]} -radix hexadecimal} {{/F_D_X_M_W_tb/D0/REGFILE[23]} -radix hexadecimal} {{/F_D_X_M_W_tb/D0/REGFILE[22]} -radix hexadecimal} {{/F_D_X_M_W_tb/D0/REGFILE[21]} -radix hexadecimal} {{/F_D_X_M_W_tb/D0/REGFILE[20]} -radix hexadecimal} {{/F_D_X_M_W_tb/D0/REGFILE[19]} -radix hexadecimal} {{/F_D_X_M_W_tb/D0/REGFILE[18]} -radix hexadecimal} {{/F_D_X_M_W_tb/D0/REGFILE[17]} -radix hexadecimal} {{/F_D_X_M_W_tb/D0/REGFILE[16]} -radix hexadecimal} {{/F_D_X_M_W_tb/D0/REGFILE[15]} -radix hexadecimal} {{/F_D_X_M_W_tb/D0/REGFILE[14]} -radix hexadecimal} {{/F_D_X_M_W_tb/D0/REGFILE[13]} -radix hexadecimal} {{/F_D_X_M_W_tb/D0/REGFILE[12]} -radix hexadecimal} {{/F_D_X_M_W_tb/D0/REGFILE[11]} -radix hexadecimal} {{/F_D_X_M_W_tb/D0/REGFILE[10]} -radix hexadecimal} {{/F_D_X_M_W_tb/D0/REGFILE[9]} -radix hexadecimal} {{/F_D_X_M_W_tb/D0/REGFILE[8]} -radix hexadecimal} {{/F_D_X_M_W_tb/D0/REGFILE[7]} -radix hexadecimal} {{/F_D_X_M_W_tb/D0/REGFILE[6]} -radix hexadecimal} {{/F_D_X_M_W_tb/D0/REGFILE[5]} -radix hexadecimal} {{/F_D_X_M_W_tb/D0/REGFILE[4]} -radix hexadecimal} {{/F_D_X_M_W_tb/D0/REGFILE[3]} -radix hexadecimal} {{/F_D_X_M_W_tb/D0/REGFILE[2]} -radix hexadecimal} {{/F_D_X_M_W_tb/D0/REGFILE[1]} -radix hexadecimal} {{/F_D_X_M_W_tb/D0/REGFILE[0]} -radix hexadecimal}} -expand -subitemconfig {{/F_D_X_M_W_tb/D0/REGFILE[31]} {-height 17 -radix hexadecimal} {/F_D_X_M_W_tb/D0/REGFILE[30]} {-height 17 -radix hexadecimal} {/F_D_X_M_W_tb/D0/REGFILE[29]} {-height 17 -radix hexadecimal} {/F_D_X_M_W_tb/D0/REGFILE[28]} {-height 17 -radix hexadecimal} {/F_D_X_M_W_tb/D0/REGFILE[27]} {-height 17 -radix hexadecimal} {/F_D_X_M_W_tb/D0/REGFILE[26]} {-height 17 -radix hexadecimal} {/F_D_X_M_W_tb/D0/REGFILE[25]} {-height 17 -radix hexadecimal} {/F_D_X_M_W_tb/D0/REGFILE[24]} {-height 17 -radix hexadecimal} {/F_D_X_M_W_tb/D0/REGFILE[23]} {-height 17 -radix hexadecimal} {/F_D_X_M_W_tb/D0/REGFILE[22]} {-height 17 -radix hexadecimal} {/F_D_X_M_W_tb/D0/REGFILE[21]} {-height 17 -radix hexadecimal} {/F_D_X_M_W_tb/D0/REGFILE[20]} {-height 17 -radix hexadecimal} {/F_D_X_M_W_tb/D0/REGFILE[19]} {-height 17 -radix hexadecimal} {/F_D_X_M_W_tb/D0/REGFILE[18]} {-height 17 -radix hexadecimal} {/F_D_X_M_W_tb/D0/REGFILE[17]} {-height 17 -radix hexadecimal} {/F_D_X_M_W_tb/D0/REGFILE[16]} {-height 17 -radix hexadecimal} {/F_D_X_M_W_tb/D0/REGFILE[15]} {-height 17 -radix hexadecimal} {/F_D_X_M_W_tb/D0/REGFILE[14]} {-height 17 -radix hexadecimal} {/F_D_X_M_W_tb/D0/REGFILE[13]} {-height 17 -radix hexadecimal} {/F_D_X_M_W_tb/D0/REGFILE[12]} {-height 17 -radix hexadecimal} {/F_D_X_M_W_tb/D0/REGFILE[11]} {-height 17 -radix hexadecimal} {/F_D_X_M_W_tb/D0/REGFILE[10]} {-height 17 -radix hexadecimal} {/F_D_X_M_W_tb/D0/REGFILE[9]} {-height 17 -radix hexadecimal} {/F_D_X_M_W_tb/D0/REGFILE[8]} {-height 17 -radix hexadecimal} {/F_D_X_M_W_tb/D0/REGFILE[7]} {-height 17 -radix hexadecimal} {/F_D_X_M_W_tb/D0/REGFILE[6]} {-height 17 -radix hexadecimal} {/F_D_X_M_W_tb/D0/REGFILE[5]} {-height 17 -radix hexadecimal} {/F_D_X_M_W_tb/D0/REGFILE[4]} {-height 17 -radix hexadecimal} {/F_D_X_M_W_tb/D0/REGFILE[3]} {-height 17 -radix hexadecimal} {/F_D_X_M_W_tb/D0/REGFILE[2]} {-height 17 -radix hexadecimal} {/F_D_X_M_W_tb/D0/REGFILE[1]} {-height 17 -radix hexadecimal} {/F_D_X_M_W_tb/D0/REGFILE[0]} {-height 17 -radix hexadecimal}} /F_D_X_M_W_tb/D0/REGFILE
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/address_dm
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/data_in_dm
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/access_size_dm
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/rw_dm
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/enable_dm
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/data_in_mem_wb
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/data_in_alu_wb
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/rw_d_wb
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/busy
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/data_out
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/pc_fetch
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/opcode_out
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/rs_out
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/rt_out
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/rd_out
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/sa_out
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/func_out
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/imm_out
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/pc_out
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/insn_decode_out
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/rsOut_regfile
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/rtOut_regfile
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/imm_out_sx_decode
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/rw_fetch
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/access_size_fetch
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/dataOut_execute
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/branch_taken_execute
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/ALUOp_decode
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/busy_dm
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/data_out_dm
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/data_out_wb
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/dm_we_execute
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/rw_d_execute
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/dm_access_size_execute
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/fd
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/scan_fd
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/status_read
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/status_write
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/sscanf_ret
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/words_read
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/words_written
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/words_fetched
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/words_decoded
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/words_executed
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/words_run
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/words_processed
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/fetch_not_enabled
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/decode_not_enabled
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/execute_not_enabled
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/line
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/opcode_out_tb
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/rs_out_tb
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/rt_out_tb
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/rd_out_tb
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/sa_out_tb
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/func_out_tb
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/imm_out_tb
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/pc_out_tb
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/insn_out_tb
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/dataOut_execute_tb
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/branch_taken_tb
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/pc_from_fetch_temp
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/pc_from_decode_temp
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/insn_execute_temp
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/rsOut_regfile_tb
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/rtOut_regfile_tb
add wave -noupdate -radix hexadecimal /F_D_X_M_W_tb/imm_out_sx_decode_tb
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {15 ps} 0}
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
WaveRestoreZoom {0 ps} {128 ps}
