#!/bin/bash
# ============================================================
# Script 4: Log File Analyzer
# Author: Pratyush Mathur | Reg: 24BCE10413
# Course: Open Source Software (NGMC) | VITyarthi
# Purpose: Read a log file line by line, count occurrences
#          of a keyword, and print a summary with the last
#          5 matching lines. Accepts arguments from command line.
# Usage:   bash script4_log_analyzer.sh /var/log/syslog error
#          bash script4_log_analyzer.sh /var/log/auth.log warning
#          bash script4_log_analyzer.sh               (interactive retry)
# ============================================================

# ── Command-line arguments ────────────────────────────────────
# $0 = script name, $1 = first argument, $2 = second argument
LOGFILE=$1

# Parameter expansion: ${2:-"error"} means "use $2, or 'error' if not set"
KEYWORD=${2:-"error"}

# ── Counters (integer variables) ──────────────────────────────
TOTAL_LINES=0    # Will count every line read from the file
MATCH_COUNT=0    # Will count lines that match the keyword

# ── Validate: ensure a log file argument was provided ─────────
if [ -z "$LOGFILE" ]; then
    # -z tests if a string is empty (zero length)
    echo "================================================================"
    echo "  ERROR: No log file specified."
    echo "  Usage: $0 /path/to/logfile [keyword]"
    echo "  Example: $0 /var/log/syslog error"
    echo "================================================================"
    exit 1   # Exit the script with a non-zero error code
fi

# ── do-while style retry loop ─────────────────────────────────
# Bash has no native do-while, but we simulate it with a while loop
# whose condition checks for an invalid file. We allow up to 2 retries.
MAX_RETRIES=2    # Maximum number of times to ask for a valid path
RETRY=0          # Counter starts at zero

# Loop continues as long as the file does NOT exist or is NOT readable
while [ ! -f "$LOGFILE" ] || [ ! -r "$LOGFILE" ]; do
    RETRY=$((RETRY + 1))   # Arithmetic: increment retry counter
    echo ""
    echo "  [WARNING] File not found or not readable: $LOGFILE"

    # If we have hit the retry limit, give up and exit
    if [ $RETRY -ge $MAX_RETRIES ]; then
        echo "  [ERROR] Maximum retries exceeded. Exiting."
        echo ""
        echo "  TIP: Try using /var/log/syslog or creating a test file:"
        echo "       echo 'test error line' > /tmp/test.log"
        echo "       bash $0 /tmp/test.log error"
        exit 1
    fi

    # Prompt the user for a new path
    echo "  Please enter a valid log file path (attempt $RETRY of $MAX_RETRIES):"
    read -r LOGFILE
done

# ── Display header ────────────────────────────────────────────
echo ""
echo "================================================================"
echo "  LOG FILE ANALYZER"
echo "  File    : $LOGFILE"
echo "  Keyword : '$KEYWORD' (case-insensitive search)"
echo "================================================================"
echo ""

# ── Main loop: read file line by line ────────────────────────
# IFS= prevents leading/trailing whitespace stripping
# read -r prevents backslash interpretation
# < "$LOGFILE" redirects the file into stdin for the while loop
while IFS= read -r LINE; do

    # Increment total line counter using arithmetic expansion
    TOTAL_LINES=$((TOTAL_LINES + 1))

    # Check if this line contains the keyword
    # grep -i = case-insensitive, -q = quiet (no output, just return code)
    if echo "$LINE" | grep -iq "$KEYWORD"; then
        MATCH_COUNT=$((MATCH_COUNT + 1))
    fi

done < "$LOGFILE"

# ── Print summary results ─────────────────────────────────────
echo "  SUMMARY"
echo "  ─────────────────────────────────────────────────────────────"
echo "  Total lines in file      : $TOTAL_LINES"
echo "  Lines matching '$KEYWORD' : $MATCH_COUNT"

# Calculate match percentage using integer arithmetic
# Bash only does integers, so multiply by 100 BEFORE dividing
if [ "$TOTAL_LINES" -gt 0 ]; then
    PERCENT=$(( (MATCH_COUNT * 100) / TOTAL_LINES ))
    echo "  Match percentage         : ${PERCENT}%"
else
    echo "  The file appears to be empty."
fi

echo ""
echo "  LAST 5 MATCHING LINES"
echo "  ─────────────────────────────────────────────────────────────"

# grep -i searches case-insensitively; pipe to tail -5 to get last 5 results
# 2>/dev/null suppresses error messages if the file disappears mid-run
LAST_MATCHES=$(grep -i "$KEYWORD" "$LOGFILE" 2>/dev/null | tail -5)

if [ -z "$LAST_MATCHES" ]; then
    # -z checks if string is empty: no matches found
    echo "  (No lines matching '$KEYWORD' were found in the file)"
else
    # Print each matching line with a >> prefix for visibility
    echo "$LAST_MATCHES" | while IFS= read -r MATCH_LINE; do
        echo "  >> $MATCH_LINE"
    done
fi

echo ""
echo "================================================================"
echo "  End of Log File Analyzer"
echo "================================================================"
