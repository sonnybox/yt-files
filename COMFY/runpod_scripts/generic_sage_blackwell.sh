#!/bin/bash

echo 'cd /root' >> /etc/bash.bashrc
echo 'source /root/ComfyUI/venv/bin/activate' >> /etc/bash.bashrc

cd /root

git clone https://github.com/Comfy-Org/ComfyUI
git clone https://github.com/Comfy-Org/ComfyUI-Manager ComfyUI/custom_nodes/ComfyUI-Manager

cd ComfyUI

git fetch --tags
git checkout $(git tag --sort=-v:refname | head -n 1)

uv venv venv --python 3.12
source venv/bin/activate

uv pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu130
uv pip install -r requirements.txt
uv pip install -r custom_nodes/ComfyUI-Manager/requirements.txt
uv pip install https://github.com/sonnybox/yt-files/raw/refs/heads/main/WHEELS/sm_120_blackwell/sageattention-2.2.0-cp312-cp312-linux_x86_64.whl

python main.py \
	--listen 0.0.0.0 \
    --port 8188 \
	--preview-method auto \
	--max-upload-size 9999999
