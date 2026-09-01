-- See https://wiki.hypr.land/Configuring/Basics/Variables/

hl.config({
    input = {
        kb_layout    = "us",
        kb_variant   = "",
        kb_model     = "",
        kb_options   = "",
        kb_rules     = "",

        follow_mouse = 1,

        sensitivity  = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad     = {
            natural_scroll = true,
        },

        tablet       = {
            output = "current",
        },
    },
})
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Gestures/
hl.gesture({
    fingers   = 4,
    direction = "horizontal",
    action    = "workspace",
})
hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "scroll_move", -- Native scrolling for Scrolling layout
})
local volume_gesture = function(change)
    hl.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ " ..
        math.abs(change) .. "%" .. (change < 0 and "-" or "+"))
end
hl.gesture({
    fingers = 3,
    direction = "vertical",
    mods = "CTRL",
    action = {
        start = function(e) volume_gesture(-0.25 * e.delta.y) end,
        update = function(e) volume_gesture(-0.25 * e.delta.y) end
    }
})
local brightness_gesture = function(change)
    hl.exec_cmd("brightnessctl set " ..
        math.abs(change) .. "%" .. (change < 0 and "-" or "+"))
end
hl.gesture({
    fingers = 3,
    direction = "vertical",
    mods = "SUPER",
    action = {
        start = function(e) brightness_gesture(-0.25 * e.delta.y) end,
        update = function(e) brightness_gesture(-0.25 * e.delta.y) end
    }
})
hl.gesture({
    fingers = 2,
    mods = "SUPER",
    direction = "pinchin",
    action = "cursor_zoom",
    zoom_level = 2.0,
    mode = "mult"
})
hl.gesture({
    fingers = 2,
    mods = "SUPER",
    direction = "pinchout",
    action = "cursor_zoom",
    zoom_level = -2.0,
    mode = "mult"
})
