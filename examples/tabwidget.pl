use HTML::Template::LZE::TabWidget qw(:all);
my %parameter = (
               style => 'Crystal',
               path  => "/srv/www/cgi-bin/templates",
               anchors =>
                 [{text => 'HTML::Template::LZE::TabWidget ', href => "href", class => 'currentLink', src => 'link.png'}, {text => 'Next', class => 'links',}, {text => 'Dynamic Tab', href => 'javascript:displayhidden()', class => 'javaScriptLink',}],
);
initTabWidget(\%parameter);
print Menu(\%parameter);
print tabwidgetHeader();
print tabwidgetFooter();
