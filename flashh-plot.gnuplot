set datafile separator ";"

set title "FLASHH visitors on ${date}"

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

# Background grid
set grid
set style line 1 lc rgb '#000000' lt 0 lw 1.25
set grid xtics ytics ls 1

# PNG rendering config
set terminal pngcairo size 900,600 enhanced font 'Noto Sans,10'
set output 'flashh-stays_${date}.png'

# Start the plot
plot 'flashh-stays_${date}.csv' using 1:2 with lines title "Amount of visitors"
