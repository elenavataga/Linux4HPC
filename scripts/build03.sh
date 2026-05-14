#!/bin/bash
# =============================================================
# create_wildcards_pipes.sh
# Creates the 03_Wildcards_and_Pipes directory structure
# Run from inside the linux course practical directory:
#   bash create_wildcards_pipes.sh
# =============================================================

set -e

BASE="03_Wildcards_and_Pipes"

echo "Creating Wildcards and Pipes..."

rm -rf "$BASE"
mkdir -p "$BASE"
mkdir -p "$BASE/climate"
mkdir -p "$BASE/populations"

# =============================================================
# README
# =============================================================
cat > "$BASE/README.md" << 'EOF'
# 03 — Wildcards and Pipes
=====================================================

## Skills practiced
  *         — wildcard: matches anything
  ?         — wildcard: matches exactly one character
  wc -l     — count lines in a file
  sort -n   — sort numerically
  head -N   — show first N lines
  tail -N   — show last N lines
  |         — pipe: send output of one command into another
  >         — redirect output to a file

## Reading this file

  cat README.md          — display the whole file at once
  less README.md         — open in a scrollable viewer (q to quit)

=====================================================

## What is a wildcard?

A wildcard stands in for other characters in a filename.

  *    matches anything — zero or more characters
  ?    matches exactly one character

Examples:
  *.csv              — all files ending in .csv
  temperature_*.csv  — all files starting with temperature_
  rainfall_201?.csv  — rainfall files where ? is one character

## What is a pipe?

A pipe | sends the output of one command directly into another.

  wc -l *.txt | sort -n

This counts lines in all .txt files, then sorts the result
numerically. Small tools chained together become powerful.

=====================================================
⚠  If a command just sits there doing nothing —
   you probably forgot to give it a filename.
   Press Ctrl+C to escape and get your prompt back.
=====================================================

## The data

  climate/       — temperature and rainfall CSV files, 2018–2022
  populations/   — population estimates by continent

Have a look around before you start:

  ls climate/
  ls populations/
  cat climate/README_data.txt

-----------------------------------------------------
### Exercise 1 — Basic wildcard *
-----------------------------------------------------

List only the temperature files in the climate directory:

  ls climate/temperature_*.csv

Now list only the rainfall files:

  ls climate/rainfall_*.csv

How many of each are there?

-----------------------------------------------------
### Exercise 2 — Single character wildcard ?
-----------------------------------------------------

There are two kinds of rainfall file in climate/:
  - yearly files:  rainfall_2018.csv, rainfall_2019.csv ...
  - backup files:  rainfall_2018_backup.csv, rainfall_2019_backup.csv

Try these two commands and count the results:

  ls climate/rainfall_201?.csv
  ls climate/rainfall_201*.csv

? matches exactly one character after 201 — so it matches
only the four-digit year files.

* matches anything — so it matches both yearly and backup files.

-----------------------------------------------------
### Exercise 3 — Count and sort
-----------------------------------------------------

Count the lines in every population file:

  wc -l populations/*.txt

Now sort the result numerically to rank them:

  wc -l populations/*.txt | sort -n

Which continent has the most lines of data?

Note: sort without -n sorts alphabetically.
      The number 10 would sort before 2 without -n.
      Always use sort -n for numbers.

-----------------------------------------------------
### Exercise 4 — Inspect files with head and tail
-----------------------------------------------------

Show the first 3 lines of the temperature file:

  head -3 climate/temperature_2022.csv

The first line is the header — the rest is data.

Show the last 2 lines of the rainfall file:

  tail -2 climate/rainfall_2020.csv

-----------------------------------------------------
### Exercise 5 — Build a pipeline
-----------------------------------------------------

Find which climate file has the most lines.
Build it step by step:

  wc -l climate/*.csv
  wc -l climate/*.csv | sort -n
  wc -l climate/*.csv | sort -n | tail -3

The last line of wc output is always the total —
so tail -3 shows the two largest files plus the total.

Save the result to a file:

  wc -l climate/*.csv | sort -n > line_counts.txt
  cat line_counts.txt

-----------------------------------------------------
Don't forget to check your solutions:

  cat .solution
-----------------------------------------------------
EOF

# =============================================================
# climate/ — temperature CSV files (5 years)
# =============================================================
write_temp_csv() {
  local file=$1 year=$2
  cat > "$file" << CSVEOF
station,month,temp_max_c,temp_min_c,temp_mean_c
Southampton_Airport,Jan_${year},9.2,2.1,5.4
Southampton_Airport,Feb_${year},9.8,2.3,5.7
Southampton_Airport,Mar_${year},12.1,3.8,7.6
Southampton_Airport,Apr_${year},15.3,5.9,10.2
Southampton_Airport,May_${year},18.6,8.7,13.4
Southampton_Airport,Jun_${year},21.4,11.8,16.3
Southampton_Airport,Jul_${year},23.1,13.9,18.2
Southampton_Airport,Aug_${year},22.8,13.5,17.9
Southampton_Airport,Sep_${year},19.2,11.0,14.8
Southampton_Airport,Oct_${year},14.7,7.6,10.9
Southampton_Airport,Nov_${year},11.3,4.2,7.4
Southampton_Airport,Dec_${year},8.9,2.0,5.1
CSVEOF
}

write_temp_csv "$BASE/climate/temperature_2018.csv" 2018
write_temp_csv "$BASE/climate/temperature_2019.csv" 2019
write_temp_csv "$BASE/climate/temperature_2020.csv" 2020
write_temp_csv "$BASE/climate/temperature_2021.csv" 2021
write_temp_csv "$BASE/climate/temperature_2022.csv" 2022

# =============================================================
# climate/ — rainfall CSV files (varied lengths)
# =============================================================
write_rain_csv() {
  local file=$1 year=$2 extra=$3
  cat > "$file" << CSVEOF
station,month,rainfall_mm,rainy_days,humidity_pct
Southampton_Airport,Jan_${year},82.3,14,84
Southampton_Airport,Feb_${year},56.1,11,79
Southampton_Airport,Mar_${year},47.8,10,74
Southampton_Airport,Apr_${year},44.2,9,70
Southampton_Airport,May_${year},48.6,9,71
Southampton_Airport,Jun_${year},45.1,8,69
Southampton_Airport,Jul_${year},35.4,7,67
Southampton_Airport,Aug_${year},42.2,8,70
Southampton_Airport,Sep_${year},56.8,10,75
Southampton_Airport,Oct_${year},77.3,13,81
Southampton_Airport,Nov_${year},88.4,14,85
Southampton_Airport,Dec_${year},91.2,15,87
CSVEOF
  if [ "$extra" = "yes" ]; then
    echo "Southampton_Airport,Annual_${year},715.4,128,77" >> "$file"
    echo "Oxford_Radcliffe,Annual_${year},648.2,119,74"   >> "$file"
  fi
}

write_rain_csv "$BASE/climate/rainfall_2018.csv" 2018
write_rain_csv "$BASE/climate/rainfall_2019.csv" 2019 yes
write_rain_csv "$BASE/climate/rainfall_2020.csv" 2020
write_rain_csv "$BASE/climate/rainfall_2021.csv" 2021 yes
write_rain_csv "$BASE/climate/rainfall_2022.csv" 2022

# =============================================================
# climate/ — backup files (for Exercise 2)
# shorter than yearly files so wc -l is informative
# =============================================================
cat > "$BASE/climate/rainfall_2018_backup.csv" << 'EOF'
station,month,rainfall_mm
Southampton_Airport,Jan_2018,82.3
Southampton_Airport,Jun_2018,45.1
Southampton_Airport,Dec_2018,91.2
EOF

cat > "$BASE/climate/rainfall_2019_backup.csv" << 'EOF'
station,month,rainfall_mm
Southampton_Airport,Jan_2019,79.8
Southampton_Airport,Jun_2019,41.3
Southampton_Airport,Dec_2019,88.7
EOF

# =============================================================
# climate/ — data README
# =============================================================
cat > "$BASE/climate/README_data.txt" << 'EOF'
Climate Data — Southern England (fictional but realistic)
=========================================================

Files:
  temperature_YYYY.csv        monthly temperature data
  rainfall_YYYY.csv           monthly rainfall data
  rainfall_YYYY_backup.csv    abbreviated backup copies

Station:  Southampton Airport (50.95N, 1.36W)
Period:   2018 to 2022
Source:   fictional data for training purposes only

Columns in temperature files:
  station       weather station name
  month         month and year
  temp_max_c    maximum temperature (Celsius)
  temp_min_c    minimum temperature (Celsius)
  temp_mean_c   mean temperature (Celsius)

Columns in rainfall files:
  station       weather station name
  month         month and year
  rainfall_mm   total rainfall in millimetres
  rainy_days    number of days with measurable rain
  humidity_pct  mean relative humidity (%)
EOF

# =============================================================
# populations/ — continent files (deliberately varied lengths)
# =============================================================
cat > "$BASE/populations/population_africa.txt" << 'EOF'
# Population estimates by subregion — Africa
# Source: fictional data for training purposes
# Year: 2020, unit: millions
Eastern_Africa,445.4
Middle_Africa,179.6
Northern_Africa,246.2
Southern_Africa,67.5
Western_Africa,415.3
EOF

cat > "$BASE/populations/population_asia.txt" << 'EOF'
# Population estimates by subregion — Asia
# Source: fictional data for training purposes
# Year: 2020, unit: millions
Central_Asia,74.3
Eastern_Asia,1671.4
South-Eastern_Asia,668.6
Southern_Asia,1940.8
Western_Asia,277.9
EOF

cat > "$BASE/populations/population_europe.txt" << 'EOF'
# Population estimates by subregion — Europe
# Source: fictional data for training purposes
# Year: 2020, unit: millions
Eastern_Europe,292.5
Northern_Europe,105.8
Southern_Europe,152.4
Western_Europe,196.7
EOF

cat > "$BASE/populations/population_americas.txt" << 'EOF'
# Population estimates by subregion — Americas
# Source: fictional data for training purposes
# Year: 2020, unit: millions
Caribbean,43.5
Central_America,179.8
Northern_America,367.9
South_America,432.5
EOF

cat > "$BASE/populations/population_oceania.txt" << 'EOF'
# Population estimates — Oceania
# Source: fictional data for training purposes
# Year: 2020, unit: millions
Australia_and_New_Zealand,30.8
Melanesia,11.3
EOF

# =============================================================
# .solution
# =============================================================
cat > "$BASE/.solution" << 'EOF'
=====================================================
SOLUTION — Wildcards and Pipes
=====================================================

Exercise 1 — basic wildcard:
  ls climate/temperature_*.csv    (5 files)
  ls climate/rainfall_*.csv       (7 files — includes backups)

Exercise 2 — single character wildcard:
  ls climate/rainfall_201?.csv    (2 files: 2018, 2019)
  ls climate/rainfall_201*.csv    (4 files: 2018, 2019 + their backups)
  ? matches exactly one character — the four-digit year only
  * matches anything — year AND backup suffix

Exercise 3 — count and sort:
  wc -l populations/*.txt | sort -n
  Oceania has fewest lines, Africa and Asia have most
  Without -n: 10 sorts before 2 (alphabetical, not numerical)

Exercise 4 — head and tail:
  head -3 climate/temperature_2022.csv
  tail -2 climate/rainfall_2020.csv

Exercise 5 — pipeline:
  wc -l climate/*.csv | sort -n | tail -3
  rainfall_2019.csv and rainfall_2021.csv are largest (15 lines each)
  wc -l climate/*.csv | sort -n > line_counts.txt

=====================================================
KEY COMMANDS SUMMARY

  ls *.csv              list all .csv files
  ls prefix_*.csv       files starting with prefix_
  ls file_201?.csv      ? = exactly one character
  wc -l *.txt           count lines in all .txt files
  sort -n               sort numerically
  head -N file          first N lines
  tail -N file          last N lines
  cmd1 | cmd2           pipe output into next command
  cmd > file.txt        save output to file (overwrites)
  cmd >> file.txt       append output to file

=====================================================
REMINDERS:
Ctrl+C rescues you if a command hangs.
> overwrites without warning — use with care.
=====================================================
EOF

# =============================================================
# Verify
# =============================================================
echo ""
echo "Done. Structure created:"
echo ""
find "$BASE" | sort | sed 's|[^/]*/|  |g'
echo ""
echo "Exercise 2 check:"
echo "  rainfall_201?.csv  matches:"
ls "$BASE"/climate/rainfall_201?.csv
echo "  rainfall_201*.csv  matches:"
ls "$BASE"/climate/rainfall_201*.csv
echo ""
echo "Exercise 3 check — population line counts:"
wc -l "$BASE"/populations/*.txt | sort -n
echo ""
echo "Exercise 5 check — climate line counts:"
wc -l "$BASE"/climate/*.csv | sort -n | tail -3
