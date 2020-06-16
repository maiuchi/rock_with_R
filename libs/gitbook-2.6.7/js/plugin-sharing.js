gitbook.require(["gitbook", "lodash", "jQuery"], function(gitbook, _, $) {
    var SITES = {
        'twitter': {
            'label': 'Twitter',
            'icon': 'fa fa-twitter',
            'onClick': function(e) {
                e.preventDefault();
                window.open("https://twitter.com/CUIMClibrary");
            }
        },
    };



    gitbook.events.bind("start", function(e, config) {
        var opts = config.sharing;
        if (!opts) return;

        // Create dropdown menu
        var menu = _.chain(opts.all)
            .map(function(id) {
                var site = SITES[id];
                if (!site) return;
                return {
                    text: site.label,
                    onClick: site.onClick
                };
            })
            .compact()
            .value();

        // Create main button with dropdown
        if (menu.length > 0) {
            gitbook.toolbar.createButton({
                icon: 'fa fa-share-alt',
                label: 'Share',
                position: 'right',
                dropdown: [menu]
            });
        }

        // Direct actions to share
        _.each(SITES, function(site, sideId) {
            if (!opts[sideId]) return;

            gitbook.toolbar.createButton({
                icon: site.icon,
                label: site.label,
                title: site.label,
                position: 'right',
                onClick: site.onClick
            });
        });
    });
});
