#!/usr/bin/env perl

# obmenu-generator - schema file

require "$ENV{HOME}/.config/obmenu-generator/config.pl";
my $editor = $CONFIG->{editor};

our $SCHEMA = [
    {sep   => "QUICK START"},
    {beg   => ["Launch Apps", "$ENV{HOME}/gigabox/icons/Gladient/find.png"]},
    {cat   => ["utility", "Accessories", "applications-utilities"]},
    {cat   => ["development", "Development", "applications-development"]},
    {cat   => ["education", "Education", "applications-science"]},
    {cat   => ["game", "Games", "applications-games"]},
    {cat   => ["graphics", "Graphics", "applications-graphics"]},
    {cat   => ["audiovideo", "Multimedia", "applications-multimedia"]},
    {cat   => ["network", "Network", "applications-internet"]},
    {cat   => ["office", "Office", "applications-office"]},
    {cat   => ["other", "Other", "applications-other"]},
    {cat   => ["settings", "Settings", "applications-accessories"]},
    {cat   => ["system", "System", "applications-system"]},
    {end   => undef},
    {sep   => undef},
    {item  => ["$ENV{HOME}/.scripts/launch-apps.sh terminal", "Open Terminal", "$ENV{HOME}/gigabox/icons/Gladient/terminal.png"]},
    {item  => ["$ENV{HOME}/.scripts/launch-apps.sh file_manager", "Open File Manager", "$ENV{HOME}/gigabox/icons/Gladient/file-manager.png"]},
    {sep   => undef},
    {beg   => ["Screenshot", "$ENV{HOME}/gigabox/icons/Gladient/screenshot.png"]},
    {item  => ["$ENV{HOME}/.scripts/screenshot-screen.sh delay", "Screen", "$ENV{HOME}/gigabox/icons/Gladient/screenshot.png"]},
    {item  => ["$ENV{HOME}/.scripts/screenshot-selection.sh", "Select or Draw", "$ENV{HOME}/gigabox/icons/Gladient/screenshot.png"]},
    {item  => ["$ENV{HOME}/.scripts/screenshot-countdown.sh", "Countdown ?s", "$ENV{HOME}/gigabox/icons/Gladient/screenshot.png"]},
    {end   => undef},
    {sep   => undef},
    {pipe  => ["$ENV{HOME}/.config/openbox/pipe-menu/ob-randr.py", "Monitor Settings", "$ENV{HOME}/gigabox/icons/Gladient/monitor-settings.png"]},
    {obgenmenu => ["Advanced Settings", "$ENV{HOME}/gigabox/icons/Gladient/advanced-settings.png"]},
    {sep   => undef},
    {sep   => "SESSIONS"},
    {beg   => ["Appearance", "$ENV{HOME}/gigabox/icons/Gladient/appearance.png"]},
    {item  => ["$ENV{HOME}/.config/openbox/joyful-desktop/wallpaper-set.sh", "Change X Wallpaper", "$ENV{HOME}/gigabox/icons/Gladient/wallpaper.png"]},
    {end   => undef},
    {sep   => undef},
    {item  => ["loginctl --no-ask-password lock-session", "Lock", "$ENV{HOME}/gigabox/icons/Gladient/lock.png"]},
    {sep   => undef},
    {exit  => ["Exit Openbox", "$ENV{HOME}/gigabox/icons/Gladient/logout.png"]},
];

