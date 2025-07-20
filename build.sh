#! /usr/bin/bash

# Set name of the virtual environment
VENV_NAME="PyQt6-Tribblix-venv"

# Ensure needed overlays are installed
zap install develop desktop qt6-base TRIBdouble-conversion

# Make a virtual environment for the build
python3 -m venv "$PyQt6-Tribblix-venv"
source "$VENV_NAME/bin/activate"

# Compile from source - from https://www.riverbankcomputing.com/static/Docs/PyQt6/installation.html
pip -v install --config-settings --confirm-license= --config-settings --qmake=/usr/versions/Qt-6/bin/qmake PyQt6

# Build a wheel of PyQt6 and PyQt6.sip
python3 -m pip wheel PyQt6

# 
echo "Completed PyQt6/.sip wheels!"
