-- Hyprland loads this file when it is started without a config, and it prefers
-- it over hyprland.conf. HyDE loads it too, last, as the override layer below.
-- The block keeps the two apart: hyde.lua sets `hyde` on its first line, so it
-- runs only when this file is the entry point and HyDE has not been loaded.
-- Removing it leaves a session with a cursor and nothing else.
if not hyde then
    local share = os.getenv("XDG_DATA_HOME") or (os.getenv("HOME") .. "/.local/share")
    local entry = share .. "/hypr/hyde.lua"
    local handle = io.open(entry, "r")
    if not handle then
        error("HyDE is not installed at " .. entry .. ". Run install.sh -r, or point Hyprland at your own config.")
    end
    handle:close()
    dofile(entry)
end

hl.config({
    input = {
        kb_layout = "us,ru",
        kb_options = "grp:alt_shift_toggle",
    }
})

require("monitors")

hl.workspace_rule({ workspace = "1", monitor = "HDMI-A-1", default = true })
hl.workspace_rule({ workspace = "2", monitor = "DP-1", default = true })
for i = 3, 10 do
    hl.workspace_rule({ workspace = tostring(i), monitor = "DP-1" })
end

hl.on("hyprland.start", function()
    hl.exec_cmd("org.telegram.desktop -startintray")
end)

hl.animation({ leaf = "windows", enabled = true, speed = 4, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 4.5, bezier = "default" })

hl.unbind("SUPER + B")
hl.unbind("SUPER + S")
hl.unbind("F10")
hl.unbind("F11")
hl.unbind("F12")

hl.bind(
    "SUPER + F",
    hl.dsp.exec_cmd("firefox"),
    { description = "[Launcher|Apps] firefox" }
)
hl.bind(
    "SUPER + C",
    hl.dsp.exec_cmd("code"),
    { description = "[Launcher|Apps] VSCode" }
)
hl.bind(
    "SUPER + M",
    hl.dsp.exec_cmd("org.telegram.desktop"),
    { description = "[Launcher|Apps] Telegram" }
)

hl.window_rule({
    name = "firefox-opaque",
    match = { class = "^(firefox)$" },
    opaque = true,
})
hl.window_rule({
    name = "vscode-opaque",
    match = { class = "^(com.microsoft.VSCode)$" },
    opaque = true,
})
hl.window_rule({
    name = "telegram-float",
    match = { class = "^(org.telegram.desktop)$" },
    float = true,
    center = true,
    size = "1000 800",
})
hl.window_rule({
    name = "calculator-float",
    match = { class = "^(org.gnome.Calculator)$" },
    float = true,
    center = true,
    size = "375 625",
})
hl.window_rule({
    name = "gcolor3-float",
    match = { class = "^(gcolor3)$" },
    float = true,
    center = true,
    size = "775 320",
})
