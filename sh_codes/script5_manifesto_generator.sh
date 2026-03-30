#!/bin/bash
# ============================================================
# Script 5: The Open Source Manifesto Generator
# Author: Pratyush Mathur | Reg: 24BCE10413
# Course: Open Source Software (NGMC) | VITyarthi
# Purpose: Interactively ask the user three questions, then
#          compose a personalised open-source philosophy
#          statement and save it to a .txt file.
# Usage:   bash script5_manifesto_generator.sh
# ============================================================

# ── Alias concept (demonstrated in comments) ──────────────────
# In an interactive shell session, you can define shortcuts like:
#   alias greet='echo "Welcome to the Open Source Manifesto Generator"'
# Aliases are command shortcuts defined with the 'alias' keyword.
# They are stored in ~/.bashrc for persistence across sessions.
# Example: alias ll='ls -la' makes 'll' run the full listing command.
# Note: Aliases are NOT available inside non-interactive scripts by default,
# so we demonstrate the concept here in comments rather than using one.

# ── Welcome banner ────────────────────────────────────────────
echo "================================================================"
echo "       THE OPEN SOURCE MANIFESTO GENERATOR"
echo "       A VITyarthi OSS Project Tool"
echo "       Author: Pratyush Mathur | 24BCE10413"
echo "================================================================"
echo ""
echo "  Answer three questions to generate your personal open-source"
echo "  philosophy statement. Your answers will be composed into a"
echo "  paragraph and saved to a text file."
echo ""
echo "----------------------------------------------------------------"
echo ""

# ── Read user input interactively ────────────────────────────
# read -r: reads a line from stdin; -r prevents backslash escaping
# read -p "prompt": displays an inline prompt before reading
# The answer is stored in the variable after -p "..."

read -r -p "  Q1. Name one open-source tool you use every day: " TOOL

# Input validation: loop until the user gives a non-empty answer
# -z tests for an empty (zero-length) string
while [ -z "$TOOL" ]; do
    echo "  Please type something — this question cannot be skipped."
    read -r -p "  Q1. Name one open-source tool you use every day: " TOOL
done

echo ""
read -r -p "  Q2. In one word, what does 'freedom' in software mean to you? " FREEDOM

while [ -z "$FREEDOM" ]; do
    echo "  Please enter at least one word."
    read -r -p "  Q2. In one word, what does 'freedom' mean to you? " FREEDOM
done

echo ""
read -r -p "  Q3. Name one thing you would build and share freely if you could: " BUILD

while [ -z "$BUILD" ]; do
    echo "  Please type your answer — even a small idea counts."
    read -r -p "  Q3. Name one thing you would build and share freely: " BUILD
done

echo ""
echo "----------------------------------------------------------------"
echo "  Composing your manifesto..."
echo "----------------------------------------------------------------"
echo ""

# ── Prepare variables ─────────────────────────────────────────
# date with a format string produces a readable timestamp
DATE=$(date '+%d %B %Y')     # e.g., 24 March 2026
TIME=$(date '+%H:%M')        # e.g., 14:30

# The output filename includes the current username for uniqueness
# String concatenation in Bash: just place variables adjacent to text
OUTPUT="manifesto_$(whoami).txt"

# ── Write the manifesto to a file ────────────────────────────
# > (redirect) creates/overwrites the file with the first line
# >> (append redirect) adds subsequent lines without erasing previous ones

# Write the file header
echo "================================================================" > "$OUTPUT"
echo "  MY OPEN SOURCE MANIFESTO" >> "$OUTPUT"
echo "  By: Pratyush Mathur" >> "$OUTPUT"
echo "  Generated: $DATE at $TIME" >> "$OUTPUT"
echo "================================================================" >> "$OUTPUT"
echo "" >> "$OUTPUT"

# Write paragraph 1 — using $TOOL (string interpolation inside double quotes)
echo "  Every day I rely on $TOOL — a tool I did not have to buy," >> "$OUTPUT"
echo "  did not have to beg permission to use, and can inspect down" >> "$OUTPUT"
echo "  to its last line of code if I choose to. This is not a small" >> "$OUTPUT"
echo "  thing. It is the direct result of people choosing to build" >> "$OUTPUT"
echo "  in the open and share their work freely." >> "$OUTPUT"
echo "" >> "$OUTPUT"

# Write paragraph 2 — using $FREEDOM
echo "  To me, freedom in software means $FREEDOM. Not in an abstract" >> "$OUTPUT"
echo "  way, but in the practical sense: freedom to run, to study," >> "$OUTPUT"
echo "  to modify, and to share. The four freedoms that the Free" >> "$OUTPUT"
echo "  Software Foundation articulates are not idealism. They are" >> "$OUTPUT"
echo "  the conditions under which knowledge compounds rather than" >> "$OUTPUT"
echo "  stagnates. Every open-source tool that exists is evidence" >> "$OUTPUT"
echo "  of what becomes possible when those conditions are met." >> "$OUTPUT"
echo "" >> "$OUTPUT"

# Write paragraph 3 — using $BUILD
echo "  If I could build one thing and share it freely, it would be" >> "$OUTPUT"
echo "  $BUILD. I would license it under GPL v2 — not because" >> "$OUTPUT"
echo "  it would make me famous, but because it is the surest way" >> "$OUTPUT"
echo "  to ensure that whatever I build remains available, forever," >> "$OUTPUT"
echo "  to everyone who might find it useful. Standing on the" >> "$OUTPUT"
echo "  shoulders of giants means, eventually, being someone else's" >> "$OUTPUT"
echo "  giant. This is my commitment to that chain." >> "$OUTPUT"
echo "" >> "$OUTPUT"

# Write footer
echo "----------------------------------------------------------------" >> "$OUTPUT"
echo "  Course: Open Source Software (NGMC) | VITyarthi 2026" >> "$OUTPUT"
echo "================================================================" >> "$OUTPUT"

# ── Confirm save and display the manifesto ────────────────────
echo "  Manifesto successfully saved to: $OUTPUT"
echo ""
echo "================================================================"
echo "  YOUR GENERATED MANIFESTO"
echo "================================================================"
echo ""

# cat reads the file and prints its contents to the terminal
cat "$OUTPUT"

echo ""
echo "================================================================"
echo "  End of Manifesto Generator"
echo "================================================================"
