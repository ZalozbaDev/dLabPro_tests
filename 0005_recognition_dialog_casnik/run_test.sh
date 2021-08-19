#!/bin/bash

export PATH=$PATH:~/dLabPro/bin.release/

echo "====================================================="
echo "=============== Generated results ==================="

recognizer -cfg recognizer.cfg filelist.flst -out res 2>/dev/null | tee generated.txt
recognizer -cfg recognizer.cfg filelist.flst -out dbg 2>/dev/null | grep "dbg: rec nad:" | tee -a generated.txt

echo "====================================================="
echo "====== Compare with expected results ================"

diff --brief expected.txt generated.txt

echo "======== No output means all ok ====================="
echo "====================================================="

