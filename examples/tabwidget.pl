#!/usr/bin/perl -w
use lib("lib");
use CGI::LZE qw(:all);
init("/home/groups/l/li/lindnerei/cgi-bin/config/settings.pl");
print header;
print start_html(-title => 'HTML::Template::LZE::TabWidget', -script => [{-type => 'text/javascript', -src => '/javascript/tabwidget.js'}], -style => '/style/Crystal/tabwidget.css',);

use HTML::Template::LZE::TabWidget qw(:all);

my %parameter = (
                 style   => 'Crystal',
                 path    => "/home/groups/l/li/lindnerei/cgi-bin/templates",
                 anchors => [
                             {text => 'HTML::Template::LZE::TabWidget ', src  => 'link.png',                   href  => $ENV{SCRIPT_NAME}, class => 'links',},
                             {text => 'Next',                            href => "$ENV{SCRIPT_NAME}?do=1",     class => 'links',},
                             {text => 'Dynamic Tab',                     href => 'javascript:displayhidden()', class => 'javaScriptLink',}
                 ],
);
initTabWidget(\%parameter);

if(param('do')) {
        $parameter{anchors}[1]{class} = 'currentLink';
        $parameter{anchors}[1]{text}  = 'Current Page';
        print Menu(\%parameter);
        print tabwidgetHeader();
        do("./content.pl");
} else {
        $parameter{anchors}[0]{class} = 'currentLink';
        print Menu(\%parameter);
        print tabwidgetHeader();
        use showsource;
        &showSource("./tabwidget.pl");
}
print tabwidgetFooter();
print end_html;

