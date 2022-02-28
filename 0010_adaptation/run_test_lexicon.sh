#!/bin/bash

export UASR_HOME=$(pwd)/uasr

# enable for more verbosity
# PATH=$PATH:$HOME/dLabPro/bin.release dlabpro $HOME/UASR/scripts/dlabpro/HMM.xtp evl uasr-data/db-hsb-asr/HSB-01/info/adapt.cfg -Puasr.am.model="3_7_A" -Puasr.am.eval.mode="0" -v2

PATH=$PATH:$HOME/dLabPro/bin.release dlabpro $HOME/UASR/scripts/dlabpro/HMM.xtp evl uasr-data/db-hsb-asr/HSB-01/info/adapt.cfg -Puasr.am.model="3_7" -Puasr.am.eval.mode="0" | sed -n -e '/Evaluation result/,$p'

echo "=============================== Above: Model 3_7 lexikon ==========================================================================================="

PATH=$PATH:$HOME/dLabPro/bin.release dlabpro $HOME/UASR/scripts/dlabpro/HMM.xtp evl uasr-data/db-hsb-asr/HSB-01/info/adapt.cfg -Puasr.am.model="3_7_A" -Puasr.am.eval.mode="0" | sed -n -e '/Evaluation result/,$p'

echo "=============================== Above: Model 3_7_A lexikon ==========================================================================================="



