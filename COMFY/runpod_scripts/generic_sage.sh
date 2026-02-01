#!/bin/bash
echo 'cd /root' >> /etc/bash.bashrc
echo 'source venv/bin/activate' >> /etc/bash.bashrc
cd /root

wget https://archive.archlinux.org/packages/c/cuda/cuda-12.8.1-3-x86_64.pkg.tar.zst -O /root/cuda.tar.zst
wget https://archive.archlinux.org/packages/g/gcc/gcc-14.2.1%2Br753%2Bg1cd744a6828f-1-x86_64.pkg.tar.zst -O /root/gcc.tar.zst
pacman -U /root/gcc.tar.zst --noconfirm
pacman -U /root/cuda.tar.zst --noconfirm

export PATH="$CUDA_HOME/bin:$PATH"

git clone https://github.com/Comfy-Org/ComfyUI
git clone https://github.com/thu-ml/SageAttention
git clone https://github.com/Comfy-Org/ComfyUI-Manager ComfyUI/custom_nodes/ComfyUI-Manager

uv venv venv --python $PYTHON_VERSION
source venv/bin/activate

uv pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu128
uv pip install -r ComfyUI/requirements.txt
uv pip install -r ComfyUI/custom_nodes/ComfyUI-Manager/requirements.txt

cd SageAttention
git checkout v2.2.0
uv pip install setuptools ninja
uv pip install . --no-build-isolation
cd ..

python ComfyUI/main.py --listen
sleep infinity
