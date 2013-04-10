#!/usr/bin/perl -w 

use strict;
my $script_dir; BEGIN { use Cwd qw/ abs_path /; use File::Basename; $script_dir = dirname(abs_path($0)); push @INC, $script_dir; }
use MosesRegressionTesting;
use Getopt::Long;
use File::Temp qw ( tempfile );
use POSIX qw ( strftime );

my ($mosesRoot, $mosesBin, $test_name, $data_dir, $test_dir, $results_dir);

GetOptions("moses-root=s" => \$mosesRoot,
           "moses-bin=s" => \$mosesBin,
           "test=s"    => \$test_name,
           "data-dir=s"=> \$data_dir,
           "test-dir=s"=> \$test_dir,
           "results-dir=s"=> \$results_dir,
          ) or exit 1;

<<<<<<< HEAD
<<<<<<< HEAD
my $cmd;
$cmd = "$mosesRoot/scripts/generic/extract-parallel.perl 2 $splitCmd $sortCmd $mosesBin/extract $test_dir/$test_name/en $test_dir/$test_name/fr $test_dir/$test_name/align.fr-en $results_dir/extract 7 --GZOutput --InstanceWeights $test_dir/$test_name/weights 2> $results_dir/log";
print STDERR "Executing: $cmd\n";
`$cmd`;
system("$catCmd $results_dir/extract.sorted.gz $results_dir/extract.inv.sorted.gz > $results_dir/out");
=======
=======
>>>>>>> 47addea26d2effd79843275644e2d287aa282266
my $SPLIT_EXEC = `gsplit --help 2>/dev/null`; 
if($SPLIT_EXEC) {
  $SPLIT_EXEC = 'gsplit';
}
else {
  $SPLIT_EXEC = 'split';
}

my $SORT_EXEC = `gsort --help 2>/dev/null`; 
if($SORT_EXEC) {
  $SORT_EXEC = 'gsort';
}
else {
  $SORT_EXEC = 'sort';
}

my $CAT_EXEC = "gunzip -c ";

my $cmd;
$cmd = "$mosesRoot/scripts/generic/extract-parallel.perl 2 $SPLIT_EXEC $SORT_EXEC $mosesBin/extract $test_dir/$test_name/en $test_dir/$test_name/fr $test_dir/$test_name/align.fr-en $results_dir/extract 7 --GZOutput --InstanceWeights $test_dir/$test_name/weights 2> $results_dir/log";
print STDERR "Executing: $cmd\n";
`$cmd`;

system("$CAT_EXEC $results_dir/extract.sorted.gz $results_dir/extract.inv.sorted.gz > $results_dir/out");
<<<<<<< HEAD
>>>>>>> 475688bf6e70934b733b1e3ffb711f997c993ba3
=======
>>>>>>> 47addea26d2effd79843275644e2d287aa282266


