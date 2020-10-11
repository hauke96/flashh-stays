# flashh-stays

Script to collect visitor data from the FLASHH boulder spot in Hamburg, Germany.

This all works with CSV files of the following format:
```csv
date;stays
10:00;23
10:05;31
10:10;29
...
```

The `flashh-plot.gnuplot` file requires a `flashh-plot.csv` file and renders its content to a `flashh-plot.png` file.

The `flashh-stays.sh` loads the data from the server and writes it into a CSV file with a name like `flashh-stays_2020-10-25.csv`.
After that it takes this CSV file, copies it, renders it using the gnuplot script and renames the PNG file into `flashh-stays_2020-10-25.png`.

The `flashh-stays.timer` and `flashh-stays.service` are config files to a systemd timer executing the `flashh-stays.sh` file every 5 minutes between 8AM and 11:59PM.
