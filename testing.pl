#!/usr/bin/perl

use 5.010;
#use strict;
use warnings;

$text="abc";
$pad_len = 4;
#$padded = sprintf("%-${$pad_len}s", $text);
# $message .= chr 0x80;
# $l = bytes::length($message);
# print "Hello World!\n";
# print unpack("H*", $message);
# print "\n";
# print $l;


#vec($message,  1, 3) = 1;  # bits 0 to 3
print("vec() Has a created a string of nybbles,
    in hex: ", unpack("B*", $padded), "\n");
    
    printf unpack("B*",$text);