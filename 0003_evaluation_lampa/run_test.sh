#!/bin/bash

export UASR_HOME=$(pwd)/uasr

export PATH=$PATH:~/dLabPro/bin.release/

dlabpro ../../UASR/scripts/dlabpro/HMM.xtp evl uasr-data/db-hsb-asr-exp/common/info/eval_new.cfg

echo "=============================================="
echo "============ Expected result ================="

cat expected.txt

echo "=============================================="

