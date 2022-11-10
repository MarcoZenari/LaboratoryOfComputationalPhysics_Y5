DIR=students
if [ -d "$DIR" ]; then
	echo "$DIR exists."
else
	mkdir students
fi

cd students

FILE=LCP_22-23_students.csv
if [ -f "$FILE" ]; then
	echo "$FILE exists."
else
	wget https://www.dropbox.com/s/867rtx3az6e9gm8/LCP_22-23_students.csv
fi

FILE_POD=POD.txt
FILE_PHYSICS=Physics.txt
if [ -f "$FILE_POD" ]; then
	echo "$FILE_POD exists."
else
	touch $FILE_POD
fi
if [ -f "$FILE_PHYSICS" ]; then
	echo "$FILE_PHYSICS exists."
else
	touch $FILE_PHYSICS
fi

grep "PoD" $FILE > $FILE_POD
grep "Physics" $FILE > $FILE_PHYSICS

i=0 # variabile per vedere quale è la lettera più comune
for x in {A..Z}
do
	count=$(cut -f1 -d "," $FILE | cut -f1 -d " " | grep -c "$x")
	echo "$x : $count"
	if [ $count -gt $i ]; then 
		i=$count
		most_common=$x
	fi		
done
echo "The most common letter is $most_common"

zero=0
for j in {1..18}
do
	line_number=0
	group=1
	
	while read -r line;
	do
		if [ $line_number -ne 0 ]; then
			FILE_NAME=group$j.txt
			if [ $((line_number%18)) -eq $j ]; then
				echo $line >> $FILE_NAME
			fi
		fi
		((line_number=line_number+1))
	
	done<$FILE
done



