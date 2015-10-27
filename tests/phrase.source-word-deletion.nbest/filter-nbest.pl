#!/usr/bin/env perl
$x=0;
$oldcode = "";

while (<>) {
  chomp;

  # Remove last digit in scores printed with high precision, to avoid 
  # tests failing due to compiler-specific differences in the way rounding
  # errors happen in the code. And yes: it's a really bad hack. UG
  s/(([0-9]+)\.([0-9]{2,}))/sprintf(sprintf("%%%d.%df",length($1),length($3)-1),$1)/ge;
  
  ($code,$trans,$featscores,$globscores) = split(/[\s]*\|\|\|[\s]*/,$_);
  $x = 0 if $oldcode ne $code;
  $x++;
  chomp($code);
  print "TRANSLATION_${code}_NBEST_${x}=$trans ||| $featscores\n";
  $oldcode = $code;
}
