package HatebuCount::Tasks;
use strict;
use LWP::Simple;

use constant API_URL => 'http://api.b.st-hatena.com/entry.count';

sub get_hatebu_count {
    require MT::Entry;
    # get counts slowly
    my $iter = MT::Entry->load_iter(
        { status   => MT::Entry::RELEASE() },
        { no_class => 1 },
    );
    while ( my $entry = $iter->() ) {
        my $link  = $entry->permalink or next;
        my $count = _get_count( $link );
        if ( $count ) {
            $entry->hatebu_count( $count );
            $entry->update or die "cnnot update";
        }
    }
}

sub _get_count {
    return get( API_URL . '?' . $_[0] );
}

1;
__END__
