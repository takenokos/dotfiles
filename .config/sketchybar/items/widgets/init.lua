local cal = require("items.widgets.calendar")
local battery = require("items.widgets.battery")
local volume = require("items.widgets.volume")
local wifi = require("items.widgets.wifi")
local cpu = require("items.widgets.cpu")
local colors = require("colors")

sbar.add("bracket", "widgets.bracket", {
    cal.name,
    battery.name,
    volume.name,
    wifi.name,
    cpu.name,
  }, {
    background = { color = colors.bg1 },
})
