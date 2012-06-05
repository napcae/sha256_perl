#!/usr/bin/perl

use 5.010;
#use strict;
use warnings;
do "logical_ops.pl";

$a=8;
$b=1;
$result = $a | $b;

#$c = ssig0($c);
print "binaer";
print "\n";
printf "%b", $a;
print "\n";
printf "%b", $b;
print "\n";
printf "%b", $result;
print "\n";

print "hex";
print "\n";
print unpack("H*", $a);
print "\n";
print unpack("H*", $b);
print "\n";
printf unpack("H*", $result);
print "\n";

print($c);#test
