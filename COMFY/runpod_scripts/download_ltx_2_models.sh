#!/bin/bash
cd /root/ComfyUI

mkdir -p models/diffusion_models \
         models/text_encoders \
         models/latent_upscale_models \
         models/loras

wget -c "https://huggingface.co/Lightricks/LTX-2/resolve/main/ltx-2-19b-dev.safetensors" \
  -O "models/diffusion_models/ltx-2-19b-dev.safetensors"

wget -c "https://huggingface.co/Comfy-Org/ltx-2/resolve/main/split_files/text_encoders/gemma_3_12B_it.safetensors" \
  -O "models/text_encoders/gemma_3_12B_it.safetensors"

wget -c "https://huggingface.co/Lightricks/LTX-2/resolve/main/ltx-2-spatial-upscaler-x2-1.0.safetensors" \
  -O "models/latent_upscale_models/ltx-2-spatial-upscaler-x2-1.0.safetensors"

wget -c "https://huggingface.co/Kijai/LTXV2_comfy/resolve/main/loras/ltx-2-19b-distilled-lora-resized_dynamic_fro095_avg_rank_242_bf16.safetensors" \
  -O "models/loras/ltx-2-19b-distilled-lora-resized_dynamic_fro095_avg_rank_242_bf16.safetensors"

