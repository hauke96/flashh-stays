#!/bin/bash

SLEEP=$((15 * 60))
OUTPUT="flashh-stays_$(date "+%F").csv"
OUTPUT_PNG="flashh-stays_$(date "+%F").png"

if [ ! -f $OUTPUT ]
then
	echo "Init new file $OUTPUT"
	echo "date;stays" > $OUTPUT
fi

DATE=$(date +%R)
STAYS=$(curl -s https://flashh.cashbloc.de/stays)

echo "New entry: $DATE;$STAYS"
echo "$DATE;$STAYS" >> $OUTPUT

# Render graphic
cp $OUTPUT flashh-plot.csv
gnuplot flashh-plot.gnuplot
mv flashh-plot.png $OUTPUT_PNG
echo "PNG $OUTPUT_PNG rendered"
