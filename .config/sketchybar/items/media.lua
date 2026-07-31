local icons = require("icons")
local colors = require("colors")

-- spacer
sbar.add("item", {
  position = "right",
  width = 5,
})
local media_cover = sbar.add("item", {
  position = "right",
  padding_left = 5,
  padding_right = 5,
  background = {
    color = colors.transparent,
    corner_radius = 14,
    image = {
      string = "media.artwork",
      scale = 0.18,
    },
  },
  label = { drawing = false },
  icon = { drawing = false },
  drawing = false,
  updates = true,
  update_freq = 1,
})

local media_artist = sbar.add("item", {
  position = "right",
  padding_left = 5,
  padding_right = 0,
  width = 0,
  icon = { drawing = false },
  label = {
    font = { size = 9 },
    color = colors.with_alpha(colors.white, 0.6),
    max_chars = 18,
    y_offset = 6,
  },
})

local media_title = sbar.add("item", {
  position = "right",
  padding_left = 5,
  padding_right = 0,
  icon = { drawing = false },
  label = {
    font = { size = 11 },
    max_chars = 16,
    y_offset = -5,
  },
})
local media_bracket = sbar.add("bracket", "media.bracket", {
  media_cover.name,
  media_title.name,
  media_artist.name,
}, {
  background = {
    color = colors.bg1,
  },
  popup = {
    align = "center",
    horizontal = true,
  }
})
sbar.add("item", {
  position = "popup." .. media_bracket.name,
  icon = { string = icons.media.back },
  label = { drawing = false },
  click_script = "nowplaying-cli previous",
})
sbar.add("item", {
  position = "popup." .. media_bracket.name,
  icon = { string = icons.media.play_pause },
  label = { drawing = false },
  click_script = "nowplaying-cli togglePlayPause",
})
sbar.add("item", {
  position = "popup." .. media_bracket.name,
  icon = { string = icons.media.forward },
  label = { drawing = false },
  click_script = "nowplaying-cli next",
})

local last_track = ""
local last_art_path = "/tmp/sketchybar_art.jpg"
media_cover:subscribe({ "routine", "system_woke", "media_change"}, function(env)
  sbar.exec("nowplaying-cli get playbackRate title artist", function(out)
		local rate_str, title, artist = out:match("([^\n]*)\n([^\n]*)\n([^\n]*)")
		local rate = tonumber(rate_str) or 0
		title = title and title:gsub("^%s*(.-)%s*$", "%1") or ""
		artist = artist and artist:gsub("^%s*(.-)%s*$", "%1") or ""
		
    local track = title .. " -- " .. artist
    local drawing = (title ~= "" and title ~= "null")
    
    media_artist:set({ drawing = drawing, label = artist, })
    media_title:set({ drawing = drawing, label = title, })
    media_cover:set({ drawing = drawing ,})

    if drawing and track ~= last_track then
      last_track = track
      local path = last_art_path
	    local cmd = string.format(
	    	"nowplaying-cli get artworkData 2>/dev/null | base64 -D > %q 2>/dev/null; "
	    		.. "if [ -s %q ]; then sips -Z 96 %q >/dev/null 2>&1; echo ok; else rm -f %q; fi",
	    	path,
	    	path,
	    	path,
	    	path
	    )
	    sbar.exec(cmd, function(artOut)
        media_cover:set({
			  		background = { image = { string = path } },
			  })
	    end)
    else
    end
  end)
end)

local function toggle_media_popup()
  media_bracket:set({ popup = { drawing = "toggle" }})
end
media_cover:subscribe("mouse.clicked", toggle_media_popup)
media_title:subscribe("mouse.clicked", toggle_media_popup)
media_artist:subscribe("mouse.clicked", toggle_media_popup)
media_bracket:subscribe("mouse.clicked", toggle_media_popup)

media_bracket:subscribe("mouse.exited.global", function(env)
  media_bracket:set({ popup = { drawing = false }})
end)
