local WorldState = State:extend("WorldState")

-- local ml = Menori.ml
-- local vec3 = ml.vec3
-- local quat = ml.quat

-- function WorldState:init()
-- 	self.worldScene = Menori.Scene:extend('minimal_scene')
-- 	self.worldScene:init()

-- 	self.rootNode = Menori.Node()
-- 	self.worldCamera = Menori.PerspectiveCamera(60, game.width/game.height, 0.5, 1024)
-- 	self.worldEnvironment = Menori.Environment(self.worldCamera)

-- 	self.worldCanvas = love.graphics.newCanvas(game.width, game.height)
-- 	self.worldSprite = Sprite()

-- 	self.worldAnimations = nil

-- 	self.angle = 0

-- 	self.player = {
-- 		position = {x = 0, y = 0, z = 0},
-- 		animations = {}
-- 	}
-- end

-- function WorldState:enter()
-- 	local gltf = Menori.glTFLoader.load('assets/models/player.gltf')
-- 	if not gltf then
-- 	    print("Failed to load GLTF")
-- 	else
-- 		local scenes, animations = Menori.NodeTreeBuilder.create(gltf, function (scene, builder)
-- 			self.worldAnimations = Menori.glTFAnimations(builder.animations)
-- 			self.worldAnimations:set_action(1)
-- 		end)

-- 		if not scenes or not scenes[1] then
-- 	    	print("Failed to create scene nodes")
-- 	    else
-- 			self.rootNode:attach(scenes[1])
-- 		end
-- 	end
-- 	Menori.app:add_scene('world', worldScene)	
-- end

-- function WorldState:update(dt)
-- 	if controls:down("world_left") then
-- 		self.player.position.x = WorldState.player.position.x + --[[dt * ]]8
-- 	end
-- 	if controls:down("world_right") then
-- 		self.player.position.x = WorldState.player.position.x - --[[dt * ]]8
-- 	end
-- 	if controls:down("world_up") then
-- 		self.player.position.y = WorldState.player.position.x + --[[dt * ]]8
-- 	end
-- 	if controls:down("world_down") then
-- 		self.player.position.y = WorldState.player.position.x - --[[dt * ]]8
-- 	end

-- 	if controls:pressed("interact") then
-- 		game.sound.play(paths.getSound("itgModifierAdd"))
-- 	end

-- 	-- self.playerModel.position = WorldState.player.position

-- 	Menori.app:update(dt)

-- 	self.worldScene:update_nodes(self.rootNode, self.worldEnvironment, {
-- 		node_sort_comp = Menori.Scene.alpha_mode_comp
-- 	})

-- 	self.angle = self.angle + 0.25

-- 	local q = quat.from_euler_angles(0, math.rad(self.angle), math.rad(10)) * vec3.unit_z * 2.0
-- 	local v = vec3(0, 0.5, 0)
-- 	self.worldCamera.center = v
-- 	self.worldCamera.eye = q + v
-- 	self.worldCamera:update_view_matrix()

-- 	self.worldScene:render_nodes(self.rootNode, self.worldEnvironment)
-- end

-- function WorldState.draw()
-- 	love.graphics.setBackgroundColor(1, 0.5, 0)
-- 	Menori.app:set_scene('world')
-- 	Menori.app:render()
-- end

function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

return WorldState