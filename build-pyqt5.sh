#! /usr/bin/bash

# Set name of the virtual environment
VENV_NAME="PyQt5-Tribblix-venv"

# Warn user we are going to install things as root
echo "Attempting to install overlays and packages as root..."

# Check if sudo is installed and install qt6-base
if [ ! -f /usr/bin/sudo ]; then
    echo "Sudo was not found."
    echo "Aborting."
    exit
else
    # Install qt6-base
    echo "/usr/bin/sudo zap install-overlay qt5-base"
    /usr/bin/sudo zap install-overlay qt5-base

    # Ensure TRIBdouble-conversion is installed
    echo "/usr/bin/sudo zap install TRIBdouble-conversion"
    /usr/bin/sudo zap install TRIBdouble-conversion
    
    # If gcc is not found, install it - we need it for building later
    if [ ! -f /usr/bin/gcc ]; then
        echo "/usr/bin/sudo zap install gcc"
        /usr/bin/sudo zap install gcc
    fi
fi

# Make a virtual environment for the build
echo "python3 -m venv ${VENV_NAME}"
python3 -m venv "${VENV_NAME}"

# Source the virtual environment
echo "source $VENV_NAME/bin/activate"
source "$VENV_NAME/bin/activate"

# Compile from source - from https://www.riverbankcomputing.com/static/Docs/PyQt5/installation.html
echo "pip -v install --verbose --config-settings --confirm-license= --config-settings --qmake=/usr/versions/Qt-5/bin/qmake PyQt5 --config-settings --jobs=$(nproc)"
pip -v install --verbose --config-settings --confirm-license= --config-settings --qmake=/usr/versions/Qt-5/bin/qmake PyQt5 --config-settings --jobs=$(nproc)

# Build a wheel of PyQt5 and PyQt5.sip
echo "python3 -m pip wheel PyQt5"
python3 -m pip wheel PyQt5

# 
echo "Completed PyQt5/.sip wheels!"
