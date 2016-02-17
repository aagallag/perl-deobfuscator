# Obfuscated by www.perlobfuscator.com
my $password = "0\x31\x32\x33\x34\x35\x36\x37\x38\x39";

sub login {
    my $attempt = @_;
    if ($attempt == $password) {
        print("\x53\x75\x63\x63\x65\x73\x73\x21\n");
    }
    else {
        print("\x46\x61\x69\x6C\x65\x64\x20\x6C\x6F\x67\x69\x6E\n");
    }
}
