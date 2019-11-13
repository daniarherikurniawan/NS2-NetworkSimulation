# For part 1 - B

# Generate the ns2 output for each tcp variants
dir_name=output_part_1

dataplot_name="dataplot-$1.dat"

echo -e "#tcp_1(B) \t #cbr_2_1(B) \t tcp_1_BW(Mbps)\t \t cbr_2_BW(Mbps)\t \t drop_1(%) \t drop_2(%) \t cbr_rate(Mb)" > $dir_name/$dataplot_name

for (( i = 3; i < 14; i++ )); do
	echo ""
	echo "Generate the traces for $i.0mb and $i.5mb CBR's BW"
	for (( j = 0; j <= 5; j=j+5 )); do
		# execute ns2 script
		ns part1_b.tcl $i.$j $1 
		traces_name="$1-"$i"."$j"mb.nam"

		# analyze traces to get BW and packet-loss rate 
		awk '{if ($1=="r" && $7==3 && $17==1 && $9=="tcp") {a += $11} else if ($1=="r" && $7==2 && $17==2 && $9=="cbr") {b += $11}  else if ($1=="+" && $5==0 && $9=="tcp" && $17==1 ) {a_sent += 1} else if ($1=="+" && $5==1 && $9=="cbr" && $17==2 ) {b_sent += 1} else if ($1=="d" && $9=="tcp" && $17==1 ) {a_dropped += 1} else if ($1=="d" && $9=="cbr" && $17==2 ) {b_dropped += 1} } END { if(a_sent==0){a_sent=1}; if(b_sent==0) {b_sent=1}; printf ("%d \t%d \t%.2f \t%.2f \t%.3f \t%.3f \t",a,b, 8*a/4/1000000, 8*b/4.4/1000000, (a_dropped/(a_sent))*100, (b_dropped/(b_sent))*100)}' $dir_name/traces_b/$traces_name >> $dir_name/$dataplot_name

		# append the cbr_rate
		echo $i"."$j >> $dir_name/$dataplot_name
		
		# stop at 13.0
		if [[ $i == 13 ]]; then
			break
		fi
	done
done
