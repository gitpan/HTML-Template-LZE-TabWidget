foreach my $action (keys %{$actions}) {
        print $action, br();
        foreach my $key (keys %{$actions->{$action}}) {
                print "$key: ", $actions->{$action}{$key}, br();
        }
}

#         $actions->{'start'}{'file'} = "$settings->{cgi}{bin}/Content/env.pl";
saveActions($settings->{actions});
includeAction();

#                                 my %vars = (user => 'guest', action => 'main', file => "/srv/www/vhosts/api/tabwidget/examples/content.pl", sub => 'main');
#                                 my $qstring = createSession(\%vars);
1;
