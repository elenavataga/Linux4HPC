#!/bin/bash
# =============================================================
# create_maze.sh
# Creates the 01_Navigation_Maze directory structure
# Run from inside the linux course practical directory:
#   bash create_maze.sh
# =============================================================

set -e

BASE="01_Navigation_Maze"

echo "Creating Navigation Maze..."

rm -rf "$BASE"
mkdir -p "$BASE"

# =============================================================
# README
# =============================================================
cat > "$BASE/README.md" << 'EOF'
# 01 — Navigation Maze
=====================================================

## Skills practiced
  cd       — change directory
  ls       — list directory contents
  pwd      — print working directory (where am I?)
  cat      — read a file

## Your mission

Somewhere in this directory tree, four boxes are hidden.
Each box contains one word of an inspiring quote.

Find all four boxes and collect them to reveal the message.

## The rules

  - NO using the `find` command — navigate manually
  - Use `pwd`   to check where you are
  - Use `ls`    to look around you
  - Use `cd`    to move into a directory
  - Use `cd ..` to go back one level

## Where to start

  cd entrance

## How to collect your findings

When you find a box, read it with:

  cat box1.txt

Write down the word, or follow the suggestion in the clue file
to collect your findings automatically.

If you collected automatically, reveal your quote at the end with:

  cat ~/maze_findings.txt

## Bonus challenge (optional)

There is a fifth hidden word somewhere in the maze.
It is not signposted. Find it by exploring thoroughly.
The bonus word completes the quote.

  Hint: not all files are visible with a plain `ls`
        try:  ls -a

## Secret bonus (for the truly curious)

Somewhere in this directory there are hidden files.
Hidden files in Linux start with a dot — for example .secret
They are invisible to plain `ls` but revealed by:

  ls -a
EOF

# =============================================================
# SIGNPOST
# =============================================================
cat > "$BASE/signpost.txt" << 'EOF'
You can see:
  entrance/   — a path leading north into trees
  village/    — quiet. too quiet.
  river/      — you can hear water
  mountain/   — a long climb
  swamp/      — smells bad

Tip: use `ls` in each directory to look around.
     Use `cd <name>` to enter. Use `cd ..` to go back.
     Use `pwd` to check where you are at any time.
EOF

# =============================================================
# .secret — hidden file in top-level directory
# teaches ls -a and introduces tree command
# =============================================================
cat > "$BASE/.secret" << 'EOF'
You found the hidden file. Well done.

Hidden files in Linux start with a dot.
Plain `ls` will never show them.
To reveal hidden files you need:

  ls -a

=====================================================
Now for something new — the `tree` command.
=====================================================

From the top of the maze run:

  tree

`tree` draws the entire directory structure as a diagram —
every file, every folder, every level — all at once.

Compare what you see with the path you actually walked.
Did you miss anything?

To reveal hidden files in the tree as well, run:

  tree -a

You will now see the desert/ path you may have missed,
and all hidden files including this one.

`tree` is one of the most useful commands for understanding
an unfamiliar directory structure. Remember it.
EOF

# =============================================================
# .solution — hidden file with absolute-style paths and full quote
# Note: uses $HOME so paths are correct for any user
# =============================================================
cat > "$BASE/.solution" << 'EOF'
=====================================================
SOLUTION — Navigation Maze
=====================================================

The four boxes are located at:

  01_Navigation_Maze/entrance/forest/clearing/cave/box1.txt
  01_Navigation_Maze/village/tower/cellar/box2.txt
  01_Navigation_Maze/river/island/box3.txt
  01_Navigation_Maze/mountain/pass/summit/box4.txt

Read them all in one command (run from your home directory):

  cat 01_Navigation_Maze/entrance/forest/clearing/cave/box1.txt \
      01_Navigation_Maze/village/tower/cellar/box2.txt \
      01_Navigation_Maze/river/island/box3.txt \
      01_Navigation_Maze/mountain/pass/summit/box4.txt

=====================================================
BONUS — fifth box (hidden path):

  01_Navigation_Maze/desert/oasis/ruin/box5.txt

=====================================================
FULL QUOTE:

  "Exploration is the engine
   that drives innovation."

                   — Edith Widder
                     Marine biologist & oceanographer
                     Winner of the TED Prize 2011

=====================================================
EOF

# =============================================================
# PATH 1 — entrance → forest → clearing → cave  (box1)
# =============================================================
mkdir -p "$BASE/entrance/forest/clearing/cave"

cat > "$BASE/entrance/clue.txt" << 'EOF'
You are at the entrance to the maze.
It is dark. You can hear wind to the north.

Go north — try the forest.

  cd forest
EOF

cat > "$BASE/entrance/forest/clue.txt" << 'EOF'
You are in a dense forest.
Tall trees block the light.
Something glints further in — go east to the clearing.

  cd clearing
EOF

cat > "$BASE/entrance/forest/clearing/clue.txt" << 'EOF'
You are in a clearing.
It is cold here. Very cold.
The cave to the south looks promising.

  cd cave
EOF

cat > "$BASE/entrance/forest/clearing/cave/clue.txt" << 'EOF'
You are in a cave.
Your eyes adjust to the darkness.
You can make out a box on the floor.

Read it:
  cat box1.txt

To collect automatically:
  cat box1.txt >> ~/maze_findings.txt
EOF

cat > "$BASE/entrance/forest/clearing/cave/box1.txt" << 'EOF'
Exploration
EOF

# =============================================================
# PATH 2 — village → tower → cellar  (box2)
# =============================================================
mkdir -p "$BASE/village/tower/cellar"

cat > "$BASE/village/clue.txt" << 'EOF'
You are in a quiet village.
Nobody is around. The houses are empty.
There is an old tower at the end of the road.

  cd tower
EOF

cat > "$BASE/village/tower/clue.txt" << 'EOF'
You are at the top of the tower.
A fine view, but nothing useful here.
Wait — there is a trapdoor. Look DOWN, not up.

  cd cellar
EOF

cat > "$BASE/village/tower/cellar/clue.txt" << 'EOF'
You climb down into the cellar.
It smells of old books and adventure.
Something is here.

Read it:
  cat box2.txt

To collect automatically:
  cat box2.txt >> ~/maze_findings.txt
EOF

cat > "$BASE/village/tower/cellar/box2.txt" << 'EOF'
is
EOF

# =============================================================
# PATH 3 — river → island  (box3)
# =============================================================
mkdir -p "$BASE/river/island"

cat > "$BASE/river/clue.txt" << 'EOF'
You are at the riverbank.
The water is wide but calm.
There is a small island in the middle. Cross it.

  cd island
EOF

cat > "$BASE/river/island/clue.txt" << 'EOF'
You are on the island.
Sand. A palm tree. A box.
One word closer. Keep going.

Read it:
  cat box3.txt

To collect automatically:
  cat box3.txt >> ~/maze_findings.txt
EOF

cat > "$BASE/river/island/box3.txt" << 'EOF'
the
EOF

# =============================================================
# PATH 4 — mountain → pass → summit  (box4)
# =============================================================
mkdir -p "$BASE/mountain/pass/summit"

cat > "$BASE/mountain/clue.txt" << 'EOF'
You are at the foot of the mountain.
A steep climb awaits.
The pass through the rocks looks manageable.

  cd pass
EOF

cat > "$BASE/mountain/pass/clue.txt" << 'EOF'
You are in the mountain pass.
Wind howls around you. Almost there.
Push on to the summit.

  cd summit
EOF

cat > "$BASE/mountain/pass/summit/clue.txt" << 'EOF'
You made it.
The view from here is extraordinary.
Below you — the whole maze.
And here, waiting for you — the final box.

Read it:
  cat box4.txt

To collect automatically:
  cat box4.txt >> ~/maze_findings.txt

If you collected all four automatically, reveal your quote:
  cat ~/maze_findings.txt
EOF

cat > "$BASE/mountain/pass/summit/box4.txt" << 'EOF'
engine
EOF

# =============================================================
# BONUS PATH — desert → oasis → ruin  (box5, hidden)
# Not signposted — discoverable only by thorough ls at top level
# =============================================================
mkdir -p "$BASE/desert/oasis/ruin"

cat > "$BASE/desert/clue.txt" << 'EOF'
Nobody told you about the desert.
Yet here you are.
Curiosity brought you this far — keep going.

  cd oasis
EOF

cat > "$BASE/desert/oasis/clue.txt" << 'EOF'
An oasis. Water. Shade.
And the crumbling walls of something ancient.

  cd ruin
EOF

cat > "$BASE/desert/oasis/ruin/clue.txt" << 'EOF'
The ruin is old. Very old.
Carved into the wall, barely legible — a single word.
You found the bonus.

Read it:
  cat box5.txt

To collect automatically:
  cat box5.txt >> ~/maze_findings.txt

Then reveal the full quote:
  cat ~/maze_findings.txt
EOF

cat > "$BASE/desert/oasis/ruin/box5.txt" << 'EOF'
that drives innovation.
EOF

# =============================================================
# DEAD END — swamp (goes nowhere, teaches cd ..)
# =============================================================
mkdir -p "$BASE/swamp"

cat > "$BASE/swamp/clue.txt" << 'EOF'
You are in a swamp.
It is unpleasant. Nothing is here.
This was a dead end.

Go back the way you came.

  cd ..

(But are you sure there is really nothing here?
 Have you looked carefully?)
EOF

# =============================================================
# Verify
# =============================================================
echo ""
echo "Done. Structure created:"
echo ""
find "$BASE" | sort | sed 's|[^/]*/|  |g'
echo ""
echo "Boxes:"
find "$BASE" -name "box*.txt" | sort
echo ""
echo "Hidden files:"
find "$BASE" -name ".*" -not -name "." | sort
echo ""
echo "Quote check:"
cat "$BASE/entrance/forest/clearing/cave/box1.txt" \
    "$BASE/village/tower/cellar/box2.txt" \
    "$BASE/river/island/box3.txt" \
    "$BASE/mountain/pass/summit/box4.txt" \
    "$BASE/desert/oasis/ruin/box5.txt"
echo ""
echo ".solution preview:"
cat "$BASE/.solution"
