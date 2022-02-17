#!/bin/bash

# export PATH=$PATH:~/dLabPro/bin.release/

echo "====================================================="
echo "=============== Generated results ==================="

rm -rf corpus  sentences  speechrecorder  uasr_configurations

python3 BASgenerator.py HSB.yaml

echo "====================================================="
echo "====== Compare with expected results ================"

diff --brief -Naur corpus/              expected/corpus/
diff --brief -Naur uasr_configurations/ expected/uasr_configurations/

echo "======== No output means all ok ====================="
echo "====================================================="

