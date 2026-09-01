-- See https://wiki.hypr.land/Configuring/Basics/Monitors/

-- Primary home desk monitor
hl.monitor({
    output   = "DP-1",
    mode     = "3440x1440@144",
    position = "0x0",
    scale    = 1,
    bitdepth = 10,
    vrr      = 3,
})

-- Secondary home desk monitor
hl.monitor({
    output   = "DP-2",
    mode     = "1920x1080@144",
    position = "-1920x0",
    scale    = 1,
})

hl.monitor({
    output   = "eDP-1",
    mode     = "preferred",
    position = "0x0",
    scale    = 1.67,
    vrr      = 1,
})

-- Random other monitors I plug in
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = 1,
})

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/
hl.device({
    name   = "remarkable-pen",
    output = "DP-1",
})

hl.on("workspace.move_to_monitor", function(ws, m)
    local layout = "scrolling"
    if m.width / m.scale >= 1800 then
        layout = "master"
    end
    hl.workspace_rule({
        workspace = tostring(ws.id),
        layout = layout,
    })
end)
