set term postscript eps color 25 font ",35"
set title queuing_algo_." Queue"

set ylabel 'Latency (ms)' offset -1,0,0
set xlabel 'Time(s)'
set xrange [0:4.5]
set yrange [0:150]

set key samplen 4

set size 0.8, 0.8

#set xtic 0.5
#set ytics ("0" 0.0, ".2" 0.2, ".4" 0.4, ".6" 0.6, ".8" 0.8, "1" 1.0)
set key bottom right

set terminal pdf
set output "output_part_2/graph-b_latency_".queuing_algo_.".pdf"

plot \
'output_part_2/dataplot_b/dataplot-'.queuing_algo_.'-UDP_1-latency.dat' u 2:($3*1000) title 'UDP_1'		w l 	lw 1 dt 1 lt 1 lc  rgb 'red', \
'output_part_2/dataplot_b/dataplot-'.queuing_algo_.'-UDP_2-latency.dat' u 2:($3*1000) title 'UDP_2'		w l 	lw 1 dt 1 lt 1 lc  rgb 'blue',\
'output_part_2/dataplot_b/dataplot-'.queuing_algo_.'-UDP_3-latency.dat' u 2:($3*1000) title 'UDP_3'		w l 	lw 1 dt 1 lt 1 lc  rgb 'green', \

