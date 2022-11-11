echo "Insert number of copies:"
read n

sed '/#/d' ./data.csv | tr ',' '\t' > data.txt

even=0
odd=0

tr -s '[:blank:]' '[\n*]' < data.txt >tmp.txt

while read line; do
	if [ $((line%2)) -ne 0 ]; then
		((odd=odd+1))
	else
		((even=even+1))
	fi
done <tmp.txt
echo "Odd: $odd Even:$even"

counter=0
quadrato=0
greater=0
lower=0
confront=$( echo 'scale=2; 2500*3' | bc) 

while read line; do
	if [ $((counter%3)) -eq 0 ]; then
		quadrato=$((line*line))
	elif [ $((counter%3)) -eq 2 ] ; then
		((quadrato=quadrato+line*line))
		if [ $quadrato -gt $confront ]; then
			((greater=greater+1))
		else
			((lower=lower+1))
		fi
	else
		((quadrato=quadrato+line*line))
	fi
	((counter=counter+1))
done <tmp.txt

echo "Greater: $greater Lower:$lower"

rm copy*

for (( j=1; j<=$n; j++ ))
do
	FILE_NAME=copy$j.txt
	>$FILE_NAME
	new_line=0	
	while read number; do
		((new_number=number/j))
		if [ $new_line -eq 0 ]; then
			echo -n "$new_number ">>$FILE_NAME
		else
			if [ $((new_line%6)) -eq 5 ]; then
				echo $new_number>>$FILE_NAME
			else
				echo -n "$new_number ">>$FILE_NAME
			fi
		fi
		((new_line=new_line+1))
	done <tmp.txt
	
done

rm tmp.txt
