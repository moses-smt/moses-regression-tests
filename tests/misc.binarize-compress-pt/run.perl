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

my $cmd;

$cmd = "$mosesBin/processPhraseTableMin -in $test_dir/$test_name/phrase-table.0-0.1.1.gz -out $results_dir/phrase-table.0-0.1.1 -nscores 5 -threads 4";
print STDERR "Executing: $cmd\n";
`$cmd`;

$cmd = "$mosesBin/processLexicalTableMin -in $test_dir/$test_name/reordering-table.0-0.wbe-msd-bidirectional-fe.gz -out $results_dir/reordering-table.0-0.wbe-msd-bidirectional-fe -threads 4";
print STDERR "Executing: $cmd\n";
`$cmd`;

my $origIni = "$test_dir/$test_name/moses.ini";
my $local_moses_ini = MosesRegressionTesting::get_localized_moses_ini($origIni, $data_dir);
print STDERR "local_moses_ini=$local_moses_ini \n";

$cmd = "$mosesBin/moses -f $local_moses_ini -i $test_dir/$test_name/to-translate.txt -n-best-list $results_dir/out 1";
print STDERR "Executing: $cmd\n";
`$cmd`;





