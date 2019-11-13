# For part 1 - A

dir_name=output_part_1

# comment this if you just drawing a graph

	# echo "Prepare the output directory"
	# rm -rf $dir_name/traces_a
	# mkdir $dir_name/traces_a


	# echo -e "\nAnalyzing Reno vs Reno"
	# ./part1_run_tcp_variants.sh Reno Reno
	# echo -e "Done: Reno vs Reno\n"

	# echo -e "\nAnalyzing Newreno vs Reno"
	# ./part1_run_tcp_variants.sh Newreno Reno
	# echo -e "Done: Newreno vs Reno\n"

	# echo -e "\nAnalyzing Vegas vs Vegas"
	# ./part1_run_tcp_variants.sh Vegas Vegas
	# echo -e "Done: Vegas vs Vegas\n"

	# echo -e "\nAnalyzing Newreno vs Vegas"
	# ./part1_run_tcp_variants.sh Newreno Vegas
	# echo -e "Done: Newreno vs Vegas\n"

# drawing a graph using gnuplot
	echo -e "\nPlotting Avg Packet Loss"
	gnuplot -e "variant_1='Reno'; variant_2='Reno'" part1-a_plot_packet_loss.plt 
	gnuplot -e "variant_1='Newreno'; variant_2='Reno'" part1-a_plot_packet_loss.plt 
	gnuplot -e "variant_1='Newreno'; variant_2='Vegas'"  part1-a_plot_packet_loss.plt 
	gnuplot -e "variant_1='Vegas'; variant_2='Vegas'" part1-a_plot_packet_loss.plt 
	echo -e "Output at: $dir_name/"
	echo -e "Done\n"

	echo -e "\nPlotting Avg Bandwidth Usage"
	gnuplot -e "variant_1='Reno'; variant_2='Reno'" part1-a_plot_avg_bw.plt 
	gnuplot -e "variant_1='Newreno'; variant_2='Reno'" part1-a_plot_avg_bw.plt 
	gnuplot -e "variant_1='Newreno'; variant_2='Vegas'" part1-a_plot_avg_bw.plt 
	gnuplot -e "variant_1='Vegas'; variant_2='Vegas'" part1-a_plot_avg_bw.plt 
	echo -e "Output at: $dir_name/"
	echo -e "Done\n"
	# gnuplot part1-a_plot_avg_bw.plt 
	# pdf $dir_name/graph-a_avg_bw.pdf 
	# echo -e "Done\n"
