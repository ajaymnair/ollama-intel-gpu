# ollama-intel-gpu

This repo illustrates the use of Ollama with support for Intel ARC GPU based via ipex-llm and Ollama Portable ZIP support.

## Important Note

All Ollama based ipex-llm defects should be reported directly to the ipex-llm project at https://github.com/intel/ipex-llm

## Screenshot
![screenshot](doc/screenshot.png)

# Prerequisites
* Intel ARC series GPU (tested with Intel ARC A770 16GB and Intel(R) Core(TM) Ultra 5 125H integrated GPU)
 
*Note:* If you have multiple GPU's installed (like integrated and discrete), set the ONEAPI_DEVICE_DELECTOR environment variable in the docker compose file to select the intended device to use.

Then launch your web browser to http://localhost:3000 to launch the web ui.  Create a local OpenWeb UI credential, then click the settings icon in the top right of the screen, then select 'Models', then click 'Show', then download a model like 'llama3.1:8b-instruct-q8_0' for Intel ARC A770 16GB VRAM

## Update to the latest IPEX-LLM Portable Zip Version

To update to the latest portable zip version of IPEX-LLM's Ollama, update the compose file with the build arguments shown below, using the latest `ollama-*.tgz` release from https://github.com/intel/ipex-llm/releases/tag/v2.2.0-nightly , then rebuild the image.

```yaml
ollama-intel-gpu:
    build:
      context: .
      dockerfile: Dockerfile
      args:
        IPEXLLM_RELEASE_REPO: intel/ipex-llm
        IPEXLLM_RELEASE_VERSON: v2.2.0-nightly
        IPEXLLM_PORTABLE_ZIP_FILENAME: ollama-ipex-llm-2.2.0b20250313-ubuntu.tgz
``` 

# References
* https://dgpu-docs.intel.com/driver/client/overview.html
* https://github.com/intel/ipex-llm/blob/main/docs/mddocs/Quickstart/llamacpp_portable_zip_gpu_quickstart.md
* https://github.com/intel/ipex-llm/releases/download/v2.2.0-nightly/ollama-ipex-llm-2.2.0b20250313-ubuntu.tgz
