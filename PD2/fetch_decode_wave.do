onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /fetch_decode_tb/clock
add wave -noupdate /fetch_decode_tb/address
add wave -noupdate /fetch_decode_tb/data_in
add wave -noupdate /fetch_decode_tb/access_size
add wave -noupdate /fetch_decode_tb/rw
add wave -noupdate /fetch_decode_tb/enable
add wave -noupdate /fetch_decode_tb/enable_fetch
add wave -noupdate /fetch_decode_tb/enable_decode
add wave -noupdate /fetch_decode_tb/insn
add wave -noupdate /fetch_decode_tb/stall
add wave -noupdate /fetch_decode_tb/busy
add wave -noupdate /fetch_decode_tb/data_out
add wave -noupdate /fetch_decode_tb/pc_fetch
add wave -noupdate /fetch_decode_tb/pc_from_fetch_temp
add wave -noupdate /fetch_decode_tb/pc_decode
add wave -noupdate /fetch_decode_tb/pc_out_tb
add wave -noupdate /fetch_decode_tb/opcode_out
add wave -noupdate /fetch_decode_tb/rs_out
add wave -noupdate /fetch_decode_tb/rt_out
add wave -noupdate /fetch_decode_tb/rd_out
add wave -noupdate /fetch_decode_tb/sa_out
add wave -noupdate /fetch_decode_tb/func_out
add wave -noupdate /fetch_decode_tb/imm_out
add wave -noupdate /fetch_decode_tb/pc_out
add wave -noupdate /fetch_decode_tb/rw_fetch
add wave -noupdate /fetch_decode_tb/access_size_fetch
add wave -noupdate /fetch_decode_tb/fd
add wave -noupdate /fetch_decode_tb/scan_fd
add wave -noupdate /fetch_decode_tb/status_read
add wave -noupdate /fetch_decode_tb/status_write
add wave -noupdate /fetch_decode_tb/sscanf_ret
add wave -noupdate /fetch_decode_tb/words_read
add wave -noupdate /fetch_decode_tb/words_written
add wave -noupdate /fetch_decode_tb/words_fetched
add wave -noupdate /fetch_decode_tb/words_decoded
add wave -noupdate /fetch_decode_tb/words_processed
add wave -noupdate /fetch_decode_tb/fetch_not_enabled
add wave -noupdate /fetch_decode_tb/decode_not_enabled
add wave -noupdate /fetch_decode_tb/line
add wave -noupdate /fetch_decode_tb/opcode_out_tb
add wave -noupdate /fetch_decode_tb/rs_out_tb
add wave -noupdate /fetch_decode_tb/rt_out_tb
add wave -noupdate /fetch_decode_tb/rd_out_tb
add wave -noupdate /fetch_decode_tb/sa_out_tb
add wave -noupdate /fetch_decode_tb/func_out_tb
add wave -noupdate /fetch_decode_tb/imm_out_tb
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 2} {443 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 270
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
WaveRestoreZoom {431 ps} {452 ps}
