#!/usr/bin/env perl

# obmenu-generator - schema file

require "$ENV{HOME}/.config/obmenu-generator/config.pl";
my $editor = $CONFIG->{editor};

our $SCHEMA = [
    {sep   => "QUICK START"},
    {beg   => ["Launch Apps", "$ENV{HOME}/.icons/Gladient/find.png"]},
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
    {item  => ["kitty", "Open Terminal", "$ENV{HOME}/.icons/Gladient/terminal.png"]},
    {item  => ["thunar", "Open File Manager", "$ENV{HOME}/.icons/Gladient/file-manager.png"]},
    {sep   => undef},
    {item  => ["$ENV{HOME}/.config/rofi/bin/screenshot", "Take a Screenshot", "$ENV{HOME}/.icons/Gladient/screenshot.png"]},
    {sep   => undef},
    {item => ["$ENV{HOME}/.config/openbox/scripts/toggle-safeeyes.sh", "Toggle Safe Eyes", "$ENV{HOME}/.icons/Gladient/eyecandy.artistic.png"]},
    {pipe  => ["$ENV{HOME}/.config/openbox/pipe-menu/ob-randr.py", "Monitor Settings", "$ENV{HOME}/.icons/Gladient/monitor-settings.png"]},
    {beg => ["Monitor Scripts", "$ENV{HOME}/.icons/Gladient/monitor-settings.png"]},
    {item  => ["$ENV{HOME}/.config/openbox/scripts/laptop-only.sh", "Laptop Only", "$ENV{HOME}/.icons/Gladient/monitor-settings.png"]},
    {item  => ["$ENV{HOME}/.config/openbox/scripts/main-only.sh", "Main Only", "$ENV{HOME}/.icons/Gladient/monitor-settings.png"]},
    {item  => ["$ENV{HOME}/.config/openbox/scripts/two-monitors.sh", "Two Monitors", "$ENV{HOME}/.icons/Gladient/monitor-settings.png"]},
    {item  => ["$ENV{HOME}/.config/openbox/scripts/three-monitors.sh", "Three Monitors", "$ENV{HOME}/.icons/Gladient/monitor-settings.png"]},
    {end   => undef},
    {sep   => undef},
    {obgenmenu => ["Advanced Settings", "$ENV{HOME}/.icons/Gladient/advanced-settings.png"]},
    {sep   => undef},
    {sep   => "SESSIONS"},
    {beg   => ["Appearance", "$ENV{HOME}/.icons/Gladient/appearance.png"]},
    {item  => ["nitrogen", "Change Wallpaper", "$ENV{HOME}/.icons/Gladient/wallpaper.png"]},
    {end   => undef},
    {sep   => undef},
    {item  => ["loginctl --no-ask-password lock-session", "Lock", "$ENV{HOME}/.icons/Gladient/lock.png"]},
    {sep   => undef},
    {exit  => ["Exit Openbox", "$ENV{HOME}/.icons/Gladient/logout.png"]},
];

