#!/usr/bin/perl

use strict;
use warnings;

use Test::More 'no_plan';

use Tie::RefHash;

tie my %hash, 'Tie::RefHash';

$hash{ [ 1, 2, 3 ] } = "an array";

$hash{foo} = "a stringy";

use ok 'Tie::ToObject';

tie my %new_hash, 'Tie::ToObject', tied %hash;

is( tied(%new_hash), tied(%hash), "tied is the same" );

is_deeply( \%new_hash, \%hash, "is_deeply" );

