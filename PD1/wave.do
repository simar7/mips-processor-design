onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /memory/clock
add wave -noupdate /memory/address
add wave -noupdate /memory/data_in
add wave -noupdate /memory/access_size
add wave -noupdate /memory/rw
add wave -noupdate /memory/enable
add wave -noupdate /memory/busy
add wave -noupdate /memory/data_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {99273 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
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
WaveRestoreZoom {99050 ps} {100050 ps}