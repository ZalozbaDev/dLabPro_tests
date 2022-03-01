#!/bin/bash

# export PATH=$PATH:~/dLabPro/bin.release/

# sound card now defined in config (by name)
sudo ~/dLabPro/bin.release/recognizer -cfg recognizer.cfg -out vad | grep -v pF
