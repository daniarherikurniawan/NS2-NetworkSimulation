set term postscript eps color 25 font ",35"
set title variant_1.' / '.variant_2

set ylabel 'Packet-Loss rate (%)' offset 1,0,0
set xlabel 'CBR rate (Mb)'
set xrange [3:13]
# set yrange [1:5]

set key samplen 4

set size 0.8, 0.8

#set xtic 0.5
#set ytics ("0" 0.0, ".2" 0.2, ".4" 0.4, ".6" 0.6, ".8" 0.8, "1" 1.0)
set key top left

set terminal pdf
set output "output_part_1/graph-a_loss_rate_".variant_1."-".variant_2.".pdf"

plot \
'output_part_1/dataplot-'.variant_1."-".variant_2.'.dat' u 10:7 title variant_1.' / TCP(N1-N4)'		w l 	lw 3 dt 5 lt 1 lc  rgb 'red', \
'output_part_1/dataplot-'.variant_1."-".variant_2.'.dat' u 10:8 title 'UDP(N2-N3)'		w l 	lw 3 dt 2 lt 1 lc  rgb 'blue',\
'output_part_1/dataplot-'.variant_1."-".variant_2.'.dat' u 10:9 title variant_2.' / TCP(N5-N6)'		w l 	lw 3 dt 1 lt 1 lc  rgb 'green', \

