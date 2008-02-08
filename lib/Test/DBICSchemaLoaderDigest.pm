package Test::DBICSchemaLoaderDigest;
use strict;
use warnings;
use 5.00800;
use base qw/Exporter/;
use Test::More;
use Digest::MD5 ();
our $VERSION = '0.01';
our @EXPORT = qw/test_dbic_schema_loader_digest/;

our $MARK_RE = qr{^(# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:)([A-Za-z0-9/+]{22})\n};

sub test_dbic_schema_loader_digest {
    my $fname = shift;

    open my $fh, '<', $fname or die "$fname $!";

    my $buf = '';
    while ( my $line = <$fh> ) {
        if ( $line =~ $MARK_RE ) {
            $buf .= $1;
            is Digest::MD5::md5_base64( $buf ), $2, "$fname is valid";
            close $fh;
            return;
        }
        else {
            $buf .= $line;
        }
    }
    close $fh;

    ok undef, "md5sum not found: $fname";
}

1;
__END__

=encoding utf8

=head1 NAME

Test::DBICSchemaLoaderDigest - test the DBIC::Schema::Loader's MD5 sum

=head1 SYNOPSIS

  use Test::More tests => 1;
  use Test::DBICSchemaLoaderDigest;
  test_dbic_schema_loader_digest('lib/Proj/Schema/Foo.pm');

=head1 DESCRIPTION

Hey DBIC::Schema::Loader dumps follow code:

    # DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:2lkIltTa9Ey3fExXmUB/gw

But, some programmer MODIFY THE ABOVE OF
THIS CODE!!!!!!!!!! AAAAHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH!!!

This module tests this module.If you use this module, you can stop this problem.

=head1 AUTHOR

Tokuhiro Matsuno E<lt>tokuhirom@gmail.comE<gt>

=head1 SEE ALSO

L<DBIx::Class::Schema::Loader>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
