----------------
----KEYBINDS----
----------------

local mainMod = "ALT"

hl.bind(mainMod .. " + W", hl.dsp.exec_cmd(terminal))
local closeWindowBind = hl.bind(mainMod .. " + Q", hl.dsp.window.close())
-- closeWindowBind:set_enabled(false)
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))    -- dwindle only

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

-- Example special workspace (scratchpad)
-- hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
-- hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
-- hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
-- hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Resize windows with arrow keys
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.resize({ x = -10, y = 0,   window = "active" }),   { repeating = true })
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.resize({ x = 10 , y = 0,   window = "active" }),   { repeating = true })
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.resize({ x = 0  , y = -10, window = "active" }),   { repeating = true })
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.resize({ x = 0  , y = 10,  window = "active" }),   { repeating = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("$HOME/.config/dunst/volume -i 5"),                 { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("$HOME/.config/dunst/volume -d 5"),                 { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("$HOME/.config/dunst/volume -t"),                   { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),    { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("$HOME/.config/dunst/brightness 5%+"),              { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("$HOME/.config/dunst/brightness 5%-"),              { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

-- Scripts
-- hl.bind(mainMod .. " + SHIFT + CTRL + Z", hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/rofi.sh"))
hl.bind(mainMod .. " + SHIFT + CTRL + Z", hl.dsp.exec_cmd("qs ipc call wallpaper toggle"))
hl.bind(mainMod .. " + SHIFT + Z", hl.dsp.exec_cmd(wallswitch))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/launch.sh"))
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd("kitty -e cava"))
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("kitty -e cmatrix -u 10 -B f"))
hl.bind(mainMod .. " + Z", hl.dsp.exec_cmd(walldefault))
