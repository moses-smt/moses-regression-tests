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

$cmd = "$mosesBin/consolidate  $test_dir/$test_name/phrase-table.1.half.f2e $test_dir/$test_name/phrase-table.1.half.e2f $results_dir/out";
print STDERR "Executing: $cmd\n";
`$cmd`;






