#!/bin/bash
# =============================================================
# create_file_lab.sh
# Creates the 02_File_Management_Lab directory structure
# Run from inside the linux course practical directory:
#   bash create_file_lab.sh
# =============================================================

set -e

BASE="02_File_Management_Lab"

echo "Creating File Management Lab..."

rm -rf "$BASE"
mkdir -p "$BASE"

# =============================================================
# README
# =============================================================
cat > "$BASE/README.md" << 'EOF'
# 02 — File Management Lab
=====================================================

## Skills practiced
  mv        — move or rename files and directories
  cp        — copy files
  mkdir     — create directories
  rm        — remove files (PERMANENT — no Recycle Bin)
  rm -i     — remove with confirmation prompt
  rm -ri    — remove a directory with confirmation at each step
  nano      — simple terminal text editor

## Reading this file

  cat README.md          — display the whole file at once
  less README.md         — open in a scrollable viewer

Navigation inside less:
  SPACE or f             — scroll down one page
  b                      — scroll back one page
  arrow keys             — scroll line by line
  q                      — quit

=====================================================
⚠  WARNING — there is no Recycle Bin on the cluster.
   rm deletes immediately and permanently.
   There is no undo. There is no recovery.
   Use rm -i until it becomes a habit.
=====================================================

-----------------------------------------------------
### Linux is case sensitive
-----------------------------------------------------

Linux treats uppercase and lowercase letters as completely different.
These are three different files:

  data.txt
  Data.txt
  DATA.txt

And these are three different directories:

  results/
  Results/
  RESULTS/

This matters everywhere — filenames, commands, flags, and paths.
A common mistake:

  ls -L       — wrong flag, does something else entirely
  ls -l       — correct — long listing format

Another example:

  cd Documents    — works if the directory is called Documents
  cd documents    — fails if it is called Documents

Tab completion helps: press Tab and let Linux fill in the exact name.

-----------------------------------------------------
### Exercise 1 — Fix a typo using mv
-----------------------------------------------------

There is a file in this directory with a spelling mistake.
Find it and rename it using mv.

mv does two things:
  mv oldname newname    — rename a file
  mv file directory/    — move a file into a directory

-----------------------------------------------------
### Exercise 2 — Create a backup directory and copy a file
-----------------------------------------------------

Create a directory called backups:

  mkdir backups

Copy draft.txt into it:

  cp draft.txt backups/

Check it worked — the original should still be there:

  ls
  ls backups/

-----------------------------------------------------
### Exercise 3 — Edit a file with nano
-----------------------------------------------------

Open draft.txt in the nano editor:

  nano draft.txt

Make any change you like — add a line, fix something.

To save and exit:
  Ctrl+O    — write the file (press Enter to confirm the name)
  Ctrl+X    — exit nano

To exit without saving:
  Ctrl+X    then N when asked

Other useful nano shortcuts:
  Ctrl+K    — cut the current line
  Ctrl+U    — paste the cut line
  Ctrl+W    — search for text

nano shows available shortcuts at the bottom of the screen.
^ means Ctrl.

Note: if you ever end up in vim by mistake, type:
  :q!
and press Enter to quit without saving.

-----------------------------------------------------
### Exercise 4 — Build a directory structure
-----------------------------------------------------

Create the following structure from scratch using mkdir:

  project/
  ├── data/
  │   ├── raw/
  │   └── processed/
  ├── scripts/
  └── results/

You can do it one directory at a time:

  mkdir project
  mkdir project/data

Or in one command using -p (creates parents as needed):

  mkdir -p project/data/raw

Check your work:

  tree project

-----------------------------------------------------
### Exercise 5 — Delete a file safely with rm -i
-----------------------------------------------------

Delete the file draft.txt using the -i flag:

  rm -i draft.txt

-----------------------------------------------------
### Exercise 6 — Remove a directory and its contents
-----------------------------------------------------

Now delete the entire project/ structure you created
in Exercise 4:

  rm -ri project/

-r stands for recursive — removes the directory and everything inside it.
-i asks for confirmation at each step.

=====================================================
⚠  Without -i, rm -r deletes everything silently.
   Always double-check the directory name.
   A common and painful mistake:

     rm -r results/     — deletes the results directory
     rm -r results /    — the space means: delete results/ AND /
                          Catastrophic. Do not do this.
=====================================================

-----------------------------------------------------
Don't forget to check your solutions:

  cat .solution
-----------------------------------------------------
EOF

# =============================================================
# Files for exercises
# =============================================================

# Exercise 1 — misspelled file
cat > "$BASE/statstics.txt" << 'EOF'
This file contains some important statistics.
But nobody can find it because the name is wrong.

Rename it with:
  mv statstics.txt statistics.txt
EOF

# Exercise 2 & 3 — draft file to copy and edit
cat > "$BASE/draft.txt" << 'EOF'
This is a draft document.

Author: [your name]
Date:   [today's date]

Summary:
  This file is used to practice copying and editing.
  Open it in nano, make a change, and save it.

Notes:
  Add your own notes here.
EOF

# =============================================================
# .solution — hidden file with answers to all exercises
# =============================================================
cat > "$BASE/.solution" << 'EOF'
=====================================================
SOLUTION — File Management Lab
=====================================================

Exercise 1 — rename the misspelled file:
  mv statstics.txt statistics.txt

Exercise 2 — create backup directory and copy:
  mkdir backups
  cp draft.txt backups/

Exercise 3 — edit with nano:
  nano draft.txt
  Ctrl+O to save, Enter to confirm, Ctrl+X to exit

Exercise 4 — build directory structure:
  mkdir -p project/data/raw
  mkdir -p project/data/processed
  mkdir -p project/scripts
  mkdir -p project/results

Exercise 5 — delete with confirmation:
  rm -i draft.txt

Exercise 6 — remove directory recursively with confirmation:
  rm -ri project/

=====================================================
KEY COMMANDS SUMMARY

  mv old new          rename a file
  mv file dir/        move a file into a directory
  cp file dir/        copy a file into a directory
  cp -r dir1 dir2     copy a directory and its contents
  mkdir name          create a directory
  mkdir -p a/b/c      create nested directories in one go
  rm file             remove a file (permanent)
  rm -i file          remove with confirmation prompt
  rm -ri dir/         remove directory with confirmation at each step
  nano file           open file in nano editor

=====================================================
REMINDERS:
rm IS FOREVER!
LINUX IS CASE SENSITIVE:
  Linux is case sensitive — Data.txt and data.txt are different files.
  Use tab completion to avoid mistakes.
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
echo "Files:"
ls -la "$BASE/"
