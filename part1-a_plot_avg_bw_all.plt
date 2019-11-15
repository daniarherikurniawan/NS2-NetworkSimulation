set term postscript eps color 25 font ",35"
set title 'Average Bandwidth of All Variants'

set ylabel 'Avg BW (Mbps)' offset 1,0,0
set xlabel 'CBR rate (Mb)'
set xrange [3:13]
# set yrange [1:5]

set key samplen 4

set size 0.8, 0.8

#set xtic 0.5
#set ytics ("0" 0.0, ".2" 0.2, ".4" 0.4, ".6" 0.6, ".8" 0.8, "1" 1.0)
set key bottom right

set terminal pdf
set output "output_part_1/graph-a_avg_bw_all_variants.pdf"

plot \
'output_part_1/dataplot-Newreno-Vegas.dat' u 10:(($4+$5+$6)/3) title 'Newreno-Vegas' w l 	lw 2 dt 1 lt 1 lc  rgb 'green', \
'output_part_1/dataplot-Vegas-Vegas.dat' u 10:(($4+$5+$6)/3) title 'Vegas-Vegas'	w l 	lw 2 dt 3 lt 1 lc  rgb 'black', \
'output_part_1/dataplot-Newreno-Reno.dat' u 10:(($4+$5+$6)/3) title 'Newreno-Reno'  w l 	lw 2 dt 2 lt 1 lc  rgb 'blue',\
'output_part_1/dataplot-Reno-Reno.dat' u 10:(($4+$5+$6)/3) title 'Reno-Reno' 		w l 	lw 2 dt 5 lt 1 lc  rgb 'red', \

