# For part 2 - A

dir_name=output_part_2
traces_name=$1
dataplot_name="dataplot-"$traces_name".dat"

# TCP data

awk '{if ($1=="+" && $5==0 && $9=="tcp") {count += 1; printf("%d \t %.4f \t %d \t %d\n",count % 200,$3,$11,$15) } } END {}' $dir_name/traces_a/$traces_name.nam > $dir_name/"dataplot_a/dataplot-"$traces_name"-TCP-sent.dat"

awk '{ if ($1=="+" && $5==0 && $9=="tcp") {count += 1; sent_id[$15]=count } else if ($1=="r" && $7==0 && $9=="ack") { printf("%d \t %.4f \t %d \t %d\n",sent_id[$15] % 200,$3,$11,$15) } }  END {}' $dir_name/traces_a/$traces_name.nam > $dir_name/"dataplot_a/dataplot-"$traces_name"-TCP-ack-tmp.dat"

awk '{ if ($1=="+" && $5==0 && $9=="tcp") {count += 1; time[$15] = $3; sent_id[$15]=count} else if ($1=="d" && $9=="tcp" && $17==1) { printf("%d \t %.4f \t %d \t %d\n",sent_id[$15] % 200,time[$15],$11,$15) } }  END {}' $dir_name/traces_a/$traces_name.nam > $dir_name/"dataplot_a/dataplot-"$traces_name"-TCP-drop.dat"

grep -Fvxf $dir_name/"dataplot_a/dataplot-"$traces_name"-TCP-drop.dat" $dir_name/"dataplot_a/dataplot-"$traces_name"-TCP-sent.dat" > $dir_name/"dataplot_a/dataplot-"$traces_name"-TCP-sent-acked.dat"

paste $dir_name/"dataplot_a/dataplot-"$traces_name"-TCP-sent-acked.dat" $dir_name/"dataplot_a/dataplot-"$traces_name"-TCP-ack-tmp.dat" | awk '{print $1,$6,$7,$8}' > $dir_name/"dataplot_a/dataplot-"$traces_name"-TCP-ack.dat"

# UDP data

awk '{if ($1=="+" && $5==1 && $9=="cbr") {count += 1; printf("%d \t %.4f \t %d \t %d\n",count % 200,$3,$11,$15) } } END {}' $dir_name/traces_a/$traces_name.nam > $dir_name/"dataplot_a/dataplot-"$traces_name"-UDP-sent.dat"

# There is no ack in udp, it just the received packets
awk '{ if ($1=="+" && $5==1 && $9=="cbr") {count += 1; sent_id[$15]=count } else if ($1=="r" && $7==2 && $9=="cbr") { printf("%d \t %.4f \t %d \t %d\n",sent_id[$15] % 200,$3,$11,$15) } }  END {}' $dir_name/traces_a/$traces_name.nam > $dir_name/"dataplot_a/dataplot-"$traces_name"-UDP-ack.dat"

awk '{ if ($1=="+" && $5==1 && $9=="cbr") {count += 1; time[$15] = $3; sent_id[$15]=count} else if ($1=="d" && $9=="cbr" && $17==2) { printf("%d \t %.4f \t %d \t %d\n",sent_id[$15] % 200,time[$15],$11,$15) } }  END {}' $dir_name/traces_a/$traces_name.nam > $dir_name/"dataplot_a/dataplot-"$traces_name"-UDP-drop.dat"

grep -Fvxf $dir_name/"dataplot_a/dataplot-"$traces_name"-UDP-drop.dat" $dir_name/"dataplot_a/dataplot-"$traces_name"-UDP-sent.dat" > $dir_name/"dataplot_a/dataplot-"$traces_name"-UDP-sent-acked.dat"
