[![CPAN version](https://badge.fury.io/pl/Business-DK-CVR.svg)](http://badge.fury.io/pl/Business-DK-CVR)
[![Build Status](https://travis-ci.org/jonasbn/bdkcvr.svg?branch=master)](https://travis-ci.org/jonasbn/bdkcvr)
[![Coverage Status](https://coveralls.io/repos/jonasbn/bdkcvr/badge.png)](https://coveralls.io/r/jonasbn/bdkcvr)

# NAME

Business::DK::CVR - Danish CVR (VAT Registration) number generator/validator

# VERSION

This documentation describes version 0.10 of Business::DK::CVR

# SYNOPSIS

    use Business::DK::CVR qw(validate);

    my $rv;
    eval { $rv = validate(27355021); };

    if ($@) {
        die "Code is not of the expected format - $@";
    }

    if ($rv) {
        print "Code is valid";
    } else {
        print "Code is not valid";
    }

    #Using with Params::Validate
    #See also examples/

    use Params::Validate qw(:all);
    use Business::DK::CVR qw(validateCVR);

    eval {
        check_cvr(cvr => 27355021);
    };

    if ($@) {
        print "CVR is not valid - $@\n";
    }

    eval {
        check_cvr(cvr => 27355020);
    };

    if ($@) {
        print "CVR is not valid - $@\n";
    }

    sub check_cvr {
        validate( @_,
        { cvr =>
            { callbacks =>
                { 'validate_cvr' => sub { validateCVR($_[0]); } } } } );

        print "$_[0] is a valid CVR\n";

    }

# DESCRIPTION

CVR is a company registration number used in conjuction with VAT handling in
Denmark.

If you want to use this module with [Data::FormValidator](https://metacpan.org/pod/Data::FormValidator) please check:
[Data::FormValidator::Constraints::Business::DK::CVR](https://metacpan.org/pod/Data::FormValidator::Constraints::Business::DK::CVR)

# SUBROUTINES AND METHODS

## validate

The function takes a single argument, a 10 digit CVR number.

The function returns 1 (true) in case of a valid CVR number argument and  0
(false) in case of an invalid CVR number argument.

If the argument is a valid argument the sum is calculated by **\_calculate\_sum**
based on the argument and the controlcifers array.

The sum returned is checked using a modulus caluculation and based on its
validity either 1 or 0 is returned.

## validateCVR

Better name for export. This is just a wrapper for ["validate"](#validate)

## generate

Generate is a function which generates valid CVR numbers, it is by no means
an authority, since CVRs are generated and distributed by danish tax
authorities, but it can be used to generate example CVRs for testing and so on.

# PRIVATE FUNCTIONS

## \_calculate\_sum

This function takes an integer and calculates the sum bases on the the
controlcifer array.

# EXPORTS

Business::DK::CVR exports on request:

- ["validate"](#validate)
- ["generate"](#generate)
- ["\_calculate\_sum"](#_calculate_sum)

# DIAGNOSTICS

- The amount requested exceeds the maximum possible valid CVRs 9090908

    The number of valid CVRs are limited, so if the user requests a number of CVRs
    to be generated which exceeds the upper limit, this error is instantiated.
    See: ["generate"](#generate).

# CONFIGURATION AND ENVIRONMENT

The module requires no special configuration or environment to run.

# DEPENDENCIES

- [Params::Validate](https://metacpan.org/pod/Params::Validate)
- [Exporter](https://metacpan.org/pod/Exporter)
- [Carp](https://metacpan.org/pod/Carp)
- [Scalar::Util](https://metacpan.org/pod/Scalar::Util)
- [Class::InsideOut](https://metacpan.org/pod/Class::InsideOut)
- [English](https://metacpan.org/pod/English)
- [Params::Validate](https://metacpan.org/pod/Params::Validate)
- [Readonly](https://metacpan.org/pod/Readonly)

# INCOMPATIBILITIES

The module has no known incompatibilities.

# BUGS AND LIMITATIONS

The module has no known bugs or limitations.

# TEST AND QUALITY

Coverage of the test suite is at 100%

# BUG REPORTING

Please report issues via CPAN RT:

    http://rt.cpan.org/NoAuth/Bugs.html?Dist=Business-DK-CVR

or by sending mail to

    bug-Business-DK-CVR@rt.cpan.org

# SEE ALSO

- [http://www.cvr.dk/](http://www.cvr.dk/)
- [Business::DK::CPR](https://metacpan.org/pod/Business::DK::CPR), validation of Danish social security numbers
- [http://search.cpan.org/dist/Algorithm-CheckDigits](http://search.cpan.org/dist/Algorithm-CheckDigits), an alternative implementation
- [http://search.cpan.org/~mamawe/Algorithm-CheckDigits-0.38/CheckDigits/M11\_008.pm](http://search.cpan.org/~mamawe/Algorithm-CheckDigits-0.38/CheckDigits/M11_008.pm), see above
- [Data::FormValidator::Constraints::Business::DK::CVR](https://metacpan.org/pod/Data::FormValidator::Constraints::Business::DK::CVR), a validator for DFV, included in this distribution
- [Business::Tax::VAT](https://metacpan.org/pod/Business::Tax::VAT), for VAT rates and doing VAT calculations

# AUTHOR

Jonas B. Nielsen, (jonasbn) - `<jonasbn@cpan.org>`

# COPYRIGHT

Business-DK-CVR and related is (C) by Jonas B., (jonasbn) 2006-2020

# LICENSE

Business-DK-CVR is released under the Artistic License 2.0
