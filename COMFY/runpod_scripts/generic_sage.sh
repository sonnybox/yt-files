#!/bin/bash

echo 'cd /root' >> /etc/bash.bashrc
echo 'source venv/bin/activate' >> /etc/bash.bashrc

cd /root

git clone https://github.com/Comfy-Org/ComfyUI
git clone https://github.com/Comfy-Org/ComfyUI-Manager ComfyUI/custom_nodes/ComfyUI-Manager

cd ComfyUI

git fetch --tags
git checkout $(git tag --sort=-v:refname | head -n 1)

uv venv venv --python 3.12
source venv/bin/activate

uv pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu128
uv pip install comfy-cli
uv pip install -r ComfyUI/requirements.txt
uv pip install -r ComfyUI/custom_nodes/ComfyUI-Manager/requirements.txt

# thanks kijai
uv pip install https://huggingface.co/Kijai/PrecompiledWheels/resolve/main/sageattention-2.2.0-cp312-cp312-linux_x86_64.whl

python main.py \
	--listen \
	--preview-method auto \
	--max-upload-size 9999999 \
	--extra-model-paths-config ~/comfy-user/models.yaml
