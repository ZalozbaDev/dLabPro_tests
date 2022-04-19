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

function generate_lexica {
	OUTDIR=$1-lex
	echo "Processing $1 - store in $OUTDIR"
	rm -rf $OUTDIR/*
	mkdir -p $OUTDIR
	
	cp tools/*        $OUTDIR
	cp phoneme_rules* $OUTDIR
	
	sed -e s/smartlamp.corp/$1/ $OUTDIR/HSB.yaml
	cd $OUTDIR && python3 BASgenerator.py HSB.yaml
}

function create_trigrams {
	OUTDIR=$1-tri
	echo "Processing $1 - store in $OUTDIR"
	rm -rf $OUTDIR/*
	mkdir -p $OUTDIR
	
	ngramsymbols --OOV_symbol="<unk>" $1 $OUTDIR/$1.syms
	farcompilestrings --fst_type=compact --symbols=$OUTDIR/$1.syms --keep_symbols --unknown_symbol="<unk>" $1 lm/hsb.far
}



generate_lexica sorbian_institute_monolingual.hsb
generate_lexica witaj_monolingual.hsb
generate_lexica web_monolingual.hsb
generate_lexica cv.hsb

#create_trigrams sorbian_institute_monolingual.hsb
#create_trigrams witaj_monolingual.hsb
#create_trigrams web_monolingual.hsb
#create_trigrams cv.hsb
