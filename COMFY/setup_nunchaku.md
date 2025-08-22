## How to setup Nunchaku in ComfyUI on Arch Linux

1. Find your ComfyUI repo

2. Source your environment

3. Check your torch and python versions

`python -c "import sys; import torch; print(f'Python Version: {sys.version.split()[0]}'); print(f'PyTorch Version: {torch.__version__}')"`

4. Go to Nunchaku releases

[https://github.com/nunchaku-tech/nunchaku/releases](https://github.com/nunchaku-tech/nunchaku/releases)

5. Find the correct torch and python combo for Linux

6. Download it to your PC with `wget`

`wget https://github.com/nunchaku-tech/nunchaku/releases/download/v0.3.2/nunchaku-0.3.2+torch2.8-cp312-cp312-linux_x86_64.whl`

7. Make sure you have `xformers` installed

`uv pip install xformers`

8. Install the downloaded Nunchaku wheel (remove uv if you don't use it)

`uv pip install nunchaku-*.whl`

9. Open ComfyUI and install Nunchaku Custom Nodes

