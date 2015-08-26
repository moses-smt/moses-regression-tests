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



my $cmd = "$mosesBin/lexical-reordering-score  $test_dir/$test_name/extract.o 0.5 $results_dir/reordering-table. --model \"wbe msd wbe-msd-bidirectional-fe\"";
print STDERR "Executing: $cmd\n";
`$cmd`;
my $is_osx = ($^O eq "darwin");
my $catCmd = $is_osx?"gunzip -c ":"zcat ";
system("$catCmd $results_dir/reordering-table.* > $results_dir/out");






