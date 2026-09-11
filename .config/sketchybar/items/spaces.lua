local colors = require("colors")
local icons = require("icons")
local settings = require("settings")
local app_icons = require("helpers.app_icons")

local spaces = {}
local names={}
local highlight_colors = {
  0xffffa066,
  0xffc8c093,
  0xffd27e99,
  0xff957fb8,
  0xffe46876,
  0xffff5d62,
  0xffe6c384,
  0xff98bb6c,
  0xff7aa89f,
  0xffa3d4d5,
  0xff658594,
  0xff7e9cd8,
  0xffb8b4d0,
  0xff727169
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
