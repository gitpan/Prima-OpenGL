# $Id$
package MY;
use strict;
use ExtUtils::MakeMaker;
use Config;
use Prima::Config;

my @libs;
my @obj  = ('OpenGL.o');

if ( 
	$^O eq 'MSWin32' or 
	( $^O eq 'cygwin' and $Prima::Config::Config{platform} eq 'win32')
) {
	push @libs, '-L/lib/w32api' if $^O eq 'cygwin';
	push @libs, '-lopengl32 -lgdi32';
	push @obj,  'win32.o';
} else {
	push @libs, '-lGL';
	push @obj,  'x11.o';
}

push @libs, $Prima::Config::Config{libs};

WriteMakefile(
	NAME               => 'Prima::OpenGL',
	VERSION_FROM       => 'lib/Prima/OpenGL.pm',
	MIN_PERL_VERSION   => '5.008',
	PREREQ_PM          => {
		'Prima'		=> '1.30',
		'OpenGL'	=> '0.64',
	},
	CONFIGURE_REQUIRES => {
		'Prima'		=> '1.30',
	},
	ABSTRACT_FROM      => 'lib/Prima/OpenGL.pm',
	AUTHOR             => 'Dmitry Karasik <dmitry@karasik.eu.org>',
	LIBS               => "@libs",
	DEFINE             => "$Prima::Config::Config{define}",
	INC                => "$Prima::Config::Config{inc} -Iinclude",
	OBJECT             => "@obj",
);
