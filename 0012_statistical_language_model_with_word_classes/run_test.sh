#!/bin/bash

rm -rf corpus/ sentences/ speechrecorder/ uasr_configurations/

python3 BASgenerator.py HSB.yaml

rm -f merge/hsb.txt merge/hsb_tmp.txt

fstprint lm/hsb.mod > merge/hsb_tmp.txt

pushd merge/

cat hsb_tmp.txt | sed -e 's/<epsilon>/<eps>/g' | \
sed -e 's/{PERCENT}\(.*\){PERCENT}/NUM1-100\1<eps>/' > hsb.txt

python3 grmmerge.py -lmw 10 -ofstin hsb.txt

popd

rm -rf uasr-data/db-hsb-asr/grammatics/word_class_lm/lm/
mkdir -p uasr-data/db-hsb-asr/grammatics/word_class_lm/lm/
cp merge/hsb.txt_ofst.txt uasr-data/db-hsb-asr/grammatics/word_class_lm/lm/

export PATH=$PATH:$HOME/dLabPro/bin.release/
export UASR_HOME=uasr

dlabpro $HOME/UASR/scripts/dlabpro/tools/REC_PACKDATA.xtp rec default_lm.cfg

recognizer -cfg recognizer.cfg ./sig_free/list.flst 2>/dev/null | grep  'cmd:\|processing'
