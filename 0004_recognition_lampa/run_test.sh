#!/bin/bash

export PATH=$PATH:~/dLabPro/bin.release/

echo "====================================================="
echo "=============== Generated results ==================="


for i in $(ls -1 *.wav); do 
	# echo "Recognizing $i"
	recognizer -cfg recognizer.cfg $i -out res 2>/dev/null
	recognizer -cfg recognizer.cfg $i -out dbg 2>/dev/null | grep "dbg: rec nad:"
	# echo "--------------------------------------------"
done

echo "====================================================="
echo "=============== Expected results ===================="

cat expected.txt

