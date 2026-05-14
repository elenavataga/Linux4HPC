#!/bin/bash
# =============================================================
# create_search_filter.sh
# Creates the 04_Search_and_Filter directory structure
# Run from inside the linux course practical directory:
#   bash create_search_filter.sh
# =============================================================

set -e

BASE="04_Search_and_Filter"

echo "Creating Search and Filter..."

rm -rf "$BASE"
mkdir -p "$BASE"
mkdir -p "$BASE/job_logs"
mkdir -p "$BASE/species"

# =============================================================
# README
# =============================================================
cat > "$BASE/README.md" << 'EOF'
# 04 — Search and Filter
=====================================================

## Skills practiced
  grep          — search for a pattern inside files
  grep -i       — case insensitive search
  grep -n       — show line numbers
  grep -c       — count matching lines
  grep -v       — invert match (lines that do NOT match)
  grep -l       — list filenames with matches
  grep -r       — search recursively through directories
  sort          — sort lines alphabetically
  sort -n       — sort lines numerically
  uniq          — remove consecutive duplicate lines
  uniq -c       — count occurrences of each line

## Reading this file

  cat README.md          — display the whole file at once
  less README.md         — open in a scrollable viewer (q to quit)

=====================================================

## What is grep?

grep searches inside files for lines matching a pattern.

  grep "error" logfile.txt

Prints every line in logfile.txt that contains the word "error".
grep is case sensitive by default — "Error" and "error" are different.

## What are sort and uniq?

sort arranges lines in order.
uniq removes repeated consecutive lines.
They are almost always used together:

  sort file.txt | uniq -c

This counts how many times each unique line appears.

=====================================================
⚠  grep "pattern" with no filename just sits there.
   Press Ctrl+C to escape.
=====================================================

## The data

  job_logs/     — output from four simulated HPC jobs
  species/      — species observation records

Have a look around before you start:

  ls job_logs/
  ls species/
  cat job_logs/job_101.log

-----------------------------------------------------
### Exercise 1 — Basic grep
-----------------------------------------------------

Search for lines containing "error" in one log file:

  grep "error" job_logs/job_101.log

Now search for "warning":

  grep "warning" job_logs/job_101.log

grep is case sensitive. Try:

  grep "Error" job_logs/job_101.log

What happens?

-----------------------------------------------------
### Exercise 2 — grep flags
-----------------------------------------------------

Make the search case insensitive with -i:

  grep -i "error" job_logs/job_101.log

Show line numbers with -n:

  grep -n "error" job_logs/job_101.log

Count matching lines with -c:

  grep -c "error" job_logs/job_101.log

Show lines that do NOT contain "error" with -v:

  grep -v "error" job_logs/job_101.log

-----------------------------------------------------
### Exercise 3 — grep across multiple files
-----------------------------------------------------

Search all log files at once using a wildcard:

  grep "error" job_logs/*.log

grep shows the filename when searching multiple files.
This is how you find which of your jobs failed.

List only the filenames that contain errors:

  grep -l "error" job_logs/*.log

Count errors per job:

  grep -c "error" job_logs/*.log

Which job has the most errors?

-----------------------------------------------------
### Exercise 4 — sort and uniq
-----------------------------------------------------

The species/ directory contains observation records.
Look at one file:

  cat species/observations.txt

Extract and count unique species names:

  sort species/observations.txt | uniq

Count how many times each species appears:

  sort species/observations.txt | uniq -c

Sort by frequency — most common species first:

  sort species/observations.txt | uniq -c | sort -rn

-rn means: sort numerically, in reverse (largest first)

-----------------------------------------------------
### Exercise 5 — Combine grep and sort
-----------------------------------------------------

Find all errors across all log files and sort them:

  grep "error" job_logs/*.log | sort

Count how many unique error messages there are:

  grep "error" job_logs/*.log | sort | uniq -c | sort -rn

Save the error summary to a file:

  grep "error" job_logs/*.log | sort | uniq -c | sort -rn > error_summary.txt
  cat error_summary.txt

-----------------------------------------------------
Don't forget to check your solutions:

  cat .solution
-----------------------------------------------------
EOF

# =============================================================
# job_logs/ — four realistic HPC job output files
# deliberately varied error/warning counts
# =============================================================
cat > "$BASE/job_logs/job_101.log" << 'EOF'
[2024-03-15 08:00:01] Job 101 started on node cn042
[2024-03-15 08:00:02] Loading modules: python/3.11 gdal/3.6
[2024-03-15 08:00:03] Input file: rainfall_2022.csv
[2024-03-15 08:00:04] Processing month: January
[2024-03-15 08:00:05] Processing month: February
[2024-03-15 08:00:06] warning: missing value in row 12, using mean
[2024-03-15 08:00:07] Processing month: March
[2024-03-15 08:00:08] Processing month: April
[2024-03-15 08:00:09] error: file rainfall_2019.csv not found
[2024-03-15 08:00:10] Processing month: May
[2024-03-15 08:00:11] Processing month: June
[2024-03-15 08:00:12] warning: value 999.9 looks suspicious in row 34
[2024-03-15 08:00:13] Processing month: July
[2024-03-15 08:00:14] error: division by zero in humidity calculation
[2024-03-15 08:00:15] Processing month: August
[2024-03-15 08:00:16] Processing month: September
[2024-03-15 08:00:17] Processing month: October
[2024-03-15 08:00:18] Processing month: November
[2024-03-15 08:00:19] Processing month: December
[2024-03-15 08:00:20] Job 101 completed with 2 errors, 2 warnings
EOF

cat > "$BASE/job_logs/job_102.log" << 'EOF'
[2024-03-15 08:01:01] Job 102 started on node cn043
[2024-03-15 08:01:02] Loading modules: python/3.11 gdal/3.6
[2024-03-15 08:01:03] Input file: temperature_2022.csv
[2024-03-15 08:01:04] Processing month: January
[2024-03-15 08:01:05] Processing month: February
[2024-03-15 08:01:06] Processing month: March
[2024-03-15 08:01:07] Processing month: April
[2024-03-15 08:01:08] Processing month: May
[2024-03-15 08:01:09] Processing month: June
[2024-03-15 08:01:10] Processing month: July
[2024-03-15 08:01:11] Processing month: August
[2024-03-15 08:01:12] Processing month: September
[2024-03-15 08:01:13] Processing month: October
[2024-03-15 08:01:14] Processing month: November
[2024-03-15 08:01:15] Processing month: December
[2024-03-15 08:01:16] Job 102 completed successfully
EOF

cat > "$BASE/job_logs/job_103.log" << 'EOF'
[2024-03-15 08:02:01] Job 103 started on node cn044
[2024-03-15 08:02:02] Loading modules: R/4.3 gdal/3.6
[2024-03-15 08:02:03] Input directory: populations/
[2024-03-15 08:02:04] error: cannot read population_asia.txt — permission denied
[2024-03-15 08:02:05] error: cannot read population_africa.txt — permission denied
[2024-03-15 08:02:06] error: cannot read population_europe.txt — permission denied
[2024-03-15 08:02:07] error: cannot read population_americas.txt — permission denied
[2024-03-15 08:02:08] error: cannot read population_oceania.txt — permission denied
[2024-03-15 08:02:09] Fatal error: no input files could be read
[2024-03-15 08:02:10] Job 103 failed
EOF

cat > "$BASE/job_logs/job_104.log" << 'EOF'
[2024-03-15 08:03:01] Job 104 started on node cn045
[2024-03-15 08:03:02] Loading modules: python/3.11 numpy/1.24
[2024-03-15 08:03:03] Running climate trend analysis
[2024-03-15 08:03:04] warning: only 5 years of data — trends may not be reliable
[2024-03-15 08:03:05] Computing temperature anomalies
[2024-03-15 08:03:06] Computing rainfall anomalies
[2024-03-15 08:03:07] warning: incomplete data for 2019 rainfall
[2024-03-15 08:03:08] warning: incomplete data for 2021 rainfall
[2024-03-15 08:03:09] Generating output plots
[2024-03-15 08:03:10] error: output directory /scratch/results does not exist
[2024-03-15 08:03:11] Job 104 completed with 1 error, 3 warnings
EOF

# =============================================================
# species/ — observation records for sort/uniq exercises
# =============================================================
cat > "$BASE/species/observations.txt" << 'EOF'
Passer_domesticus
Turdus_merula
Erithacus_rubecula
Passer_domesticus
Columba_palumbus
Turdus_merula
Passer_domesticus
Erithacus_rubecula
Accipiter_nisus
Turdus_merula
Passer_domesticus
Columba_palumbus
Passer_domesticus
Erithacus_rubecula
Turdus_merula
Accipiter_nisus
Columba_palumbus
Passer_domesticus
Turdus_merula
Erithacus_rubecula
EOF

cat > "$BASE/species/README_data.txt" << 'EOF'
Species Observations — Southern England garden survey
======================================================

File: observations.txt
Format: one species name per line (genus_species)
Source: fictional data for training purposes

Species recorded:
  Passer_domesticus    house sparrow
  Turdus_merula        common blackbird
  Erithacus_rubecula   European robin
  Columba_palumbus     common woodpigeon
  Accipiter_nisus      Eurasian sparrowhawk
EOF

# =============================================================
# .solution
# =============================================================
cat > "$BASE/.solution" << 'EOF'
=====================================================
SOLUTION — Search and Filter
=====================================================

Exercise 1 — basic grep:
  grep "error"   job_logs/job_101.log   (3 lines — 2 errors + summary line)
  grep "warning" job_logs/job_101.log   (2 lines)
  grep "Error"   job_logs/job_101.log   (0 lines — case sensitive)

Exercise 2 — grep flags:
  grep -i "error" job_logs/job_101.log  (case insensitive)
  grep -n "error" job_logs/job_101.log  (with line numbers)
  grep -c "error" job_logs/job_101.log  (count: 3)
  grep -v "error" job_logs/job_101.log  (all lines WITHOUT error)

Exercise 3 — multiple files:
  grep "error" job_logs/*.log           (all errors, with filenames)
  grep -l "error" job_logs/*.log        (job_101, job_103, job_104)
  grep -c "error" job_logs/*.log        (job_103 has most: 6)

Exercise 4 — sort and uniq:
  sort species/observations.txt | uniq
  sort species/observations.txt | uniq -c
  sort species/observations.txt | uniq -c | sort -rn
  Passer_domesticus (house sparrow) is most common with 6 observations

Exercise 5 — combine grep and sort:
  grep "error" job_logs/*.log | sort
  grep "error" job_logs/*.log | sort | uniq -c | sort -rn
  grep "error" job_logs/*.log | sort | uniq -c | sort -rn > error_summary.txt

=====================================================
KEY COMMANDS SUMMARY

  grep "pattern" file       find lines matching pattern
  grep -i                   case insensitive
  grep -n                   show line numbers
  grep -c                   count matching lines
  grep -v                   invert — lines NOT matching
  grep -l                   list filenames only
  grep "pat" *.log          search across multiple files
  sort file                 sort alphabetically
  sort -n                   sort numerically
  sort -rn                  sort numerically, reverse
  uniq                      remove consecutive duplicates
  uniq -c                   count occurrences
  sort file | uniq -c       count unique lines

=====================================================
REMINDERS:
Ctrl+C rescues you if a command hangs.
grep is case sensitive by default — use -i when unsure.
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
echo "Error counts per log (Exercise 3):"
grep -c "error" "$BASE"/job_logs/*.log
echo ""
echo "Species frequency (Exercise 4):"
sort "$BASE"/species/observations.txt | uniq -c | sort -rn
echo ""
echo "Unique error messages (Exercise 5):"
grep "error" "$BASE"/job_logs/*.log | sort | uniq -c | sort -rn
