#!/bin/bash

export PATH=$PATH:~/dLabPro/bin.release/

echo "====================================================="
echo "=============== Generated results ==================="

recognizer -cfg recognizer.cfg filelist.flst -out res 2>/dev/null
recognizer -cfg recognizer.cfg filelist.flst -out dbg 2>/dev/null | grep "dbg: rec nad:"

echo "====================================================="
echo "=============== Expected results ===================="

cat expected.txt

