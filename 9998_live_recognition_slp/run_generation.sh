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
	
	# remove whole sentences that we don't normalize right now
	
	# digits
	(cat $1.norm.tmp1 | grep -v '[[:digit:]]') > $1.norm.tmp2

	# curly braces (no word classes here)
	(cat $1.norm.tmp2 | grep -v '{' | grep -v '}') > $1.norm.tmp3
	
	# normal braces
	(cat $1.norm.tmp3 | grep -v '(' | grep -v ')') > $1.norm.tmp4
	
	# rect braces
	(cat $1.norm.tmp4 | grep -v '\[' | grep -v '\]') > $1.norm.tmp5
	
	# umlauts
	(cat $1.norm.tmp5 | grep -v 'Ä' | grep -v 'Ö' | grep -v 'Ü' | grep -v 'ß') > $1.norm.tmp6
	
	
	# remove special characters but keep sentences
	sed -e 's/-//g'  -e 's/"//g'  -e 's/,//g'  -e 's/\.//g' -e 's/\?//g' \
	    -e 's/\!//g' -e 's/–//g'  -e 's/„//g'  -e 's/“//g'  -e "s/'//g"  \
	    -e 's/\///g' -e 's/://g'  -e 's/;//g'  -e 's/*//g'  -e 's/_//g'  \
	    -e 's/”//g'  -e 's/»//g'  -e 's/«//g'  -e 's/‚//g'  -e 's/‘//g'  \
	    -e 's/<//g'  -e 's/>//g'  -e 's/=//g'  -e 's/&//g'  -e 's/|//g'  \
	    -e 's/…//g'  -e 's/#//g'  -e 's/’//g'  -e 's/+//g'  -e 's/•//g'  \
	    -e 's/\^//g' -e 's/¹//g'  -e 's/■//g'  -e 's/\\//g' -e 's/¿//g'  \
	    -e 's/©//g'  -e 's/%//g'  -e 's/§//g'  -e 's/¯//g'  -e 's/´//g'  \
	    -e 's/@//g'  -e 's/~//g'  -e 's/∞//g'  -e 's/‛//g'  -e 's/˝//g'  \
	    -e 's/`//g'  -e 's/−//g'  -e 's/†//g'  -e 's/®//g'  -e 's/�//g'  \
	    -e 's/\xC2\xA0//g' \
	    $1.norm.tmp6 > $1.norm
	    
	# -e 's/\=//g' -e 's/\&//g' -e 's/\|//g'
	    
	# sanity check: no lines should match this anymore
	cat $1.norm | sed -e 's/\w//g' | sed '/^[[:space:]]*$/d'
	
	echo "If you see output above, file $1.norm is NOT properly normalized!"
	    
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

function create_ngrams {
	OUTDIR=$1-tri
	echo "Processing $1 - store in $OUTDIR"
	rm -rf $OUTDIR/*
	mkdir -p $OUTDIR
	
	cp $1-nrm/$1.norm          $OUTDIR
	cp $1-lex/corpus/hsb.vocab $OUTDIR
	
	cd $OUTDIR/
	
	ngramsymbols --OOV_symbol="<unk>" hsb.vocab hsb.syms
	farcompilestrings --fst_type=compact --symbols=hsb.syms --keep_symbols --unknown_symbol="<unk>" $1.norm hsb.far
	
	echo "Create ngrams with order $3"
	ngramcount --order=$3 hsb.far hsb.cnts
	
	echo "Shrinking with parameter $2"
	ngrammake --backoff --method=witten_bell hsb.cnts hsb.mod
	ngramshrink --method=relative_entropy --theta=$2 hsb.mod hsb.pru
	ls -l hsb.mod hsb.pru
	
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

function package_recognizer {
	OUTDIR=$1-rec
	echo "Processing $1 - store in $OUTDIR"
	rm -rf $OUTDIR/*
	mkdir -p $OUTDIR
	
	# acoustic model
	cp -r uasr-data $OUTDIR
	
	# lexicon
	mkdir -p $OUTDIR/uasr-data/db-hsb-asr/common/lex/
	cp $1-lex/uasr_configurations/lexicon/hsb_sampa.ulex $OUTDIR/uasr-data/db-hsb-asr/common/lex/hsb.ulex
	
	# language model
	mkdir -p $OUTDIR/uasr-data/db-hsb-asr/common/lm/
	cp $1-con/hsb.txt_ofst.txt    $OUTDIR/uasr-data/db-hsb-asr/common/lm/
	cp $1-con/hsb.txt_ofst_is.txt $OUTDIR/uasr-data/db-hsb-asr/common/lm/
	cp $1-con/hsb.txt_ofst_os.txt $OUTDIR/uasr-data/db-hsb-asr/common/lm/
	
	cp cfg/package.cfg $OUTDIR
	
	cd $OUTDIR

	UASR_HOME=uasr $HOME/dLabPro/bin.release/dlabpro $HOME/UASR/scripts/dlabpro/tools/REC_PACKDATA.xtp rec package.cfg -v2
	
	cd ..
}

normalize sorbian_institute_monolingual.hsb
normalize witaj_monolingual.hsb
normalize web_monolingual.hsb
normalize smartlamp.corp
normalize cv.hsb

generate_lexica sorbian_institute_monolingual.hsb
generate_lexica witaj_monolingual.hsb
generate_lexica web_monolingual.hsb
generate_lexica smartlamp.corp
generate_lexica cv.hsb

# theta == 1.0e-7  --> resulting model way too big for a big corpus
# theta == 0.00015 --> significant reduction 

create_ngrams sorbian_institute_monolingual.hsb 0.00015 3
create_ngrams witaj_monolingual.hsb 0.00015 3
create_ngrams web_monolingual.hsb 0.00015 3
create_ngrams smartlamp.corp 1.0e-7 3
create_ngrams cv.hsb 0.00015 3

# single corpora language models

convert_fst sorbian_institute_monolingual.hsb
convert_fst witaj_monolingual.hsb
convert_fst web_monolingual.hsb
convert_fst smartlamp.corp
convert_fst cv.hsb

# reverse order due to complexity
package_recognizer smartlamp.corp
package_recognizer cv.hsb
package_recognizer web_monolingual.hsb
package_recognizer witaj_monolingual.hsb
package_recognizer sorbian_institute_monolingual.hsb

