-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/

hl.window_rule({
    name      = "discord-to-3",
    match     = { class = "discord" },
    workspace = "3 silent",
})

hl.window_rule({
    name      = "vesktop-to-3",
    match     = { class = "vesktop" },
    workspace = "3 silent",
})

hl.window_rule({
    name      = "steam-to-4",
    match     = { class = "steam" },
    workspace = "4 silent",
})

hl.window_rule({
    name      = "lutris-to-4",
    match     = { class = "lutris" },
    workspace = "4",
})

hl.window_rule({
    name      = "brave-dev-to-1",
    match     = { class = "^(brave-browser)$", title = "^(DEV)$" },
    workspace = "1 silent",
})

hl.window_rule({
    name      = "brave-www-to-2",
    match     = { class = "^(brave-browser)$", title = "^(WWW)$" },
    workspace = "2 silent",
})

hl.window_rule({
    name      = "brave-dnd-to-5",
    match     = { class = "^(brave-browser)$", title = "^(DND)$" },
    workspace = "5 silent",
})

-- Layer rules
hl.layer_rule({
    match = { namespace = "vicinae" },
    blur  = true,
})

hl.layer_rule({
    match        = { namespace = "vicinae" },
    ignore_alpha = 0,
})
