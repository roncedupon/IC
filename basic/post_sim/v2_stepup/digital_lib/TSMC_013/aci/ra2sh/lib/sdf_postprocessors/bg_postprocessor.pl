#!/usr/local/bin/perl
# -*- perl -*- Forces EMacs to use perl-mode 

use Getopt::Std; 

&getopts('s:o:');
if(!$opt_s || !$opt_o) {
    die "
bg_postprocessor.pl  -s <input SDF file>
                     -o <output SFD file>

This perl script modifes an SDF file created by Cadence BuildGates.  The script
creates a valid SDF that can be read by Artisan simulation models.


"
}

$IN_FILE = $opt_s;
$OUT_FILE = $opt_o;

open(INPUT, $IN_FILE) || 
    die printf("Sorry, Could not open file %s\n",$IN_FILE);

open(OUTPUT, ">" . $OUT_FILE) ||
    die printf("Sorry, Could not open file %s\n",$OUT_FILE);

#
# This script cuts the posedge statement out of the PERIOD construct
# and removes the negedge PERIOD statment completely.
#

while (<INPUT>) {
    chop;
    @var = split;
    if (@var[0] eq "(PERIOD"){ 
	if (@var[1] eq "(posedge"){
	    $_ =~ s/\)//i;
	    $_ =~ s/\(POSEDGE //i;
	    printf OUTPUT "%s\n",$_;
	}
	elsif (@var[1] eq "(negedge"){
	}
	else{
	    printf OUTPUT "%s\n",$_;
	}
    }
#
# The following code removes the posedge (or negedge) statemnts from the
# IOPATH description of memories.
#
    elsif ( (@var[0] =~ /IOPATH/) && (($_ =~ /posedge/) || ($_ =~ /negedge/))){
        $_ =~ s/\(POSEDGE CLK\)/CLK/ig;
        $_ =~ s/\(POSEDGE CLKA\)/CLKA/ig;
        $_ =~ s/\(POSEDGE CLKB\)/CLKB/ig;
	$_ =~ s/\(NEGEDGE CLK\)/CLK/ig;
        $_ =~ s/\(NEGEDGE CLKA\)/CLKA/ig;
        $_ =~ s/\(NEGEDGE CLKB\)/CLKB/ig;
	printf OUTPUT "%s\n",$_;
    }
    else{
	printf OUTPUT "%s\n",$_;
    }
}
