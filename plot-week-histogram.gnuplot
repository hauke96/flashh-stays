set datafile separator ";"
set rmargin 5

set title "FLASHH visitors from ${mo} to ${su} (week ${week})"

set key off

# X dimension
set xdata time
set timefmt "%H:%M"
set xrange ["08:30":"23:30"]
set xtics "01:00"
# Not necessary because raw data has already a nice time format
# set format x "%H:%M"

# Y dimension
set ydata time
set yrange [strptime("%Y-%m-%d", "${mo}")-60*60*12:strptime("%Y-%m-%d %H:%M", "${su} 12:00")]
set format y "%A\n%Y-%m-%d"
set ytics 60*60*24
unset mytics

# Für grün-rot verlauf abh. von Besucherzahl
set cbrange [0:150]
set cbtics 10
set palette defined (0 "green", 50 "orange", 100 "red", 150 "#a600ff")

# Background grid
set grid
set style line 1 lc rgb '#505050' dt 3
set grid xtics ytics ls 1

# PNG rendering config
set terminal pngcairo size 900,600 enhanced font 'Noto Sans,10'
set output 'week-${week}-histogram.png'

set object 1 rect from strptime("%H:%M","00:00"),(strptime("%Y-%m-%d","${mo}")-60*60*24) to strptime("%H:%M","10:00"),strptime("%Y-%m-%d","${fr}")+60*60*12 front fc rgb "#65e0e0e0" fs solid noborder
set object 2 rect from strptime("%H:%M","23:00"),(strptime("%Y-%m-%d","${mo}")-60*60*24) to strptime("%H:%M","23:59"),strptime("%Y-%m-%d","${fr}")+60*60*12 front fc rgb "#65e0e0e0" fs solid noborder
set object 3 rect from strptime("%H:%M","00:00"),strptime("%Y-%m-%d","${fr}")+60*60*12 to strptime("%H:%M","09:00"),strptime("%Y-%m-%d","${su}")+60*60*24 front fc rgb "#65e0e0e0" fs solid noborder
set object 4 rect from strptime("%H:%M","22:00"),strptime("%Y-%m-%d","${fr}")+60*60*12 to strptime("%H:%M","23:59"),strptime("%Y-%m-%d","${su}")+60*60*24 front fc rgb "#65e0e0e0" fs solid noborder

set object 5 rect from strptime("%H:%M","00:00"),(strptime("%Y-%m-%d","${mo}")-60*60*24) to strptime("%H:%M","10:00"),strptime("%Y-%m-%d","${fr}")+60*60*12 front fc rgb "gray" fs transparent pattern 5 noborder
set object 6 rect from strptime("%H:%M","23:00"),(strptime("%Y-%m-%d","${mo}")-60*60*24) to strptime("%H:%M","23:59"),strptime("%Y-%m-%d","${fr}")+60*60*12 front fc rgb "gray" fs transparent pattern 5 noborder
set object 7 rect from strptime("%H:%M","00:00"),strptime("%Y-%m-%d","${fr}")+60*60*12 to strptime("%H:%M","09:00"),strptime("%Y-%m-%d","${su}")+60*60*24 front fc rgb "gray" fs transparent pattern 5 noborder
set object 8 rect from strptime("%H:%M","22:00"),strptime("%Y-%m-%d","${fr}")+60*60*12 to strptime("%H:%M","23:59"),strptime("%Y-%m-%d","${su}")+60*60*24 front fc rgb "gray" fs transparent pattern 5 noborder

# Start the histogram plot
plot 'mo.csv' using 1:(strptime("%Y-%m-%d", "${mo}")):2 with lines palette lw 20, \
     'tu.csv' using 1:(strptime("%Y-%m-%d", "${tu}")):2 with lines palette lw 20, \
     'we.csv' using 1:(strptime("%Y-%m-%d", "${we}")):2 with lines palette lw 20, \
     'th.csv' using 1:(strptime("%Y-%m-%d", "${th}")):2 with lines palette lw 20, \
     'fr.csv' using 1:(strptime("%Y-%m-%d", "${fr}")):2 with lines palette lw 20, \
     'sa.csv' using 1:(strptime("%Y-%m-%d", "${sa}")):2 with lines palette lw 20, \
     'su.csv' using 1:(strptime("%Y-%m-%d", "${su}")):2 with lines palette lw 20
