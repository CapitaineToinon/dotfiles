-- This is an example Hyprland Lua config file.
-- Refer to the wiki for more information.
-- https://wiki.hypr.land/Configuring/Start/

-- Please note not all available settings / options are set here.
-- For a full list, see the wiki

-- You can (and should!!) split this configuration into multiple files
-- Create your files separately and then require them like this:
-- require("myColors")

------------------
---- MONITORS ----
------------------

require("monitors")

---------------------
---- MY PROGRAMS ----
---------------------

-- Set programs that you use
local terminal = "GTK_IM_MODULE=simple ghostty"
local fileManager = "nautilus"
local menu = "vicinae toggle"
local browser = "firefox"

-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
hl.on("hyprland.start", function()
	hl.exec_cmd("hyprpaper")
	hl.exec_cmd("waybar")
	hl.exec_cmd("nm-applet")
	hl.exec_cmd("hyprpaper")
	hl.exec_cmd('EMOJI_FONT="Noto Color Emoji" vicinae server')
	hl.exec_cmd("swaync")
end)

----------------
---- EVENTS ----
----------------

hl.on("workspace.active", function()
	hl.exec_cmd("swaync-client --close-panel")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-----------------------
----- PERMISSIONS -----
-----------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

-- hl.config({
-- 	ecosystem = {
-- 		enforce_permissions = true,
-- 	},
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
		gaps_in = 0,
		gaps_out = 0,

		border_size = 2,

		col = {
			active_border = "#fabd2f",
			inactive_border = "#928374",
		},

		-- Set to true to enable resizing windows by clicking and dragging on borders and gaps
		resize_on_border = false,

		-- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
		allow_tearing = false,

		layout = "dwindle",

		snap = {
			enabled = true,
		},
	},

	decoration = {
		rounding = 0,
		rounding_power = 2,

		-- background dim when opening a special workspace
		dim_special = 0.8,

		-- Change transparency of focused and unfocused windows
		active_opacity = 1.0,
		inactive_opacity = 1.0,

		shadow = {
			enabled = false,
		},

		blur = {
			enabled = false,
		},
	},

	cursor = {
		inactive_timeout = 5,
	},

	animations = {
		enabled = false,
	},
})

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
	dwindle = {
		force_split = 2,
		preserve_split = true, -- You probably want this
	},
})

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config({
	master = {
		new_status = "master",
		orientation = "right",
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
		focus_on_activate = false,
		force_default_wallpaper = 0, -- Set to 0 or 1 to disable the anime mascot wallpapers
		disable_hyprland_logo = false, -- If true disables the random hyprland logo / anime girl background. :(
	},
})

---------------
---- INPUT ----
---------------

hl.config({
	input = {
		kb_layout = "ch",
		kb_variant = "fr",
		kb_model = "",
		kb_options = "caps:escape",
		kb_rules = "",

		follow_mouse = 1,

		sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

		touchpad = {
			natural_scroll = false,
		},

		-- Disable touch screens on Thinkpad laptop
		touchdevice = {
			enabled = false,
		},
	},
})

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})

-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
hl.device({
	name = "lemokey-lemokey-g1,",
	sensitivity = -0.8,
})

-- Second mouse for work
hl.device({
	name = "keychron-keychron-v1-mouse",
	sensitivity = -0.8,
})

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))

-- discord is giga slow
hl.bind(mainMod .. " + D", function()
	local window = hl.get_window("class:discord")

	if window ~= nil then
		return hl.dispatch(hl.dsp.focus({ window = window }))
	end

	return hl.exec_cmd("discord")
end)

-- swaync
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("swaync-client --toggle-panel --skip-wait"))
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("swaync-client --toggle-dnd --skip-wait"))

-- vicinae
hl.bind("ALT + Space", hl.dsp.exec_cmd(menu))
hl.bind("CTRL + ALT + Space", hl.dsp.exec_cmd("vicinae vicinae://launch/core/search-emojis"))
hl.bind("CTRL + ALT + C", hl.dsp.exec_cmd("vicinae vicinae://launch/clipboard/history"))

-- Move focus with mainMod + vim keys
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))

-- Move windows with maidMod + vim keys
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))

-- Fullscreen stuff
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "maximized" }))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }))

-- Trigger client fullscreen while keeping hyprland window not fullscreen
hl.bind(mainMod .. " + CTRL + SHIFT + F", hl.dsp.window.fullscreen_state({ internal = 0, client = 3 }))

-- Pin window
hl.bind(mainMod .. " + P", hl.dsp.window.pin())

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
	local key = i % 10
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Screenshot things
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd('grim -g "$(slurp -b 000000CC -c fabd2f -w 3)" - | wl-copy'))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd('grim -g "$(slurp)" - | swappy -f -'))

-- Laptop multimedia keys for volume and LCD brightness
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

hl.on("workspace.active", function()
	local workspace = hl.get_active_special_workspace()

	if workspace ~= nil and workspace.name == "special:vicinae" then
		hl.exec_cmd("vicinae close")
	end
end)

-- Example window rules that are useful
hl.window_rule({
	workspace = "10",
	float = true,
	pin = true,
})

hl.window_rule({
	-- Ignore maximize requests from all apps. You'll probably like this.
	name = "suppress-maximize-events",
	match = { class = ".*" },
	suppress_event = "maximize",
})

hl.window_rule({
	-- Fix some dragging issues with XWayland
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},

	no_focus = true,
})

-- vicinae blur
hl.layer_rule({
	match = { namespace = "vicinae" },
	name = "vicinae-blur",
	blur = true,
	ignore_alpha = 0,
})

-- disable animation for vicinae only
hl.layer_rule({
	match = { namespace = "vicinae" },
	name = "vicinae-no-animation",
	no_anim = true,
})

-- Move vicinae to its own workspace
hl.window_rule({
	name = "move-vicinae",
	match = { class = "vicinae" },
	workspace = "special:vicinae",
})

-- move firefox save windows
hl.window_rule({
	name = "move-firefox-popups",
	match = { class = "xdg-desktop-portal-gtk", title = "^Save As.+ — Mozilla Firefox$" },
	center = true,
})

-- Automatically make PiP pinned and floating
hl.window_rule({
	pin = true,
	float = true,
	move = { "(monitor_w-640-3)", "(monitor_h-360-3)" },
	size = { 640, 360 },
	no_initial_focus = true,
	match = {
		title = "Picture-in-Picture",
		class = "firefox",
	},
})

hl.window_rule({
	name = "move-discord",
	match = { class = "discord" },
	workspace = 3,
})

hl.window_rule({
	name = "move-steam",
	match = { class = "steam" },
	workspace = 4,
})

hl.window_rule({
	name = "move-slack",
	match = { class = "slack" },
	workspace = 4,
})
