#!/bin/bash

export PATH=$PATH:~/dLabPro/bin.release/
export UASR_HOME=$(pwd)/uasr

echo "====================================================="
echo "=============== Generated results ==================="

# clean log dir
rm -rf uasr-data/db-hsb-asr/HSB-01/log
mkdir -p uasr-data/db-hsb-asr/HSB-01/log

./run_adaptation.sh

./run_test_lexicon.sh > logfile_adaptation_test.txt
./run_test_free_phoneme.sh >> logfile_adaptation_test.txt


echo "====================================================="
echo "====== Compare with expected results ================"

diff -u logfile_adaptation_test.txt expected/logfile_adaptation_test.txt


