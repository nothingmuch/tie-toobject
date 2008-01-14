#!/usr/bin/perl

use strict;
#use warnings;

use Test::More 'no_plan';

use Tie::RefHash;

tie my %hash, 'Tie::RefHash';

$hash{ [ 1, 2, 3 ] } = "an array";

$hash{foo} = "a stringy";

use ok 'Tie::ToObject';

tie my %new_hash, 'Tie::ToObject', tied %hash;

is( tied(%new_hash), tied(%hash), "tied is the same" );

is_deeply( \%new_hash, \%hash, "is_deeply" );

is( Tie::ToObject->TIEHASH(tied %hash), tied(%hash), "tie is just the identity function" );

eval { tie my %other_hash, 'Tie::ToObject' };
my $e = $@;
ok($e, "error" );
like( $e, qr/object.*tie/i, "right error" );

eval { tie my %other_hash, 'Tie::ToObject', { } };
my $e = $@;
ok($e, "error" );
like( $e, qr/object.*tie/i, "right error" );

eval { Tie::ToObject->blah(tied(%hash)) };
my $e = $@;
ok($e, "error" );
like( $e, qr/method.*blah/i, "right error" );

