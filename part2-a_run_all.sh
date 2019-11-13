# For part 1 - A

dir_name=output_part_2

# comment this if you just drawing a graph

	# echo "Prepare the output directory"
	# rm -rf $dir_name/traces_a
	# mkdir $dir_name/traces_a

	# echo -e "Starting!\n"
	# ns part2_a.tcl DropTail Reno TCPSink
	# ns part2_a.tcl DropTail Sack1 TCPSink/Sack1
	# ns part2_a.tcl RED Reno TCPSink
	# ns part2_a.tcl RED Sack1 TCPSink/Sack1
	# echo -e "Done generating the traces!\n"

# Analyze the traces using AWK
	# echo -e "Analyzing DropTail-Reno traces!"
	# ./part2-a_analyze.sh DropTail-Reno
	# echo -e "Analyzing DropTail-Sack1 traces!"
	# ./part2-a_analyze.sh DropTail-Sack1
	# echo -e "Analyzing RED-Reno traces!"
	# ./part2-a_analyze.sh RED-Reno
	# echo -e "Analyzing RED-Sack1 traces!"
	# ./part2-a_analyze.sh RED-Sack1
	# echo -e "Done generating the dataplot!\n"

# drawing a graph using gnuplot
	echo -e "\nPlotting Throughput (packet number vs time)"
	gnuplot -e "variant_='DropTail-Reno'" part2-a_plot_throughput.plt 
	gnuplot -e "variant_='DropTail-Sack1'" part2-a_plot_throughput.plt 
	gnuplot -e "variant_='RED-Reno'" part2-a_plot_throughput.plt 
	gnuplot -e "variant_='RED-Sack1'" part2-a_plot_throughput.plt 
	echo -e "Output at: $dir_name/"
	echo -e "Done\n"