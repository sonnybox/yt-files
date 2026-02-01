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

uv pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu128
uv pip install -r requirements.txt
uv pip install -r custom_nodes/ComfyUI-Manager/requirements.txt
uv pip install -r custom_nodes/ComfyUI-WanAnimatePreprocess/requirements.txt

# PUT SAGE WHEEL HERE WHEN COMPILED

# models
wget https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/diffusion_models/wan2.2_animate_14B_bf16.safetensors -O models/diffusion_models/wan2.2_animate_14B_bf16.safetensors

wget https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/LoRAs/Wan22_relight/WanAnimate_relight_lora_fp16.safetensors -O models/loras/WanAnimate_relight_lora_fp16.safetensors

wget https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/Lightx2v/lightx2v_I2V_14B_480p_cfg_step_distill_rank128_bf16.safetensors -O models/loras/lightx2v_I2V_14B_480p_cfg_step_distill_rank128_bf16.safetensors

mkdir -p models/detection
wget https://huggingface.co/Wan-AI/Wan2.2-Animate-14B/resolve/main/process_checkpoint/det/yolov10m.onnx -O models/detection/yolov10m.onnx

wget https://huggingface.co/JunkyByte/easy_ViTPose/resolve/main/onnx/wholebody/vitpose-l-wholebody.onnx -O models/detection/vitpose-l-wholebody.onnx

wget https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/umt5-xxl-enc-bf16.safetensors -O models/text_encoders/umt5-xxl-enc-bf16.safetensors

wget https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/Wan2_1_VAE_bf16.safetensors -O models/vae/Wan2_1_VAE_bf16.safetensors

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
