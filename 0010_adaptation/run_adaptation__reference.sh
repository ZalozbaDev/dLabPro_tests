#!/bin/bash

export UASR_HOME=$(pwd)/uasr

PATH=$PATH:$HOME/dLabPro/bin.release dlabpro $HOME/UASR/scripts/dlabpro/HMM.xtp adp uasr-data/db-hsb-asr/HSB-01/info/adapt_reference.cfg

