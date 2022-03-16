#!/bin/bash

echo "====================================================="
echo "=============== Generated results ==================="

DLABPRO_HOME=$HOME/dLabPro/ UASR_HOME=$HOME/UASR/ python3 grmmerge.py uasr-data/db-hsb-asr-exp/grammatics/smartlamp_numbers/grm/smart_lamp_hsb_evl_fsg_num.txt

echo "====================================================="
echo "====== Compare with expected results ================"

diff -u uasr-data/db-hsb-asr-exp/grammatics/smartlamp_numbers/grm/smart_lamp_hsb_evl_fsg_num.txt_lex.txt expected/smart_lamp_hsb_evl_fsg_num.txt_lex.txt
diff -u uasr-data/db-hsb-asr-exp/grammatics/smartlamp_numbers/grm/smart_lamp_hsb_evl_fsg_num.txt_ofst_is.txt expected/smart_lamp_hsb_evl_fsg_num.txt_ofst_is.txt
diff -u uasr-data/db-hsb-asr-exp/grammatics/smartlamp_numbers/grm/smart_lamp_hsb_evl_fsg_num.txt_ofst_os.txt expected/smart_lamp_hsb_evl_fsg_num.txt_ofst_os.txt
diff -u uasr-data/db-hsb-asr-exp/grammatics/smartlamp_numbers/grm/smart_lamp_hsb_evl_fsg_num.txt_ofst.txt expected/smart_lamp_hsb_evl_fsg_num.txt_ofst.txt

echo "======== No differences means ok ===================="
echo "====================================================="


