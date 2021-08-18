#!/bin/bash

export UASR_HOME=$(pwd)/uasr

export PATH=$PATH:~/dLabPro/bin.release/

rm -rf generated/

dlabpro ../../UASR/scripts/dlabpro/tools/REC_PACKDATA.xtp dlg uasr-data/db-hsb-asr-exp/common/info/dlg.cfg

echo "============================================================="
echo "=============== Checking differences ========================"

# compare the 3 files in unpacked state
rm -rf tmpcompare
mkdir tmpcompare

zcat expected/feainfo.object > tmpcompare/feainfo.object.expected.txt
zcat generated/feainfo.object > tmpcompare/feainfo.object.generated.txt

zcat expected/sesinfo.object > tmpcompare/sesinfo.object.expected.txt
zcat generated/sesinfo.object > tmpcompare/sesinfo.object.generated.txt

zcat expected/adapted/3_20_hsb_adp.gmm > tmpcompare/3_20_hsb_adp.gmm.expected.txt
zcat generated/adapted/3_20_hsb_adp.gmm > tmpcompare/3_20_hsb_adp.gmm.generated.txt

zcat expected/dialog.fst > tmpcompare/dialog.fst.expected.txt
zcat generated/dialog.fst > tmpcompare/dialog.fst.generated.txt

diff -q tmpcompare/feainfo.object.expected.txt tmpcompare/feainfo.object.generated.txt
diff -q tmpcompare/sesinfo.object.expected.txt tmpcompare/sesinfo.object.generated.txt
diff -q tmpcompare/3_20_hsb_adp.gmm.expected.txt tmpcompare/3_20_hsb_adp.gmm.generated.txt
diff -q tmpcompare/dialog.fst.expected.txt tmpcompare/dialog.fst.generated.txt

echo "============== No output means all ok ======================="
echo "============================================================="
