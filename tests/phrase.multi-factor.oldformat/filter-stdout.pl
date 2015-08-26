#!/usr/bin/env perl
$x=0;
while (<>) {
  chomp;
  $x++;
  print "TRANSLATION_$x=$_\n";
}
