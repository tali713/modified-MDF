#!/usr/bin/perl
use strict;
use warnings;
use Compress::Zlib qw'uncompress $gzerrno';

undef $/; # slurp whole files
FILE: while (<>) {
    my @chunks = unpack "(V/a)*", $_;
    warn "*** found ".@chunks." compressed chunks in $ARGV\n";
    CHUNK: for my $i (1 .. @chunks) {
	my $data = uncompress $chunks[$i-1];
	if (not defined $data) {
	    warn "*** uncompressing chunk $i failed: $gzerrno\n";
	    next CHUNK;
	}
	(my $n, $data) = unpack "Va*", $data;
	warn "*** found $n strings in chunk $i\n";
	my $j = 1;
	while (length $data) {
	    (my $m1, my $m2, $data) = unpack "Vva*", $data;
	    if ($m1 != $m2) {
		warn "*** length mismatch for string $j: $m1 != $m2\n";
		next CHUNK;
	    }
	    elsif ($m1 > length $data) {
		warn "*** string $j should have $m1 bytes, but only ".length($data)." remain in chunk!\n";
	    }
	    (my $str, $data) = unpack "a[$m1]a*", $data;
	    s/\\/\\\\/g, s/\r/\\r/g, s/\n/\\n/g, s/\t/\\t/g for $str;
	    s/([^ -~])/sprintf "\\x%02X", ord $1/eg for $str;
	    print "$str\n";
	    $j++;
	}
    }
    print "\n";
}
