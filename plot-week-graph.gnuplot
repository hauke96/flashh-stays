set datafile separator ";"
set rmargin 5

set title "FLASHH visitors from ${mo} to ${su} (week ${week})"

set key left

# X dimension
set xdata time
set timefmt "%H:%M"
set xrange ["08:30":"23:30"]
set xtics "01:00"
# Not necessary because raw data has already a nice time format
# set format x "%H:%M"

# Y dimension
set yrange [0:150]
set ytics 10

# Für Wochentage:
set cbdata time
set format cb "%A"
set cbrange [strptime("%Y-%m-%d", "${mo}")-60*60*12:strptime("%Y-%m-%d %H:%M", "${su} 12:00")]
unset mcbtics

set palette maxcolors 7
set palette defined (0 "black", 2 "red", 4 "orange", 6 "dark-green")

# Background grid
set grid
set style line 1 lc rgb '#505050' dt 3
set grid xtics ytics ls 1

# PNG rendering config
set terminal pngcairo size 900,600 enhanced font 'Noto Sans,10'
set output 'week-${week}-graph.png'

# Start the graph plot
plot 'mo.csv' using 1:2:(strptime("%Y-%m-%d", "${mo}")) with lines palette title "Monday ${mo}", \
     'tu.csv' using 1:2:(strptime("%Y-%m-%d", "${tu}")) with lines palette title "Tuesday ${tu}", \
     'we.csv' using 1:2:(strptime("%Y-%m-%d", "${we}")) with lines palette title "Wednesday ${we}", \
     'th.csv' using 1:2:(strptime("%Y-%m-%d", "${th}")) with lines palette title "Thursday ${th}", \
     'fr.csv' using 1:2:(strptime("%Y-%m-%d", "${fr}")) with lines palette title "Friday ${fr}", \
     'sa.csv' using 1:2:(strptime("%Y-%m-%d", "${sa}")) with lines palette title "Saturday ${sa}", \
     'su.csv' using 1:2:(strptime("%Y-%m-%d", "${su}")) with lines palette title "Sunday ${su}"
