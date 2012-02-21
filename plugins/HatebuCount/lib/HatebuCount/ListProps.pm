package HatebuCount::ListProps;
use strict;

sub list_prop {
    return {
        hatebu_count => {
            label           => 'Hatebu Count',
            display         => 'default',
            raw             => \&_raw,
            bulk_sort       => \&_bulk_sort,
        },
    };
}

sub _raw {
    my ( $prop, $obj ) = @_;
    return $obj->hatebu_count;
}

sub _bulk_sort {
    my ( $prop, $objs ) = @_;
    return sort { $a->hatebu_count <=> $b->hatebu_count } @$objs;
}

1;
__END__
