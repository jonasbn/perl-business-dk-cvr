# $Id: calculate.t,v 1.1 2006-02-20 21:37:04 jonasbn Exp $

use strict;
use Test::More tests => 29;
use Test::Exception;

#Test 1, load test
BEGIN { use_ok('Business::DK::CVR', qw(calculate validate)) };

#Test 2
my (@cprs = calculate(150172));
ok(scalar @cprs, 'Ok');

#Test 3
dies_ok{calculate()} 'no arguments';

#Test 4
dies_ok{calculate(123456789)} 'too long';

#Test 5
dies_ok{validate("abcdefg1")} 'unclean';

#Test 6
dies_ok{validate(0)} 'zero';
