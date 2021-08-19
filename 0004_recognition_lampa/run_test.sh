#!/bin/bash

export PATH=$PATH:~/dLabPro/bin.release/

echo "====================================================="
echo "=============== Generated results ==================="

rm -f generated.txt
touch generated.txt

for i in $(ls -1 *.wav); do 
	# echo "Recognizing $i"
	recognizer -cfg recognizer.cfg $i -out res 2>/dev/null | tee -a generated.txt
	recognizer -cfg recognizer.cfg $i -out dbg 2>/dev/null | grep "dbg: rec nad:" | tee -a generated.txt
	# echo "--------------------------------------------"
done

echo "====================================================="
echo "=============== Expected results ===================="

diff --brief expected.txt generated.txt

echo "======== No output means all ok ====================="
echo "====================================================="
