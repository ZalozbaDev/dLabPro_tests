#!/bin/bash

export PATH=$PATH:~/dLabPro/bin.release/
export UASR_HOME=$(pwd)/uasr

echo "====================================================="
echo "=============== Generated results ==================="

# clean log dir
rm -rf uasr-data/db-hsb-asr/HSB-01/log
mkdir -p uasr-data/db-hsb-asr/HSB-01/log

# clean model dir
rm -rf uasr-data/db-hsb-asr/HSB-01/model
mkdir -p uasr-data/db-hsb-asr/HSB-01/model

dlabpro $HOME/UASR/scripts/dlabpro/HMM.xtp trn uasr-data/db-hsb-asr/HSB-01/info/train.cfg

echo "====================================================="
echo "====== Compare with expected results ================"

rm -rf generated
mkdir -p generated

for i in $(cd uasr-data/db-hsb-asr/HSB-01/model; ls -1 *.hmm | sed -e 's/\.hmm//'); do
	echo "Evaluating $i"
	dlabpro $HOME/UASR/scripts/dlabpro/HMM.xtp evl uasr-data/db-hsb-asr/HSB-01/info/train.cfg -Puasr.am.model="$i" | sed -n -e '/Evaluation result/,$p' > generated/$i.txt
done
