FROM ubuntu:24.04
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=america/new_york

# Base packages
RUN apt update && \
    apt install --no-install-recommends -q -y \
    software-properties-common \
    ca-certificates \
    wget \
    ocl-icd-libopencl1

# Intel GPU compute user-space drivers
RUN mkdir -p /tmp/gpu && \
 cd /tmp/gpu && \
 wget https://github.com/oneapi-src/level-zero/releases/download/v1.22.4/level-zero_1.22.4+u24.04_amd64.deb && \
 wget https://github.com/intel/intel-graphics-compiler/releases/download/v2.12.5/intel-igc-core-2_2.12.5+19302_amd64.deb && \
 wget https://github.com/intel/intel-graphics-compiler/releases/download/v2.12.5/intel-igc-opencl-2_2.12.5+19302_amd64.deb && \
 # wget https://github.com/intel/compute-runtime/releases/download/25.22.33944.8/intel-ocloc-dbgsym_25.22.33944.8-0_amd64.ddeb && \
 wget https://github.com/intel/compute-runtime/releases/download/25.22.33944.8/intel-ocloc_25.22.33944.8-0_amd64.deb && \
 # wget https://github.com/intel/compute-runtime/releases/download/25.22.33944.8/intel-opencl-icd-dbgsym_25.22.33944.8-0_amd64.ddeb && \
 wget https://github.com/intel/compute-runtime/releases/download/25.22.33944.8/intel-opencl-icd_25.22.33944.8-0_amd64.deb && \
 wget https://github.com/intel/compute-runtime/releases/download/25.22.33944.8/libigdgmm12_22.7.0_amd64.deb && \
 # wget https://github.com/intel/compute-runtime/releases/download/25.22.33944.8/libze-intel-gpu1-dbgsym_25.22.33944.8-0_amd64.ddeb && \
 wget https://github.com/intel/compute-runtime/releases/download/25.22.33944.8/libze-intel-gpu1_25.22.33944.8-0_amd64.deb && \
 dpkg -i *.deb && \
 rm *.deb

# Install Ollama Portable Zip https://github.com/intel/ipex-llm/releases/download/v2.2.0/llama-cpp-ipex-llm-2.2.0-ubuntu-core.tgz
ARG IPEXLLM_PORTABLE_ZIP_FILENAME=ollama-ipex-llm-2.3.0b20250710-ubuntu.tgz
RUN cd / && \
  wget https://github.com/ipex-llm/ipex-llm/releases/download/v2.3.0-nightly/${IPEXLLM_PORTABLE_ZIP_FILENAME} && \
  tar xvf ${IPEXLLM_PORTABLE_ZIP_FILENAME} --strip-components=1 -C /

ENV OLLAMA_NUM_GPU=999 \ 
    no_proxy=localhost,127.0.0.1 \
    ZES_ENABLE_SYSMAN=1 \
    SYCL_CACHE_PERSISTENT=1 \
    OLLAMA_KEEP_ALIVE=10m \
    # [optional]
    SYCL_PI_LEVEL_ZERO_USE_IMMEDIATE_COMMANDLISTS=1 \
    OLLAMA_HOST='0.0.0.0:11434'
    # ONEAPI_DEVICE_SELECTOR=level_zero:0
    # ONEAPI_DEVICE_SELECTOR="level_zero:0;level_zero:1"

ENTRYPOINT ["/bin/bash", "-c", "exec /ollama serve"]
