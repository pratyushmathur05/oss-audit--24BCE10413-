#!/bin/bash
# ============================================================
# Script 1: System Identity Report
# Author: Aditi Prakash | Reg: 24BAI10589
# Course: Open Source Software (NGMC) | VITyarthi
# Purpose: Display a welcome screen summarising key Linux
#          system information and the OS license.
# Usage:   bash script1_system_identity.sh
# ============================================================

# ── Variables ────────────────────────────────────────────────
STUDENT_NAME="Pratyush Mathur"   # Student's full name
REG_NO="24BCE10413"                   # Registration number
SOFTWARE_CHOICE="Git"                 # Chosen OSS project

# ── Gather system information using command substitution ─────
KERNEL=$(uname -r)           # Kernel release version
ARCH=$(uname -m)             # Hardware architecture (x86_64 etc.)
USER_NAME=$(whoami)          # Name of the currently logged-in user
HOME_DIR=$HOME               # Home directory path from environment variable
HOSTNAME=$(hostname)         # Machine hostname
UPTIME=$(uptime -p)          # Human-readable uptime (e.g., "up 2 hours")
CURRENT_DATE=$(date '+%A, %d %B %Y')   # e.g., "Monday, 24 March 2026"
CURRENT_TIME=$(date '+%H:%M:%S')       # e.g., "14:30:00"

# ── Detect Linux distribution name ───────────────────────────
# /etc/os-release is the standard file for distro identification
# on modern systemd-based Linux distributions
if [ -f /etc/os-release ]; then
    # Source the file to load its variables, then extract PRETTY_NAME
    DISTRO=$(grep "^PRETTY_NAME" /etc/os-release | cut -d= -f2 | tr -d '"')
else
    # Fallback if the file doesn't exist (very old systems)
    DISTRO="Unknown Linux Distribution"
fi

# ── Display formatted output ──────────────────────────────────
echo "================================================================"
echo "           OPEN SOURCE AUDIT — SYSTEM IDENTITY REPORT          "
echo "================================================================"
echo ""
echo "  Student : $STUDENT_NAME ($REG_NO)"
echo "  Project : $SOFTWARE_CHOICE — Open Source Software Audit"
echo ""
echo "----------------------------------------------------------------"
echo "  SYSTEM INFORMATION"
echo "----------------------------------------------------------------"
echo "  Distribution : $DISTRO"
echo "  Kernel       : $KERNEL"
echo "  Architecture : $ARCH"
echo "  Hostname     : $HOSTNAME"
echo "  Logged in as : $USER_NAME"
echo "  Home Dir     : $HOME_DIR"
echo "  Uptime       : $UPTIME"
echo "  Date         : $CURRENT_DATE"
echo "  Time         : $CURRENT_TIME"
echo ""
echo "----------------------------------------------------------------"
echo "  LICENSE INFORMATION"
echo "----------------------------------------------------------------"
# Note: Most Linux distributions use the GPL v2 licensed kernel.
# Ubuntu and Debian ship with a mixture of free and non-free packages.
echo "  Linux Kernel License : GNU General Public License v2 (GPL v2)"
echo "  This means you have the freedom to:"
echo "    * Run the OS for any purpose"
echo "    * Study and modify the kernel source code"
echo "    * Redistribute copies freely"
echo "    * Share your modifications under GPL v2"
echo ""
echo "================================================================"
echo "  End of System Identity Report"
echo "================================================================"
