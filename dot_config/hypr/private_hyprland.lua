-- This is an example Hyprland Lua config file.
-- Refer to the wiki for more information.
-- https://wiki.hypr.land/Configuring/Start/

-- Please note not all available settings / options are set here.
-- For a full list, see the wiki

-- You can (and should!!) split this configuration into multiple files
-- Create your files separately and then require them like this:
-- require("myColors")

-- noctalia ipc
local ipc = "noctalia msg "

------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "auto",
})

-- Built-in MacBook Air M4 panel. With the kernel arg appledrm.show_notch=1 the
-- panel reports its full 2560x1664 and the 64px notch strip (40px at scale 1.6)
-- becomes usable; Noctalia's bar (thickness 42) sits in it, slightly taller than the notch.
-- Valid scales must divide 2560x1664 into whole pixels and be multiples of 1/120:
-- 2.0, 1.6, 1.3333, 1.0667, 1.0. Others (e.g. 1.8) get rejected.
hl.monitor({
    output   = "eDP-1",
    mode     = "preferred",
    position = "auto",
    scale    = 1.6, -- 1600x1040 logical
})


---------------------
---- MY PROGRAMS ----
---------------------

-- Set programs that you use
local terminal    = "kitty"
local fileManager = "dolphin"
local browser     = "helium"


-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
hl.on("hyprland.start", function () 
   hl.exec_cmd("noctalia")
--   hl.exec_cmd("nm-applet")
--   hl.exec_cmd("waybar & hyprpaper & firefox")
end)


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- FreeType stem darkening: thickens thin glyph stems at small sizes, the way
-- macOS renders text. Applies to TrueType fonts through the autohinter, which
-- fontconfig enables (autohint + hintslight). Restart apps to pick it up.
hl.env("FREETYPE_PROPERTIES", "cff:no-stem-darkening=0 autofitter:no-stem-darkening=0 type1:no-stem-darkening=0 t1cid:no-stem-darkening=0")


-----------------------
----- PERMISSIONS -----
-----------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

-- hl.config({
--   ecosystem = {
--     enforce_permissions = true,
--   },
-- })

-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")


-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 10,

        border_size = 1,

        col = {
            active_border   = { colors = {"rgba(33ccffee)", "rgba(00ff99ee)"}, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },

        -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false,

        -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
        allow_tearing = false,

        layout = "dwindle",
    },

    decoration = {
        rounding       = 10,
        rounding_power = 2,

        -- Change transparency of focused and unfocused windows
        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = 0xee1a1a1a,
        },

        blur = {
            enabled   = true,
            size      = 3,
            passes    = 1,
            vibrancy  = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },
})

-- Default curves and animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })

-- Default springs
hl.curve("easy",           { type = "spring", mass = 1, stiffness = 312.5, dampening = 33.25 })

hl.animation({ leaf = "global",        enabled = true,  speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true,  speed = 1.94, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true,  speed = 1.73, spring = "easy" })
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 1.47,  spring = "easy",         style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 0.54, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 0.62, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 0.53, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true,  speed = 1.09, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true,  speed = 1.37, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true,  speed = 1.44,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true,  speed = 0.54,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 0.65, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 0.5, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true,  speed = 0.7, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 0.43, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 0.7, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor",    enabled = true,  speed = 2.52,    bezier = "quick" })

-- Ref https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- "Smart gaps" / "No gaps when only"
-- uncomment all if you wish to use that.
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({
--     name  = "no-gaps-wtv1",
--     match = { float = false, workspace = "w[tv1]" },
--     border_size = 0,
--     rounding    = 0,
-- })
-- hl.window_rule({
--     name  = "no-gaps-f1",
--     match = { float = false, workspace = "f[1]" },
--     border_size = 0,
--     rounding    = 0,
-- })

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
    dwindle = {
        preserve_split = true, -- You probably want this
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config({
    master = {
        new_status = "master",
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
hl.config({
    scrolling = {
        fullscreen_on_one_column = true,
    },
})

----------------
----  MISC  ----
----------------

hl.config({
    misc = {
        force_default_wallpaper = -1,    -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo   = false, -- If true disables the random hyprland logo / anime girl background. :(
    },
})

-----------------
----  BINDS  ----
-----------------

hl.config({
    binds = {
        workspace_back_and_forth = true
    },
})


---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout  = "us",
        kb_variant = "",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",

        follow_mouse = 1,

        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

        -- macOS-like trackpad. Palm rejection: libinput rejects large contacts as
        -- palms (threshold in system/etc/libinput/local-overrides.quirks).
        -- disable_while_typing is off so the trackpad stays live while typing;
        -- set it to true to ignore touches that start mid-typing.
        -- (input.natural_scroll above only affects mice; touchpads use this block.)
        touchpad = {
            natural_scroll       = true,  -- macOS "natural" scrolling
            scroll_factor        = 0.12,  -- slower two-finger scrolling (1.0 = default)
            disable_while_typing = false,
            tap_to_click         = false, -- macOS default: press to click
            clickfinger_behavior = true,  -- two-finger click = right click, anywhere on the pad
            tap_and_drag         = false,
            middle_button_emulation = false,
        },
    },
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})

-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})


---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
-- Terminal (moved off Cmd+Q, which now closes the window)
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
-- Kill the process owning the window with a SIGKILL
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.window.kill())
-- Send a graceful request to close the window (Cmd+Q, mac-style)
-- code:38 = physical key labelled Q on AZERTY (QWERTY "A" position), layout-independent
hl.bind(mainMod .. " + code:38", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
-- Browser on Cmd+B. code:56 = physical B key, layout-independent
hl.bind(mainMod .. " + code:56", hl.dsp.exec_cmd(browser))
-- Toggle floating (moved off Cmd+V, which is now paste). code:28 = T
hl.bind(mainMod .. " + code:28", hl.dsp.window.float({ action = "toggle" }))

-- Universal copy / paste / cut, mac & omarchy style.
-- Cmd+C/V/X send Ctrl+Insert / Shift+Insert / Ctrl+X to the focused window, which
-- works in GUI apps AND terminals (no Ctrl+C = SIGINT problem).
-- Physical keycodes (AZERTY bottom row): code:53 = X, code:54 = C, code:55 = V
hl.bind(mainMod .. " + code:54", hl.dsp.send_shortcut({ mods = "CTRL",  key = "Insert" }))
hl.bind(mainMod .. " + code:55", hl.dsp.send_shortcut({ mods = "SHIFT", key = "Insert" }))
hl.bind(mainMod .. " + code:53", hl.dsp.send_shortcut({ mods = "CTRL",  key = "X" }))
-- Cmd+A = select all. code:24 = physical key labelled A on AZERTY (QWERTY "Q" position)
hl.bind(mainMod .. " + code:24", hl.dsp.send_shortcut({ mods = "CTRL",  key = "A" }))
-- Cmd+W = close the current tab, mac-style (not the window). code:52 = physical W on AZERTY.
-- Most apps close a tab on Ctrl+W, but in a terminal that's "delete word", so kitty
-- gets Ctrl+Shift+W instead (kitty's default close_window: closes the split, and the
-- tab with it when it's the last one).
hl.bind(mainMod .. " + code:52", function()
    local win = hl.get_active_window()
    if win and win.class == "kitty" then
        hl.dispatch(hl.dsp.send_shortcut({ mods = "CTRL SHIFT", key = "W" }))
    else
        hl.dispatch(hl.dsp.send_shortcut({ mods = "CTRL", key = "W" }))
    end
end)
-- Cmd+Backspace = delete previous word
hl.bind(mainMod .. " + BackSpace", hl.dsp.send_shortcut({ mods = "CTRL", key = "BackSpace" }), { repeating = true })
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(ipc .. "panel-toggle launcher"))
-- App launcher on Cmd+Space, mac-style
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(ipc .. "panel-toggle launcher"))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))    -- dwindle only

-- Cmd+Left / Cmd+Right = beginning / end of line, mac-style
hl.bind(mainMod .. " + left",  hl.dsp.send_shortcut({ mods = "", key = "Home" }), { repeating = true })
hl.bind(mainMod .. " + right", hl.dsp.send_shortcut({ mods = "", key = "End" }),  { repeating = true })

-- Move focus with mainMod + arrow keys (left/right moved to Cmd+Alt, see above)
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))
-- Move focus with Cmd+Alt + arrow keys
hl.bind(mainMod .. " + ALT + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + ALT + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + ALT + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + ALT + down",  hl.dsp.focus({ direction = "down" }))

-- Resize windows
local resizeUnit = 20
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.resize({ x = resizeUnit, y = 0, relative=true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.resize({ x = -resizeUnit, y = 0, relative=true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.resize({ x = 0, y = -resizeUnit, relative=true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.resize({ x = 0, y = resizeUnit, relative=true }), { repeating = true })

-- French AZERTY: the number row sends & é " ' ( § è ! ç à, not digits,
-- so bind by physical keycode instead (code:10 = key "1" ... code:19 = key "0").
for i = 1, 10 do
    local key = "code:" .. (9 + i)
    -- Switch workspaces with mainMod + [0-9]
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))

    -- Move window to a different workspace and switch to that workspace with mainMod + SHIFT + [0-9]
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
    -- Move window to a different workspace but keep current workspace with mainMod + CTRL + [0-9]
    hl.bind(mainMod .. " + CTRL + " .. key, hl.dsp.window.move({ workspace = i, follow = false }))
end

-- Switch to workspaces 01-99
hl.bind(mainMod .. " + G", hl.dsp.submap("ws_tens"), { description = "Workspace picker (01-99)" })
hl.define_submap("ws_tens", function()
    for tens = 0, 9 do
        hl.bind(tostring(tens), hl.dsp.submap("ws_units_" .. tens))
    end
    local letters = "abcdefghijklmnopqrstuvwxyz"
    for i = 1, #letters do
        hl.bind(letters:sub(i, i), hl.dsp.submap("reset"))
    end
    hl.bind("escape", hl.dsp.submap("reset"))
end)
for tens = 0, 9 do
    hl.define_submap("ws_units_" .. tens, "reset", function()
        for units = 0, 9 do
            local target = tens * 10 + units
            if target > 0 then
                hl.bind(tostring(units), hl.dsp.focus({ workspace = target }))
            end
        end
        hl.bind("escape", hl.dsp.submap("reset"))
        hl.bind("catchall", hl.dsp.submap("reset"))
    end)
end

-- Fullscreen - Window takes up the entire working space, keeping the margins.
hl.bind(mainMod .. " + CTRL + F", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
-- Fullscreen - Window takes up the entire screen.
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))

-- Screenshots on Ctrl+Option+3/4 (MacBook keyboards have no Print key).
-- Bound by keycode for AZERTY: code:12 = key "3", code:13 = key "4".
-- Screenshot a monitor
hl.bind("CTRL + ALT + code:12", hl.dsp.exec_cmd(ipc .. "screenshot-fullscreen pick"))
-- Screenshot a region
hl.bind("CTRL + ALT + code:13", hl.dsp.exec_cmd(ipc .. "screenshot-region"))

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Cmd+click = Ctrl+click, mac-style (open link in new tab, multi-select, ...)
hl.bind(mainMod .. " + mouse:272", hl.dsp.send_shortcut({ mods = "CTRL", key = "mouse:272" }))

-- Move windows with mainMod + ALT + LMB (plain mainMod + LMB is Cmd+click above),
-- resize with mainMod + RMB, both by dragging
hl.bind(mainMod .. " + ALT + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273",       hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })


--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Example window rules that are useful

local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})

-- HyprMod managed settings
require("hyprland-gui")

-- For Noctalia Color templates
require("noctalia").apply_theme()
