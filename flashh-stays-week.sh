#!/bin/bash

WEEK=$(date +%V)
WEEK_DIR="$(date +%Y)/week_$WEEK"

if [ $(date +%u) == 1 ]
then
	# today is monday
	MO_STR="$(date +%Y-%m-%d)"
else
	# it's not monday, get the monday of this week
	MO_STR="$(date -d "last-monday" +%Y-%m-%d)"
fi

MO=$MO_STR
TU=$(date -d $MO_STR"+1days" +%Y-%m-%d)
WE=$(date -d $MO_STR"+2days" +%Y-%m-%d)
TH=$(date -d $MO_STR"+3days" +%Y-%m-%d)
FR=$(date -d $MO_STR"+4days" +%Y-%m-%d)
SA=$(date -d $MO_STR"+5days" +%Y-%m-%d)
SU=$(date -d $MO_STR"+6days" +%Y-%m-%d)

# Create week folder and fill with empty files so that gnuplot runs
if [ ! -d "$WEEK_DIR" ]
then
	mkdir -p "$WEEK_DIR"

	touch "$WEEK_DIR/mo.csv"
	touch "$WEEK_DIR/tu.csv"
	touch "$WEEK_DIR/we.csv"
	touch "$WEEK_DIR/th.csv"
	touch "$WEEK_DIR/fr.csv"
	touch "$WEEK_DIR/sa.csv"
	touch "$WEEK_DIR/su.csv"
fi

# Update also the gnuplot files in case something changes in the templates

PLOT_HIST="plot-week-$WEEK-histogram.gnuplot"
PLOT_GRAPH="plot-week-$WEEK-graph.gnuplot"

cp plot-week-histogram.gnuplot "$WEEK_DIR/$PLOT_HIST"
sed -i "s/\${mo}/$MO/g" "$WEEK_DIR/$PLOT_HIST"
sed -i "s/\${tu}/$TU/g" "$WEEK_DIR/$PLOT_HIST"
sed -i "s/\${we}/$WE/g" "$WEEK_DIR/$PLOT_HIST"
sed -i "s/\${th}/$TH/g" "$WEEK_DIR/$PLOT_HIST"
sed -i "s/\${fr}/$FR/g" "$WEEK_DIR/$PLOT_HIST"
sed -i "s/\${sa}/$SA/g" "$WEEK_DIR/$PLOT_HIST"
sed -i "s/\${su}/$SU/g" "$WEEK_DIR/$PLOT_HIST"
sed -i "s/\${week}/$WEEK/g" "$WEEK_DIR/$PLOT_HIST"

cp plot-week-graph.gnuplot "$WEEK_DIR/$PLOT_GRAPH"
sed -i "s/\${mo}/$MO/g" "$WEEK_DIR/$PLOT_GRAPH"
sed -i "s/\${tu}/$TU/g" "$WEEK_DIR/$PLOT_GRAPH"
sed -i "s/\${we}/$WE/g" "$WEEK_DIR/$PLOT_GRAPH"
sed -i "s/\${th}/$TH/g" "$WEEK_DIR/$PLOT_GRAPH"
sed -i "s/\${fr}/$FR/g" "$WEEK_DIR/$PLOT_GRAPH"
sed -i "s/\${sa}/$SA/g" "$WEEK_DIR/$PLOT_GRAPH"
sed -i "s/\${su}/$SU/g" "$WEEK_DIR/$PLOT_GRAPH"
sed -i "s/\${week}/$WEEK/g" "$WEEK_DIR/$PLOT_GRAPH"

cp -f "flashh-stays_$MO.csv" "$WEEK_DIR/mo.csv"
cp -f "flashh-stays_$TU.csv" "$WEEK_DIR/tu.csv"
cp "flashh-stays_$WE.csv" "$WEEK_DIR/we.csv"
cp "flashh-stays_$TH.csv" "$WEEK_DIR/th.csv"
cp "flashh-stays_$FR.csv" "$WEEK_DIR/fr.csv"
cp "flashh-stays_$SA.csv" "$WEEK_DIR/sa.csv"
cp "flashh-stays_$SU.csv" "$WEEK_DIR/su.csv"

cd "./$WEEK_DIR"
gnuplot "$PLOT_HIST"
gnuplot "$PLOT_GRAPH"
