#!/bin/bash

echo 'cd /root' >> /etc/bash.bashrc
echo 'source /root/ComfyUI/venv/bin/activate' >> /etc/bash.bashrc

cd /root

wget https://github.com/sonnybox/yt-files/raw/refs/heads/main/COMFY/runpod_scripts/download_wan_animate_models.sh

git clone https://github.com/Comfy-Org/ComfyUI
git clone https://github.com/Comfy-Org/ComfyUI-Manager ComfyUI/custom_nodes/ComfyUI-Manager
git clone https://github.com/kijai/ComfyUI-WanAnimatePreprocess ComfyUI/custom_nodes/ComfyUI-WanAnimatePreprocess

cd ComfyUI

git fetch --tags
git checkout $(git tag --sort=-v:refname | head -n 1)

uv venv venv --python 3.11
source venv/bin/activate

uv pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu130
uv pip install -r requirements.txt
uv pip install -r custom_nodes/ComfyUI-Manager/requirements.txt
uv pip install coloredlogs flatbuffers numpy packaging protobuf sympy
uv pip install --pre --index-url https://aiinfra.pkgs.visualstudio.com/PublicPackages/_packaging/ort-cuda-13-nightly/pypi/simple/ onnxruntime-gpu
uv pip install -r custom_nodes/ComfyUI-WanAnimatePreprocess/requirements.txt

wget https://github.com/sonnybox/yt-files/raw/refs/heads/main/WHEELS/sageattention-2.2.0-cu130-sm120-cp311-linux_x86_64.whl
mv sageattention* sageattention-2.2.0-cp311-cp311-linux_x86_64.whl
uv pip install sageattention-2.2.0-cp311-cp311-linux_x86_64.whl

TARGET_DIR="/root/ComfyUI/user/default"
TARGET_FILE="$TARGET_DIR/comfy.settings.json"

mkdir -p "$TARGET_DIR"

cat > "$TARGET_FILE" << 'EOF'
{
    "Comfy.InstalledVersion": "1.37.11",
    "Comfy.TutorialCompleted": true,
    "VHS.LatentPreview": true
}
EOF

python main.py \
	--listen \
	--preview-method auto \
	--max-upload-size 9999999
