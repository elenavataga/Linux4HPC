#!/bin/bash
# =============================================================
# create_env_modules.sh
# Creates the 06_Environment_Modules directory structure
# Run from inside the linux course practical directory:
#   bash create_env_modules.sh
# =============================================================

set -e

BASE="06_Environment_Modules"

echo "Creating Environment Modules..."

rm -rf "$BASE"
mkdir -p "$BASE"

# =============================================================
# README
# =============================================================
cat > "$BASE/README.md" << 'EOF'
# 06 — Environment Modules
=====================================================

## Skills practiced
  printenv        — print all environment variables
  echo $VAR       — print the value of one variable
  which           — show the full path of a command
  module avail    — list available software modules
  module load     — load a software module
  module list     — show currently loaded modules
  module unload   — unload a module

## Reading this file

  cat README.md          — display the whole file at once
  less README.md         — open in a scrollable viewer (q to quit)

=====================================================

## What is the shell environment?

The shell environment is a collection of named variables
that control how the shell and programs behave.
They are set when you log in and inherited by every command you run.

Print all environment variables:

  printenv

That is a lot. Print just one:

  echo $HOME
  echo $USER
  echo $HOSTNAME

The $ tells bash: this is a variable, give me its value.

-----------------------------------------------------
### Step 1 — Explore your environment
-----------------------------------------------------

Try these and see what they tell you:

  echo $HOME        — your home directory
  echo $USER        — your username
  echo $HOSTNAME    — the name of the machine you are on
  echo $SHELL       — which shell you are using

Find a specific variable with grep:

  printenv | grep HOME

-----------------------------------------------------
### Step 2 — What is PATH?
-----------------------------------------------------

PATH is the most important environment variable.
It is a list of directories that bash searches when you
type a command — in order, left to right.

  echo $PATH

You will see something like:
  /usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/home/user/bin

Each directory is separated by a colon :
When you type python3, bash looks in each directory in order
until it finds an executable called python3.

Find where a command lives:

  which python3
  which bash
  which ls

-----------------------------------------------------
### Step 3 — Python before loading a module
-----------------------------------------------------

Python 3 exists on the system but it is an old system version.
Check which version you get:

  python3 --version

You will see something like:
  Python 3.6.8

This is the system Python — old, limited, not suitable for
research work. You need a newer version.

Check where it is coming from:

  which python3

-----------------------------------------------------
### Step 4 — List available modules
-----------------------------------------------------

The module system lets multiple versions of software coexist.
See what is available:

  module avail

That is a long list. Search for Python specifically:

  module avail python

You will see the available versions, for example:
  python/3.12    python/3.12.6    python/3.13    python/3.14.3

The (D) marker shows the default version.

Search for R:

  module avail R

-----------------------------------------------------
### Step 5 — Load a module
-----------------------------------------------------

Choose your path depending on what you need for your work:

  ── If you use Python ──────────────────────────────

  Load a specific version:

    module load python/3.13

  Check the version:

    python3 --version

  You should now see Python 3.13 (or whichever you loaded).

  ── If you use R ───────────────────────────────────

  Without loading a module, R is not available:

    R --version

  This will fail — R is not installed system-wide.
  Load it:

    module load R

  Check the version:

    R --version

-----------------------------------------------------
### Step 6 — See what changed in PATH
-----------------------------------------------------

Loading a module works by adding a new directory to the
front of your PATH — so bash finds the new version first.

Check your PATH now:

  echo $PATH

Compare it to what you saw in Step 2.
A new directory has appeared at the front — the one containing
the version of python3 or R you just loaded.

Check what is currently loaded:

  module list

Unload the module:

  module unload python/3.13

Check Python version again:

  python3 --version

The old system version is back.

=====================================================

## Summary

The module system solves a real problem:
different users and different projects need different
versions of the same software.

Without modules: one version installed, everyone uses it.
With modules:    load what you need, when you need it.
                 Switch versions with one command.
                 Your colleague's environment is unaffected.

=====================================================

-----------------------------------------------------
Don't forget to check your solutions:

  cat .solution
-----------------------------------------------------
EOF

# =============================================================
# .solution
# =============================================================
cat > "$BASE/.solution" << 'EOF'
=====================================================
SOLUTION — Environment Modules
=====================================================

Step 1 — explore environment:
  printenv
  echo $HOME
  echo $USER
  echo $HOSTNAME
  echo $SHELL
  printenv | grep HOME

Step 2 — PATH:
  echo $PATH
  which python3
  which bash
  which ls

Step 3 — Python before module:
  python3 --version        (shows Python 3.6.8 — old system version)
  which python3            (shows /usr/bin/python3)

Step 4 — list modules:
  module avail
  module avail python
  module avail R

Step 5 — load a module:

  Python users:
    module load python/3.13
    python3 --version       (shows Python 3.13.x)

  R users:
    module load R
    R --version             (now works)

Step 6 — PATH after loading:
  echo $PATH                (new directory at the front)
  module list               (shows loaded modules)
  module unload python/3.13
  python3 --version         (back to 3.6.8)

=====================================================
KEY COMMANDS SUMMARY

  printenv              print all environment variables
  printenv | grep X     search environment for X
  echo $VAR             print value of variable VAR
  which command         show full path of a command
  module avail          list all available modules
  module avail name     search modules by name
  module load name      load a module
  module list           show currently loaded modules
  module unload name    unload a module

=====================================================
EXTRA — compare PATH before and after with diff:

diff compares two files line by line and shows what changed.
You have not used it before — here is how it works:

  echo $PATH > path_before.txt
  module load python/3.13
  echo $PATH > path_after.txt
  diff path_before.txt path_after.txt

How to read the output:
  <    line only in the first file  (path_before)
  >    line only in the second file (path_after)
  ---  separator between the two

In this case > shows the new directory that module load
added to the front of your PATH.
This makes it clear exactly what the module system changed.

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
echo "=== README line count ===" && wc -l "$BASE/README.md"
