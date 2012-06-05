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
######################################################################################################

use 5.010;
use strict;
#use warnings;

####variablen & constanten

#Variablen für Initialisierung: Die ersten 32 bits der Nachkommastelle von der Wurzel der ersten 8 Primzahlen(2,3,5,7,11,13,17,19) 
our @H = (0x6a09e667, 0xbb67ae85, 0x3c6ef372, 0xa54ff53a, 0x510e527f, 0x9b05688c, 0x1f83d9ab, 0x5be0cd19);

#Konstanten nach NIST: Die ersten 32 bits der Nachkommastelle von den Quadratwurzeln der ersten 64 Primzahlen
our @K = (0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5, 0x3956c25b, 0x59f111f1, 0x923f82a4, 0xab1c5ed5,
          0xd807aa98, 0x12835b01, 0x243185be, 0x550c7dc3, 0x72be5d74, 0x80deb1fe, 0x9bdc06a7, 0xc19bf174,
          0xe49b69c1, 0xefbe4786, 0x0fc19dc6, 0x240ca1cc, 0x2de92c6f, 0x4a7484aa, 0x5cb0a9dc, 0x76f988da,
          0x983e5152, 0xa831c66d, 0xb00327c8, 0xbf597fc7, 0xc6e00bf3, 0xd5a79147, 0x06ca6351, 0x14292967,
          0x27b70a85, 0x2e1b2138, 0x4d2c6dfc, 0x53380d13, 0x650a7354, 0x766a0abb, 0x81c2c92e, 0x92722c85,
          0xa2bfe8a1, 0xa81a664b, 0xc24b8b70, 0xc76c51a3, 0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070,
          0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5, 0x391c0cb3, 0x4ed8aa4a, 0x5b9cca4f, 0x682e6ff3,
          0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208, 0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2);

####logische Operationen
#ROTR(rotate right) defined by NIST(1)
sub ROTR { 
      
      my $bit = 32;
      #defined as ROTR^n(x) = (x >> n) | (x << w - n), wobei w = 32, denn SHA256 hat 32bit Wörter; $_[0] = Anzahl der Schritte(n), $_[1] = Wert(x)
      return ( ($_[1] >> $_[0]) | ($_[1] << ($bit - $_[0]) ) ); 
}


#SHR(shift right) defined by NIST(1)
sub SHR {
      #defined as SHR^n(x)=x >> n; $_[0] = Anzahl der Schritte(n), $_[1] = Wert(x)
      return ($_[1] >> $_[0]);
}



      
###benötigte Funktionen
#ch
sub ch { 
      #B = $_[0]
      #C = $_[1]
      #D = $_[2]
      return ( ($_[0] & $_[1]) ^ (~$_[0] & $_[2]) );
}

#maj
sub maj {
      #B = $_[0]
      #C = $_[1]
      #D = $_[2] 
      return ( ($_[0] & $_[1]) ^ ($_[0] & $_[2]) ^ ($_[1] & $_[2]) );
}

#bigsigma0
sub bsig0 {
      return ( ROTR(2,$_[0]) ^ ROTR(13,$_[0]) ^ ROTR(22,$_[0]) );
}

#bigsigma1
sub bsig1 {
      return ( ROTR(6,$_[0]) ^ ROTR(11,$_[0]) ^ ROTR(25,$_[0]) );
}

#smallsigma0
sub ssig0 { 
      return ( ROTR(7,$_[0]) ^ ROTR(18,$_[0]) ^ SHR(3,$_[0]) );
}

#smallsigma1
sub ssig1 {
      return ( ROTR(17,$_[0]) ^ ROTR(19,$_[0]) ^ SHR(10,$_[0]) );
}  #test
