#!/bin/bash

###########################################
# create corpus and vocabulary
###########################################

rm -rf corpus/ sentences/ speechrecorder/ uasr_configurations/

python3 BASgenerator.py HSB.yaml

###########################################
# create statistical model from corpus only
###########################################

rm -rf lm/*
mkdir -p lm/

ngramsymbols --OOV_symbol="<unk>" corpus/hsb.vocab lm/hsb.syms

farcompilestrings --fst_type=compact --symbols=lm/hsb.syms --keep_symbols --unknown_symbol="<unk>" corpus/hsb.corp lm/hsb.far

ngramcount --order=2 lm/hsb.far lm/hsb.cnts

ngrammake --backoff --method=witten_bell lm/hsb.cnts lm/hsb.mod

ngramshrink --method=relative_entropy --theta=1.0e-7 lm/hsb.mod lm/hsb.pru


ngramperplexity --OOV_symbol="<unk>" lm/hsb.mod lm/hsb.far

ngramperplexity --OOV_symbol="<unk>" lm/hsb.pru lm/hsb.far


###########################################
# merge word classes into model
###########################################

rm -f merge/hsb.txt merge/hsb_tmp.txt

fstprint lm/hsb.mod > merge/hsb_tmp.txt

pushd merge/

cat hsb_tmp.txt | sed -e 's/<epsilon>/<eps>/g' | \
sed -e 's/{PERCENT}\(.*\){PERCENT}/NUM1-100\1<eps>/' > hsb.txt

python3 grmmerge.py -lmw 10 -ofstin hsb.txt

popd

###########################################
# compile recognizer data
###########################################

rm -rf uasr-data/db-hsb-asr/grammatics/word_class_lm/lm/
mkdir -p uasr-data/db-hsb-asr/grammatics/word_class_lm/lm/
cp merge/hsb.txt_ofst.txt uasr-data/db-hsb-asr/grammatics/word_class_lm/lm/

export PATH=$PATH:$HOME/dLabPro/bin.release/
export UASR_HOME=uasr

dlabpro $HOME/UASR/scripts/dlabpro/tools/REC_PACKDATA.xtp rec default_lm.cfg

###########################################
# run recognition
###########################################

recognizer -cfg recognizer.cfg ./sig_free/list.flst 2>/dev/null | grep  'cmd:\|processing'
