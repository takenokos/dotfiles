return {
  black = 0xff1f1f28,
  white = 0xffdcd7ba,
  rosewater = 0xffffa066,
  flamingo = 0xffc8c093,
  pink = 0xffd27e99,
  mauve = 0xff957fb8,
  red = 0xffe46876,
  maroon = 0xffff5d62,
  peach = 0xffffa066,
  yellow = 0xffe6c384,
  green = 0xff98bb6c,
  teal = 0xff7aa89f,
  sky = 0xffa3d4d5,
  sapphire = 0xff658594,
  blue = 0xff7e9cd8,
  lavender = 0xffb8b4d0,
  grey = 0xff727169,
  transparent = 0x00000000,

  bar = {
    bg = 0x00000000,
    border = 0x601f1f28,
  },
  popup = {
    bg = 0x661f1f28,
    border = 0xffdcd7ba
  },
  bg1 = 0x601f1f28,
  bg2 = 0x602a2a37,

  with_alpha = function(color, alpha)
    if alpha > 1.0 or alpha < 0.0 then return color end
    return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
  end,
}
