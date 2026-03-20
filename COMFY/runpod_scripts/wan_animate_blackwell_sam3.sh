#!/bin/bash

echo 'cd /root' >> /etc/bash.bashrc
echo 'source /root/ComfyUI/venv/bin/activate' >> /etc/bash.bashrc

cd /root

git clone https://github.com/Comfy-Org/ComfyUI
git clone https://github.com/Comfy-Org/ComfyUI-Manager ComfyUI/custom_nodes/ComfyUI-Manager
git clone https://github.com/kijai/ComfyUI-WanAnimatePreprocess ComfyUI/custom_nodes/ComfyUI-WanAnimatePreprocess
git clone https://github.com/PozzettiAndrea/ComfyUI-SAM3 ComfyUI/custom_nodes/ComfyUI-SAM3

cd ComfyUI

git fetch --tags
git checkout $(git tag --sort=-v:refname | head -n 1)

uv venv venv --python 3.11
source venv/bin/activate

uv pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu130
uv pip install -r requirements.txt
uv pip install -r custom_nodes/ComfyUI-Manager/requirements.txt
uv pip install coloredlogs flatbuffers numpy packaging protobuf sympy matplotlib
uv pip install --pre --index-url https://aiinfra.pkgs.visualstudio.com/PublicPackages/_packaging/ort-cuda-13-nightly/pypi/simple/ onnxruntime-gpu
uv pip install -r custom_nodes/ComfyUI-WanAnimatePreprocess/requirements.txt
uv pip install -r custom_nodes/ComfyUI-SAM3/requirements.txt

uv pip install https://github.com/sonnybox/yt-files/raw/refs/heads/main/WHEELS/sm_120_blackwell/sageattention-2.2.0-cp311-cp311-linux_x86_64.whl

TARGET_DIR="/root/ComfyUI/user/default"
TARGET_FILE="$TARGET_DIR/comfy.settings.json"

mkdir -p "$TARGET_DIR"

cat > "$TARGET_FILE" << 'EOF'
{
    "Comfy.TutorialCompleted": true,
    "VHS.LatentPreview": true,
    "Comfy.ColorPalette": "github",
    "Comfy.UI.TabBarLayout": "Integrated",
    "Comfy.Sidebar.Style": "floating",
    "Comfy.Sidebar.Size": "small",
    "LiteGraph.Canvas.MinFontSizeForLOD": 0,
    "Comfy.Keybinding.NewBindings": [
        {
            "commandId": "Comfy.Canvas.FitView",
            "combo": {
                "key": "f",
                "ctrl": false,
                "alt": false,
                "shift": false
            }
        }
    ],
    "Comfy.Keybinding.UnsetBindings": [
        {
            "commandId": "Comfy.Canvas.FitView",
            "combo": {
                "key": ".",
                "ctrl": false,
                "alt": false,
                "shift": false
            },
            "targetElementId": "graph-canvas-container"
        }
    ]
}
EOF

mkdir -p /root/ComfyUI/user/default/workflows

wget -c https://raw.githubusercontent.com/sonnybox/yt-files/refs/heads/main/COMFY/workflows/Wan%20Animate%20-%20Character%20Swap%20-%20RunPod%20-%20RTX%20Pro%206000.json -O "/root/ComfyUI/user/default/workflows/Character Swap.json"

wget -c https://raw.githubusercontent.com/sonnybox/yt-files/refs/heads/main/COMFY/workflows/Wan%20Animate%20-%20Head%20Swap%20-%20RunPod%20-%20RTX%20Pro%206000.json -O "/root/ComfyUI/user/default/workflows/Head Swap.json"

python main.py \
	--listen \
	--preview-method auto \
	--max-upload-size 9999999
