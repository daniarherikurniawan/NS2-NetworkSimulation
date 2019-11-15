set term postscript eps color 25 font ",35"
# set title variant_
set title type_.' Throughput ('.queuing_algo_.' queue and TCP '.variant_.')'

set ylabel 'Packet number (Mod 200)' offset 1,0,0
set xlabel 'Time (s)'
set xrange [0:4.5]
set yrange [0:200]

set key samplen 1 spacing 1 font ",11"

set size 0.8, 0.8

#set xtic 0.5
#set ytics ("0" 0.0, ".2" 0.2, ".4" 0.4, ".6" 0.6, ".8" 0.8, "1" 1.0)
set key top left

set terminal pdf
set output "output_part_2/graph-a_throughput-".variant_."-".type_.".pdf"

plot \
'output_part_2/dataplot_a/dataplot-'.queuing_algo_.'-'.variant_.'-'.type_.'-sent.dat' u 2:1  title 'sent' ls 7 ps 0.1 lc  rgb 'black', \
'output_part_2/dataplot_a/dataplot-'.queuing_algo_.'-'.variant_.'-'.type_.'-ack.dat' u 2:1 	title 'ack' ls 7 ps 0.1 lc  rgb 'grey',\
'output_part_2/dataplot_a/dataplot-'.queuing_algo_.'-'.variant_.'-'.type_.'-drop.dat' u 2:1 title 'dropped'		lt 2 lw 2 ps 0.7 lc  rgb 'red', \


#title 'sent'
#title 'ack'
#title 'dropped'