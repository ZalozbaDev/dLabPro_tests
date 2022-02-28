#!/bin/bash

export PATH=$PATH:~/dLabPro/bin.release/

# sound card now defined in config (by name)
./recognizer -cfg recognizer.cfg -out vad
