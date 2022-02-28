#!/bin/bash

export UASR_HOME=$(pwd)/uasr

# PATH=$PATH:$HOME/dLabPro/bin.release dlabpro $HOME/UASR/scripts/dlabpro/HMM.xtp evl uasr-data/db-hsb-asr/HSB-01/info/adapt_reference.cfg -Puasr.am.model="3_8_A" -Puasr.am.eval.mode="0" -v2

PATH=$PATH:$HOME/dLabPro/bin.release dlabpro $HOME/UASR/scripts/dlabpro/HMM.xtp evl uasr-data/db-hsb-asr/HSB-01/info/adapt_reference.cfg -Puasr.am.model="3_8" -Puasr.am.eval.mode="0" | sed -n -e '/Evaluation result/,$p'

echo "=============================== Above: Model 3_8 lexikon ==========================================================================================="

PATH=$PATH:$HOME/dLabPro/bin.release dlabpro $HOME/UASR/scripts/dlabpro/HMM.xtp evl uasr-data/db-hsb-asr/HSB-01/info/adapt_reference.cfg -Puasr.am.model="3_8_A" -Puasr.am.eval.mode="0" | sed -n -e '/Evaluation result/,$p'

echo "=============================== Above: Model 3_8_A lexikon ==========================================================================================="

