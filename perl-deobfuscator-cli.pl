#!/usr/bin/perl

###############################################################################
#	Perl Deobfuscator
# 	Copyright (C) 2016  Aaron Gallagher
# 
#	This program is free software; you can redistribute it and/or modify
#	it under the terms of the GNU General Public License as published by
#	the Free Software Foundation; either version 3 of the License, or
#	(at your option) any later version.
#
#	This program is distributed in the hope that it will be useful,
#	but WITHOUT ANY WARRANTY; without even the implied warranty of
#	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#	GNU General Public License for more details.
#
#	You should have received a copy of the GNU General Public License
#	along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
# 	Contact: Aaron Gallagher <aaron.b.gallagher@gmail.com>
###############################################################################
use strict;
use warnings;
use Getopt::Long qw(GetOptions);
use Security::PerlDeobfuscator;
###############################################################################
my $title = "Perl Deobfuscator v" . Security::PerlDeobfuscator->VERSION . ", Copyright (C) 2016  Aaron Gallagher\n";
my $license_sum = "This is free software, and you are welcome to redistribute it\n";
my $info = $title . $license_sum . "\n";
my $help = "Usage:\n\t$0 --in INPUT_FILE\nOptional Parameters:\n\t--out OUTPUT_FILE (Default: deobfuscated_{INPUT_FILE})\n";
my $inputfile = "";
my $outputfile = "";
###############################################################################

###############################################################################
# main - Main function, parses cli arguments and writes deobfuscated results
# Required Arg: in
# Optional Arg: out
###############################################################################
sub main {
	# Print main info
	print($info);

	# Parse command line arguments
	GetOptions(
		'in=s' => \$inputfile,
		'out=s' => \$outputfile,
	) or die $help;

	# Missing required command line argument
	if (length($inputfile) == 0) {
		print ("Missing a required command line argument\n");
		print ($help);
		return;
	}

	# Missing optional arg, use the default
	if (length($outputfile) == 0) {

		# Position of filename in string, ex: ./scripts/hello.pl
		my $idx = 0;

		# Keep looping until there are now more slashes in filename
		while ($inputfile=~ /(\/)/g) {
			if (index($inputfile, "//") == -1) {
				# Get position of filename
				$idx = pos($inputfile)-length($1)+1;
			}
		}

		# Build new string
		$outputfile = substr($inputfile, 0, $idx) . "deobfuscated_" . substr($inputfile, $idx, length($inputfile) - $idx);
	}

	# Run the deobfuscator
	my $my_deobfuscat = Security::PerlDeobfuscator->new($inputfile, $outputfile);#new_ok 'Security::Deobfuscator', [$inputfile, $outputfile];
	$my_deobfuscat->deobfuscat();

	# print the stats
	print("Deobfuscated Lines: " . $my_deobfuscat->{modified_lines} . "\n");
	print("Deobfuscated Characters: " . $my_deobfuscat->{deobfuscated_chars} . "\n");
	print("Completed deobfuscation, changes written to: " . $my_deobfuscat->{outfilename} . "\n");
}

###########
# Call main
&main();
###########
