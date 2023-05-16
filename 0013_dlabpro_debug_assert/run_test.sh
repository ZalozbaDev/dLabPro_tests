#!/bin/bash

export UASR_HOME=/home/pi/UASR/
export DLABPRO_HOME=/home/pi/dLabPro/

echo "Run in release mode."

$DLABPRO_HOME/bin.release/dlabpro grm2ofst.xtp  ./combined_uasr_grammar.txt NUM1-99 NUM5-99 NUM1-100 digidom NUM1-9

echo "Run in debug mode."

$DLABPRO_HOME/bin.debug/dlabpro grm2ofst.xtp  ./combined_uasr_grammar.txt NUM1-99 NUM5-99 NUM1-100 digidom NUM1-9


