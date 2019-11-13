set term postscript eps color 25 font ",35"
set title variant_
#set title 'Throughput '.variant_

set ylabel 'Packet number (Mod 60)' offset 1,0,0
set xlabel 'Time (s)'
set xrange [0:4.5]
set yrange [0:60]

#set key samplen 4

set size 1, 1

#set xtic 0.5
#set ytics ("0" 0.0, ".2" 0.2, ".4" 0.4, ".6" 0.6, ".8" 0.8, "1" 1.0)
set key top left

set terminal pdf
set output "output_part_2/graph-a_throughput-".variant_.".pdf"

plot \
'output_part_2/dataplot-'.variant_.'-sent.dat' u 2:1  notitle ls 7 ps 0.2 lc  rgb 'black', \
'output_part_2/dataplot-'.variant_.'-ack.dat' u 2:1 	notitle ls 7 ps 0.1 lc  rgb 'grey',\
'output_part_2/dataplot-'.variant_.'-drop.dat' u 2:1 notitle		lt 3 ps 0.7 lc  rgb 'red', \


#title 'sent'
#title 'ack'
#title 'dropped'