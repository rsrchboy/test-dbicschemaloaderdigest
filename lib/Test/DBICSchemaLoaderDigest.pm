package Test::DBICSchemaLoaderDigest;
use strict;
use warnings;
use 5.00800;
use base qw/Exporter/;
use Test::More;
use Digest::MD5 ();
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

# ABSTRACT: test the DBIC::Schema::Loader's MD5 sum

1;
__END__

=for stopwords AAAAHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH

=encoding utf8

=head1 SYNOPSIS

  use Test::More tests => 1;
  use Test::DBICSchemaLoaderDigest;
  test_dbic_schema_loader_digest('lib/Proj/Schema/Foo.pm');

=head1 DESCRIPTION

Hey DBIC::Schema::Loader dumps follow code:

    # DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:2lkIltTa9Ey3fExXmUB/gw

But, some programmer MODIFY THE ABOVE OF
THIS CODE!!!!!!!!!! AAAAHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH!!!

This module tests for manual changes to the forbidden zone. If you use this
test, you can stop this problem before it becomes a real problem.

=head1 METHODS

=head2 test_dbic_schema_loader_digest('lib/Proj/Schema/Foo.pm')

Check the MD5 sum.

=head1 CODE COVERAGE

    ---------------------------- ------ ------ ------ ------ ------ ------ ------
    File                           stmt   bran   cond    sub    pod   time  total
    ---------------------------- ------ ------ ------ ------ ------ ------ ------
    ...DBICSchemaLoaderDigest.pm  100.0  100.0    n/a  100.0  100.0  100.0  100.0
    Total                         100.0  100.0    n/a  100.0  100.0  100.0  100.0
    ---------------------------- ------ ------ ------ ------ ------ ------ ------

=head1 SEE ALSO

L<DBIx::Class::Schema::Loader>

=cut
