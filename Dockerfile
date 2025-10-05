FROM nvidia/cuda:13.0.0-cudnn-devel-ubuntu24.04

RUN apt update && apt upgrade -y
RUN apt install -y build-essential git libgomp1 cmake curl libcurl4-openssl-dev

RUN git clone https://github.com/ggml-org/llama.cpp
RUN cd llama.cpp && cmake -B build -DGGML_CUDA=ON -DBUILD_SHARED_LIBS=OFF -DLLAMA_CURL=ON
RUN cd llama.cpp && cmake --build build --config Release -j 4

CMD ["./llama.cpp/build/bin/llama-server", "--host", "0.0.0.0", "--port", "8001", "-ngl", "99", "-hf", "unsloth/LFM2-1.2B-GGUF", "-hff", "LFM2-1.2B-Q4_K_M.gguf", "-fa", "on"]
