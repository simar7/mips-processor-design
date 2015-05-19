onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /memory_tb/M0/clock
add wave -noupdate /memory_tb/M0/address
add wave -noupdate /memory_tb/M0/data_in
add wave -noupdate /memory_tb/M0/access_size
add wave -noupdate /memory_tb/M0/rw
add wave -noupdate /memory_tb/M0/enable
add wave -noupdate /memory_tb/M0/busy
add wave -noupdate /memory_tb/M0/data_out
add wave -noupdate /memory_tb/M0/mem
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {13 ps} 0}
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
