#!/bin/bash

SLEEP=$((15 * 60))
DATE=$(date +%F)
OUTPUT_CSV="flashh-stays_$DATE.csv"
OUTPUT_GNUPLOT="flashh-stays_$DATE.gnuplot"
OUTPUT_PNG="flashh-stays_$DATE.png"

if [ ! -f $OUTPUT_CSV ]
then
	echo "Init new file $OUTPUT_CSV"
	echo "date;stays" > $OUTPUT_CSV
fi

TIME=$(date +%R)
STAYS=$(curl -s https://flashh.cashbloc.de/stays)

echo "New entry: $TIME;$STAYS"
echo "$TIME;$STAYS" >> $OUTPUT_CSV

# Render graphic
#cp $OUTPUT_CSV flashh-plot.csv
#gnuplot flashh-plot.gnuplot
#mv flashh-plot.png $OUTPUT_PNG
cp flashh-plot.gnuplot $OUTPUT_GNUPLOT
sed -i "s/\${date}/$DATE/" $OUTPUT_GNUPLOT

gnuplot $OUTPUT_GNUPLOT

echo "PNG $OUTPUT_PNG rendered"
