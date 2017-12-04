local Node = require "modules/node"

local function character(x, y, w, h, r, scaleX, scaleY, anchorX, anchorY, layer)
  local self = Node(x, y, w, h, r, scaleX, scaleY, anchorX, anchorY)
  local hitbox = Node(x, y, w, h, r, scaleX, scaleY, anchorX, anchorY)

  local assets = require "templates/assets"
  local sprite = assets.kramer.graphics.walk.frames[1]
  local _, _, spriteWidth, spriteHeight = sprite:getViewport()

  ----------------------------------------------
  -- attributes
  ----------------------------------------------

  self.width = w or spriteWidth
  self.height = h or spriteHeight


  ----------------------------------------------
  -- components
  ----------------------------------------------

  -- sprite renderer component to render the sprite
  self:addComponent("spriteRenderer",
  { sprite = sprite,
    layer = layer })

  -- animator component to animate the sprite
  self:addComponent("animator",
  { animations = assets.kramer.animations,
    animationName = "walk" })

  -- collider component to collide with other collision objects
  self:addComponent("collider")


  ----------------------------------------------

  local hitbox = Node(10, 0, 25, 10, math.pi * 0)
  hitbox.anchorX, hitbox.anchorY = 0, 0.5
  hitbox:addComponent("collider")
  hitbox.collider.body:setActive(false)
  self:addChild(hitbox)


  ----------------------------------------------
  -- methods
  ----------------------------------------------

  function self:update(dt)
    -- character movement
    if(lk.isDown("a")) then
      self.x = self.x - 100 * dt
    end
    if(lk.isDown("d")) then
      self.x = self.x + 100 * dt
    end
    if(lk.isDown("w")) then
      self.y = self.y - 100 * dt
    end
    if(lk.isDown("s")) then
      self.y = self.y + 100 * dt
    end

    -- character attack
    if(lm.isDown(1)) then
      hitbox.collider.body:setActive(true)
    else
      hitbox.collider.body:setActive(false)
    end

    -- make character look at direction
    self:lookAt(lm.getPosition())
  end

  function self:beginContact(f, contact)
    print("beginContact")
  end

  function self:endContact(f, contact)
    print("endContact")
  end

  function self:lookAt(x, y)
    local dx, dy = x - self.x, y - self.y
    self.rotation = vector.angle(1, 0, dx, dy)
  end


  ----------------------------------------------
  return self
end

return character
