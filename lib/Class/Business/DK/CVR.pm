package Class::Business::DK::CVR;

# $Id$

use strict;
use warnings;
use Class::InsideOut qw( private register id );
use Carp qw(croak);
use English qw(-no_match_vars);

use Business::DK::CVR qw(validate);

our $VERSION = '0.01';

private number => my %number;     # read-only accessor: number()

sub new {
    my ($class, $number) = @_;
    
    my $self = \( my $scalar );
    
    bless $self, $class;
    
    register( $self );
    
    if ($number) {
        $self->set_number($number);
    } else {
        croak 'You must provide a CVR number';
    }

    return $self;
}

sub number { $number{ id $_[0] } }

sub get_number { $number{ id $_[0] } }

sub set_number {
    
    my $rv;
    
    if ($_[1]) {
        eval { $rv = validate($_[1]); };
    
        if ($EVAL_ERROR or not $rv) {
            croak 'Invalid CVR number parameter';
            
        } else {
            $number{ id $_[0] } = $_[1];
            return 1;
            
        }
    } else {
        croak 'You must provide a CVR number';
    }
}

1;

__END__

=pod

=head1 NAME

Class::Business::DK::CVR - Danish CVR number class 

=head1 VERSION

The documentation describes version 0.01 of Class::Business::DK::CVR

=head1 SYNOPSIS

    use Class::Business::DK::CVR;

    my $cvr = Class::Business::DK::CVR->new(27355021);

=head1 DESCRIPTION

This module exposes a set of subroutines which are compatible with
L<Data::FormValidator>. The module implements contraints as specified in
L<Data::FormValidator::Constraints>.

=head1 SUBROUTINES AND METHODS

=head2 new

This is the constructor, it takes a single mandatory parameter, which should be
a valid CVR number, if the parameter provided is not valid, the constructor
dies.

=head2 get_number

This method/accessor returns the CVR number associated with the object.

=head2 number

Alias for the L</get_number> accessor, see above.

=head2 set_number

This method/mutator sets the a CVR number for a given CVR object, it takes a
single mandatory parameter, which should be a valid CVR number, returns true (1)
upon success else it dies.

=head1 DIAGNOSTICS

=over

=item * You must provide a CVR number, thrown by L</set_number> and L</new> if
no argument is provided.

=item * Invalid CVR number parameter, thrown by L</new> and L</set_number> if
the provided argument is not a valid CVR number.

=back

=head1 CONFIGURATION AND ENVIRONMENT

The module requires no special configuration or environment to run.

=head1 DEPENDENCIES

=over

=item * L<Class::InsideOut>

=item * L<Business::DK::CVR>

=back

=head1 INCOMPATIBILITIES

The module has no known incompatibilities.

=head1 BUGS AND LIMITATIONS

The module has no known bugs or limitations

=head1 TEST AND QUALITY

Coverage of the test suite is at 98.3%

=head1 TODO

=over

=item * Please refer to the TODO file

=back

=head1 SEE ALSO

=over

=item * L<Business::DK::CVR>

=back

=head1 BUG REPORTING

Please report issues via CPAN RT:

  http://rt.cpan.org/NoAuth/Bugs.html?Dist=Business-DK-CVR

or by sending mail to

  bug-Business-DK-CVR@rt.cpan.org
  
=head1 AUTHOR

Jonas B. Nielsen, (jonasbn) - C<< <jonasbn@cpan.org> >>

=head1 COPYRIGHT

Business-DK-CVR and related is (C) by Jonas B. Nielsen, (jonasbn) 2006-2009

=head1 LICENSE

Business-DK-CVR and related is released under the artistic license

The distribution is licensed under the Artistic License, as specified
by the Artistic file in the standard perl distribution
(http://www.perl.com/language/misc/Artistic.html).

=cut