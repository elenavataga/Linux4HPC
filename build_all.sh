#!/bin/bash
# =============================================================
# build_all.sh
# Master build script for the Linux4HPC practical course
# Usage:
#   bash build_all.sh
#
# Creates:
#   Linux4HPC/
#   Linux4HPC/README.md
#   Linux4HPC/01_Navigation_Maze/
#   Linux4HPC/02_File_Management_Lab/
#   Linux4HPC/03_Wildcards_and_Pipes/
#   Linux4HPC/04_Search_and_Filter/
#   Linux4HPC/05_Scripting_and_Jobs/
#   Linux4HPC/06_Environment_Modules/
#   Linux4HPC/07_Certificate/
# =============================================================

set -e

COURSE="Linux4HPC"
SCRIPTS="scripts"

echo "============================================"
echo "  Building Linux4HPC practical course..."
echo "============================================"
echo ""

# =============================================================
# Check all build scripts exist before starting
# =============================================================
for i in 01 02 03 04 05 06 07; do
    script="$SCRIPTS/build${i}.sh"
    if [ ! -f "$script" ]; then
        echo "ERROR: $script not found"
        echo "Please make sure all build scripts are in scripts/"
        exit 1
    fi
done

# =============================================================
# Create top-level course directory
# =============================================================
rm -rf "$COURSE"
mkdir -p "$COURSE"

# =============================================================
# README.md — top-level welcome file
# =============================================================
cat > "$COURSE/README.md" << 'EOF'
# Welcome to the Linux Practical Exercises
=====================================================

**____Welcome to the Linux practical exercises____**

Please work through the directories one by one, starting from 01.
In each directory, display the README file first and follow the instructions.

-----------------------------------------------------
## Getting started

```
cd 01_Navigation_Maze
cat README.md
```

-----------------------------------------------------
## Useful commands

| Command                  | What it does                          |
|--------------------------|---------------------------------------|
| `cd <directory_name>`    | go into a directory                   |
| `cd ..`                  | go up one directory                   |
| `cat README.md`          | display the README file               |
| `less README.md`         | open the file in a scrollable viewer  |
| `pwd`                    | show where you are                    |
| `ls`                     | list files and directories            |

-----------------------------------------------------
## Reading files with less

```
less README.md
```

Navigation inside less:

| Key              | Action                    |
|------------------|---------------------------|
| `SPACE` or `f`   | scroll down one page      |
| `b`              | scroll back one page      |
| arrow keys       | scroll line by line       |
| `q`              | quit                      |

-----------------------------------------------------
## Tips

- Use **TAB** to complete commands and file names
- Use the **Up and Down arrow keys** to move through your command history

-----------------------------------------------------
## If you get stuck

Check where you are:
```
pwd
```

List the files and directories:
```
ls
```

-----------------------------------------------------
## Getting help with any command

```
man <command>        # open the manual page
<command> --help     # show short help
```

For example:
```
man ls
ls --help
```

Navigation inside a man page:

| Key      | Action                         |
|----------|--------------------------------|
| `q`      | quit and return to command line |
| `SPACE`  | move one page down             |
| `/word`  | search for "word"              |

-----------------------------------------------------

**Good luck!**
EOF

echo "Created: $COURSE/README.md"

# =============================================================
# Run each build script inside the course directory
# =============================================================
chapters=(
    "01:build01.sh:01_Navigation_Maze"
    "02:build02.sh:02_File_Management_Lab"
    "03:build03.sh:03_Wildcards_and_Pipes"
    "04:build04.sh:04_Search_and_Filter"
    "05:build05.sh:05_Scripting_and_Jobs"
    "06:build06.sh:06_Environment_Modules"
    "07:build07.sh:07_Certificate"
)

for entry in "${chapters[@]}"; do
    num="${entry%%:*}"
    rest="${entry#*:}"
    script="${rest%%:*}"
    dirname="${rest#*:}"

    echo ""
    echo "--- Building chapter $num: $dirname ---"
    (cd "$COURSE" && bash "../$SCRIPTS/$script")
    echo "    Done: $COURSE/$dirname/"
done

# =============================================================
# Summary
# =============================================================
echo ""
echo "============================================"
echo "  Build complete!"
echo "============================================"
echo ""
echo "Course directory: $COURSE/"
echo ""
echo "Structure:"
find "$COURSE" -maxdepth 1 | sort | sed 's|[^/]*/|  |g'
echo ""
echo "To copy to a user's home directory:"
echo "  cp -r $COURSE /home/<username>/"
echo ""
echo "To let a user copy it themselves from a shared location:"
echo "  cp -r /path/to/$COURSE ~/"
echo "  cd ~/$COURSE"
echo "  cat README.md"
echo "============================================"
