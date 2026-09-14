-- ~/.config/swayimg/init.lua
-- Converted from the old INI-style `config` file.
-- Swayimg moved to Lua-based config around v5.0 — see CONFIG.md in the repo
-- and /usr/share/swayimg/example.lua for the canonical reference.
--
-- IMPORTANT CAVEATS (read before relying on this 1:1):
--  1. Colors: old format was #RRGGBBAA, new format is 0xAARRGGBB. Every
--     color below has been re-ordered accordingly.
--  2. Antialiasing: the old config let you pick an algorithm per mode
--     (none/box/bilinear/bicubic/mks13). The new API only exposes a
--     global on/off (swayimg.enable_antialiasing). "mks13" everywhere
--     collapses to just "on" — there's no way to pick the algorithm anymore.
--  3. Window `position = auto` (Sway/Hyprland absolute position) has no
--     Lua setter in the current API — it's now only a CLI flag (-P/--position).
--  4. Gallery tile "shadow" color has no equivalent function in the current
--     API (border/select/background colors exist, shadow doesn't).
--  5. The old info-scheme "+exif"/"+imagesize"/"+filesize" auto-expanding
--     group tags don't exist anymore — every line in the new text overlay
--     must name explicit {meta.Exif.X.Y} fields. I picked a couple of
--     common EXIF tags as a starting point; add more as you like.
--  6. There's no built-in `help`, `skip_file`, `pause` (slideshow), or bare
--     `zoom`/`mode`-toggle action anymore — I implemented small Lua
--     helper functions to replicate them as closely as possible.
--  7. You had "o" bound TWICE in your original [keys.viewer]: first to
--     next_frame, then later to "mode gallery". In an INI file the later
--     entry wins, so next_frame was actually already dead in your old
--     config. I preserved that same resolution below (o -> gallery mode).
--     Shift+o (prev_frame) was untouched by the collision and still works.
--     Say the word if you actually wanted o = next_frame instead.

--------------------------------------------------------------------------
-- Helper functions (things the old action-string system did for free)
--------------------------------------------------------------------------

local aa_enabled = true
local function toggle_antialiasing()
	aa_enabled = not aa_enabled
	swayimg.enable_antialiasing(aa_enabled)
end

local function toggle_info()
	if swayimg.text.visible() then
		swayimg.text.hide()
	else
		swayimg.text.show()
	end
end

local function toggle_fullscreen()
	swayimg.set_fullscreen() -- no arg = toggle
end

-- Move the image by a percentage of the window size (old "step_* N")
local function step_image(mode, dx_percent, dy_percent)
	local wnd = swayimg.get_window_size()
	local pos = mode.get_position()
	local dx = math.floor(wnd.width * dx_percent / 100)
	local dy = math.floor(wnd.height * dy_percent / 100)
	mode.set_abs_position(pos.x + dx, pos.y + dy)
end

-- Zoom by a percentage step, optionally anchored at the mouse pointer
local function zoom_step(mode, delta_percent, at_mouse)
	local scale = mode.get_scale()
	scale = scale + scale * delta_percent / 100
	if at_mouse then
		local p = swayimg.get_mouse_pos()
		mode.set_abs_scale(scale, p.x, p.y)
	else
		mode.set_abs_scale(scale)
	end
end

-- Cycle through fixed scales (approximates the old bare "zoom" action)
local scale_cycle = { "optimal", "fit", "fill", "real" }
local scale_idx = 1
local function cycle_scale()
	scale_idx = (scale_idx % #scale_cycle) + 1
	swayimg.viewer.set_fix_scale(scale_cycle[scale_idx])
end

-- Remove current file from the list only (old "skip_file")
local function skip_file(mode)
	local image = mode.get_image()
	if image then
		mode.switch_image("next")
		swayimg.imagelist.remove(image.path)
	end
end

-- Delete current file from disk + list (old "exec rm -f '%' ...; skip_file")
local function delete_file(mode)
	local image = mode.get_image()
	if image then
		local path = image.path
		mode.switch_image("next")
		os.remove(path)
		swayimg.imagelist.remove(path)
		swayimg.text.set_status("File removed: " .. path)
	end
end

-- Slideshow pause/resume (undocumented whether timeout=0 truly "pauses" —
-- flagging this as a best-effort guess, test it before relying on it)
local slideshow_time = 3
local slideshow_paused = false
local function toggle_slideshow_pause()
	slideshow_paused = not slideshow_paused
	swayimg.slideshow.set_timeout(slideshow_paused and 0 or slideshow_time)
end

local function thumb_step(delta)
	local sz = swayimg.gallery.get_thumb_size()
	swayimg.gallery.set_thumb_size(sz + delta)
end

--------------------------------------------------------------------------
-- [general]
--------------------------------------------------------------------------
swayimg.set_mode("viewer") -- mode at startup
swayimg.set_window_size(1280, 720) -- window size
-- position = auto  -> no Lua setter currently; use -P/--position on the CLI
swayimg.enable_overlay(false) -- Sway/Hyprland overlay window
swayimg.enable_decoration(false) -- window decoration
swayimg.set_appid("swayimg") -- app_id / window class
-- sigusr1/sigusr2 are now bound per-mode; wiring them for viewer mode:
swayimg.viewer.on_signal("USR1", function()
	swayimg.viewer.reload()
end)
swayimg.viewer.on_signal("USR2", function()
	swayimg.viewer.switch_image("next")
end)
-- NOTE: old `scale = 1.0` under [general] had no documented meaning in the
-- current schema either (not a real key in upstream's own example config),
-- so it's dropped rather than guessed at.

--------------------------------------------------------------------------
-- [viewer]
--------------------------------------------------------------------------
swayimg.viewer.set_window_background(0xff000000) -- #000000ff -> 0xff000000
-- transparency = grid -> chessboard is swayimg's default; giving it
-- explicit values so it's not left to chance:
swayimg.viewer.set_image_chessboard(20, 0xff333333, 0xff4c4c4c)
swayimg.viewer.set_default_scale("optimal")
swayimg.viewer.set_default_position("center")
swayimg.enable_antialiasing(true) -- was per-mode "mks13", now global (see caveat #2)
swayimg.viewer.enable_loop(true)
swayimg.viewer.limit_history(1)
swayimg.viewer.limit_preload(1)

--------------------------------------------------------------------------
-- [slideshow]
--------------------------------------------------------------------------
swayimg.slideshow.set_timeout(3)
swayimg.slideshow.set_window_background("auto")
swayimg.slideshow.set_image_background(0xff000000) -- #121212ff -> 0xff121212
swayimg.slideshow.set_default_scale("fit")
swayimg.slideshow.set_default_position("center")
-- antialiasing already set globally above

--------------------------------------------------------------------------
-- [gallery]
--------------------------------------------------------------------------
swayimg.gallery.set_thumb_size(200)
swayimg.gallery.limit_cache(100)
swayimg.gallery.enable_preload(false)
swayimg.gallery.enable_pstore(false)
swayimg.gallery.set_aspect("fill")
-- antialiasing already set globally above
swayimg.gallery.set_window_color(0xff121212) -- #121212ff -> 0xff121212
swayimg.gallery.set_unselected_color(0xff202020) -- #202020ff -> 0xff202020
swayimg.gallery.set_selected_color(0xff404040) -- #404040ff -> 0xff404040
swayimg.gallery.set_border_color(0xff000000) -- #000000ff -> 0xff000000
-- shadow = #000000ff -> no equivalent function currently exists (caveat #4)

--------------------------------------------------------------------------
-- [list]
--------------------------------------------------------------------------
swayimg.imagelist.set_order("alpha")
swayimg.imagelist.enable_reverse(false)
swayimg.imagelist.enable_recursive(false)
swayimg.imagelist.enable_adjacent(false)
swayimg.imagelist.enable_fsmon(true)

--------------------------------------------------------------------------
-- [font]
--------------------------------------------------------------------------
swayimg.text.set_font("monospace")
swayimg.text.set_size(12)
swayimg.text.set_foreground(0xffd1d1d1) -- #d1d1d1ff -> 0xffd1d1d1
swayimg.text.set_shadow(0xd0000000) -- #000000d0 -> 0xd0000000
swayimg.text.set_background(0x00000000) -- #00000000 -> 0x00000000

--------------------------------------------------------------------------
-- [info] / [info.viewer] / [info.slideshow] / [info.gallery]
--------------------------------------------------------------------------
swayimg.text.set_padding(10)
swayimg.text.set_timeout(5) -- info_timeout
swayimg.text.set_status_timeout(3) -- status_timeout
swayimg.on_initialized(function()
	swayimg.text.show()
end) -- show = yes

-- info.viewer: top_left = +name,+format,+filesize,+imagesize,+exif
swayimg.viewer.set_text("topleft", {
	"{name}",
	"{format}",
	"{sizehr} ({size} bytes)",
	"{frame.width}x{frame.height}",
	"{meta.Exif.Photo.DateTimeOriginal}",
	"{meta.Exif.Image.Model}",
})
-- info.viewer: top_right = index
swayimg.viewer.set_text("topright", { "{list.index} of {list.total}" })
-- info.viewer: bottom_left = scale,frame
swayimg.viewer.set_text("bottomleft", {
	"Scale: {scale}",
	"Frame: {frame.index} of {frame.total}",
})
-- info.viewer: bottom_right = status -> the status message is shown via
-- swayimg.text.set_status()/set_status_timeout() automatically; there's
-- no separate template slot for it to assign here.

-- info.slideshow: top_left/top_right/bottom_left = none (leave unset)
-- info.slideshow: bottom_right = dir,status
swayimg.slideshow.set_text("bottomright", { "{dir}" })

-- info.gallery: top_left = none
-- info.gallery: top_right = index
swayimg.gallery.set_text("topright", { "{list.index} of {list.total}" })
-- info.gallery: bottom_left = none
-- info.gallery: bottom_right = name,status
swayimg.gallery.set_text("bottomright", { "{name}" })

--------------------------------------------------------------------------
-- [keys.viewer]
--------------------------------------------------------------------------
-- F1 = help  -> no built-in help overlay function currently exposed, omitted
swayimg.viewer.on_key("Home", function()
	swayimg.viewer.switch_image("first")
end)
swayimg.viewer.on_key("End", function()
	swayimg.viewer.switch_image("last")
end)
swayimg.viewer.on_key("Prior", function()
	swayimg.viewer.switch_image("prev")
end)
swayimg.viewer.on_key("Next", function()
	swayimg.viewer.switch_image("next")
end)
swayimg.viewer.on_key("Space", function()
	swayimg.viewer.switch_image("next")
end)
swayimg.viewer.on_key("Shift+r", function()
	swayimg.viewer.switch_image("random")
end)
swayimg.viewer.on_key("Shift+d", function()
	swayimg.viewer.switch_image("prev_dir")
end)
swayimg.viewer.on_key("d", function()
	swayimg.viewer.switch_image("next_dir")
end)
swayimg.viewer.on_key("Shift+o", function()
	swayimg.viewer.prev_frame()
end)
swayimg.viewer.on_key("c", function()
	skip_file(swayimg.viewer)
end)
swayimg.viewer.on_key("s", function()
	swayimg.set_mode("slideshow")
end)
swayimg.viewer.on_key("n", function()
	swayimg.viewer.set_animation()
end) -- toggle
swayimg.viewer.on_key("f", toggle_fullscreen)
swayimg.viewer.on_key("h", function()
	swayimg.viewer.switch_image("next")
end)
swayimg.viewer.on_key("l", function()
	swayimg.viewer.switch_image("prev")
end)
swayimg.viewer.on_key("k", function()
	zoom_step(swayimg.viewer, 10)
end)
swayimg.viewer.on_key("j", function()
	zoom_step(swayimg.viewer, -10)
end)
swayimg.viewer.on_key("Shift+h", function()
	step_image(swayimg.viewer, -10, 0)
end)
swayimg.viewer.on_key("Shift+j", function()
	step_image(swayimg.viewer, 0, 10)
end)
swayimg.viewer.on_key("Shift+k", function()
	step_image(swayimg.viewer, 0, -10)
end)
swayimg.viewer.on_key("Shift+l", function()
	step_image(swayimg.viewer, 10, 0)
end)
-- o = mode gallery  (this OVERWROTE next_frame in your original file — see caveat #7)
swayimg.viewer.on_key("o", function()
	swayimg.set_mode("gallery")
end)
swayimg.viewer.on_key("Left", function()
	step_image(swayimg.viewer, -10, 0)
end)
swayimg.viewer.on_key("Right", function()
	step_image(swayimg.viewer, 10, 0)
end)
swayimg.viewer.on_key("Up", function()
	step_image(swayimg.viewer, 0, -10)
end)
swayimg.viewer.on_key("Down", function()
	step_image(swayimg.viewer, 0, 10)
end)
swayimg.viewer.on_key("Equal", function()
	zoom_step(swayimg.viewer, 10)
end)
swayimg.viewer.on_key("w", function()
	swayimg.viewer.set_fix_scale("width")
end)
swayimg.viewer.on_key("Shift+w", function()
	swayimg.viewer.set_fix_scale("height")
end)
swayimg.viewer.on_key("z", function()
	swayimg.viewer.set_fix_scale("fit")
end)
swayimg.viewer.on_key("Shift+z", function()
	swayimg.viewer.set_fix_scale("fill")
end)
swayimg.viewer.on_key("0", function()
	swayimg.viewer.set_fix_scale("real")
end)
swayimg.viewer.on_key("BackSpace", function()
	swayimg.viewer.set_fix_scale("optimal")
end)
swayimg.viewer.on_key("Alt+s", cycle_scale) -- best-effort stand-in for bare "zoom"
swayimg.viewer.on_key("bracketleft", function()
	swayimg.viewer.rotate(270)
end) -- rotate_left
swayimg.viewer.on_key("bracketright", function()
	swayimg.viewer.rotate(90)
end) -- rotate_right
swayimg.viewer.on_key("m", function()
	swayimg.viewer.flip_vertical()
end)
swayimg.viewer.on_key("Shift+m", function()
	swayimg.viewer.flip_horizontal()
end)
swayimg.viewer.on_key("a", toggle_antialiasing)
swayimg.viewer.on_key("r", function()
	swayimg.viewer.reload()
end)
swayimg.viewer.on_key("i", toggle_info)
swayimg.viewer.on_key("Shift+Delete", function()
	delete_file(swayimg.viewer)
end)
swayimg.viewer.on_key("Escape", function()
	swayimg.exit()
end)
swayimg.viewer.on_key("q", function()
	swayimg.exit()
end)

-- Mouse
swayimg.viewer.set_drag_button("MouseLeft")
swayimg.viewer.on_mouse("ScrollLeft", function()
	step_image(swayimg.viewer, 5, 0)
end)
swayimg.viewer.on_mouse("ScrollRight", function()
	step_image(swayimg.viewer, -5, 0)
end)
swayimg.viewer.on_mouse("ScrollUp", function()
	step_image(swayimg.viewer, 0, -5)
end)
swayimg.viewer.on_mouse("ScrollDown", function()
	step_image(swayimg.viewer, 0, 5)
end)
swayimg.viewer.on_mouse("Ctrl+ScrollUp", function()
	zoom_step(swayimg.viewer, 10, true)
end)
swayimg.viewer.on_mouse("Ctrl+ScrollDown", function()
	zoom_step(swayimg.viewer, -10, true)
end)
swayimg.viewer.on_mouse("Shift+ScrollUp", function()
	swayimg.viewer.switch_image("prev")
end)
swayimg.viewer.on_mouse("Shift+ScrollDown", function()
	swayimg.viewer.switch_image("next")
end)
swayimg.viewer.on_mouse("Alt+ScrollUp", function()
	swayimg.viewer.prev_frame()
end)
swayimg.viewer.on_mouse("Alt+ScrollDown", function()
	swayimg.viewer.next_frame()
end)
swayimg.viewer.on_mouse("MouseSide", function()
	swayimg.viewer.switch_image("prev")
end)
swayimg.viewer.on_mouse("MouseExtra", function()
	swayimg.viewer.switch_image("next")
end)

--------------------------------------------------------------------------
-- [keys.slideshow]
--------------------------------------------------------------------------
swayimg.slideshow.on_key("Home", function()
	swayimg.slideshow.switch_image("first")
end)
swayimg.slideshow.on_key("End", function()
	swayimg.slideshow.switch_image("last")
end)
swayimg.slideshow.on_key("Prior", function()
	swayimg.slideshow.switch_image("prev")
end)
swayimg.slideshow.on_key("Next", function()
	swayimg.slideshow.switch_image("next")
end)
swayimg.slideshow.on_key("Shift+r", function()
	swayimg.slideshow.switch_image("random")
end)
swayimg.slideshow.on_key("Shift+d", function()
	swayimg.slideshow.switch_image("prev_dir")
end)
swayimg.slideshow.on_key("d", function()
	swayimg.slideshow.switch_image("next_dir")
end)
swayimg.slideshow.on_key("Space", toggle_slideshow_pause) -- see caveat above
swayimg.slideshow.on_key("i", toggle_info)
swayimg.slideshow.on_key("f", toggle_fullscreen)
swayimg.slideshow.on_key("Return", function()
	swayimg.set_mode("viewer")
end) -- old bare "mode"
swayimg.slideshow.on_key("Escape", function()
	swayimg.exit()
end)
swayimg.slideshow.on_key("q", function()
	swayimg.exit()
end)

--------------------------------------------------------------------------
-- [keys.gallery]
--------------------------------------------------------------------------
swayimg.gallery.on_key("Home", function()
	swayimg.gallery.switch_image("first")
end)
swayimg.gallery.on_key("End", function()
	swayimg.gallery.switch_image("last")
end)
swayimg.gallery.on_key("Left", function()
	swayimg.gallery.switch_image("left")
end)
swayimg.gallery.on_key("Right", function()
	swayimg.gallery.switch_image("right")
end)
swayimg.gallery.on_key("Up", function()
	swayimg.gallery.switch_image("up")
end)
swayimg.gallery.on_key("Down", function()
	swayimg.gallery.switch_image("down")
end)
swayimg.gallery.on_key("Prior", function()
	swayimg.gallery.switch_image("pgup")
end)
swayimg.gallery.on_key("Next", function()
	swayimg.gallery.switch_image("pgdown")
end)
swayimg.gallery.on_key("c", function()
	skip_file(swayimg.gallery)
end)
swayimg.gallery.on_key("s", function()
	swayimg.set_mode("slideshow")
end)
swayimg.gallery.on_key("f", toggle_fullscreen)
swayimg.gallery.on_key("Return", function()
	swayimg.set_mode("viewer")
end)
swayimg.gallery.on_key("a", toggle_antialiasing)
swayimg.gallery.on_key("r", function()
	swayimg.gallery.reload()
end)
swayimg.gallery.on_key("i", toggle_info)
swayimg.gallery.on_key("Equal", function()
	thumb_step(20)
end)
swayimg.gallery.on_key("Plus", function()
	thumb_step(20)
end)
swayimg.gallery.on_key("Minus", function()
	thumb_step(-20)
end)
swayimg.gallery.on_key("Shift+Delete", function()
	delete_file(swayimg.gallery)
end)
swayimg.gallery.on_key("Escape", function()
	swayimg.exit()
end)
swayimg.gallery.on_key("q", function()
	swayimg.exit()
end)

-- Mouse
swayimg.gallery.on_mouse("ScrollLeft", function()
	swayimg.gallery.switch_image("right")
end)
swayimg.gallery.on_mouse("ScrollRight", function()
	swayimg.gallery.switch_image("left")
end)
swayimg.gallery.on_mouse("ScrollUp", function()
	swayimg.gallery.switch_image("up")
end)
swayimg.gallery.on_mouse("ScrollDown", function()
	swayimg.gallery.switch_image("down")
end)
swayimg.gallery.on_mouse("Ctrl+ScrollUp", function()
	thumb_step(20)
end)
swayimg.gallery.on_mouse("Ctrl+ScrollDown", function()
	thumb_step(-20)
end)
swayimg.gallery.on_mouse("MouseLeft", function()
	swayimg.set_mode("viewer")
end)
