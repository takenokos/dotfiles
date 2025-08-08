local colors = require("colors")
local icons = require("icons")
local settings = require("settings")

local apple = sbar.add("item", {
  icon = {
    string = icons.apple,
    padding_right = 8,
    padding_left = 8,
  },
  label = { drawing = false },
  background = {
    height = 26,
    color = colors.bg1,
    corner_radius = 14,
    border_color = colors.transparent,
    border_width = 0
  },
  click_script = "$CONFIG_DIR/helpers/menus/bin/menus -s 0"
})
