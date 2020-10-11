set datafile separator ";"

set xdata time
set timefmt "%H:%M"
# set format x "%H:%M"

set yrange [0:150]
set xrange ["08:30":"23:30"]

set ytics 10
set xtics "01:00"

set key autotitle columnhead
set grid

set terminal png size 900,600 enhanced font 'Noto Sans,10'
set output 'flashh-plot.png'

plot 'flashh-plot.csv' using 1:2 with lines
