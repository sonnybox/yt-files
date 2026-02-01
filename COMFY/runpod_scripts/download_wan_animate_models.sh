#!/bin/bash
cd /root/ComfyUI

wget https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/diffusion_models/wan2.2_animate_14B_bf16.safetensors -O models/diffusion_models/wan2.2_animate_14B_bf16.safetensors

wget https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/LoRAs/Wan22_relight/WanAnimate_relight_lora_fp16.safetensors -O models/loras/WanAnimate_relight_lora_fp16.safetensors

wget https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/Lightx2v/lightx2v_I2V_14B_480p_cfg_step_distill_rank128_bf16.safetensors -O models/loras/lightx2v_I2V_14B_480p_cfg_step_distill_rank128_bf16.safetensors

mkdir -p models/detection
wget https://huggingface.co/Wan-AI/Wan2.2-Animate-14B/resolve/main/process_checkpoint/det/yolov10m.onnx -O models/detection/yolov10m.onnx

wget https://huggingface.co/JunkyByte/easy_ViTPose/resolve/main/onnx/wholebody/vitpose-l-wholebody.onnx -O models/detection/vitpose-l-wholebody.onnx

wget https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/umt5-xxl-enc-bf16.safetensors -O models/text_encoders/umt5-xxl-enc-bf16.safetensors

wget https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/Wan2_1_VAE_bf16.safetensors -O models/vae/Wan2_1_VAE_bf16.safetensors
