package Business::DK::CVR;

# $Id: CVR.pm,v 1.6 2007-03-13 19:15:33 jonasbn Exp $

use strict;
use warnings;
use vars qw($VERSION @ISA @EXPORT_OK);
use Carp qw(croak);
use Business::DK::PO qw(_argument _content);

require Exporter;

$VERSION   = '0.04';
@ISA       = qw(Exporter);
@EXPORT_OK = qw(validate _length _calculate_sum);

use constant MODULUS_OPERAND => 11;

my @controlcifers = qw(2 7 6 5 4 3 2 1);

sub validate {
    my $controlnumber = shift;

    my $controlcode_length = scalar(@controlcifers);

    if ( !$controlnumber ) {
        _argument($controlcode_length);
    }
    _content($controlnumber);
    _length( $controlnumber, $controlcode_length );

    my $sum = _calculate_sum( $controlnumber, \@controlcifers );

    if ( $sum % MODULUS_OPERAND ) {
        return 0;
    } else {
        return 1;
    }
}

sub _length {
    my ( $number, $length ) = @_;

    if ( length($number) != $length ) {
        croak "argument: $number has to be $length digits long";
    }
    return 1;
}

sub _calculate_sum {
    my ( $number, $controlcifers ) = @_;

    my $sum = 0;
    my @numbers = split( //, $number );

    for ( my $i = 0; $i < scalar(@numbers); $i++ ) {
        $sum += $numbers[$i] * $controlcifers->[$i];
    }
    return $sum;
}

1;

__END__

=head1 NAME

Business::DK::CVR - a danish CVR (VAT Registration) code generator/validator

=head1 VERSION

This documentation describes version 0.04

=head1 SYNOPSIS

	use Business::DK::CVR qw(validate);

	my $rv;
	eval {
		$rv = validate(27355021);
	};
	
	if ($@) {
		die "Code is not of the expected format - $@";
	}
	
	if ($rv) {
		print "Code is valid";
	} else {
		print "Code is not valid";
	}


=head1 DESCRIPTION

CVR is a company registration number used in conjuction with VAT handling.

=head2 validate

The function takes a single argument, a 10 digit CVR number. 

The function returns 1 (true) in case of a valid CVR number argument and  0 
(false) in case of an invalid CVR number argument.

The validation function goes through the following steps.

Validation of the argument is done using the functions (all described below in 
detail):

=over

=item _argument, exported by L<Business::DK::PO>

=item _content, exported by L<Business::DK::PO>

=item _length

=back

If the argument is a valid argument the sum is calculated by B<_calculate_sum>
based on the argument and the controlcifers array.

The sum returned is checked using a modulus caluculation and based on its
validity either 1 or 0 is returned.

=head1 PRIVATE FUNCTIONS

=head2 _length

This function validates the length of the argument, it dies if the argument
does not fit wihtin the boundaries specified by the arguments provided:

The B<_length> function takes the following arguments:

=over

=item number (mandatory), the number to be validated

=item length required of number (mandatory)

=back

=head2 _calculate_sum

This function takes an integer and calculates the sum bases on the the 
controlcifer array.

=head1 EXPORTS

Business::DK::CVR exports on request:

=over

=item validate

=item _length 

=item _calculate_sum

=back

=head1 TESTS

Coverage of the test suite is at 100%

=head1 BUGS

Please report issues via CPAN RT:

  http://rt.cpan.org/NoAuth/Bugs.html?Dist=Business-DK-CVR

or by sending mail to

  bug-Business-DK-CVR@rt.cpan.org

=head1 SEE ALSO

=over

=item L<http://www.cpr.dk/>

=item L<Business::DK::PO>

=item L<Business::DK::CPR>

=item L<http://search.cpan.org/dist/Algorithm-CheckDigits>

=item L<http://search.cpan.org/~mamawe/Algorithm-CheckDigits-0.38/CheckDigits/M11_008.pm>

=back

=head1 AUTHOR

Jonas B. Nielsen, (jonasbn) - C<< <jonasbn@cpan.org> >>

=head1 COPYRIGHT

Business-DK-CVR is (C) by Jonas B. Nielsen, (jonasbn) 2006

Business-DK-CVR is released under the artistic license

The distribution is licensed under the Artistic License, as specified
by the Artistic file in the standard perl distribution
(http://www.perl.com/language/misc/Artistic.html).

=cut
