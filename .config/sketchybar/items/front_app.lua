local colors = require("colors")
local settings = require("settings")
local app_icons = require("helpers.app_icons")

local front_app = sbar.add("item", "front_app", {
  position = "center",
  display = "active",
  icon = {
    drawing = true,
    font = "sketchybar-app-font:Regular:16.0",
    padding_left = 8,
  },
  label = {
    font = {
      style = settings.font.style_map["SemiboldItalic"],
      size = 14.0,
    },
    padding_right = 8,
  },
  background = {
    color = colors.bg1,
    corner_radius = 14,
    border_color = colors.transparent,
    border_width = 0,
  },
  updates = true,
})

front_app:subscribe("front_app_switched", function(env)
  local lookup = app_icons[env.INFO]
  local icon = ((lookup == nil) and app_icons["Default"] or lookup)
  sbar.delay(0.15, function()
    front_app:set({
      icon = { string = icon },
      label = { string = env.INFO }
    })
  end)
  sbar.animate("sin", 10, function()
    front_app:set({
      y_offset = 70
    })
    sbar.animate("sin", 10, function()
      front_app:set({
        y_offset = 0
      })
    end)
  end)
end)

front_app:subscribe("mouse.clicked", function(env)
  sbar.trigger("swap_menus_and_spaces")
end)
