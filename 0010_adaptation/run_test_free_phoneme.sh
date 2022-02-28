#!/bin/bash

export UASR_HOME=$(pwd)/uasr

# PATH=$PATH:$HOME/dLabPro/bin.release dlabpro $HOME/UASR/scripts/dlabpro/HMM.xtp evl uasr-data/db-hsb-asr/HSB-01/info/eval.cfg -Puasr.am.model="3_7_A" -v2

PATH=$PATH:$HOME/dLabPro/bin.release dlabpro $HOME/UASR/scripts/dlabpro/HMM.xtp evl uasr-data/db-hsb-asr/HSB-01/info/eval.cfg -Puasr.am.model="3_7" | sed -n -e '/Evaluation result/,$p'

echo "=============================== Above: Model 3_7 free phoneme ==========================================================================================="

PATH=$PATH:$HOME/dLabPro/bin.release dlabpro $HOME/UASR/scripts/dlabpro/HMM.xtp evl uasr-data/db-hsb-asr/HSB-01/info/eval.cfg -Puasr.am.model="3_7_A" | sed -n -e '/Evaluation result/,$p'

echo "=============================== Above: Model 3_7_A free phoneme ==========================================================================================="



