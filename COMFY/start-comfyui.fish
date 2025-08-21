#!/bin/fish
if not cd /path/to/comfyui
    echo "Please change placeholder ComfyUI path in this script! Or your provided path is not found."
    exit 1
end

# Get latest tags from remote
git fetch --tags

# Get latest tag
set latest_tag (git tag --sort=-v:refname | head -n 1)
if test -z "$latest_tag"
    echo "❌ No tags found!"
    exit 1
end

# Checkout the latest tag
git checkout $latest_tag

# Set compilers
set -x CC gcc-14
set -x CXX g++-14

# Activate Python virtual environment
source venv/bin/activate.fish

# Check requirements for updates
uv pip install -r requirements.txt

python main.py --front-end-version Comfy-Org/ComfyUI_frontend@latest --listen 0.0.0.0 --port 9000
