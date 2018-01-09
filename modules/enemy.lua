local Node = require "modules/node"

local function enemy(x, y, w, h, r, scaleX, scaleY, anchorX, anchorY, layer)
  local self = Node(x, y, w, h, r, scaleX, scaleY, anchorX, anchorY)

  local assets = require "templates/assets"

  ----------------------------------------------
  -- attributes
  ----------------------------------------------



  self.name = "enemy"
  self.scale = 0.5

  self.health = 1
  self.speed = 100

  ----------------------------------------------
  -- components
  ----------------------------------------------

  -- sprite renderer component to render the sprite
  local body = Node()

  -- sprite renderer component to render the sprite
  body:addComponent("spriteRenderer",
  { atlas = assets.character.atlas,
    asset = assets.character.sword_shield.idle,
    layer = 1 })

  -- animator component to animate the sprite
  body:addComponent("animator",
  { animations = assets.character.animations })
  body.animator:play("sword-shield-idle", 0)

  self:addChild(body)


  -- collider component to collide with other collision objects
  self:addComponent("collider", {
    shapeType = "circle",
    radius = 40
  })

  -- agent component to implement AI
  self:addComponent("agent")

  ----------------------------------------------
  -- methods
  ----------------------------------------------

  function self:update(dt)
    if not self.target then
      self.target = scene.rootNode:getChildByName("character")
    end

    -- make enemy look at character in a certain range
    if self.target and vector.length(self.x - c.x, self.y - c.y) < 200 then
      self:lookAt(c.x, c.y)
      -- enable hitbox
      --hitbox.collider.active = true

      -- change animation
      if not body.animator:isPlaying("sword-shield-stab") then
        body.animator:play("sword-shield-stab", 1, function()
          body.animator:play("sword-shield-idle", 0)
          --hitbox.collider.active = false
        end)
      end
    end
  end

  function self:damage(amount)
    local amount = amount or 1
    self.health = self.health - amount
    if self.health <= 0 then
      self:kill()
    end
  end

  function self:kill()
    self.active = false
  end


  ----------------------------------------------
  return self
end

return enemy
