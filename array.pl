#!/usr/bin/perl

use 5.010;



@H = (0x6a09e667, 0xbb67ae85, 0x3c6ef372, 0xa54ff53a, 0x510e527f, 0x9b05688c, 0x1f83d9ab, 0x5be0cd19);


foreach my $element (@H)
{
    my $results = do printf("%#x", $element);
    print "$results\n";
}