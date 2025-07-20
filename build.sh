#! /usr/bin/bash

# Set name of the virtual environment
VENV_NAME="PyQt6-Tribblix-venv"

# Ensure needed overlays are installed
X="zap install-overlay develop desktop qt6-base && zap install TRIBdouble-conversion"
echo "Attempting to execute as root: ${X}"

# Check if sudo is installed
if [ ! -f /usr/bin/sudo ]; then
    echo "Sudo was not found."
    echo "Aborting."
    exit
else
    /usr/bin/sudo "$X"
fi

# Make a virtual environment for the build
python3 -m venv "$PyQt6-Tribblix-venv"
source "$VENV_NAME/bin/activate"

# Compile from source - from https://www.riverbankcomputing.com/static/Docs/PyQt6/installation.html
pip -v install --config-settings --confirm-license= --config-settings --qmake=/usr/versions/Qt-6/bin/qmake PyQt6 --config-settings --jobs $(nrpoc)

# Build a wheel of PyQt6 and PyQt6.sip
python3 -m pip wheel PyQt6

# 
echo "Completed PyQt6/.sip wheels!"
