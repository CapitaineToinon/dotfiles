------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- internal monitor output name (verify with hyprctl devices)
local INTERNAL_MONITOR = "eDP-1"

---Configures the internal monitor
---@param params { disabled: boolean }
local function setup_internal_monitor(params)
	hl.monitor({
		output = INTERNAL_MONITOR,
		disabled = params.disabled,
	})
end

-- list of external monitors that, when connected, should disable the internal
-- monitor even if the lid is opened
local GIGABYTE_DESC = "GIGA-BYTE TECHNOLOGY CO. LTD. M27Q 20460B003499"
local DELL_DESC = "Dell Inc. DELL P2425H B8T6104"

-- All valid external monitors, others will duplicate eDP-1 instead
local VALID_EXTERNAL_MONITORS = { GIGABYTE_DESC, DELL_DESC }

---Tests if a given monitor is an external monitor
---@param monitor HL.Monitor
local function is_external_monitor(monitor)
	for _, desc in ipairs(VALID_EXTERNAL_MONITORS) do
		if monitor.description == desc then
			return true
		end
	end

	return false
end

---Checks if the internal monitor should be disabled
---@return boolean
local function should_disable_internal_monitor()
	local monitors = hl.get_monitors()

	for _, monitor in ipairs(monitors) do
		if is_external_monitor(monitor) then
			-- when a valid external monitor is
			-- detected, stop using the internal one
			return true
		end
	end

	-- Found no valid external monitor
	-- so keep using the internal one
	return false
end

local function update_internal_monitor()
	setup_internal_monitor({ disabled = should_disable_internal_monitor() })
end

---@param monitor HL.Monitor
local function on_monitor_added(monitor)
	if is_external_monitor(monitor) then
		update_internal_monitor()
	end
end

---@param monitor HL.Monitor
local function on_monitor_removed(monitor)
	if is_external_monitor(monitor) then
		update_internal_monitor()
	end
end

-- Syncing events
-- hl.bind("switch:on:Lid Switch", update_internal_monitor, { locked = true })
-- hl.bind("switch:off:Lid Switch", update_internal_monitor, { locked = true })
hl.on("monitor.added", on_monitor_added)
hl.on("monitor.removed", on_monitor_removed)

-- Thinkpad internal display
hl.monitor({
	output = INTERNAL_MONITOR,
	mode = "2880x1800@120",
	position = "auto",
	scale = "auto",
	disabled = should_disable_internal_monitor(),
})

-- Gigabyte home external display
hl.monitor({
	output = "desc:" .. GIGABYTE_DESC,
	mode = "2560x1440@170",
	position = "auto",
	scale = "auto",
})

-- Work external monitor
hl.monitor({
	output = "desc:" .. DELL_DESC,
	mode = "1920x1080@100",
	position = "auto",
	scale = "auto",
})

-- Default sensible config for HDMI out, mirroring
-- the Thinkpad internal display
hl.monitor({
	output = "",
	mode = "preferred",
	position = "auto",
	scale = 1,
	mirror = "eDP-1",
})
