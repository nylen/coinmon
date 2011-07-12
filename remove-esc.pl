#!/usr/bin/perl -w

use strict;

my $out = '';
my $in_esc_seq = 0;

while(my $line = <>) {
  for my $c (split //, $line) {
    if($c eq chr 27) {
      $in_esc_seq = 1;
    } elsif($c eq 'm' and $in_esc_seq) {
      $in_esc_seq = 0;
    } elsif($c eq chr 8) {
      chop $out;
    } elsif(!$in_esc_seq) {
      $out .= $c;
    }
  }
}
print $out;
