HW: http://people.cs.uchicago.edu/~ravenben/classes/333/hw1.html

Running

	cd ~/Project/NS2-BenZhao/
	ns simple.tcl



Desc:
	 analyze the performance of these different TCP variants.
	 	(TCP Tahoe, Reno, NewReno, Vegas and SACK)
	 	under various load conditions and queuing algorithms.
	 practice performance evaluation
	 	read the paper: "Simulation-based Comparisons of Tahoe, Reno and SACK TCP" (PDF) 
	 		to understand what type of analysis you are required to do.

Part 1:

                         N0                      N3
                           \                    /
                            \                  /
                             N1--------------N2
                            /                  \
                           /                    \
                         N4                      N5


	TCP variants (Reno, NewReno, and Vegas)
		various load conditions and queuing algorithms.
		 in the presence of a Constant Bit Rate (CBR)

	set up a network topology. Use the following topology with 10Mbits on all links.

     Graph the average packet loss rate and the average bandwidth used by all three flows

     	Maybe my packet size is to small (bytes) since I have 10 Mbits BW


     	change the bandwidth on N1-N2 and count the #packetLoss 
     		using the maxSeq_
     			http://intronetworks.cs.luc.edu/current/html/ns2.html#equal-delays 
     				section 16.2.2

    Script:

ns part1_a.tcl 3.0mb Reno Reno
ns part1_a.tcl 3.5mb Reno Reno
...
ns part1_a.tcl 8.0mb Reno Reno
ns part1_a.tcl 8.5mb Reno Reno

ns part1_a.tcl 3.0mb Newreno Reno
ns part1_a.tcl 3.5mb Newreno Reno
...
ns part1_a.tcl 8.0mb Vegas Vegas
ns part1_a.tcl 8.5mb Vegas Vegas


    	Graph the average packet loss rate and the average bandwidth used by all three flows as a function of the bandwidth used by the CBR flow. 

    	That is, the CBR flow is the parameter you need to vary for this experiment. You must repeat the experiment using the following TCP variants (one variant creating traffic from N1 to N4, and the other creating traffic from N5 to N6):
			Reno/Reno
			NewReno/Reno
			Vegas/Vegas
			NewReno/Vegas


use awk to get packet loss perfile

get total bytes transfered
	tcp received by node 3 (flow id 1)
		awk '$1=="r" && $7==3 && $17==1 && $9=="tcp" {a += $11} END {print a " bytes"}' output_part_1/Reno-Reno-6.0mb.nam
	
	udp received by node 2 (flow id 2)
		awk '$1=="r" && $7==2 && $17==2 && $9=="cbr" {a += $11} END {print a " bytes"}' output_part_1/Reno-Reno-6.0mb.nam

	tcp received by node 5 (flow id 3)
		awk '$1=="r" && $7==5 && $17==3 && $9=="tcp" {a += $11} END {print a " bytes"}' output_part_1/Reno-Reno-6.0mb.nam

	>>> 1385320+1650000+1386360
	4421680
	>>> 4421680/4.4
	1004927.2727272726
	Average BW = 1004927 bytes/s 
			   = 1Mbps 

	combine total bytes sent + BW
		awk '{if ($1=="r" && $7==3 && $17==1 && $9=="tcp") {a += $11} else if ($1=="r" && $7==2 && $17==2 && $9=="cbr") {b += $11} else if ($1=="r" && $7==5 && $17==3 && $9=="tcp") {c += $11}} END {printf (" tcp 1 :\t%d B\n cbr   :\t%d B\n tcp 2 :\t%d B\n total :\t%d B\n tcp ratio:\t%.4f \n cbr ratio:\t%.4f\n Avg BW   :\t%.1f MBps\n", a, b, c, a+b+c, (a+c)/(a+b+c), b/(a+b+c), (a+b+c)/4.4/1000000 )}' output_part_1/Reno-Reno-6.0mb.nam

	average packet loss rate
		number of packet loss
			awk '$1=="d" {a += 1} END {print a " packets"}' output_part_1/Reno-Reno-6.0mb.nam
		
		total packet sent
			awk '$1=="h" && $15>a {a = $15} END {print a " packets"}' output_part_1/Reno-Reno-6.0mb.nam

		loss rate
			awk '{if ($1=="d") {dropped += 1} else if ($1=="h" && $15>sent) {sent = $15}} END {printf (" #packets :\t%d\n #dropped :\t%d\n rate     :\t%.3f %% \n", sent, dropped, (dropped/sent)*100)}' output_part_1/Reno-Reno-6.0mb.nam

	Combine all part1_a
	<!-- raw version -->
		awk '{if ($1=="r" && $7==3 && $17==1 && $9=="tcp") {a += $11} else if ($1=="r" && $7==2 && $17==2 && $9=="cbr") {b += $11} else if ($1=="r" && $7==5 && $17==3 && $9=="tcp") {c += $11} else if ($1=="d") {dropped += 1} else if ($1=="h" && $15>sent) {sent = $15} } END {printf (" tcp_1(B) :\t%d \n cbr(B)   :\t%d \n tcp_2(B) :\t%d \n total(B) :\t%d \n tcp_ratio:\t%.4f \n cbr_ratio:\t%.4f\n Avg_BW(MBps):\t%.1f \n #packets :\t%d\n #dropped :\t%d\n rate(%%)  :\t%.3f \n", a, b, c, a+b+c, (a+c)/(a+b+c), b/(a+b+c), (a+b+c)/4.4/1000000, sent, dropped, (dropped/sent)*100 )}' output_part_1/Reno-Reno-6.0mb.nam

	<!-- clean version -->

		echo -e "Avg_BW(MBps)\trate(%)\tcbr(Mb)" >> dataplot-reno-reno.txt
		cbr_rate=6.5
		awk '{if ($1=="r" && $7==3 && $17==1 && $9=="tcp") {a += $11} else if ($1=="r" && $7==2 && $17==2 && $9=="cbr") {b += $11} else if ($1=="r" && $7==5 && $17==3 && $9=="tcp") {c += $11} else if ($1=="d") {dropped += 1} else if ($1=="h" && $15>sent) {sent = $15} } END {printf ("%.1f \t%.3f \t", (a+b+c)/4.4/1000000, (dropped/sent)*100 )}' output_part_1/Reno-Reno-6.0mb.nam >> dataplot-reno-reno.txt

		echo $cbr_rate >> dataplot-reno-reno.txt

awk '{
if ($1== "d" && $7==3 && $17==1 && $9=="tcp") 
	{a += $11} 
else if ($1== "r" && $7==3 && $17==2 && $9=="cbr") 
	{b += $11}
} 
END {
	printf (" 
		tcp:\t%d\n 
		cbr:\t%d\n 
		total:\t%d\n 
		tcp ratio:\t%.4f \n 
		cbr ratio:\t%.4f\n", a, b, a+b, a/(a+b), b/(a+b))
}' 
task1_out.nam


awk '$1=="d" && $7==3 && $17==1 && $9=="tcp" {a += $11} END {print a}' task1_out.nam


Next, remove one TCP stream and analyze how a single flow of each TCP variant reacts to an increasing CBR flow. Perform the experiments with Reno, NewReno, and Vegas.

Final script:

./part1-a_run_all.sh
./part1-b_run_all.sh




Part 2:
	TCP variants (Reno, NewReno, and Vegas)
		under the influence of two different queuing disciplines (DropTail and RED).

	1. 
		Use the same topology from Part1 
			and have one TCP flow (N1-N4) and one CBR/UDP (N5-N6) flow. 

		First, start the TCP flow. Once the TCP flow is steady, 
			start the CBR source 

	ns part2_a.tcl DropTail Reno TCPSink
	ns part2_a.tcl DropTail Sack1 TCPSink/Sack1
	ns part2_a.tcl RED Reno TCPSink
	ns part2_a.tcl RED Sack1 TCPSink/Sack1

	TCP/Reno
		Agent/TCPSink

	TCP/Sack1
		TCPSink/Sack1

		and analyze how the TCP and CBR flows 
			under these queuing algorithms: DropTail and RED. 
			
			study the influence of the queuing discipline used at the node on the overall throughput.

			each TCP variant
				packet-loss rate??
				avg bw rate??


		Perform the experiments with TCP Reno and SACK. 

	Parse the trace to get packet_id send by sender
		separate the ack recceived on another file

		then plot the packet_id+ack vs time

dir_name=output_part_2
traces_name="DropTail-Reno"
dataplot_name="dataplot-"$traces_name".dat"
awk '{if ($1=="+" && $5==0 && $9=="tcp") {count += 1; printf("\n"$0) } } END { printf ("%d \t", count )}' $dir_name/traces_a/$traces_name.nam >> $dir_name/$dataplot_name


dir_name=output_part_2
traces_name="DropTail-Reno"
dataplot_name="dataplot-"$traces_name".dat"
awk '{if ($1=="+" && $5==0 && $9=="tcp") {count += 1; printf(count"\t"$3"\t"$11"\t"$15"\n") } } END {}' $dir_name/traces_a/$traces_name.nam > $dir_name/"dataplot-"$traces_name"-sent.dat"
awk '{if ($1=="r" && $7==0 && $9=="ack") {count += 1; printf(count"\t"$3"\t"$11"\t"$15"\n") } } END {}' $dir_name/traces_a/$traces_name.nam > $dir_name/"dataplot-"$traces_name"-ack.dat"
awk '{if ($1=="d" && $9=="tcp" && $17==1) {count += 1; printf(count"\t"$3"\t"$11"\t"$15"\n") } } END {}' $dir_name/traces_a/$traces_name.nam > $dir_name/"dataplot-"$traces_name"-drop.dat"


The goodput of a TCP connection is, properly, the number of application bytes received. This differs from the throughput – the total bytes sent – in two ways: the latter includes both packet headers and retransmitted packets. The ack0 value above includes no retransmissions; we will occasionally refer to it as “goodput” in this sense.

So, throughput includes both packet headers and retransmitted packets. 





throughput

	Only consider the delivered/received packet!

	This drop in throughput is due to the sliding window protocols used for acknowledgment of received packets. In certain variants of TCP, if a transmitted packet is lost, it will be re-sent along with every packet that had been sent after it. This retransmission causes the overall throughput of the connection to drop.

	Throughput is defined as the quantity of data being sent/received by unit of time

	Mbps 
		can change per second 
	Maybe should plot the graph like in goodputratio
		16.3.4.2   Two-sender phase effects
		16.3.10   Raising the Bandwidth
			http://intronetworks.cs.luc.edu/current/html/ns2.html#equal-delays

		checkout
			Packet number vs time
				Figure 4: Simulations with three dropped packets.
	
			http://people.cs.uchicago.edu/~ravenben/classes/333/tcp-sim.pdf





Other queue objects derived from the base class Queue are drop-tail, FQ, SFQ, DRR, RED and CBQ queue objects. Each are


The one-way TCP sending agents currently supported are:

• Agent/TCP - a “tahoe” TCP sender
• Agent/TCP/Reno - a “Reno” TCP sender
• Agent/TCP/Newreno - Reno with a modification
• Agent/TCP/Sack1 - TCP with selective repeat (follows RFC2018)
• Agent/TCP/Vegas - TCP Vegas
• Agent/TCP/Fack - Reno TCP with “forward acknowledgment”
• Agent/TCP/Linux - a TCP sender with SACK support that runs TCP congestion control modules from Linux kernel

The one-way TCP receiving agents currently supported are:

• Agent/TCPSink - TCP sink with one ACK per packet
• Agent/TCPSink/DelAck - TCP sink with configurable delay per ACK
• Agent/TCPSink/Sack1 - selective ACK sink (follows RFC2018)
• 


		Answer the following questions for Reno and for SACK:
Simulate the following scenario under two queuing algorithms: One TCP flow (test with Reno and SACK) sending 1000 bytes packets, and one UDP flow sending 500 bytes packets at a rate of 1 Mbps. The middle link they are sharing is a 1.5Mbps link. How do results change? Why?


















Agent classes:

	TCP a “Tahoe” TCP sender (cwnd = 1 on any loss)
	TCP/Reno a “Reno” TCP sender (with fast recovery)
	TCP/Newreno a modified Reno TCP sender 
	TCP/Sack1 a SACK TCP sender
	TCP/Fack a “forward” SACK sender TCP
	TCP/FullTcp a TCP with 2-way traffic
	TCP/Vegas a “Vegas” TCP sender
	TCP/Vegas/RBP a Vegas TCP with “rate based pacing”
	TCP/Vegas/RBP a Reno TCP with “rate based pacing”
	TCP/Asym a Tahoe TCP for asymmetric links
	TCP/Reno/Asym a Reno TCP for asymmetric links
	TCP/Newreno/Asym a Newreno TCP for asymmetric links
	TCPSink a Reno or Tahoe TCP receiver (not for FullTcp)
	TCPSink/DelAck a TCP delayed-ACK receiver
	TCPSink/Asym a TCP sink for asymmetric links
	TCPSink/Sack1 a SACK TCP receiver
	TCPSink/Sack1/DelAck a delayed-ACK SACK TCP receiver


TCP objects 

	https://www.isi.edu/nsnam/ns/doc/ns_doc.pdf 
		page 108

	dupacks_ Number of duplicate acks seen since any new data was acknowledged.
	seqno_ Highest sequence number for data from data source to TCP.
	t_seqno_ Current transmit sequence number.
	ack_ Highest acknowledgment seen from receiver. 
	cwnd_ Current value of the congestion window.
	awnd_ Current value of a low-pass filtered version of the congestion window. For investigations of different windowincrease algorithms.
	ssthresh_ Current value of the slow-start threshold.
	rtt_ Round-trip time estimate.
	srtt_ Smoothed round-trip time estimate.
	rttvar_ Round-trip time mean deviation estimate.
	backoff_ Round-trip time exponential backoff constant.

	about cwnd_ and ssthresh_ 
		https://blog.stackpath.com/glossary-cwnd-and-rwnd/

		1. Congestion window with an initial value of one maximum segment size (MSS) and
		2. the slow start threshold value (ssthresh) with an initial value equal to the receiver window.
		
		The congestion window increases exponentially during congestion control, and lineally during the congestion avoidance. In the example below, slow start occurs when cwnd < ssthresh and congestion avoidance occurs when cwnd >= ssthresh

NAM trace format
	https://www.isi.edu/nsnam/ns/doc/ns_doc.pdf
		page 411

	<type> -t <time> -e <extent> -s <source id> -d <destination id> -c <conv> -i <id>
		<type> is one of:

	h Hop: The packet started to be transmitted on the link from <source id> to <destination id> and is forwarded to the next hop.
	r Receive: The packet finished transmission and started to be received at the destination.
	d Drop: The packet was dropped from the queue or link from <source id> to <destination id>. Drop here doesn’t distinguish between dropping from queue or link. This is decided by the drop time.
	+ Enter queue: The packet entered the queue from <source id> to <destination id>.
	- Leave queue: The packet left the queue from <source id> to <destination id>.
	

	-t <time> is the time the event occurred.
	-s <source id> is the originating node.
	-d <destination id> is the destination node.
	-p <pkt-type> is the descriptive name of the type of packet seen. See section 26.5 for the different types of packets supported in ns.
	-e <extent> is the size (in bytes) of the packet.
	-c <conv> is the conversation id or flow-id of that session.
	-i <id> is the packet id in the conversation.
	-a <attr> is the packet attribute, which is currently used as color id.
	-x <src-na.pa> <dst-sa.na> <seq> <flags> <sname> is taken from ns-traces and it gives the source and destination node and port addresses, sequence number, flags (if any) and the type of message. For example -x {0.1 -2147483648.0
	
Trace Analysis
	http://nile.wpi.edu/NS/analysis.html

		cat out.tr | grep " 2 3 cbr " | grep ^r | column 1 10 | awk '{dif = $2 - old2; if(dif==0) dif = 1; if(dif > 0) {printf("%d\t%f\n", $2, ($1 - old1) / dif); old1 = $1; old2 = $2}}' > jitter.txt


Important:
	install: https://www.absingh.com/ns2/
	script : http://nile.wpi.edu/NS/simple_ns.html
	manual : https://www.isi.edu/nsnam/ns/ns-documentation.html

	https://sites.cs.ucsb.edu/~almeroth/classes/F05.276/topics/ns2.html

	complete graph	: http://intronetworks.cs.luc.edu/current/html/ns2.html





