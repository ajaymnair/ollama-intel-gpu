# ollama-intel-gpu

This repo illustrates the use of Ollama with support for Intel ARC GPU based via ipex-llm and Ollama Portable ZIP support.

## Important Note

All Ollama based ipex-llm defects should be reported directly to the ipex-llm project at https://github.com/intel/ipex-llm

## Screenshot
![screenshot](doc/screenshot.png)

# Prerequisites
* Intel ARC series GPU (tested with Intel(R) Core(TM) Ultra 265K integrated GPU)
 
*Note:* If you have multiple GPU's installed (like integrated and discrete), set the ONEAPI_DEVICE_DELECTOR environment variable in the docker compose file to select the intended device to use.
