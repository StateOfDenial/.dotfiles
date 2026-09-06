-- See https://wiki.hypr.land/Configuring/Basics/Monitors/

-- Primary home desk monitor
hl.monitor({
    output   = "DP-1",
    mode     = "3440x1440@144",
    position = "0x0",
    scale    = 1,
    bitdepth = 10,
    vrr      = 3,
    sdrbrightness = 1.2,
    sdrsaturation = 1.05,
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

local function layoutForMonitor(m)
    if m.width / m.scale >= 1800 then
        return "master"
    end
    return "scrolling"
end

local function workspaceKey(ws)
    if ws.special then
        return ws.name
    end
    return "name:" .. ws.name
end

local function applyLayoutRule(ws)
    hl.workspace_rule({
        workspace = workspaceKey(ws),
        layout = "scrolling",
    })
end

local function applyWidthLayoutRule(ws)
    local m = ws.monitor
    if not m then
        return
    end
    hl.workspace_rule({
        workspace = workspaceKey(ws),
        layout = layoutForMonitor(m),
    })
end

hl.on("workspace.created", function(ws)
    if ws.special then
        applyLayoutRule(ws)
        return
    end
    applyWidthLayoutRule(ws)
end)

hl.on("workspace.move_to_monitor", function(ws)
    if ws.special then
        applyLayoutRule(ws)
        return
    end
    applyWidthLayoutRule(ws)
end)
