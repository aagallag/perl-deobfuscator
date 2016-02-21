# Perl Deobfuscator

## Features and Limitations
Detects strings that have been mangled and makes them human-readable.
Only tested against the Perl obfuscator at http://perlobfuscator.com/ with
the "String Mangling" option enabled.  Currently, this script will not be
able to unobfuscate anything more complex.

## How to use

##### Clone repository
```
git clone https://github.com/aagallag/perl-deobfuscator.git
```

##### Execute deobfuscator on sample script
```
cd perl-deobfuscator
perl-deobfuscator -in sample/obfuscated_test.pl
```

##### Expected output
```
Perl Deobfuscator, Copyright (C) 2016  Aaron Gallagher
This is free software, and you are welcome to redistribute it

Deobfuscated Lines: 3
Deobfuscated Characters: 29
Completed deobfuscation, changes written to: sample/deobfuscated_obfuscated_test.pl
```

## License
  Perl Deobfuscator
 	Copyright (C) 2016  Aaron Gallagher
 
	This program is free software; you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation; either version 3 of the License, or
	(at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with this program.  If not, see <http://www.gnu.org/licenses/>.

 	Contact: Aaron Gallagher <aaron.b.gallagher@gmail.com>
