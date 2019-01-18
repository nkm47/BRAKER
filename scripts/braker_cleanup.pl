#!/usr/bin/env perl

####################################################################################################
#                                                                                                  #
# braker_cleanup.pl                                                                                #
# Script that deletes all files produced by BRAKER that are not deleted by the braker.pl script,   #
# itself, and that are usually not required for downstream analysis, unless you wish to debug      #
# something.                                                                                       #
#                                                                                                  #
# Author: Katharina Hoff                                                                           #
#                                                                                                  #
# Contact: katharina.hoff@uni-greifswald.de                                                        #
#                                                                                                  #
# This script is under the Artistic Licence                                                        #
# (http://www.opensource.org/licenses/artistic-license.php)                                        #
####################################################################################################

use Getopt::Long;
use File::Path;
use strict;
use warnings;

my $usage = <<'ENDUSAGE';

braker_cleanup.pl     delete braker.pl output files that are usually not required for 
                      downstream analysis

SYNOPSIS

braker_cleanup.pl --wdir=WDIR

OPTIONS

--wdir=WDIR         output directory of braker.pl job

--help	            Display this help message

ENDUSAGE

my $help;
my $wdir;

GetOptions(
	'wdir=s'  => \$wdir,
    'help!' => \$help
);

if ($help) {
	print $usage;
    exit(0);
}

if(not(defined($wdir))){
	print "ERROR: in file " . __FILE__ ." at line "
            . __LINE__ . "\n" . "No Working directory provided!"
            . "(option --wdir=WDIR)\n";
    print $usage;
	exit(1)
}

my @files = ("firsttest.stdout", "genome.fa", "getAnnoFasta.augustus.ab_initio.stdout", 
	"getAnnoFasta.augustus.hints.stdout", "optimize_augustus.stdout", "secondtest.stdout",
	"train.gb", "GeneMark-ES/genemark.d.gtf", "GeneMark-ES/genemark.f.good.gtf", 
	"GeneMark-ES/gmes.log", "GeneMark-ES/logfile", "GeneMark-ES/run.cfg", 
	"GeneMark-ES/training.fna", "GeneMark-ES.stdout", "genemark_hintsfile.gff", "GeneMark-ET/genemark.d.gtf", 
	"GeneMark-ET/genemark.f.good.gtf", "GeneMark-ET/genemark.c.gtf", "GeneMark-ET/genemark.average_gene_length.out",
	"GeneMark-ET/gmes.log", "GeneMark-ET/logfile", "GeneMark-ET/run.cfg", 
	"GeneMark-ET/training.fna", "GeneMark-ET/genemark.f.bad.gtf", "GeneMark-ET.stdout", "filterGenemark.stdout", 
	"GeneMark-EP/genemark.d.gtf", 
	"GeneMark-EP/genemark.f.good.gtf", "GeneMark-EP/genemark.c.gtf", "GeneMark-EP/genemark.average_gene_length.out",
	"GeneMark-EP/gmes.log", "GeneMark-EP/logfile", "GeneMark-EP/run.cfg", 
	"GeneMark-EP/training.fna", "GeneMark-EP/genemark.f.bad.gtf", "GeneMark-EP.stdout",
	"GeneMark-ETP/genemark.d.gtf", 
	"GeneMark-ETP/genemark.f.good.gtf", "GeneMark-ETP/genemark.c.gtf", "GeneMark-ETP/genemark.average_gene_length.out",
	"GeneMark-ETP/gmes.log", "GeneMark-ETP/logfile", "GeneMark-ETP/run.cfg", 
	"GeneMark-ETP/training.fna", "GeneMark-ETP/genemark.f.bad.gtf", "GeneMark-ETP.stdout",
	"aug_hints.lst", "aa2nonred.stdout", "augustus.hints.tmp.gtf", "bothutr.lst", "fourthtest.stdout", "gbFilterEtraining.stdout",
	"genes.gtf", "genes_in_gb.gtf", "gff2gbSmallDNA.utr.stdout", "hints.job.lst", "merged.bam", "merged.s.bam", "merged.wig", 
	"randomSplit_utr1.log", "randomSplit_utr2.log", "rnaseq2utr.stdout", "rnaseq.utr.hints", "samtools_sort_before_wig.stdout",
	"singlecds.hints", "stops.and.starts.gff", "train.gb.test", "train.gb.train", "train.gb.train.test",
	"train.gb.train.train", "traingenes.good.fa", "traingenes.gtf", "utr.aa2nonred.stdout",
	"utr.gb", "utr.gb.test", "utr.gb.train", "utr.gb.train.test", "utr.gb.train.train", "utr_genes_in_gb.fa",
	"utr_genes_in_gb.nr.fa", "utr.nonred.loci.lst", "utrs.gff", "downsample_traingenes.log", "firstetraining.stdout", 
	"secondetraining.stdout");

my @dirs = ("GeneMark-ES/data", "GeneMark-ES/info", "GeneMark-ES/output", "GeneMark-ES/run",
	"GeneMark-ET/data", "GeneMark-ET/info", "GeneMark-ET/output", "GeneMark-ET/run",
	"GeneMark-EP/data", "GeneMark-EP/info", "GeneMark-EP/output", "GeneMark-EP/run",
	"GeneMark-ETP/data", "GeneMark-ETP/info", "GeneMark-ETP/output", "GeneMark-ETP/run",
	"genome_split");

foreach(@files){
	if(-e $wdir."/".$_){
		print "Deleting file ".$wdir."/".$_."\n";
		unlink($wdir."/".$_);
	}
}

foreach(@dirs){
	if(-d $wdir."/".$_){
		print "Deleting directory ".$wdir."/".$_."\n";
		rmtree($wdir."/".$_);
	}
}
