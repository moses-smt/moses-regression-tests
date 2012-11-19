#!/usr/bin/perl -w

use strict;
use Getopt::Long;

my $mosesRoot, $mosesBin, $test_name, $data_dir, $test_dir, $results_dir;

GetOptions("moses-root=s" => \$mosesRoot,
           "moses-bin=s" => \$mosesBin,
           "test=s"    => \$test_name,
           "data-dir=s"=> \$data_dir,
           "test-dir=s"=> \$test_dir,
           "results-dir=s"=> \$results_dir,
          ) or exit 1;

print STDERR "hello world! \n $mosesRoot \n $test_name \n $data_dir \n $test_dir \n $results_dir \n";

my $cmd;

$cmd = "$mosesBin/processPhraseTableMin -in $test_dir/phrase-table.gz -out $results_dir/phrase-table -nscores 5 -threads 4";
`$cmd`;

$cmd = "md5sum $results_dir/phrase-table > $results_dir/out"


