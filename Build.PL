# Build.PL for Business-DK-CVR

# $Id: Build.PL,v 1.2 2006-02-20 21:50:41 jonasbn Exp $

use Module::Build;
my $build = Module::Build->new(
	dist_author        => 'Jonas B. Nielsen, (jonasbn) <jonasbn@cpan.org>',
	module_name        => 'Business::DK::CVR',
	dist_version_from  => 'lib/Business/DK/CVR.pm',
	license            => 'artistic',
	create_makefile_pl => 'passthrough',
	requires => {
	    'Exporter'         => 0, #core
		'Carp'             => 0, #core
		'Test::Exception'  => 0,
		'Business::DK::PO' => 0.02,
	},
);
$build->create_build_script();
