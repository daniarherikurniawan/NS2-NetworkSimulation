set term postscript eps color 25 font ",32"
#set title "Figure 7 "

set ylabel 'CDF' offset 1,0,0
set xlabel 'Stdev over mean of server-side delay'
set xrange [0:2.2]
# set yrange [1:5]

set key samplen 3

set size 1.17, 0.7

set xtic 0.5
set ytics ("0" 0.0, ".2" 0.2, ".4" 0.4, ".6" 0.6, ".8" 0.8, "1" 1.0)
set key bottom right

set output '../eps/tes.eps'

plot \
'../dat/tes2.dat' u 2:($3/1440)	title "Page Type 1"		w l 	lw 6 dt 4 lt 1 lc  rgb 'blue', \
'../dat/tes1.dat' u 2:($3/1440)	title "Page Type 2"		w l 	lw 6 lt 1 lc  rgb '#cc66ff', \
'../dat/tes3.dat' u 2:($3/1440)	title "Page Type 3"		w l 	lw 6 dt 3 lt 1 lc  rgb '#ff0000', \
