!/bin/bash
echo 'cd /root' >> /etc/bash.bashrc
echo 'source venv/bin/activate' >> /etc/bash.bashrc
cd /root

git clone https://github.com/Comfy-Org/ComfyUI
git clone https://github.com/thu-ml/SageAttention
git clone https://github.com/Comfy-Org/ComfyUI-Manager ComfyUI/custom_nodes/ComfyUI-Manager

uv venv venv --python $PYTHON_VERSION
source venv/bin/activate

uv pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu130
uv pip install -r ComfyUI/requirements.txt
uv pip install -r ComfyUI/custom_nodes/ComfyUI-Manager/requirements.txt

cd SageAttention
git checkout v2.2.0
uv pip install setuptools ninja
uv pip install . --no-build-isolation
cd ..

python ComfyUI/main.py
sleep infinity
