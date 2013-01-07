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

my $splitCmd = `gsplit --help 2>/dev/null`; 
if($splitCmd) {
  $splitCmd = 'gsplit';
}
else {
  $splitCmd = 'split';
}

my $sortCmd = `gsort --help 2>/dev/null`; 
if($sortCmd) {
  $sortCmd = 'gsort';
}
else {
  $sortCmd = 'sort';
}

my $cmd;
$cmd = "$mosesRoot/scripts/generic/extract-parallel.perl 2 $splitCmd $sortCmd $mosesBin/extract $test_dir/$test_name/en $test_dir/$test_name/fr $test_dir/$test_name/align.fr-en $results_dir/extract 7 --GZOutput 2> $results_dir/log";
print STDERR "Executing: $cmd\n";
`$cmd`;
my $is_osx = ($^O eq "darwin");
my $catCmd = $is_osx?"gunzip -c ":"zcat ";
system("$catCmd $results_dir/extract.sorted.gz $results_dir/extract.inv.sorted.gz > $results_dir/out");


