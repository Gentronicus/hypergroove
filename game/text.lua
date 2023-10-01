local Text = Object:extend()

function Text:new(x, y, content, font, color, align, limit)
    self.x = x or 0
    self.y = y or 0

    self.content = content
    self.font = font or love.graphics.getFont()
    self.alignment = align or "left"
    self.limit = limit

    self.color = color or {1, 1, 1}
    self.alpha = 1
    self.cameras = nil
    self.visible = true
    self.scrollFactor = {x = 1, y = 1}

    self.alive = true
    self.exists = true

    self.antialiasing = true
    self.blend = "alpha"
    self.shader = nil

    self.outColor = {0, 0, 0}
    self.outWidth = 0
end

function Text:setContent(content) self.content = content or "" end

function Text:getWidth() return self.font:getWidth(self.content) end

function Text:getHeight() return self.font:getHeight(self.content) end

function Text:setFont(font) self.font = font or love.graphics.getFont() end

function Text:setColor(color) self.color = color or {1, 1, 1} end

function Text:screenCenter(axes)
    if axes == nil then axes = "xy" end

    if axes:find("x") then
        self.x = (push.getWidth() - self.font:getWidth(self.content)) * 0.5
    end
    if axes:find("y") then
        self.y = (push.getHeight() - self.font:getHeight(self.content)) * 0.5
    end
end

function Text:setScrollFactor(x, y)
    if x == nil then x = 0 end
    if y == nil then y = 0 end
    self.scrollFactor.x, self.scrollFactor.y = x, y
end

function Text:kill()
    self.alive = false
    self.exists = false
end

function Text:revive()
    self.alive = true
    self.exists = true
end

function Text:destroy()
    self.exists = false
    self.content = nil
    self.outWidth = 0
end

function Text:draw()
    if self.exists and self.alive and self.visible and self.alpha > 0 then
        for _, c in ipairs(self.cameras or Camera.__defaultCameras) do
            if c.visible and c.exists then
                table.insert(c.__renderQueue, self)
            end
        end
    end
end

function Text:__render(camera)
    local font = love.graphics.getFont()
    local r, g, b, a = love.graphics.getColor()
    local min, mag, anisotropy = self.font:getFilter()
    local shader = love.graphics.getShader()
    local x, y = self.x - (camera.scroll.x * self.scrollFactor.x),
                 self.y - (camera.scroll.y * self.scrollFactor.y)

    local mode = self.antialiasing and "linear" or "nearest"
    self.font:setFilter(mode, mode)
    if self.shader then love.graphics.setShader(self.shader) end

    local blendMode, alphaMode = love.graphics.getBlendMode()
    love.graphics.setBlendMode(self.blend)

    love.graphics.setFont(self.font)
    love.graphics.setColor(self.outColor[1], self.outColor[2], self.outColor[3],
                           alpha)

    if self.outWidth > 0 then
        for dx = -self.outWidth, self.outWidth do
            for dy = -self.outWidth, self.outWidth do
                love.graphics.printf(self.content, x + dx, y + dy,
                                     (self.limit or self:getWidth()),
                                     self.alignment)
            end
        end
    end

    love.graphics.setColor(self.color[1], self.color[2], self.color[3], alpha)
    love.graphics.printf(self.content, x, y, (self.limit or self:getWidth()),
                         self.alignment)

    love.graphics.setFont(font)
    love.graphics.setColor(r, g, b, a)

    self.font:setFilter(min, mag, anisotropy)
    love.graphics.setBlendMode("alpha")
    if self.shader then love.graphics.setShader(shader) end
    love.graphics.setBlendMode(blendMode, alphaMode)
end

return Text
