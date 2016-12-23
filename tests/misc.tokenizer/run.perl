#!/usr/bin/env perl

use warnings;
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

my $cmd;

$cmd = "$mosesRoot/scripts/tokenizer/tokenizer.perl -l cs < $test_dir/$test_name/cs.txt >> $results_dir/out";
print STDERR "Executing: $cmd\n";
`$cmd`;

$cmd = "$mosesRoot/scripts/tokenizer/tokenizer.perl -l de < $test_dir/$test_name/de.txt >> $results_dir/out";
print STDERR "Executing: $cmd\n";
`$cmd`;

$cmd = "$mosesRoot/scripts/tokenizer/tokenizer.perl -l en < $test_dir/$test_name/en.txt >> $results_dir/out";
print STDERR "Executing: $cmd\n";
`$cmd`;

$cmd = "$mosesRoot/scripts/tokenizer/tokenizer.perl -l es < $test_dir/$test_name/es.txt >> $results_dir/out";
print STDERR "Executing: $cmd\n";
`$cmd`;

$cmd = "$mosesRoot/scripts/tokenizer/tokenizer.perl -l fr < $test_dir/$test_name/fr.txt >> $results_dir/out";
print STDERR "Executing: $cmd\n";
`$cmd`;

$cmd = "$mosesRoot/scripts/tokenizer/tokenizer.perl -l ru < $test_dir/$test_name/ru.txt >> $results_dir/out";
print STDERR "Executing: $cmd\n";
`$cmd`;


