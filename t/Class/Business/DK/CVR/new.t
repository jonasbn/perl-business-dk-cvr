#!/usr/bin/perl -w

# $Id$

use strict;
use warnings;
use Test::More tests => 4;
use Test::Exception;
use English qw(-no_match_vars);

use Class::Business::DK::CVR;

ok(my $cvr = Class::Business::DK::CVR->new(27355021));

isa_ok($cvr, 'Class::Business::DK::CVR');

dies_ok { $cvr = Class::Business::DK::CVR->new(); } 'no argument to constructor';

like($EVAL_ERROR, qr/You must provide a CVR number/, 'asserting error message');