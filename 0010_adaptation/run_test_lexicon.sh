#!/bin/bash

export UASR_HOME=$(pwd)/uasr

PATH=$PATH:$HOME/dLabPro/bin.release dlabpro $HOME/UASR/scripts/dlabpro/HMM.xtp evl uasr-data/db-hsb-asr/HSB-01/info/adapt_tst.cfg -Puasr.am.model="3_7_A" -Puasr.am.eval.mode="0" -v2

