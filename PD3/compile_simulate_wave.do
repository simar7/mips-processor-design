# Quit current sim
quit -sim
# Compile Design
vlog *.v
# Load Design
vsim work.F_D_X_M_W_tb
# Set watchfile and waveform
do FDXMW_wave.do
# Run simulation
run 10000 
