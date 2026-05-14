#!/bin/bash
# =============================================================
# create_scripting_jobs.sh
# Creates the 05_Scripting_and_Jobs directory structure
# Run from inside the linux course practical directory:
#   bash create_scripting_jobs.sh
# =============================================================

set -e

BASE="05_Scripting_and_Jobs"

echo "Creating Scripting and Jobs..."

rm -rf "$BASE"
mkdir -p "$BASE"
mkdir -p "$BASE/scripts"

# =============================================================
# README
# =============================================================
cat > "$BASE/README.md" << 'EOF'
# 05 — Scripting and Jobs
=====================================================

## Skills practiced
  sleep       — pause for N seconds (safe test process)
  ps          — list running processes
  ps aux      — list ALL processes from ALL users
  top         — live interactive process monitor
  jobs        — list background jobs in current shell
  kill %N     — kill a background job by job number
  kill <PID>  — kill a process by process ID
  &           — run a command in the background
  bash        — run a shell script

## Reading this file

  cat README.md          — display the whole file at once
  less README.md         — open in a scrollable viewer (q to quit)

=====================================================

## What is a process?

Every command you run becomes a process — an active task
with a unique Process ID (PID).

You are on a shared login node. Many other users and system
processes are running at the same time as you.

=====================================================

## Part A — Processes

-----------------------------------------------------
### Exercise 1 — Foreground process
-----------------------------------------------------

Run sleep in the foreground and observe it blocks the terminal:

  sleep 30

You cannot type anything while it runs.
Press Ctrl+C to cancel it early.

-----------------------------------------------------
### Exercise 2 — Background process
-----------------------------------------------------

Now run it in the background:

  sleep 60 &

The terminal returns immediately.
You will see something like:  [1] 12345
  [1]    — job number
  12345  — process ID (PID)

Check your background jobs:

  jobs

Check your own running processes:

  ps

-----------------------------------------------------
### Exercise 3 — See ALL processes from ALL users
-----------------------------------------------------

You are on a shared login node. See what everyone is running:

  ps aux

This shows every process on the machine.
The columns are:

  USER    — who owns the process
  PID     — process ID
  %CPU    — CPU usage
  %MEM    — memory usage
  TIME    — total CPU time consumed
  COMMAND — what is running

The output is long. Pipe it through less to scroll:

  ps aux | less

Press q to quit less.

Find only your own processes:

  ps aux | grep $USER

Count how many processes are running in total:

  ps aux | wc -l

-----------------------------------------------------
### Exercise 4 — Live monitoring with top
-----------------------------------------------------

top shows a live, updating view of all processes:

  top

It updates every few seconds. Look at the top section:
  - load average    — how busy the system is
  - Tasks           — total processes, how many running
  - %Cpu            — overall CPU usage

The process list is sorted by CPU usage by default.

Your mission — find:
  1. The process using the most CPU right now
  2. The process that has been running the longest (TIME+ column)
  3. Your own processes — type u then your username and Enter

Useful keys inside top:
  q         — quit
  u         — filter by user
  P         — sort by CPU usage (default)
  M         — sort by memory usage
  T         — sort by running time
  k         — kill a process (enter PID when prompted)
  h         — help

=====================================================
⚠  You can only kill YOUR OWN processes.
   Linux will refuse to kill processes owned by other users.
   You cannot accidentally break someone else's work.
   Do not worry — just explore.
=====================================================

-----------------------------------------------------
### Exercise 5 — Kill a job
-----------------------------------------------------

Start two background jobs:

  sleep 300 &
  sleep 400 &

List them:

  jobs

Kill the first one by job number:

  kill %1

Kill the second by PID (use the number shown in jobs):

  kill <PID>

Check they are gone:

  jobs
  ps

-----------------------------------------------------
### Exercise 6 — Kill from a second terminal
-----------------------------------------------------

Open a second terminal and log into Iridis again.

In terminal 1 — start a long process:

  sleep 500 &

Find its PID:

  ps -u $USER

In terminal 2 — find the same process:

  ps -u $USER

Kill it from terminal 2:

  kill <PID>

Switch back to terminal 1 and confirm it is gone:

  jobs

This is how you kill a runaway job stuck on a login node.

=====================================================

## Part B — Your first script

-----------------------------------------------------
### Exercise 7 — Read and run myjob.sh
-----------------------------------------------------

Look at the script in the scripts/ directory:

  cat scripts/myjob.sh

Read through it — notice:
  - The first line starts with #! — this is the shebang
  - It tells Linux which interpreter to use (bash)
  - Commands run top to bottom, one at a time
  - # lines are comments — ignored by bash, useful for humans
  - Output goes to the screen unless redirected with >

Run it:

  bash scripts/myjob.sh

Watch what happens. When it finishes, check the output file:

  cat scripts/job.output

Notice that date and uname -n tell you:
  date     — exactly when the job ran
  uname -n — which machine it ran on

=====================================================

## Note on myjob.sh

This script is a prototype of a real SLURM job.
In the next session you will submit it to the cluster scheduler.

-----------------------------------------------------
Don't forget to check your solutions:

  cat .solution
-----------------------------------------------------
EOF

# =============================================================
# scripts/myjob.sh
# =============================================================
cat > "$BASE/scripts/myjob.sh" << 'EOF'
#!/bin/bash
# =============================================================
# myjob.sh — a simple job script
# =============================================================
# This script demonstrates the basic structure of a job.
# Every SLURM job script starts with exactly this kind of code.
#
# To run it:
#   bash scripts/myjob.sh
# =============================================================

echo "Job started"
echo "------------------------------"

# Print the current date and time
date

# Print the name of the machine we are running on
echo "Running on: $(uname -n)"

echo "------------------------------"
echo "Working..."

# Simulate some work taking time
sleep 10

# Save a result to an output file
echo "This is a simple job"          > job.output
echo "Finished at: $(date)"         >> job.output
echo "Ran on:      $(uname -n)"     >> job.output

echo "------------------------------"
date
echo "Job finished"
echo "Output written to job.output"
EOF

chmod +x "$BASE/scripts/myjob.sh"

# =============================================================
# .solution
# =============================================================
cat > "$BASE/.solution" << 'EOF'
=====================================================
SOLUTION — Scripting and Jobs
=====================================================

Exercise 1 — foreground process:
  sleep 30
  Ctrl+C to cancel early

Exercise 2 — background process:
  sleep 60 &
  jobs
  ps

Exercise 3 — see all processes:
  ps aux
  ps aux | less        (scroll with SPACE, quit with q)
  ps aux | grep $USER  (your processes only)
  ps aux | wc -l       (total process count)

Exercise 4 — top:
  top
  P    — sort by CPU (find highest CPU user)
  T    — sort by time (find longest running process)
  u    — filter by username (find your own)
  q    — quit

Exercise 5 — kill a job:
  sleep 300 &
  sleep 400 &
  jobs
  kill %1
  kill <PID>
  jobs && ps

Exercise 6 — kill from second terminal:
  Terminal 1:  sleep 500 &
  Terminal 1:  ps -u $USER       (note the PID)
  Terminal 2:  ps -u $USER       (same process visible)
  Terminal 2:  kill <PID>
  Terminal 1:  jobs              (confirms killed)

Exercise 7 — read and run the script:
  cat scripts/myjob.sh
  bash scripts/myjob.sh
  cat scripts/job.output

=====================================================
KEY COMMANDS SUMMARY

  command &       run command in background
  Ctrl+C          cancel a foreground process
  jobs            list background jobs
  ps              show your processes in this terminal
  ps aux          show ALL processes from ALL users
  ps -u $USER     show all your processes
  top             live process monitor (q to quit)
  kill %N         kill job number N
  kill <PID>      kill process by ID
  kill -9 <PID>   force kill (last resort)
  bash script.sh  run a shell script

=====================================================
WHAT IS A SHEBANG?

  #!/bin/bash

The first line of every script.
# is usually a comment — but #! at the very start is special.
It tells Linux which program to use to run the script.
#!/bin/bash means: run this with bash.

=====================================================
REMINDERS:
kill -9 is a last resort — it cannot be ignored.
Never run heavy computations on login nodes.
Scripts on the cluster always run on compute nodes via SLURM.
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
echo "=== myjob.sh ==="
cat "$BASE/scripts/myjob.sh"
