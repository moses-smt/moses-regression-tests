#!/usr/bin/env perl

use strict;

sub SortScores($);

my $x=0;
my $oldcode = "";
while (<>) {
  chomp;

  # Remove last digit in scores printed with high precision, to avoid 
  # tests failing due to compiler-specific differences in the way rounding
  # errors happen in the code. And yes: it's a really bad hack. UG
  s/(([0-9]+)\.([0-9]{2,}))/sprintf(sprintf("%%%d.%df",length($1),length($3)-1),$1)/ge;

  my ($code,$trans,$featscores,$globscores) = split(/[\s]*\|\|\|[\s]*/,$_);
  $x = 0 if $oldcode ne $code;
  $x++;
  chomp($code);

  my $featscoresSorted = SortScores($featscores);

  print "TRANSLATION_${code}_NBEST_${x}=$trans ||| $featscoresSorted\n";
  $oldcode = $code;
}


sub SortScores($)
{
  my $featscores = shift;
  my @toks = split(/ /, $featscores);  
  my @toks2;

  my $currInd = -1;
  for (my $i = 0; $i < scalar(@toks); ++$i) {
    my $tok = $toks[$i];
    my $lastChar = substr($tok, -1, 1);
    if ($lastChar eq '=') {
      push(@toks2, $tok);
      ++$currInd;
    }
    else {
      $toks2[$currInd] .= " " . $tok;
    }
  }

  @toks2 = sort(@toks2);
  
  return join(' ', @toks2);
}


