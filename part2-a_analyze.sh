# For part 2 - A

dir_name=output_part_2
traces_name=$1
dataplot_name="dataplot-"$traces_name".dat"

awk '{if ($1=="+" && $5==0 && $9=="tcp") {count += 1; printf("%d \t %.4f \t %d \t %d\n",count%60,$3,$11,$15) } } END {}' $dir_name/traces_a/$traces_name.nam > $dir_name/"dataplot-"$traces_name"-sent.dat"
# awk '{if ($1=="+" && $5==0 && $9=="tcp") {count += 1; printf(count"\t"$3"\t"$11"\t"$15"\n") } } END {}' $dir_name/traces_a/$traces_name.nam > $dir_name/"dataplot-"$traces_name"-sent.dat"
awk '{if ($1=="r" && $7==0 && $9=="ack") {count += 1; printf("%d \t %.4f \t %d \t %d\n",count%60,$3,$11,$15) } }  END {}' $dir_name/traces_a/$traces_name.nam > $dir_name/"dataplot-"$traces_name"-ack.dat"
awk '{ if ($1=="+" && $5==0 && $9=="tcp") {count += 1} else if ($1=="d" && $9=="tcp" && $17==1) { printf("%d \t %.4f \t %d \t %d\n",count%60,$3,$11,$15) } }  END {}' $dir_name/traces_a/$traces_name.nam > $dir_name/"dataplot-"$traces_name"-drop.dat"
