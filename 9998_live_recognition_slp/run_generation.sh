#!/bin/bash

# fetch the corpora we wish to experiment with
if ! [ -e sorbian_institute_monolingual.hsb ]; then
	wget https://www.statmt.org/wmt20/unsup_and_very_low_res/sorbian_institute_monolingual.hsb.gz
	gunzip sorbian_institute_monolingual.hsb.gz
fi

if ! [ -e witaj_monolingual.hsb ]; then
	wget https://www.statmt.org/wmt20/unsup_and_very_low_res/witaj_monolingual.hsb.gz
	gunzip witaj_monolingual.hsb.gz
fi

if ! [ -e web_monolingual.hsb ]; then
	wget https://www.statmt.org/wmt20/unsup_and_very_low_res/web_monolingual.hsb.gz
	gunzip web_monolingual.hsb.gz
fi

