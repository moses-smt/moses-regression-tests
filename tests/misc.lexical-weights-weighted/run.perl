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

require "$mosesRoot/scripts/training/LexicalTranslationModel.pm"; 
"LexicalTranslationModel"->import; 

&get_lexical("$test_dir/$test_name/fr", "$test_dir/$test_name/en",
              "$test_dir/$test_name/align.fr-en", "$results_dir/out",
              0, "","",undef,"$test_dir/$test_name/weights");

system("cat $results_dir/out.f2e $results_dir/out.e2f > $results_dir/out");



