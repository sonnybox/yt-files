#!/bin/bash
cd /path/to/comfyui || { echo "Please change placeholder ComfyUI path in this script! Or the path you provided is not found."; exit 1; }

# Get latest tags from remote
git fetch --tags

# Get latest tag
latest_tag=$(git tag --sort=-v:refname | head -n 1)
if test -z "$latest_tag"; then
    echo "❌ No tags found!"
    exit 1
fi

# Checkout the latest tag
git checkout $latest_tag

# Set compilers
export CC=gcc-14
export CXX=g++-14

# Activate Python virtual environment
source venv/bin/activate

# Check requirements for updates
uv pip install -r requirements.txt

python main.py --front-end-version Comfy-Org/ComfyUI_frontend@latest --listen 0.0.0.0 --port 9000
