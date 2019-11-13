# For part 1 - B

dir_name=output_part_1

# comment this if you just drawing a graph

	# echo "Prepare the output directory"
	# rm -rf $dir_name/traces_b
	# mkdir $dir_name/traces_b


	# echo -e "\nAnalyzing Reno"
	# ./part1_run_tcp_in_various_cbr.sh Reno
	# echo -e "Done: Reno \n"

	# echo -e "\nAnalyzing Newreno"
	# ./part1_run_tcp_in_various_cbr.sh Newreno
	# echo -e "Done: Newreno \n"

	# echo -e "\nAnalyzing Vegas"
	# ./part1_run_tcp_in_various_cbr.sh Vegas
	# echo -e "Done: Vegas \n"

# drawing a graph using gnuplot
	echo -e "\nPlotting Avg Packet Loss"
	gnuplot -e "variant_='Reno'" part1-b_plot_packet_loss.plt 
	gnuplot -e "variant_='Newreno'" part1-b_plot_packet_loss.plt 
	gnuplot -e "variant_='Vegas'" part1-b_plot_packet_loss.plt 
	echo -e "Output at: $dir_name/"
	echo -e "Done\n"

	echo -e "\nPlotting Avg Bandwidth Usage"
	gnuplot -e "variant_='Reno'" part1-b_plot_avg_bw.plt 
	gnuplot -e "variant_='Newreno'" part1-b_plot_avg_bw.plt 
	gnuplot -e "variant_='Vegas'" part1-b_plot_avg_bw.plt 
	echo -e "Output at: $dir_name/"
	echo -e "Done\n"
	