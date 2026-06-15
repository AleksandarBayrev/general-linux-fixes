# Use `distrobox` to create a container (I use `rockylinux` as the base image)
# Install `ollama` inside the new container (check [here](https://docs.ollama.com/linux) how to do it)
# Install `python3-pip` and run `pip install open-webui`
# Run `ollama serve` (or `GGML_VK_VISIBLE_DEVICES=-1 CUDA_VISIBLE_DEVICES=-1 HIP_VISIBLE_DEVICES=-1 ollama serve` if you don't want GPU acceleration) and `open-webui serve`