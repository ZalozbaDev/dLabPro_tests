# Tests for dLabPro

Prerequisites:

* UASR checked out to $HOME
* dlabpro / recognizer binaries to test in $HOME/dLabPro/bin.release/

# Test cases

* 0001_rec_packdata_simple:                          repackaging acoustic model and simple grammar for standalone recognizer. 
* 0002_rec_packdata_dialog:                          repackaging acoustic model and dialog grammar for standalone recognizer. 
* 0003_evaluation_lampa:                             evaluation run with smart lamp test data
* 0004_recognition_lampa:                            recognition run with smart lamp test data
* 0005_recognition_dialog_casnik:                    recognition run with dialog test data
* 0006_acoustic_model_adaptation:                    adaptation of German acoustic model to Upper Sorbian
* 0007_corpus_generation:                            generation of lexicon and other data from textual corpus
* 0008_automated_labelling:                          automated labelling of audio files
* 0009_training:                                     training of an acoustic model from scratch
* 0010_adaptation:                                   speaker-dependent adaptation of an acoustic model
* 0011_word_class_grammar_merge:                     test combination of word class definition and an existing CFG
* 0012_statistical_language_model_with_word_classes: test recognition using a statistical language model plus word classes

# Development and use cases

* 9998_live_recognition_slp:                         check performace using statistical language models and adapted acoustic models
* 9999_live_recognition_word_loop_grammar:           check performance using word loop grammar and adapted acoustic models


# License

See file "LICENSE".
