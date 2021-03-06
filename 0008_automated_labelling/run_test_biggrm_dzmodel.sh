#!/bin/bash

export PATH=$PATH:~/dLabPro/bin.release/
export UASR_HOME=$(pwd)/uasr

echo "====================================================="
echo "=============== Generated results ==================="

# this directory shall always be empty each time the script is run
rm -rf uasr-data/db-hsb-asr/common/lab_biggrm_dzmodel
mkdir -p uasr-data/db-hsb-asr/common/lab_biggrm_dzmodel

# clean log dir
rm -rf uasr-data/db-hsb-asr/HSB-01/log
mkdir -p uasr-data/db-hsb-asr/HSB-01/log

dlabpro $HOME/UASR/scripts/dlabpro/HMM.xtp lab uasr-data/db-hsb-asr/HSB-01/info/label_biggrm_dzmodel.cfg

echo "====================================================="
echo "====== Compare with expected results ================"

diff -Naur expected_bad/ uasr-data/db-hsb-asr/common/lab_biggrm_dzmodel/

echo "======== Small differences maybe ok ================="
echo "====================================================="

