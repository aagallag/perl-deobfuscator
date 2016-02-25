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
package Security::PerlDeobfuscator
our $VERSION   = '0.03';
use strict;
use warnings;
use Getopt::Long qw(GetOptions);
###############################################################################
my $title = "Perl Deobfuscator, Copyright (C) 2016  Aaron Gallagher\n";
my $license_sum = "This is free software, and you are welcome to redistribute it\n";
my $info = $title . $license_sum . "\n";
my $help = "Usage:\n\t$0 --in INPUT_FILE\nOptional Parameters:\n\t--out OUTPUT_FILE (Default: deobfuscated_{INPUT_FILE})\n";
my $inputfile = "";
my $outputfile = "";
my $modified_lines = 0;
my $deobfuscated_chars = 0;
###############################################################################

###############################################################################
# deobfuscat - Deobfuscats the perl strings
# infilename - Name of file to deobfuscat
# outfilename - Name of human-readable file to write deobfuscated code to
###############################################################################
sub deobfuscat {
	my ($infilename, $outfilename) = @_;

	# Open both files
	open(my $in_fh, '<', $infilename);
	open(my $out_fh, '>', $outfilename);

	# Read contents of file, one line at a times
	while( my $line = $in_fh->getline() ) {
		my $changed = 0;

		# Keep looping until all instances of '\xHEX' have been replaced with ascii char
		while ($line=~ /(\\x[0-9A-F]{2})/g) {
			# Set the starting index
			my $idx = pos($line)-length($1);

			# isolate the hex numbers from the rest of the string
			my $char = substr($line, $idx+2, 2);

			# convert the hex digits to decimal
			my $decvalue =  hex($char);

			# convert the decimal value to ASCII character
			$char = chr($decvalue);

			# replace the hex characters with ascii character
			$line = substr($line, 0, $idx) . $char . substr($line, $idx+4);

			# set changed to true
			$changed = 1;

			# increase the character counter
			$deobfuscated_chars = $deobfuscated_chars + 1;
		}

		# write to output file
		print $out_fh $line;

		# if changed, increase counter
		if ($changed) {
			$modified_lines = $modified_lines + 1;
		}
	}

	# close both files
	close($in_fh);
	close($out_fh);
}
