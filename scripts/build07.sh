#!/bin/bash
# =============================================================
# create_certificate.sh
# Creates the 07_Certificate directory structure
# Run from inside the linux course practical directory:
#   bash create_certificate.sh
# =============================================================

set -e

BASE="07_Certificate"

echo "Creating Certificate..."

rm -rf "$BASE"
mkdir -p "$BASE"

# =============================================================
# README.md
# =============================================================
cat > "$BASE/README.md" << 'EOF'
# 07 -- Certificate
=====================================================

## ____Congratulations!____

You have reached the final exercise.

In this directory you have a Bash script.
You have learned how to run scripts from the command line --
now try two different ways to run it.

-----------------------------------------------------
## Two ways to run a script

### Way 1 -- tell bash to run it explicitly

```bash
bash certificate.sh
```

This always works. You are telling Linux:
*"use bash to interpret this file"*.
No special permissions needed.

-----------------------------------------------------
### Way 2 -- run it like a command

First check the current permissions:

```bash
ls -l certificate.sh
```

You will see something like:

```
-rw-r--r-- 1 user group 1234 May 14 10:00 certificate.sh
```

The permission string `-rw-r--r--` means:

| Characters | Who        | Permissions          |
|------------|------------|----------------------|
| `-`        | --          | it is a file         |
| `rw-`      | you        | read and write       |
| `r--`      | your group | read only            |
| `r--`      | everyone   | read only            |

Nobody has execute (`x`) permission -- so you cannot run it
as a command yet.

Add execute permission with `chmod`:

```bash
chmod +x certificate.sh
```

Check the permissions again -- notice the `x` has appeared:

```
-rwxr-xr-x 1 user group 1234 May 14 10:00 certificate.sh
```

Now run it like a command:

```bash
./certificate.sh
```

The `./` means: *run this file from the current directory*.

Or pass your name directly:

```bash
./certificate.sh "Your Name Here"
```

-----------------------------------------------------

**Well done -- you have completed the Linux for HPC practical!**
EOF

# =============================================================
# certificate.sh -- permissions deliberately NOT executable
# so students have to chmod +x themselves
# =============================================================
cat > "$BASE/certificate.sh" << 'EOF'
#!/bin/bash
# certificate.sh
# Usage:
#   bash certificate.sh "Ada Lovelace"
# or after chmod +x:
#   ./certificate.sh "Ada Lovelace"

if [ $# -eq 0 ]; then
    read -r -p "Enter participant name: " NAME
else
    NAME="$*"
fi

DATE=$(date +"%d %B %Y")
WIDTH=72

repeat_char() {
    local char="$1"
    local count="$2"
    local i
    for ((i=0; i<count; i++)); do
        printf "%s" "$char"
    done
}

outer_border() {
    printf "+"
    repeat_char "=" $((WIDTH + 2))
    printf "+\n"
}

inner_border() {
    printf "|+"
    repeat_char "-" "$WIDTH"
    printf "+|\n"
}

blank_line() {
    printf "||"
    printf "%*s" "$WIDTH" ""
    printf "||\n"
}

centre_line() {
    local text="$1"
    local len=${#text}
    if [ "$len" -gt "$WIDTH" ]; then
        text="${text:0:$WIDTH}"
        len=${#text}
    fi
    local left=$(( (WIDTH - len) / 2 ))
    local right=$(( WIDTH - len - left ))
    printf "||"
    printf "%*s" "$left" ""
    printf "%s" "$text"
    printf "%*s" "$right" ""
    printf "||\n"
}

echo
echo
echo
outer_border
inner_border
blank_line
centre_line "    .--."
centre_line "     |o_o |"
centre_line "     |:_/ |"
centre_line "     //   \\ \\"
centre_line "    (|     | )"
centre_line "   /'\\_   _/\`\\"
centre_line "   \\___)=(___/"
blank_line
centre_line "CERTIFICATE OF COMPLETION"
blank_line
centre_line "This certifies that"
blank_line
centre_line "$NAME"
blank_line
centre_line "has completed the Linux for HPC practical session."
blank_line
centre_line "Skills unlocked:"
centre_line "ssh, ls, cd, mkdir, cp, mv, rm, sort, grep, top"
blank_line
centre_line "Date: $DATE"
blank_line
centre_line "Awarded by:"
centre_line "The Ancient Spirit of UNIX"
blank_line
inner_border
outer_border
echo
echo
EOF

# deliberately NOT chmod +x -- students do this themselves
# verify it is not executable
echo "Permissions of certificate.sh (should be -rw-r--r--):"
ls -l "$BASE/certificate.sh"

# =============================================================
# .solution
# =============================================================
cat > "$BASE/.solution" << 'EOF'
=====================================================
SOLUTION -- Certificate
=====================================================

Way 1 -- run with bash (no permissions needed):
  bash certificate.sh "Your Name"

Way 2 -- make executable and run as a command:
  chmod +x certificate.sh
  ./certificate.sh "Your Name"

chmod +x adds execute permission to the file.
Without it, ./certificate.sh gives "Permission denied".

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
echo "=== Test run with bash (Way 1) ===" && bash "$BASE/certificate.sh" "Ada Lovelace"
