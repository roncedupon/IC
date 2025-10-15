#!/usr/local/bin/perl
# -*- perl -*- Forces EMacs to use perl-mode 

use Getopt::Std; 

&getopts('s:o:');
if(!$opt_s || !$opt_o) {
    die "
pt_postprocessor.pl  -s <input SDF file>
                     -o <output SFD file>

This perl script modifes an SDF file created by Synopsys PrimeTime.  
The script creates a valid SDF that can be read by Artisan simulation models.


"
}

$IN_FILE = $opt_s;
$OUT_FILE = $opt_o;

open(INPUT, $IN_FILE) || 
    die printf("Sorry, Could not open file %s\n",$IN_FILE);

open(OUTPUT, ">" . $OUT_FILE) ||
    die printf("Sorry, Could not open file %s\n",$OUT_FILE);

# this list describes the valid IOPATHS for each cell that has conditional
# path delays.  All COND IOPATHS are not modified.

%cells = (
	  XOR2 => {
	      inputs => "",
	      outputs=> ""
	      },
          CLKXOR2 => {
              inputs => "",
              outputs=> ""
              },
	  XNOR2 => {
	      inputs => "",
	      outputs=> ""
	      },
	  XOR3 => {
	      inputs => "",
	      outputs=> ""
	      },
	  XNOR3 => {
	      inputs => "",
	      outputs=> ""
	      },
	  MX2 => {
	      inputs => "A B",
	      outputs=> "Y Y"
	      },
	  CLKMX2 => {
	      inputs => "A B",
	      outputs=> "Y Y"
	      },
	  MXI2 => {
	      inputs => "A B",
	      outputs=> "Y Y"
	      },
	  MX3 => {
	      inputs => "A B C",
	      outputs=> "Y Y Y"
	      },
	  MXI3 => {
	      inputs => "A B C",
	      outputs=> "Y Y Y"
	      },
	  MX4 => {
	      inputs => "A B C D",
	      outputs=> "Y Y Y Y"
	      },
	  MXI4 => {
	      inputs => "A B C D",
	      outputs=> "Y Y Y Y"
	      },
	  ADDH => {
	      inputs => "A B",
	      outputs=> "CO CO"
	      },
	  ADDF => {
	      inputs => "CI",
	      outputs=> "CO"
	      },
	  ADDFH => {
	      inputs => "CI",
	      outputs=> "CO"
	      },
	  ACHCIN => {
	      inputs => "CIN",
	      outputs=> "CO"
	      },
	  ACHCON => {
	      inputs => "CI",
	      outputs=> "CON"
	      },
	  AFHCIN => {
	      inputs => "CIN",
	      outputs=> "CO"
	      },
	  AFHCON => {
	      inputs => "CI",
	      outputs=> "CON"
	      },
	  AHHCIN => {
	      inputs => "A CIN",
	      outputs=> "CO CO"
	      },
	  AHCSHCIN => {
	      inputs => "A CIN",
	      outputs=> "CO CO"
	      },
	  AHCSHCON => {
	      inputs => "A CI",
	      outputs=> "CON CON"
	      },
	  AHHCON => {
	      inputs => "A CI",
	      outputs=> "CON CON"
	      },
	  CMPR22 => {
	      inputs => "A B",
	      outputs=> "CO CO"
	      },
	  CMPR32 => {
	      inputs => "C",
	      outputs=> "CO"
	      },
	  BENC => {
	      inputs => "M0 M1 M2 M0 M1 M2",
	      outputs=> "S S S A A A"
	      },
	  AFCSHCIN => {
	      inputs => "CI0N CI1N",
	      outputs=> "CO0 CO1"
	      },      
	  AFCSHCON => {
	      inputs => "CI0 CI1",
	      outputs=> "CO0N CO1N"
	      },      
	  AFCSIHCON => {
	      inputs => "A A B B CS",
	      outputs=> "CO0N CO1N CO0N CO1N S"
	      },      
	  ACCSHCIN => {
	      inputs => "CI0N CI1N",
	      outputs=> "CO0 CO1"
	      },      
	  ACCSHCON => {
	      inputs => "CI0 CI1",
	      outputs=> "CO0N CO1N"
	      },      
	  BMX => {
	      inputs => "",
	      outputs=> ""
	      },      
	  BMXI => {
	      inputs => "",
	      outputs=> ""
	      },      
	  CMPR42 => {
	      inputs => "C D ICI",
	      outputs=> "ICO CO CO"
	      }      
	  );

while (<INPUT>) {
    chop;
    @var = split;
#
# The following code strips out the unnecessary IOPATHS that are created by
# PrimeTime for cells with conditional path delays
#
    if (@var[0] eq "(CELLTYPE"){
	$cell_name = @var[1];
	$cell_name =~ s/[\"\)]//g;
	$_=~s/[_]core//g;
	foreach $key (keys %cells){
	    if (@var[1] =~ /^\"$key[X][L0-9]/){
		$in_cell = 1;
		$cell_type = $key;
	    }
	}
	printf OUTPUT "%s\n",$_;
    }
    elsif ( $in_cell ){
	if (@var[0] eq "(IOPATH"){
	    @inputs = split(/ /,$cells{$cell_type}{inputs});
	    @outputs = split(/ /,$cells{$cell_type}{outputs});
	    for ($i=0; $i<=$#inputs; $i++){
		if ((@var[1] eq @inputs[$i]) && (@var[2] eq @outputs[$i])){
		    printf OUTPUT "%s\n",$_;
		}
	    }
	}
	elsif (@var[0] eq "(IOPATH"){
	}
	elsif (@var[0] eq ")") {
	    $in_cell = 0;
	    printf OUTPUT "%s\n",$_;
	}
	else {
	    printf OUTPUT "%s\n",$_;
	}
    }
#
# The following code removes the posedge and negedge statements that are mysteriously
# inserted in the IOPATH section of sequential cells
#
    elsif (($cell_name =~ /^(RF[12]R1W|DFF|EDFF|MDFF|JKFF|SDFF|SEDFF|SMDFF|TLAT|TTLAT|RSLAT)/) && 
	   (@var[0] eq "(IOPATH") && ($_ =~ /edge/) ){
	$_ =~ s/\(POSEDGE //i;
	$_ =~ s/\(NEGEDGE //i;
	$_ =~ s/\)//;
	printf OUTPUT "%s\n",$_;
    }
#
# The following code removes the word "core" that mysteriously appears in the SDF
# It also strips out the escaped [ and ] that appears in the INTERCONNECT statement
#
    elsif (@var[0] eq "(INTERCONNECT") {
        $_=~s/[\/]core//g;
        $_=~s/\\\[/\[/g;
        $_=~s/\\\]/\]/g;
        printf OUTPUT "%s\n",$_;
    }
    elsif (@var[0] eq "(INSTANCE") {
        $_=~s/[\/]core//g;
        printf OUTPUT "%s\n",$_;
    }
#
# The following code removes the posedge and negedge statements that are mysteriously
# inserted in the IOPATH section of memories.  It also removes the escaped character
# from bus pins.
#
    elsif ( ($_ =~ /IOPATH/) && (($_ =~ /posedge/) || ($_ =~ /negedge/))){
	$_=~s/\\\[/\[/g;
	$_=~s/\\\]/\]/g;
        $_ =~ s/\(POSEDGE WW\)/WW/ig;
        $_ =~ s/\(POSEDGE CLK\)/CLK/ig;
        $_ =~ s/\(POSEDGE CLKA\)/CLKA/ig;
        $_ =~ s/\(POSEDGE CLKB\)/CLKB/ig;
	$_ =~ s/\(NEGEDGE CLK\)/CLK/ig;
	$_ =~ s/\(NEGEDGE CLKA\)/CLKA/ig;
	$_ =~ s/\(NEGEDGE CLKB\)/CLKB/ig;
	printf OUTPUT "%s\n",$_;
    }
#
# The following code prints out both posedge and negedge statements after
# Design Compiler combined them because they are the same.
#
    elsif ( ((@var[0] eq "(SETUP") || (@var[0] eq "(HOLD")) && 
	    (@var[1] =~ /CEN|OEN|WEN|^A|^D|TIS|TMS|TCEN|TOEN|TWEN|^TA|^TD|^TAA/) &&
	    ((@var[2] eq "(posedge") || (@var[2] eq "(negedge"))  &&
	    (@var[3] =~ /CLK|CLKA|CLKB/)){
	@var[1]=~s/\\\[/\[/g;
	@var[1]=~s/\\\]/\]/g;
	printf OUTPUT "    %s (posedge %s) %s %s %s\n",@var[0],@var[1],@var[2],@var[3],@var[4];
	printf OUTPUT "    %s (negedge %s) %s %s %s\n",@var[0],@var[1],@var[2],@var[3],@var[4];
    }
    else{
	$_=~s/\\\[/\[/g;
	$_=~s/\\\]/\]/g;
	printf OUTPUT "%s\n",$_;
    }
}
