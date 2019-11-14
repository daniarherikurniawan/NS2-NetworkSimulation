set term postscript eps color 25 font ",35"
set title 'Average Latency'

set ylabel 'Latency (ms)' offset -1,0,0
set xlabel 'Time(s)'
set xrange [0:4.5]
set yrange [0:150]

set key samplen 4

set size 1, 1

#set xtic 0.5
#set ytics ("0" 0.0, ".2" 0.2, ".4" 0.4, ".6" 0.6, ".8" 0.8, "1" 1.0)
set key bottom right

set terminal pdf
set output "output_part_2/graph-b_avg_latency.pdf"

plot \
'output_part_2/dataplot_b/dataplot-DropTail-avg-latency.dat' u 1:2 title 'DropTail'		w l 	lw 2 dt 1 lt 1 lc  rgb 'red', \
'output_part_2/dataplot_b/dataplot-RED-avg-latency.dat' u 1:2 title 'RED'		w l 	lw 2 dt 1 lt 1 lc  rgb 'blue',\

