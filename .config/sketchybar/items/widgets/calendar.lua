local settings = require("settings")
local colors = require("colors")
local icons = require("icons")

local cal = sbar.add("item", {
  icon = {
    string = icons.calendar,
    color = colors.blue,
    font = {
      style = settings.font.style_map["Bold"],
      size = 18.0,
    },
  },
  label = {
    color = colors.white,
    align = "right",
    font = { family = settings.font.numbers },
  },
  position = "right",
  update_freq = 1,
  click_script = "open -a 'Calendar'"
})

local week_map = {
  "周日", "周一", "周二", "周三", "周四", "周五", "周六"
}
cal:subscribe({ "forced", "routine", "system_woke" }, function(env)
  local w = os.date("*t").wday
  cal:set({ label = os.date("%Y年%m月%d日 ") .. week_map[w] .. os.date(" %T") })
end)

return cal
