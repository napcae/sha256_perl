#!/usr/bin/perl

use 5.010;
use strict;
use warnings;

our($UPPER32BITS,$LOWER32BITS);
BEGIN {
  use Config;
  die "$0: $^X not configured for 64-bit ints"
    unless $Config{use64bitint};

  no warnings "portable";
  *UPPER32BITS = \0xffff_ffff_0000_0000;
  *LOWER32BITS = \0x0000_0000_ffff_ffff;
}

sub pad_message {
  use bytes;

  my($msg) = @_;
  my $l = bytes::length($msg) * 8;
  my $extra = $l % 512;  # pad to 512-bit boundary
  my $k = 448 - ($extra + 1);

  # append 1 bit followed by $k zero bits
  $msg .= pack "B*", 1 . 0 x $k;

  # add big-endian length
  $msg .= pack "NN", (($l & $UPPER32BITS) >> 32), ($l & $LOWER32BITS);

  die "$0: bad length: ", bytes::length $msg
    if (bytes::length($msg) * 8) % 512;

  $msg;
}

my $mmm = pad_message "abc";

print unpack("H*",$mmm);#test
