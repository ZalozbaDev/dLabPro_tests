#!/bin/bash

export UASR_HOME=$(pwd)/uasr

export PATH=$PATH:~/dLabPro/bin.release/

dlabpro $HOME/UASR/scripts/dlabpro/tools/REC_PACKDATA.xtp rec uasr-data/db-hsb-asr-exp/common/info/grm.cfg

