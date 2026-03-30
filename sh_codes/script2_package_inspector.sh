#!/bin/bash
# ============================================================
# Script 2: FOSS Package Inspector
# Author: Pratyush Mathur | Reg: 24BCE10413
# Course: Open Source Software (NGMC) | VITyarthi
# Purpose: Check if a FOSS package is installed, display its
#          version and license, and print a philosophical note
#          about the package using a case statement.
# Usage:   bash script2_package_inspector.sh
# ============================================================

# ── Target package — change this to test other packages ──────
PACKAGE="git"   # Primary package being audited in this project

# ── Helper function: check package on apt/dpkg systems ───────
check_package_apt() {
    # dpkg -l lists installed packages; grep -q = quiet (just checks exit code)
    # ^ii means the package is fully installed in dpkg state
    if dpkg -l "$1" 2>/dev/null | grep -q "^ii"; then
        echo "[INSTALLED] $1 is present on this system."
        echo ""
        echo "  Package details:"
        # dpkg -s gives detailed status; grep -E filters multiple fields
        dpkg -s "$1" 2>/dev/null | grep -E "^(Version|Maintainer|Homepage|Description)"
    else
        echo "[NOT FOUND] $1 is not installed via apt/dpkg."
        echo "  To install: sudo apt install $1"
    fi
}

# ── Helper function: check package on rpm systems ─────────────
check_package_rpm() {
    # rpm -q queries if package is installed (exits 0 if yes, non-zero if not)
    if rpm -q "$1" &>/dev/null; then
        echo "[INSTALLED] $1 is present on this system."
        echo ""
        echo "  Package details:"
        # rpm -qi gives detailed info; grep filters version, license, summary
        rpm -qi "$1" | grep -E "^(Version|License|Summary|URL)"
    else
        echo "[NOT FOUND] $1 is not installed via rpm."
        echo "  To install: sudo dnf install $1"
    fi
}

# ── Detect which package manager is available ─────────────────
echo "================================================================"
echo "           FOSS PACKAGE INSPECTOR"
echo "================================================================"
echo ""
echo "  Checking for package: $PACKAGE"
echo "  ───────────────────────────────"

# command -v returns the path to a command if it exists; used to detect tools
if command -v dpkg &>/dev/null; then
    # dpkg found: this is a Debian/Ubuntu based system
    check_package_apt "$PACKAGE"
elif command -v rpm &>/dev/null; then
    # rpm found: this is a Fedora/RHEL/CentOS based system
    check_package_rpm "$PACKAGE"
else
    echo "  Neither dpkg nor rpm found. Cannot query package database."
fi

echo ""

# ── Also show the git version directly if git command is available ──
if command -v git &>/dev/null; then
    echo "  Direct version check: $(git --version)"
fi

echo ""

# ── Case statement: print philosophy note for each package ────
# A case statement matches the value of PACKAGE against patterns.
# Each pattern ends with ;;  The * at the end is a wildcard default.
echo "================================================================"
echo "  OPEN SOURCE PHILOSOPHY NOTE"
echo "================================================================"
case $PACKAGE in
    git)
        # Git: the subject of this audit — GPL v2
        echo "  Git (GPL v2): Born from a licensing crisis in 2005, Git"
        echo "  proved that the best response to proprietary failure is to"
        echo "  build something free and better. Its distributed model is"
        echo "  a philosophical statement: history belongs to everyone."
        ;;
    httpd|apache2)
        # Apache HTTP Server — Apache 2.0 licence
        echo "  Apache (Apache 2.0): The web server that built the open"
        echo "  internet. Its permissive licence means anyone can build on"
        echo "  it commercially — a deliberate choice to maximise adoption."
        ;;
    mysql|mariadb)
        # MySQL/MariaDB — dual GPL v2 and commercial licence
        echo "  MySQL/MariaDB (GPL v2 / Commercial): MySQL's dual-licence"
        echo "  model is a lesson in open-source business. MariaDB forked"
        echo "  when Oracle acquired MySQL — community governance in action."
        ;;
    vlc)
        # VLC Media Player — LGPL/GPL
        echo "  VLC (LGPL/GPL): Started by students in Paris who wanted to"
        echo "  stream video on their university network. It plays anything."
        echo "  A reminder that student projects can change the world."
        ;;
    firefox)
        # Mozilla Firefox — MPL 2.0
        echo "  Firefox (MPL 2.0): A nonprofit browser fighting for an open"
        echo "  web against corporate monocultures. The fact that it exists"
        echo "  is itself an argument for the open-source model."
        ;;
    python3|python)
        # Python — PSF Licence
        echo "  Python (PSF Licence): Shaped entirely by community consensus"
        echo "  and the PEP process. The PSF licence is permissive, enabling"
        echo "  Python to become the most widely taught language on Earth."
        ;;
    *)
        # Default case: generic message for any other package
        echo "  $PACKAGE: Every FOSS project carries a philosophy in its"
        echo "  licence. Look up the SPDX identifier at spdx.org/licenses"
        echo "  to understand what freedoms its authors chose to grant."
        ;;
esac

echo ""
echo "================================================================"
echo "  End of FOSS Package Inspector"
echo "================================================================"
