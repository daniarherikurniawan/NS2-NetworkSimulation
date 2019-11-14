#Create a simulator object
set ns [new Simulator]

#Define different colors for data flows (for NAM)
$ns color 1 Blue
$ns color 2 Red
$ns color 3 Green

set queuing_algo [lindex $argv 0]

set output_file output_part_2/traces_b/$queuing_algo.nam

puts "file output : $$output_file"
puts "queuing_algo : $$queuing_algo"

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
set n6 [$ns node]
set n7 [$ns node]

# $ns simplex-link hnode0i hnode1i hbandwidthi hdelayi hqueue_typei
#Create links between the nodes
$ns duplex-link $n0 $n1 2Mb 10ms $queuing_algo

# BW for CBR
$ns duplex-link $n1 $n2 1.5Mb 10ms $queuing_algo

$ns duplex-link $n2 $n3 2Mb 10ms $queuing_algo
$ns duplex-link $n1 $n4 2Mb 10ms $queuing_algo
$ns duplex-link $n2 $n5 2Mb 10ms $queuing_algo
$ns duplex-link $n6 $n1 2Mb 10ms $queuing_algo
$ns duplex-link $n2 $n7 2Mb 10ms $queuing_algo

#Set Queue Size of link (n2-n3) to 10
$ns queue-limit $n1 $n2 20

#Give node position (for NAM)
$ns duplex-link-op $n2 $n3 orient right-up
$ns duplex-link-op $n2 $n5 orient right-down
$ns duplex-link-op $n0 $n1 orient right-down
$ns duplex-link-op $n4 $n1 orient right-up
$ns duplex-link-op $n1 $n2 orient center
$ns duplex-link-op $n1 $n6 orient left
$ns duplex-link-op $n2 $n7 orient right

#Monitor the queue for link (n2-n3). (for NAM)
$ns duplex-link-op $n1 $n2 queuePos 0.5

# N0 --- N3
	#Setup a UDP connection
	set udp_1 [new Agent/UDP]
	$ns attach-agent $n0 $udp_1

	set null [new Agent/Null]
	$ns attach-agent $n3 $null
	$ns connect $udp_1 $null
	$udp_1 set fid_ 1

	#Setup a CBR over UDP connection
	set cbr_1 [new Application/Traffic/CBR]
	$cbr_1 attach-agent $udp_1
	$cbr_1 set type_ CBR
	$cbr_1 set packet_size_ 1000
	# CBR rate
	$cbr_1 set rate_ 1mb
	$cbr_1 set random_ false

# N4 --- N5
	#Setup a UDP connection
	set udp_2 [new Agent/UDP]
	$ns attach-agent $n4 $udp_2

	set null [new Agent/Null]
	$ns attach-agent $n5 $null
	$ns connect $udp_2 $null
	$udp_2 set fid_ 2

	#Setup a CBR over UDP connection
	set cbr_2 [new Application/Traffic/CBR]
	$cbr_2 attach-agent $udp_2
	$cbr_2 set type_ CBR
	$cbr_2 set packet_size_ 1000
	# CBR rate
	$cbr_2 set rate_ 1mb
	$cbr_2 set random_ false


# N6 --- N7
	#Setup a UDP connection
	set udp_3 [new Agent/UDP]
	$ns attach-agent $n6 $udp_3

	set null [new Agent/Null]
	$ns attach-agent $n7 $null
	$ns connect $udp_3 $null
	$udp_3 set fid_ 3

	#Setup a CBR over UDP connection
	set cbr_3 [new Application/Traffic/CBR]
	$cbr_3 attach-agent $udp_3
	$cbr_3 set type_ CBR
	$cbr_3 set packet_size_ 500
	# CBR rate
	$cbr_3 set rate_ 0.6mb
	$cbr_3 set random_ false


#Schedule events for the CBR and FTP agents
$ns at 0.0 "$cbr_1 start"
$ns at 0.1 "$cbr_2 start"
$ns at 0.2 "$cbr_3 start"
$ns at 4.3 "$cbr_3 stop"
$ns at 4.4 "$cbr_2 stop"
$ns at 4.5 "$cbr_1 stop"

#Detach tcp and sink agents (not really necessary)
# $ns at 4.5 "$ns detach-agent $n0 $tcp ; $ns detach-agent $n3 $sink"

#Call the finish procedure after 5 seconds of simulation time
$ns at 5.0 "finish"

#Print CBR packet size and interval
# puts "CBR packet size = [$cbr set packet_size_]"
puts "Trace generated!"

#Run the simulation
$ns run