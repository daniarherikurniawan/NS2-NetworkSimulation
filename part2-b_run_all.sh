# For part 2 - B

dir_name=output_part_2

# comment this if you just drawing a graph

	# echo "Prepare the output directory"
	# rm -rf $dir_name/traces_b
	# mkdir $dir_name/traces_b

	# echo -e "Starting!\n"
	# ns part2_b.tcl DropTail
	# ns part2_b.tcl RED
	# echo -e "Done generating the traces!\n"

# Analyze the traces using AWK

	# rm -rf $dir_name/dataplot_b
	# mkdir $dir_name/dataplot_b

	# echo -e "Analyzing DropTail traces!"
	# ./part2-b_analyze.sh DropTail
	# echo -e "Analyzing RED traces!"
	# ./part2-b_analyze.sh RED

	# echo -e "Get the avg latency!"
	# python part2-b_get_avg_latency.py

	# echo -e "Done generating the dataplot!\n"


# drawing a graph using gnuplot

	# echo -e "\nPlotting Throughput (packet number vs time)"

	# gnuplot -e "queuing_algo_='DropTail'; type_='UDP_1' " part2-b_plot_throughput.plt 
	# gnuplot -e "queuing_algo_='DropTail'; type_='UDP_2' " part2-b_plot_throughput.plt 
	# gnuplot -e "queuing_algo_='DropTail'; type_='UDP_3' " part2-b_plot_throughput.plt 
	# gnuplot -e "queuing_algo_='RED'; type_='UDP_1' " part2-b_plot_throughput.plt 
	# gnuplot -e "queuing_algo_='RED'; type_='UDP_2' " part2-b_plot_throughput.plt 
	# gnuplot -e "queuing_algo_='RED'; type_='UDP_3' " part2-b_plot_throughput.plt 

	# echo -e "\nPlotting latency for each UDP link"
	# gnuplot -e "queuing_algo_='DropTail' " part2-b_plot_latency.plt 
	# gnuplot -e "queuing_algo_='RED' " part2-b_plot_latency.plt 

	echo -e "\nPlotting average latency for each queue algorithm"
	gnuplot part2-b_plot_avg_latency.plt 
	
	echo -e "Done"
	# echo -e "Output at: $dir_name/"
