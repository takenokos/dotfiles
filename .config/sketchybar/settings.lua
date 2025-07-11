return {
  paddings = 3,
  group_paddings = 5,

  icons = "sf-symbols", -- alternatively available: NerdFont

  -- This is a font configuration for SF Pro and SF Mono (installed manually)
  -- font = require("helpers.default_font"),

  -- Alternatively, this is a font config for JetBrainsMono Nerd Font
  font = {
    text = "Cascadia Code NF", -- Used for text
    numbers = "Cascadia Code NF", -- Used for numbers
    style_map = {
      ["Regular"] = "Regular",
      ["Italic"] = "Italic",
      ["Semibold"] = "Semibold",
      ["SemiboldItalic"] = "Semibold Italic",
      ["Bold"] = "Bold",
      ["BoldItalic"] = "Bold Italic",
    }
  },
}
