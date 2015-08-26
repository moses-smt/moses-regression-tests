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


my $local_config = new File::Temp( UNLINK => 0, SUFFIX => '.config' );
my $cmd;
open(CONFIG, "$test_dir/$test_name/config") || die "Failed to open config file";
open(NEWCONFIG, ">$local_config") || die "Failed to create local config";
while (<CONFIG>) {
  s,TESTDIR,$test_dir/$test_name,g;
  s,RESULTSDIR,$results_dir,g;
  print NEWCONFIG;
}
close NEWCONFIG;


$cmd = "$mosesRoot/scripts/ems/support/mml-filter.py  $local_config";
print STDERR "Executing: $cmd\n";
`$cmd`;
system("cat $results_dir/output.fr $results_dir/output.en $results_dir/domain > $results_dir/out");






