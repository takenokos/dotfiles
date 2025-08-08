local colors = require("colors")
local icons = require("icons")
local settings = require("settings")
local app_icons = require("helpers.app_icons")

local spaces = {}
local names={}
local highlight_colors = {
  0xfff4dbd6,
  0xfff0c6c6,
  0xfff5bde6,
  0xffc6a0f6,
  0xffed8796,
  0xffee99a0,
  0xfff5a97f,
  0xffeed49f,
  0xffa6da95,
  0xff8bd5ca,
  0xff91d7e3,
  0xff7dc4e4,
  0xff8aadf4,
  0xffb7bdf8
}

for i = 1, 10, 1 do
  local space = sbar.add("space", "space." .. i, {
    space = i,
    icon = {
      font = { family = settings.font.numbers },
      string = i .. ".",
      padding_left = 8,
      padding_right = 3,
      color = highlight_colors[i],
      highlight_color = colors.black,
      y_offset = -1,
    },
    label = {
      padding_right = 10,
      color = highlight_colors[i],
      highlight_color = colors.black,
      font = "sketchybar-app-font:Regular:14.0",
    },
    background = {
      corner_radius = 10,
      height = 20,
    },
    popup = { background = { border_width = 5, border_color = colors.black } }
  })

  spaces[i] = space
  names[i]=space.name

  local space_popup = sbar.add("item", {
    position = "popup." .. space.name,
    background = {
      drawing = true,
      image = {
        scale = 0.2
      }
    }
  })
  space:subscribe("space_change", function(env)
    local selected = env.SELECTED == "true"
    local color = selected and colors.grey or colors.bg2
    space:set({
      icon = { highlight = selected, },
      label = { highlight = selected },
      background = { color =selected and highlight_colors[tonumber(env.SID)] or colors.transparent }
    })
  end)

  space:subscribe("mouse.clicked", function(env)
    if env.BUTTON == "other" then
      space_popup:set({ background = { image = "space." .. env.SID } })
      space:set({ popup = { drawing = "toggle" } })
    else
      local op = (env.BUTTON == "right") and "--destroy" or "--focus"
      sbar.exec("yabai -m space " .. op .. " " .. env.SID)
    end
  end)

  space:subscribe("mouse.exited", function(_)
    space:set({ popup = { drawing = false } })
  end)
end

local space_bracket = sbar.add("bracket","spaces.bracket" , names , {
    background = {
      color = colors.bg1,
    },
})

local space_window_observer = sbar.add("item", {
  drawing = false,
  updates = true,
})

local spaces_indicator = sbar.add("item", {
  icon = {
    padding_left = 8,
    color = colors.mauve,
    string = icons.switch.on,
  },
  label = {
    width = 0,
    padding_right = 8,
    string = "Menu",
    color = colors.black,
  },
  background = {
    color = colors.with_alpha(colors.mauve, 0.0),
  }
})

space_window_observer:subscribe("space_windows_change", function(env)
  local icon_line = ""
  local no_app = true
  for app, count in pairs(env.INFO.apps) do
    no_app = false
    local lookup = app_icons[app]
    local icon = ((lookup == nil) and app_icons["Default"] or lookup)
    icon_line = icon_line .. icon
  end

  if (no_app) then
    icon_line = "—"
  end
  sbar.animate("sin", 10, function()
    spaces[env.INFO.space]:set({ label = icon_line })
  end)
end)

spaces_indicator:subscribe("swap_menus_and_spaces", function(env)
  local currently_on = spaces_indicator:query().icon.value == icons.switch.on
  spaces_indicator:set({
    icon = currently_on and icons.switch.off or icons.switch.on,
    label = currently_on and "Spaces" or "Menu"
  })
end)

spaces_indicator:subscribe("mouse.entered", function(env)
  sbar.animate("sin", 10, function()
    spaces_indicator:set({
      background = {
        color = { alpha = 1.0 },
      },
      icon = { color = colors.black },
      label = { width = "dynamic" }
    })
  end)
end)

spaces_indicator:subscribe("mouse.exited", function(env)
  sbar.animate("sin", 10, function()
    spaces_indicator:set({
      background = {
        color = { alpha = 0.0 },
      },
      icon = { color = colors.mauve},
      label = { width = 0, }
    })
  end)
end)

spaces_indicator:subscribe("mouse.clicked", function(env)
  sbar.trigger("swap_menus_and_spaces")
end)
