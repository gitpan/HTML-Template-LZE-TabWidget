package HTML::Template::LZE::TabWidget;
use strict;
use warnings;
require Exporter;
use vars qw($DefaultClass @ISA  $mod_perl);
our $style;
use HTML::Template::LZE;
@HTML::Template::LZE::TabWidget::ISA         = qw( Exporter HTML::Template::LZE);
$HTML::Template::LZE::TabWidget::VERSION     = '0.26';
$DefaultClass                                = 'HTML::Template::LZE::TabWidget' unless defined $HTML::Template::LZE::TabWidget::DefaultClass;
@HTML::Template::LZE::TabWidget::EXPORT_OK   = qw(initTabWidget Menu tabwidgetHeader tabwidgetFooter);
%HTML::Template::LZE::TabWidget::EXPORT_TAGS = ('all' => [qw(initTabWidget tabwidgetHeader Menu tabwidgetFooter)]);

$mod_perl = ($ENV{MOD_PERL}) ? 1 : 0;
no warnings;

=head1 NAME

HTML::Template::LZE::TabWidget.pm

=head1 SYNOPSIS

      use HTML::Template::LZE::TabWidget;

      my $tabwidget = new HTML::Template::LZE::TabWidget(\%patmeter);

      my %parameter = (

                        style => 'Crystal',

                        path => "/srv/www/cgi-bin/templates",

                        anchors => [

                                {

                                text  => 'HTML::Template::LZE::TabWidget ',

                                href  => "$ENV{SCRIPT_NAME}",

                                class => 'currentLink',

                                src   => 'link.png'

                                },

                                {

                                text => 'Next', 

                                class => 'links',

                                },

                                {

                                text => 'Dynamic Tab',

                                title => 'per default it is the text'

                                href  => 'javascript:displayhidden()',

                                class => 'javaScriptLink',

                                }

                        ],

      );

      print $tabwidget->tabwidgetHeader();

      $tabwidget->Menu();

      print "your content";

      print $tabwidget->tabwidgetFooter();

You also need some js and css file. 

Example:

print start_html(

        -title => 'TabWidget',

        -script => [

                {

                -type  => 'text/javascript',

                -src   => '/javascript/tabwidget.js'

                },

                ],

                -style => '/style/Crystal/tabwidget.css',

        );


=head3 function sets 

Here is a list of the function sets you can import:

:all initTabWidget tabwidgetHeader Menu tabwidgetFooter


=head2 new

        my $tb = new HTML::Template::LZE::TabWidget(%parameter);

=cut

sub new {
        my ($class, @initializer) = @_;
        my $self = {};
        bless $self, ref $class || $class || $DefaultClass;
        $self->initTabWidget(@initializer) if(@initializer && !$mod_perl);
        return $self;
}

=head2 initTabWidget

        initTabWidget(\%patmeter);

=cut

sub initTabWidget {
        my ($self, @p) = getSelf(@_);
        $style = $p[0]->{style};
        my $tmplt = defined $p[0]->{template} ? $p[0]->{template} : "tabwidget.html";
        my %template = (path => $p[0]->{path}, style => $style, template => $tmplt,);
        $self->SUPER::initTemplate(\%template);
}

=head2 Menu()

        Menu(\%patmeter);

=cut

sub Menu {
        my ($self, @p) = getSelf(@_);
        my $hash = $p[0];
        $self->initTabWidget($hash) unless $mod_perl;
        my %header = (name => 'menuHeader');
        my $m = $self->SUPER::appendHash(\%header);
        for(my $i = 0 ; $i < @{$hash->{anchors}} ; $i++) {
                my $src   = (defined $hash->{anchors}[$i]->{src})   ? $hash->{anchors}[$i]->{src}   : 'link.png';
                my $title = (defined $hash->{anchors}[$i]->{title}) ? $hash->{anchors}[$i]->{title} : $hash->{anchors}[$i]->{text};
                my %action = (title => $title, text => $hash->{anchors}[$i]->{text}, href => $hash->{anchors}[$i]->{href}, src => $src);
                my %LINK = (name => $hash->{anchors}[$i]->{class}, style => $style, text => $self->action(\%action), title => $hash->{anchors}[$i]->{title}, $src);
                $m .= $self->SUPER::appendHash(\%LINK);
        }
        my %footer = (name => 'menuFooter');
        $m .= $self->SUPER::appendHash(\%footer);
        return $m;
}

=head2 tabwidgetHeader()

        tabwidgetHeader

=cut

sub tabwidgetHeader {
        my ($self, @p) = getSelf(@_);
        my %header = (name => 'bheader', style => $style,);
        $self->SUPER::appendHash(\%header);
}

=head2 tabwidgetFooter()

        tabwidgetFooter

=cut

sub tabwidgetFooter {
        my ($self, @p) = getSelf(@_);
        my %footer = (name => 'bfooter', style => $style,);
        $self->SUPER::appendHash(\%footer);
}

=head1 private

=head2 action()

      my %reply = (

            title => 'title',

            src => 'reply',

            href => "/reply.html",

            text => 'Your Text'

      );

      action(\%reply);

=cut

sub action {
        my ($self, @p) = getSelf(@_);
        my $hash     = $p[0];
        my $title    = $hash->{text} if(defined $hash->{text});
        my $src      = $hash->{src} if(defined $hash->{src});
        my $location = $hash->{href} if(defined $hash->{href});
        my %action   = (name => 'action', text => $hash->{text}, title => $title, href => $location, src => $src);
        return $self->SUPER::appendHash(\%action);
}

=head2 getSelf

=cut

sub getSelf {
        return @_ if defined($_[0]) && (!ref($_[0])) && ($_[0] eq 'HTML::Template::LZE::TabWidget');
        return (defined($_[0]) && (ref($_[0]) eq 'HTML::Template::LZE::TabWidget' || UNIVERSAL::isa($_[0], 'HTML::Template::LZE::TabWidget'))) ? @_ : ($HTML::Template::LZE::TabWidget::DefaultClass->new, @_);
}

=head1 SEE ALSO

L<CGI::LZE> L<HTML::Template::LZE>

http://www.lindnerei.de, http://lindnerei.sourceforege.net,

Example:

http://lindnerei.sourceforge.net/cgi-bin/tabwidget.pl

=head1 AUTHOR

Dirk Lindner <lze@cpan.org>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2006- 2008 by Hr. Dirk Lindner

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU Lesser General Public License
as published by the Free Software Foundation;
This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Lesser General Public License for more details.

=cut

1;
