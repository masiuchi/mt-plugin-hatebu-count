package HatebuCount::ListProps;
use strict;

sub list_prop {
    return {
        hatebu_count => {
            base      => '__virtual.integer',
            label     => 'Hatebu Count',
            display   => 'default',
            raw       => \&_raw,
            bulk_sort => \&_bulk_sort,
            terms     => \&_terms,
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

sub _terms {
    my $prop = shift;
    my ( $args, $db_terms, $db_args ) = @_;

    my $option = $args->{option};
    my $value  = $args->{value};
    my $query;
    if ( 'equal' eq $option ) {
        $query = $value;
    }
    elsif ( 'not_equal' eq $option ) {
        $query = { not => $value };
    }
    elsif ( 'greater_than' eq $option ) {
        $query = { '>' => $value };
    }
    elsif ( 'greater_equal' eq $option ) {
        $query = { '>=' => $value };
    }
    elsif ( 'less_than' eq $option ) {
        $query = { '<' => $value };
    }
    elsif ( 'less_equal' eq $option ) {
        $query = { '<=' => $value };
    }

    $db_args->{joins} ||= [];
    require MT::Entry;
    push @{ $db_args->{joins} }, MT::Entry->meta_pkg()->join_on(
        undef,
        {
            entry_id => \'= entry_id',
            type     => 'hatebu_count',
            vinteger => $query,
        },
        {
        },
    );
}

1;
__END__
