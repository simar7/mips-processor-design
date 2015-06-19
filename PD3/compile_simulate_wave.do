# Quit current sim
quit -sim
# Compile Design
vlog *.v
# Load Design
vsim work.F_D_M_tb
# Set waveform
do pd3_waveform.do
# Run simulation
run 10000
