onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group memory_tb /memory_tb/clock
add wave -noupdate -expand -group memory_tb /memory_tb/address
add wave -noupdate -expand -group memory_tb /memory_tb/data_in
add wave -noupdate -expand -group memory_tb /memory_tb/access_size
add wave -noupdate -expand -group memory_tb /memory_tb/rw
add wave -noupdate -expand -group memory_tb /memory_tb/enable
add wave -noupdate -expand -group memory_tb /memory_tb/busy
add wave -noupdate -expand -group memory_tb /memory_tb/data_out
add wave -noupdate -expand -group memory_tb /memory_tb/fd
add wave -noupdate -expand -group memory_tb /memory_tb/scan_fd
add wave -noupdate -expand -group memory_tb /memory_tb/status_read
add wave -noupdate -expand -group memory_tb /memory_tb/status_write
add wave -noupdate -expand -group memory_tb /memory_tb/sscanf_ret
add wave -noupdate -expand -group memory_tb /memory_tb/words_read
add wave -noupdate -expand -group memory_tb /memory_tb/words_written
add wave -noupdate -expand -group memory_tb /memory_tb/line
add wave -noupdate -expand -group memory_tb /memory_tb/data_read
add wave -noupdate /memory_tb/M0/clock
add wave -noupdate /memory_tb/M0/address
add wave -noupdate /memory_tb/M0/data_in
add wave -noupdate /memory_tb/M0/access_size
add wave -noupdate /memory_tb/M0/rw
add wave -noupdate /memory_tb/M0/enable
add wave -noupdate /memory_tb/M0/busy
add wave -noupdate /memory_tb/M0/data_out
add wave -noupdate /memory_tb/M0/data
add wave -noupdate /memory_tb/M0/global_cur_addr
add wave -noupdate /memory_tb/M0/cyc_ctr
add wave -noupdate /memory_tb/M0/i
add wave -noupdate /memory_tb/M0/fd
add wave -noupdate /memory_tb/M0/status_read
add wave -noupdate /memory_tb/M0/status_write
add wave -noupdate /memory_tb/M0/blah
add wave -noupdate /memory_tb/M0/fd_in
add wave -noupdate /memory_tb/M0/str
add wave -noupdate /memory_tb/M0/mem
add wave -noupdate /memory_tb/M0/busy_r
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
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
WaveRestoreZoom {0 ps} {26 ps}
