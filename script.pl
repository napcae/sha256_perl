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
#http://docstore.mik.ua/orelly/perl/cookbook/ch02_05.htm
######################################################################################################

use 5.010;
#use strict;
use warnings;
do "logical_ops.pl";


my $test;
our (@H,@K);
our ($message,$orig_message);
my ($element,$result);
our (@N,@M);  

####padding the message into an internal state
sub sha256_core {

      &sha256_pad;
      #&sha256_calc;
      
}

sub sha256_pad {
       
       my ($l,$i,$j); 
       my ($N,@W);  
       #append one bit(3)
       $l = length($message);
       $N = $l % 512; #anzahl der blöcke
       #pack "l",$l;
       $anzahl_der_nullen = 447 - ($l*8); #447 anstatt 448 wegen des extra bits, 448 denn 512-64(für den letzten block) = 448
       print "Laenge der message (zeichenanzahl): ".$l."\n";
       print "anzahl der bloecke: ".$N."\n";
       print "anzahl der nullen: ".$anzahl_der_nullen."\n";
       #$message = vec($message,1,1)
       
       #$message .= 1;
       #$message .= (chr 0x80).((chr 0x00)x$anzahl_der_nullen);
       #$message .= pack 'L', length($message);
       push(@W,$message);
       
        foreach my $element (@W)
             {
                print unpack("b*","$element");print "\n";
             }
       
       #$binstr = bin2dec($l);
       #print unpack("B*",$l);
       printf "%b",$l;
       print "\n";
       print $l;
       print "\n";
       $binlen = pack "b*","$l";
        print $binlen;
       print "\n";
       $binlen = length($binlen);
       print $binlen;
       print "\n";
       # $mm .= (chr 0x00)x$anzahl_der_nullen;
       # push (@W,$mm);
      
      #####print inhalte aus @m
      # print "element 2: ".$W[0];
      # print "\n";
      
      # $length = "@W";
      # print unpack("H*",$length);
      # print "\n";
      # print ($length);
      # print "\n";
      
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



 # # convert string msg into 512-bit/16-integer blocks arrays of ints [§5.2.1]
    # var l = msg.length/4 + 2;  # length (in 32-bit integers) of msg + ‘1’ + appended length
    # var N = Math.ceil(l/16);   # number of 16-integer-blocks required to hold 'l' ints
    # var M = new Array(N);

    # for (var i=0; i<N; i++) {
        # M[i] = new Array(16);
        # for (var j=0; j<16; j++) {  # encode 4 chars per integer, big-endian encoding
            # M[i][j] = (msg.charCodeAt(i*64+j*4)<<24) | (msg.charCodeAt(i*64+j*4+1)<<16) | 
                      # (msg.charCodeAt(i*64+j*4+2)<<8) | (msg.charCodeAt(i*64+j*4+3));
        # } # note running off the end of msg is ok 'cos bitwise ops on NaN return 0
    # }
    # # add length (in bits) into final pair of 32-bit integers (big-endian) [§5.1.1]
    # # note: most significant word would be (len-1)*8 >>> 32, but since JS converts
    # # bitwise-op args to 32 bits, we need to simulate this by arithmetic operators
    # M[N-1][14] = ((msg.length-1)*8) / Math.pow(2, 32); M[N-1][14] = Math.floor(M[N-1][14])
    # M[N-1][15] = ((msg.length-1)*8) & 0xffffffff;