#!/usr/bin/perl

######################################################################################################
#
#  This is an implementation of SHA256 for education purposes by napcae (CC BY-NC-SA 3.0) 2012
#  see http://creativecommons.org/licenses/by-nc-sa/3.0/de/ for further information about the license
#  contact chitrungnguyen [at] me [dot] com
#  
# References
#  (1)
#  NIST specification SHA 256:
#  http://csrc.nist.gov/publications/fips/fips180-3/fips180-3_final.pdf
#
#  (2)
#  Bitwise operations
#  from http://forums.devshed.com/perl-programming-6/bit-rotate-in-perl-253298.html
#
#  (3)
#  Appending bits and bytes
#  http://perldoc.perl.org/functions/sprintf.html
#
#
#
# test vectors
# http://csrc.nist.gov/groups/ST/toolkit/examples.html#aHashing
######################################################################################################

use 5.010;
use strict;
use warnings;
do "logical_ops.pl";


my $test;
our (@H,@K);
our ($message,$orig_message);
my ($element,$result);
our (@N,@M,@W);  

our($UPPER32BITS,$LOWER32BITS);
BEGIN {
  use Config;
   die "$0: $^X not configured for 64-bit ints"
     unless $Config{use64bitint};

  no warnings "portable";
  *UPPER32BITS = \0xffff_ffff_0000_0000;
  *LOWER32BITS = \0x0000_0000_ffff_ffff;
}

####padding the message into an internal state
sub sha256_core {

      &pad_message;
      &sha256_extend;
      #&sha256_calc;
      
}

sub pad_message {
      use bytes;


      my $l = bytes::length($message) * 8;
      my $extra = $l % 512;  # pad to 512-bit boundary
      my $k = 448 - ($extra + 1);

      # append 1 bit followed by $k zero bits
      $message .= pack "B*", 1 . 0 x $k;

      # add big-endian length
      $message .= pack "NN", (($l & $UPPER32BITS) >> 32), ($l & $LOWER32BITS);
      
      die "$0: bad length: ", bytes::length $message
        if (bytes::length($message) * 8) % 512;


      # message in 16 stücke teilen, in array pressen
      push @W, $1 while ($message =~ /(.{1,4})/msxog);
      #return @W;
      
      #debugging information
      # my $i = 0;
      # foreach my $w (@W) {
            # print "W"."[".$i."]";
            # print unpack("H*",$w);
            # print "\n";
            # $i++;
      # }
           
      # print unpack("H*",$W[1]);
      # print $W[1];

}

sub sha256_extend {
      
      my ($i, $s0, $s1);
      
      print "############################"."\n";
      print unpack("H*",$W[0]);;print "\n";
      print "############################"."\n";
      
      # Extend the sixteen 32-bit words into sixty-four 32-bit words:
      for ($i = 16;$i<=63;$i++) {
            
            $s0 = ssig0($W[$i-15]);
            $s1 = ssig1($W[$i-2]);
            $W[$i] = $s1 . $W[$i-7] . $s0 . $W[$i-16]
            
      }  
         
}

sub sha256_calc {
      
}



sub sha256_read {
      
      print "\ndie zu verschluesselnde Nachricht eingeben: ";
      $message = <stdin>;
      chop ($message);
      
      #save original message
      $orig_message = $message;
      
      return($message,$orig_message);
    
}

sub sha256_print {
      
      #print input message
      print "Input: ".$orig_message."\n";
      
      #print sha256 value
      print "SHA256: ";
      print "\n";
      print unpack("H*", $message);
      print "\n"; 
      #print $l."\n";
      print @M;
            print join("\n",@M);
            
            
           
      #debugging hash values:
      my $i = 0;
      foreach my $element (@H)
            {
                print "H"."[".$i."]";
                my $results = do printf("%#x", $element);
                print "\n";
                $i++;
            }
            
      my $a = 0;
      foreach my $w (@W) {
            print "W"."[".$a."]";
            print unpack("H*",$w);
            print "\n";
            $a++;
      }
}

# sub dec2bin {
    # my $str = unpack("B32", pack("N", shift));
    # $str =~ s/^0+(?=\d)//;   # otherwise you'll get leading zeros
    # return $str;
# }

# sub bin2dec {
    # return unpack("N", pack("B32", substr("0" x 32 . shift, -32)));
# }

sub sha256 {
      &sha256_read;
      &sha256_core;
      &sha256_print;      
}

#call the main
sha256;



# $rotr = ROTR(13,E)
# $test = ch(3,7,8);
# print "$test\n";



