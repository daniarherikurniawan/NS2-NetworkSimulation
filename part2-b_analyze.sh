# For part 2 - A

dir_name=output_part_2
queuing_algo=$1
dataplot_name="dataplot-"$queuing_algo".dat"

# UDP_1 data (N0 - N3)
awk '{if ($1=="+" && $5==0 && $9=="cbr") {count += 1; printf("%d \t %.4f \t %d \t %d\n",count % 200,$3,$11,$15) } } END {}' $dir_name/traces_b/$queuing_algo.nam > $dir_name/"dataplot_b/dataplot-"$queuing_algo"-UDP_1-sent.dat"

# There is no ack in udp, it just the received packets
awk '{ if ($1=="+" && $5==0 && $9=="cbr") {count += 1; sent_id[$15]=count} else if ($1=="r" && $7==3 && $9=="cbr") {printf("%d \t %.4f \t %d \t %d\n",sent_id[$15] % 200, $3,$11,$15) } }  END {}' $dir_name/traces_b/$queuing_algo.nam > $dir_name/"dataplot_b/dataplot-"$queuing_algo"-UDP_1-ack.dat"

awk '{ if ($1=="+" && $5==0 && $9=="cbr") {count += 1; time[$15] = $3; sent_id[$15]=count} else if ($1=="d" && $9=="cbr" && $17==1) { printf("%d \t %.4f \t %d \t %d\n",sent_id[$15] % 200,time[$15],$11,$15) } }  END {}' $dir_name/traces_b/$queuing_algo.nam > $dir_name/"dataplot_b/dataplot-"$queuing_algo"-UDP_1-drop.dat"

echo "Generating "$dir_name"/dataplot_b/dataplot-"$queuing_algo"-UDP_1-sent-acked.dat"

grep -Fvxf $dir_name/dataplot_b/dataplot-$queuing_algo-UDP_1-drop.dat $dir_name/dataplot_b/dataplot-$queuing_algo-UDP_1-sent.dat > $dir_name/dataplot_b/dataplot-$queuing_algo-UDP_1-sent-acked.dat

echo "Generating "$dir_name"/dataplot_b/dataplot-"$queuing_algo"-UDP_1-latency.dat"

paste  $dir_name/dataplot_b/dataplot-$queuing_algo-UDP_1-sent-acked.dat $dir_name/"dataplot_b/dataplot-"$queuing_algo"-UDP_1-ack.dat" | awk '{print $2, $6,($6-$2),$1}' > $dir_name"/dataplot_b/dataplot-"$queuing_algo"-UDP_1-latency.dat"


# UDP_2 data (N4 - N5)
awk '{if ($1=="+" && $5==4 && $9=="cbr") {count += 1; printf("%d \t %.4f \t %d \t %d\n",count % 200,$3,$11,$15) } } END {}' $dir_name/traces_b/$queuing_algo.nam > $dir_name/"dataplot_b/dataplot-"$queuing_algo"-UDP_2-sent.dat"

# There is no ack in udp, it just the received packets
awk '{ if ($1=="+" && $5==4 && $9=="cbr") {count += 1; sent_id[$15]=count} else if ($1=="r" && $7==5 && $9=="cbr") { printf("%d \t %.4f \t %d \t %d\n",sent_id[$15] % 200,$3,$11,$15) } }  END {}' $dir_name/traces_b/$queuing_algo.nam > $dir_name/"dataplot_b/dataplot-"$queuing_algo"-UDP_2-ack.dat"

awk '{ if ($1=="+" && $5==4 && $9=="cbr") {count += 1; time[$15] = $3; sent_id[$15]=count} else if ($1=="d" && $9=="cbr" && $17==2) { printf("%d \t %.4f \t %d \t %d\n",sent_id[$15] % 200,time[$15],$11,$15) } }  END {}' $dir_name/traces_b/$queuing_algo.nam > $dir_name/"dataplot_b/dataplot-"$queuing_algo"-UDP_2-drop.dat"

echo "Generating "$dir_name"/dataplot_b/dataplot-"$queuing_algo"-UDP_2-sent-acked.dat"

grep -Fvxf $dir_name/dataplot_b/dataplot-$queuing_algo-UDP_2-drop.dat $dir_name/dataplot_b/dataplot-$queuing_algo-UDP_2-sent.dat > $dir_name/dataplot_b/dataplot-$queuing_algo-UDP_2-sent-acked.dat

echo "Generating "$dir_name"/dataplot_b/dataplot-"$queuing_algo"-UDP_2-latency.dat"

paste  $dir_name/dataplot_b/dataplot-$queuing_algo-UDP_2-sent-acked.dat $dir_name/"dataplot_b/dataplot-"$queuing_algo"-UDP_2-ack.dat" | awk '{print $2, $6,($6-$2),$1}'> $dir_name"/dataplot_b/dataplot-"$queuing_algo"-UDP_2-latency.dat"

# UDP_3 data (N6 - N7)
awk '{if ($1=="+" && $5==6 && $9=="cbr") {count += 1; printf("%d \t %.4f \t %d \t %d\n",count % 200,$3,$11,$15) } } END {}' $dir_name/traces_b/$queuing_algo.nam > $dir_name/"dataplot_b/dataplot-"$queuing_algo"-UDP_3-sent.dat"

# There is no ack in udp, it just the received packets
awk '{ if ($1=="+" && $5==6 && $9=="cbr") {count += 1; sent_id[$15]=count} else if ($1=="r" && $7==7 && $9=="cbr") { printf("%d \t %.4f \t %d \t %d\n",sent_id[$15] % 200, $3,$11,$15) } }  END {}' $dir_name/traces_b/$queuing_algo.nam > $dir_name/"dataplot_b/dataplot-"$queuing_algo"-UDP_3-ack.dat"

awk '{ if ($1=="+" && $5==6 && $9=="cbr") {count += 1; time[$15] = $3; sent_id[$15]=count} else if ($1=="d" && $9=="cbr" && $17==3) { printf("%d \t %.4f \t %d \t %d\n",sent_id[$15] % 200,time[$15],$11,$15) } }  END {}' $dir_name/traces_b/$queuing_algo.nam > $dir_name/"dataplot_b/dataplot-"$queuing_algo"-UDP_3-drop.dat"

echo "Generating "$dir_name"/dataplot_b/dataplot-"$queuing_algo"-UDP_3-sent-acked.dat"

grep -Fvxf $dir_name/dataplot_b/dataplot-$queuing_algo-UDP_3-drop.dat $dir_name/dataplot_b/dataplot-$queuing_algo-UDP_3-sent.dat > $dir_name/dataplot_b/dataplot-$queuing_algo-UDP_3-sent-acked.dat

echo "Generating "$dir_name"/dataplot_b/dataplot-"$queuing_algo"-UDP_3-latency.dat"

paste  $dir_name/dataplot_b/dataplot-$queuing_algo-UDP_3-sent-acked.dat $dir_name/"dataplot_b/dataplot-"$queuing_algo"-UDP_3-ack.dat" | awk '{print $2, $6,($6-$2),$1}' > $dir_name"/dataplot_b/dataplot-"$queuing_algo"-UDP_3-latency.dat"


# combine all the latencies (UDP1,UDP2,UDP3) into a single file 
# paste  $dir_name"/dataplot_b/dataplot-"$queuing_algo"-UDP_1-latency.dat" $dir_name"/dataplot_b/dataplot-"$queuing_algo"-UDP_2-latency.dat" $dir_name"/dataplot_b/dataplot-"$queuing_algo"-UDP_3-latency.dat" | awk '{printf(" %.1f %d %.1f %d %.1f %d \n", $2, ($3*1000), $6, ($7*1000), $10, ($11*1000))}' > $dir_name"/dataplot_b/dataplot-"$queuing_algo"-complete-latency.dat"
echo -e "time latency" > $dir_name"/dataplot_b/dataplot-"$queuing_algo"-complete-latency.dat"
cat  $dir_name"/dataplot_b/dataplot-"$queuing_algo"-UDP_1-latency.dat" |  awk '{printf("%.1f %d\n", $2, ($3*1000))}' >> $dir_name"/dataplot_b/dataplot-"$queuing_algo"-complete-latency.dat"
cat  $dir_name"/dataplot_b/dataplot-"$queuing_algo"-UDP_2-latency.dat" |  awk '{printf("%.1f %d\n", $2, ($3*1000))}' >> $dir_name"/dataplot_b/dataplot-"$queuing_algo"-complete-latency.dat"
cat  $dir_name"/dataplot_b/dataplot-"$queuing_algo"-UDP_3-latency.dat" |  awk '{printf("%.1f %d\n", $2, ($3*1000))}' >> $dir_name"/dataplot_b/dataplot-"$queuing_algo"-complete-latency.dat"

echo "Generating "$dir_name"/dataplot_b/dataplot-"$queuing_algo"-complete-latency.dat"
