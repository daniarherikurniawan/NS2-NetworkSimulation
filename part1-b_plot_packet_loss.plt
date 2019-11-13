set term postscript eps color 25 font ",35"
set title variant_

set ylabel 'Packet-Loss rate (%)' offset 1,0,0
set xlabel 'CBR rate (Mb)'
set xrange [3:13]
# set yrange [1:5]

set key samplen 4

set size 1, 1

#set xtic 0.5
#set ytics ("0" 0.0, ".2" 0.2, ".4" 0.4, ".6" 0.6, ".8" 0.8, "1" 1.0)
set key top left

set terminal pdf
set output "output_part_1/graph-b_loss_rate_".variant_.".pdf"

plot \
'output_part_1/dataplot-'.variant_.'.dat' u 7:5 title variant_.' / TCP(N1-N4)'		w l 	lw 3 dt 5 lt 1 lc  rgb 'red', \
'output_part_1/dataplot-'.variant_.'.dat' u 7:6 title 'UDP(N2-N3)'		w l 	lw 3 dt 2 lt 1 lc  rgb 'blue',\


