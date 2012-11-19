#!/usr/bin/perl -w

use strict;
use Getopt::Long;

my ($mosesRoot, $mosesBin, $test_name, $data_dir, $test_dir, $results_dir);

GetOptions("moses-root=s" => \$mosesRoot,
           "moses-bin=s" => \$mosesBin,
           "test=s"    => \$test_name,
           "data-dir=s"=> \$data_dir,
           "test-dir=s"=> \$test_dir,
           "results-dir=s"=> \$results_dir,
          ) or exit 1;

my $cmd;

$cmd = "$mosesBin/processPhraseTableMin -in $test_dir/$test_name/phrase-table.gz -out $results_dir/phrase-table -nscores 5 -threads 4";
print STDERR "Executing: $cmd\n";
`$cmd`;

$cmd = "$mosesBin/processLexicalTableMin -in $test_dir/$test_name/reordering-table.gz -out $results_dir/reordering-table -threads 4";
print STDERR "Executing: $cmd\n";
`$cmd`;

$cmd = "md5sum $results_dir/phrase-table.minphr $results_dir/reordering-table.minlexr | cut -f 1 -d ' ' > $results_dir/out";
print STDERR "Executing: $cmd\n";
`$cmd`;


