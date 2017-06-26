#!/usr/bin/perl -w
use strict;
use warnings;
use Compress::Zlib 'compress';

# read input: 1 line -> 1 packed string, skip blank lines
my $n = my @lines = grep /\S/, <>;
chomp @lines;

# decode \t, \r, \n, \\ and \xNN escapes in input
my %map = (t => "\t", r => "\r", n => "\n", "\\" => "\\");
s/\\([trn\\]|x([^0-9A-F]{2}))/$map{$1} || chr hex $2/egi for @lines;

# prepend length to strings (twice, for some strange reason)
$_ = pack "Vva*", length, length, $_ for @lines;

# concatenate strings and prepend count, then compress
my $packed = pack "V(a*)*", $n, @lines;
my $zip = compress $packed;

# prepend length of compressed data and print
print pack("V", length $zip), $zip;
