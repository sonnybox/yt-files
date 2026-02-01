#!/bin/bash
echo 'cd /root' >> /etc/bash.bashrc
echo 'source venv/bin/activate' >> /etc/bash.bashrc
cd /root

wget https://developer.download.nvidia.com/compute/cuda/12.8.1/local_installers/cuda_12.8.1_570.124.06_linux.run -O /root/cuda128.run
sh /root/cuda128.run --silent --toolkit --toolkitpath=/opt/cuda
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

python ComfyUI/main.py
sleep infinity
