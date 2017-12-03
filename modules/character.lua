local Node = require "modules/node"
local SpriteRenderer = require "modules/spriteRenderer"
local Animator = require "modules/animator"

local function character(x, y, w, h, r, scaleX, scaleY, anchorX, anchorY, layer)
  local self = Node(x, y, w, h, r, scaleX, scaleY, anchorX, anchorY)

  local atlas = lg.newImage("assets/images/atlas.png")
  local sprite = graphics.kramer.walk.frames[1]
  local _, _, spriteWidth, spriteHeight = sprite:getViewport()


  ----------------------------------------------
  -- components
  ----------------------------------------------

  -- sprite renderer component to render the sprite
  self.spriteRenderer = SpriteRenderer(self, atlas, sprite, layer)

  -- animator component to animate the sprite
  self.animator = Animator(self, animations.kramer, "walk")


  ----------------------------------------------
  -- attributes
  ----------------------------------------------

  self.width = w or spriteWidth
  self.height = h or spriteHeight


  ----------------------------------------------
  -- methods
  ----------------------------------------------

  function self:update(dt)

  end


  ----------------------------------------------
  return self
end

return character
