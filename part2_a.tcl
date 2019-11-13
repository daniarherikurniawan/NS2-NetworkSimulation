#Create a simulator object
set ns [new Simulator]

#Define different colors for data flows (for NAM)
$ns color 1 Blue
$ns color 2 Red
# $ns color 3 Green

set cbr_rate 1mb

set queuing_algo [lindex $argv 0]
set tcp_agent_1 [lindex $argv 1]
set tcp_sink [lindex $argv 2]

set output_file output_part_2/traces_a/$queuing_algo-$tcp_agent_1.nam

puts "file output : $$output_file"
puts "queuing_algo : $$queuing_algo"
puts "tcp_agent_1 : $$tcp_agent_1"
puts "tcp_sink : $$tcp_sink"

# exit 0

#Open the NAM trace file
set nf [open $output_file w]
$ns namtrace-all $nf

#Define a 'finish' procedure
proc finish {} {
    global ns nf
    $ns flush-trace
    #Close the NAM trace file
    close $nf
    #Execute NAM on the trace file
    # exec nam $output_file &
    exit 0
}

#Create four nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]

# $ns simplex-link hnode0i hnode1i hbandwidthi hdelayi hqueue_typei
#Create links between the nodes
$ns duplex-link $n0 $n1 2Mb 10ms $queuing_algo

# BW for CBR
$ns duplex-link $n1 $n2 1.5Mb 10ms $queuing_algo

$ns duplex-link $n2 $n3 2Mb 10ms $queuing_algo
$ns duplex-link $n1 $n4 2Mb 10ms $queuing_algo
$ns duplex-link $n2 $n5 2Mb 10ms $queuing_algo

#Set Queue Size of link (n2-n3) to 10
$ns queue-limit $n1 $n2 20

#Give node position (for NAM)
$ns duplex-link-op $n2 $n3 orient right-up
$ns duplex-link-op $n2 $n5 orient right-down
$ns duplex-link-op $n0 $n1 orient right-down
$ns duplex-link-op $n4 $n1 orient right-up
$ns duplex-link-op $n1 $n2 orient center

#Monitor the queue for link (n2-n3). (for NAM)
$ns duplex-link-op $n1 $n2 queuePos 0.5

# N0 --- N3
	#Setup a TCP connection
	set tcp [new Agent/TCP/$tcp_agent_1]
	$tcp set class_ 2
	$ns attach-agent $n0 $tcp

	set sink [new Agent/$tcp_sink]
	$ns attach-agent $n3 $sink
	$ns connect $tcp $sink
	$tcp set fid_ 1

	#Setup a FTP over TCP connection
	set ftp [new Application/FTP]
	$ftp attach-agent $tcp
	$ftp set type_ FTP

# N4 --- N5
	#Setup a UDP connection
	set udp [new Agent/UDP]
	$ns attach-agent $n4 $udp

	set null [new Agent/Null]
	$ns attach-agent $n5 $null
	$ns connect $udp $null
	$udp set fid_ 2

	#Setup a CBR over UDP connection
	set cbr [new Application/Traffic/CBR]
	$cbr attach-agent $udp
	$cbr set type_ CBR
	$cbr set packet_size_ 500
	# CBR rate
	$cbr set rate_ $cbr_rate
	$cbr set random_ false


#Schedule events for the CBR and FTP agents
$ns at 0.1 "$ftp start"
$ns at 0.3 "$cbr start"
$ns at 4.3 "$cbr stop"
$ns at 4.5 "$ftp stop"

#Detach tcp and sink agents (not really necessary)
$ns at 4.5 "$ns detach-agent $n0 $tcp ; $ns detach-agent $n3 $sink"

#Call the finish procedure after 5 seconds of simulation time
$ns at 5.0 "finish"

#Print CBR packet size and interval
puts "CBR packet size = [$cbr set packet_size_]"
puts "CBR interval = [$cbr set interval_]"

#Run the simulation
$ns run