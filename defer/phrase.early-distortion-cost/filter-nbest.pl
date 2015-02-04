#!/usr/bin/perl

use strict;

my $x=0;
my $oldcode = "";
while (<>) {
  chomp;
  my ($code, $trans, $featscores, $globscores, $align1, $align2 ) = split(/[\s]*\|\|\|[\s]*/,$_);
  $x = 0 if $oldcode ne $code;
  $x++;
  chomp($code);
  print "TRANSLATION_${code}_NBEST_${x}=$trans ||| $featscores ||| $globscores ||| $align1 ||| $align2\n";
  $oldcode = $code;
}
