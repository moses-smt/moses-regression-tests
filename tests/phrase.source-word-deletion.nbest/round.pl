#!/usr/bin/env perl
while (<>)
{
  s/(([0-9]+)\.([0-9]{2,}))/sprintf(sprintf("%%%d.%df",length($1),length($3)-1),$1)/ge unless m/^SCORE/;
  print;
}
