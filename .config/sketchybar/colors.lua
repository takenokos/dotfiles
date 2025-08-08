return {
  black = 0xff181926,
  white = 0xffcad3f5,
  rosewater = 0xfff4dbd6,
  flamingo = 0xfff0c6c6,
  pink = 0xfff5bde6,
  mauve = 0xffc6a0f6,
  red = 0xffed8796,
  maroon = 0xffee99a0,
  peach = 0xfff5a97f,
  yellow = 0xffeed49f,
  green = 0xffa6da95,
  teal = 0xff8bd5ca,
  sky = 0xff91d7e3,
  sapphire = 0xff7dc4e4,
  blue = 0xff8aadf4,
  lavender = 0xffb7bdf8,
  grey = 0xff939ab7,
  transparent = 0x00000000,

  bar = {
    bg = 0x00000000,
    border = 0x603c3e4f,
  },
  popup = {
    bg = 0x661e1e2e,
    border = 0xffcad3f5
  },
  bg1 = 0x603c3e4f,
  bg2 = 0x60494d64,

  with_alpha = function(color, alpha)
    if alpha > 1.0 or alpha < 0.0 then return color end
    return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
  end,
}
