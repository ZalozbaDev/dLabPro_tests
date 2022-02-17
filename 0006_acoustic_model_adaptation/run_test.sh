#!/bin/bash

# export PATH=$PATH:~/dLabPro/bin.release/

echo "====================================================="
echo "=============== Generated results ==================="

UASR_HOME="dummy" ./mapAM.py hsb.yaml

echo "====================================================="
echo "====== Compare with expected results ================"

rm -f hsb.hmm.expected.txt hsb.hmm.txt hsb.hmm.expected.txt.gz hsb.hmm.txt.gz
cp hsb.hmm.expected hsb.hmm.expected.txt.gz
cp hsb.hmm hsb.hmm.txt.gz
gunzip hsb.hmm.expected.txt.gz
gunzip hsb.hmm.txt.gz

diff --brief hsb.hmm.txt hsb.hmm.expected.txt 

echo "======== No output means all ok ====================="
echo "====================================================="

