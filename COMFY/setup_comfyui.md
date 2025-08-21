### How to setup ComfyUI on Arch Linux (NVIDIA GPU)

Ensure NVIDIA drivers & git are installed
`sudo pacman -S nvidia git`

Clone the ComfyUI repo
1. `git clone https://github.com/comfyanonymous/ComfyUI`

Install UV
2. `sudo pacman -S uv`

Go to ComfyUI git folder
3. `cd ComfyUI`

Create a virtual environment
4. `uv venv venv --python 3.12`

Add ComfyUI Manager
5. `git clone https://github.com/Comfy-Org/ComfyUI-Manager custom_nodes/ComfyUI-Manager`

Install requirements
6. `uv pip install xformers`
7. `uv pip install -r requirements.txt`
8. `cd custom_nodes/ComfyUI-Manager && uv pip install -r requirements.txt`

Change Model Path's (Optional)
1. `cp extra_model_paths.yaml.example extra_model_paths.yaml`
2. `nvim extra_model_paths.yaml`

Create startup script (I will provide examples!)

