package MT::Plugin::HatebuCount;
use strict;
use base qw( MT::Plugin );

use constant NAME => ( split /::/, __PACKAGE__ )[-1];
use constant FREQ => 60 * 60 * 24;

my $plugin = __PACKAGE__->new({
    name           => NAME,
    id             => lc NAME,
    key            => lc NAME,
    l10n_class     => NAME . '::L10N',
    version        => '0.01',
    author_name    => 'masiuchi',
    author_link    => 'https://github.com/masiuchi',
    plugin_link    => 'https://github.com/masiuchi/mt-plugin-hatebu-count',
    description    => '<__trans phrase="This plugin gets and shows the Hatebu Count of entries and pages.">',
});
MT->add_plugin( $plugin );

sub init_registry {
    my ( $p ) = @_;
    $p->registry({
        object_types => {
            entry => {
                hatebu_count => 'integer meta',
            },
        },
        list_properties => {
            entry => '$'.NAME.'::'.NAME.'::ListProps::list_prop',
            page  => '$'.NAME.'::'.NAME.'::ListProps::list_prop',
        },
        tasks => {
            get_hatebu_count => {
                name      => 'get_hatebu_count',
                frequency => FREQ,
                code      => '$'.NAME.'::'.NAME.'::Tasks::get_hatebu_count',
            },
        },
    });
}

1;
__END__
