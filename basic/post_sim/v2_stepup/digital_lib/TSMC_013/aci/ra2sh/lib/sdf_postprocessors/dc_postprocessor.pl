#!/usr/local/bin/perl
# -*- perl -*- Forces EMacs to use perl-mode 

use Getopt::Std; 

&getopts('s:o:');
if(!$opt_s || !$opt_o) {
    die "
dc_postprocessor.pl  -s <input SDF file>
                     -o <output SFD file>

This perl script modifes an SDF file created by Synopsys Design Compiler.  
The script creates a valid SDF that can be read by Artisan simulation models.


"
}

$IN_FILE = $opt_s;
$OUT_FILE = $opt_o;

open(INPUT, $IN_FILE) || 
    die printf("Sorry, Could not open file %s\n",$IN_FILE);

open(OUTPUT, ">" . $OUT_FILE) ||
    die printf("Sorry, Could not open file %s\n",$OUT_FILE);

while (<INPUT>) {

#
# The following statement fixes the bus notation problem
#
    $_=~s/x(\d+)x/\[\1\]/g;

    @var = split;
    
#
# The following code prints out both posedge and negedge statements after
# Design Compiler combined them because they are the same.
#
    if ( ((@var[0] eq "(SETUP") || (@var[0] eq "(HOLD")) && 
	 (@var[1] =~ /CEN|OEN|WEN|^A|^D|TIS|TMS|TCEN|TOEN|TWEN|^TA|^TD|^TAA/) &&
	 ((@var[2] eq "(posedge") || (@var[2] eq "(negedge"))  &&
	 (@var[3] =~ /CLK|CLKA|CLKB/)){
	printf OUTPUT "    %s (posedge %s) %s %s %s\n",@var[0],@var[1],@var[2],@var[3],@var[4];
	printf OUTPUT "    %s (negedge %s) %s %s %s\n",@var[0],@var[1],@var[2],@var[3],@var[4];
    }
#
# The following code removes the posedge (or negedge) statemnts from the
# IOPATH description.
#
    elsif ( ($_ =~ /IOPATH/) && (($_ =~ /posedge/) || ($_ =~ /negedge/))){
        $_ =~ s/\(POSEDGE CLK\)/CLK/ig;
        $_ =~ s/\(POSEDGE CLKA\)/CLKA/ig;
        $_ =~ s/\(POSEDGE CLKB\)/CLKB/ig;
	$_ =~ s/\(NEGEDGE CLK\)/CLK/ig;
        $_ =~ s/\(NEGEDGE CLKA\)/CLKA/ig;
        $_ =~ s/\(NEGEDGE CLKB\)/CLKB/ig;
	printf OUTPUT "%s",$_;
    }
    else {
	printf OUTPUT "%s",$_;
    }
}	
