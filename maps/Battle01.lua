return {
  version = "1.10",
  luaversion = "5.1",
  tiledversion = "1.11.0",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 24,
  height = 13,
  tilewidth = 16,
  tileheight = 16,
  nextlayerid = 5,
  nextobjectid = 1,
  properties = {},
  tilesets = {
    {
      name = "World",
      firstgid = 1,
      filename = "../tiled/WorldTileset.tsx",
      exportfilename = "MapTileset.lua"
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 24,
      height = 13,
      id = 1,
      name = "Base",
      class = "Map",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        41, 302, 302, 302, 1, 1, 1, 21, 21, 21, 1, 1, 41, 41, 41, 41, 41, 41, 41, 41, 41, 41, 41, 41,
        41, 302, 302, 302, 302, 105, 105, 61, 61, 61, 105, 1, 1, 1, 41, 41, 41, 41, 41, 41, 41, 41, 41, 41,
        41, 41, 302, 302, 105, 105, 61, 61, 61, 61, 105, 105, 1, 1, 1, 1, 41, 41, 41, 41, 41, 41, 41, 41,
        41, 41, 302, 302, 302, 105, 61, 61, 61, 61, 21, 1, 1, 21, 1, 21, 1, 1, 41, 41, 41, 41, 41, 41,
        41, 41, 41, 302, 105, 105, 105, 105, 105, 105, 1, 1, 21, 21, 21, 21, 21, 1, 41, 41, 41, 302, 302, 302,
        41, 41, 41, 302, 302, 302, 302, 302, 302, 1, 1, 41, 1, 1, 21, 21, 21, 1, 41, 41, 302, 302, 284, 327,
        302, 302, 302, 302, 302, 302, 41, 41, 302, 302, 302, 41, 41, 41, 1, 21, 1, 41, 41, 41, 302, 284, 328, 261,
        302, 284, 343, 343, 343, 285, 302, 41, 41, 345, 346, 302, 302, 41, 1, 1, 43, 41, 41, 41, 302, 308, 286, 282,
        343, 348, 302, 302, 302, 347, 290, 41, 41, 342, 347, 346, 302, 302, 302, 302, 41, 41, 41, 302, 302, 308, 306, 302,
        302, 302, 302, 41, 302, 302, 341, 302, 302, 342, 302, 342, 302, 345, 346, 302, 302, 302, 302, 302, 284, 329, 310, 302,
        41, 41, 41, 41, 41, 302, 347, 343, 343, 305, 302, 347, 343, 348, 347, 343, 346, 302, 302, 284, 329, 305, 302, 302,
        41, 41, 41, 41, 41, 41, 302, 302, 302, 302, 302, 302, 302, 302, 302, 302, 347, 343, 343, 365, 301, 302, 302, 302,
        41, 41, 41, 41, 41, 41, 41, 41, 41, 41, 41, 302, 302, 302, 302, 302, 302, 302, 302, 303, 326, 285, 302, 302
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 24,
      height = 13,
      id = 2,
      name = "Objects",
      class = "Map",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 131, 0, 133, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 134, 134, 132, 132, 134, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 133, 135, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 134, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 24,
      height = 13,
      id = 4,
      name = "Collision",
      class = "Collision",
      visible = false,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 400, 0, 400, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 400, 400, 400, 400, 400, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 400, 400, 0, 0, 0, 0, 0, 400, 400,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 400, 0, 0, 0, 0, 0, 400, 400, 400,
        0, 400, 400, 400, 400, 400, 0, 0, 0, 400, 400, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 400, 400, 400,
        400, 400, 0, 0, 0, 400, 400, 0, 0, 400, 400, 400, 0, 0, 0, 0, 0, 0, 0, 0, 0, 400, 400, 0,
        0, 0, 0, 0, 0, 0, 400, 0, 0, 400, 0, 400, 0, 400, 400, 0, 0, 0, 0, 0, 400, 400, 400, 0,
        0, 0, 0, 0, 0, 0, 400, 400, 400, 400, 0, 400, 400, 400, 400, 400, 400, 0, 0, 400, 400, 400, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 400, 400, 400, 400, 400, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 400, 400, 400, 0, 0
      }
    }
  }
}
