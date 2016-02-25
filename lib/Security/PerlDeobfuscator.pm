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
package Security::PerlDeobfuscator;
our $VERSION = '0.03';
use strict;
use warnings;
use Getopt::Long qw(GetOptions);
require Carp;
###############################################################################

###############################################################################
# new - Constructor for the Perl Deobfuscator
# infilename - Name of file to deobfuscat
# outfilename - Name of human-readable file to write deobfuscated code to
###############################################################################
sub new {
    my ($class, $infilename, $outfilename, @args) = @_ or Carp::croak("Missing Input or Output file");

    bless {
        infilename         => $infilename,
        outfilename        => $outfilename,
        modified_lines     => 0,
        deobfuscated_chars => 0,
        @args
    }, $class;
}

###############################################################################
# deobfuscat - Deobfuscats the perl strings
###############################################################################
sub deobfuscat {
	my ($self) = @_;

	# Open both files
	open(my $in_fh, '<', $self->{infilename});
	open(my $out_fh, '>', $self->{outfilename});

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
			$self->{deobfuscated_chars} = $self->{deobfuscated_chars} + 1;
		}

		# write to output file
		print $out_fh $line;

		# if changed, increase counter
		if ($changed) {
			$self->{modified_lines} = $self->{modified_lines} + 1;
		}
	}

	# close both files
	close($in_fh);
	close($out_fh);
}
