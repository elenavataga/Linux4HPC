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
# 07 — Certificate
=====================================================

## ____Congratulations!____

You have reached the final exercise.

In this directory you have a Bash script.

You have learned how to run scripts from the command line,
so try to run the script and display your certificate.

```bash
bash certificate.sh
```

Or, if you want to pass your name directly:

```bash
bash certificate.sh "Your Name Here"
```

**Well done!**
EOF

# =============================================================
# certificate.sh
# =============================================================
cat > "$BASE/certificate.sh" << 'EOF'
#!/bin/bash
# certificate.sh
# Usage:
#   bash certificate.sh "Ada Lovelace"
# or:
#   bash certificate.sh

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

chmod +x "$BASE/certificate.sh"

# =============================================================
# Verify
# =============================================================
echo ""
echo "Done. Structure created:"
echo ""
find "$BASE" | sort | sed 's|[^/]*/|  |g'
echo ""
echo "=== Test run ===" && bash "$BASE/certificate.sh" "Ada Lovelace"
