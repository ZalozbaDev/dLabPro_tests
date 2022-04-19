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

function normalize {
	OUTDIR=$1-nrm
	echo "Processing $1 - store in $OUTDIR"
	rm -rf $OUTDIR/*
	mkdir -p $OUTDIR
	
	cp $1              $OUTDIR
	
	cd $OUTDIR
	
	# upper case
	sed -e 's/\(.*\)/\U\1/' $1 > $1.norm.tmp1
	# remove special characters
	sed -e 's/-//g' -e 's/"//g' -e 's/,//g' -e 's/\.//g' -e 's/\?//g' -e 's/\!//g' -e 's/–//g' -e 's/„//g' -e 's/“//g' $1.norm.tmp1 > $1.norm
	
	cd ..
}

function generate_lexica {
	OUTDIR=$1-lex
	echo "Processing $1 - store in $OUTDIR"
	rm -rf $OUTDIR/*
	mkdir -p $OUTDIR
	
	cp $1-nrm/$1.norm  $OUTDIR
	cp tools/*         $OUTDIR
	cp phoneme_rules/* $OUTDIR
	
	sed -i s/smartlamp.corp/$1.norm/ $OUTDIR/HSB.yaml
	
	cd $OUTDIR 
	
	python3 BASgenerator.py HSB.yaml 
	
	cd ..
}

function create_trigrams {
	OUTDIR=$1-tri
	echo "Processing $1 - store in $OUTDIR"
	rm -rf $OUTDIR/*
	mkdir -p $OUTDIR
	
	cp $1-nrm/$1.norm          $OUTDIR
	cp $1-lex/corpus/hsb.vocab $OUTDIR
	
	cd $OUTDIR/
	
	ngramsymbols --OOV_symbol="<unk>" hsb.vocab hsb.syms
	farcompilestrings --fst_type=compact --symbols=hsb.syms --keep_symbols --unknown_symbol="<unk>" $1.norm hsb.far
	ngramcount --order=3 hsb.far hsb.cnts
	
	ngrammake --backoff --method=witten_bell hsb.cnts hsb.mod
	ngramshrink --method=relative_entropy --theta=1.0e-7 hsb.mod hsb.pru
	
	cd ..
}

function convert_fst {
	OUTDIR=$1-con
	echo "Processing $1 - store in $OUTDIR"
	rm -rf $OUTDIR/*
	mkdir -p $OUTDIR
	
	cp $1-tri/hsb.pru  $OUTDIR
	cp tools/*         $OUTDIR
	
	cd $OUTDIR
	
	fstprint hsb.pru > hsb.txt
	python3 grmmerge.py -ofstin hsb.txt
	
	cd ..
}

normalize smartlamp.corp
normalize cv.hsb


# generate_lexica sorbian_institute_monolingual.hsb
# generate_lexica witaj_monolingual.hsb
# generate_lexica web_monolingual.hsb
generate_lexica smartlamp.corp
generate_lexica cv.hsb

#create_trigrams sorbian_institute_monolingual.hsb
#create_trigrams witaj_monolingual.hsb
#create_trigrams web_monolingual.hsb
create_trigrams smartlamp.corp
create_trigrams cv.hsb

convert_fst smartlamp.corp
convert_fst cv.hsb
