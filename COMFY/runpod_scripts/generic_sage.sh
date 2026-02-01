#!/bin/bash
echo 'cd /root' >> /etc/bash.bashrc
echo 'source venv/bin/activate' >> /etc/bash.bashrc
cd /root

MIRROR=https://archive.archlinux.org

wget $MIRROR/packages/c/cuda-tools/cuda-tools-12.8.1-3-x86_64.pkg.tar.zst -O /root/cuda.tar.zst
wget $MIRROR/packages/g/gcc14/gcc14-14.3.1%2Br416%2Bg44d5743651c4-2-x86_64.pkg.tar.zst -O /root/gcc.tar.zst
wget $MIRROR/packages/g/gcc14-libs/gcc14-libs-14.3.1%2Br416%2Bg44d5743651c4-2-x86_64.pkg.tar.zst -O /root/gcc-libs.tar.zst

pacman -U --noconfirm /root/gcc-libs.tar.zst /root/gcc.tar.zst
pacman -U --noconfirm /root/cuda.tar.zst

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
