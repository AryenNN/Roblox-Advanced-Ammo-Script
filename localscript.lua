wait(0.2)
bin = script.Parent
Player = bin.Parent.Parent
char = Player.Character
guy = char
name = script.Parent.Name
reload = 0
sel = 0
wt = 0

clip = 8
maxammo = 24
maxammo2 = maxammo
ammo = clip
ammot = -1

function computeDirection(vec)
	local lenSquared = vec.magnitude^2
	local invSqrt = 1 / math.sqrt(lenSquared)
	return Vector3.new(vec.x * invSqrt, vec.y * invSqrt, vec.z * invSqrt)
end

function onKeyDown(key)
	if (key~=nil) then
		key = key:lower()
		if (key == "r") then 
			if ammo <= 15 and maxammo2>=1 and reload == 0 then
				reload = 1	
				for i = ammo, clip, 1 do
					wait(0.6)
					if reload == 1 then
						if maxammo2>0 then
							ammo = i
							ammot = ammot+1
							maxammo2 = maxammo-ammot
							if sel == 1 then
							script.Parent.Name = "[".. ammo.. "] [".. maxammo2.. "]"
							end
						end
						if maxammo2 == 0 then
						reload = 0
						end
					end
				end
				ammot = ammot-1
				reload = 0
			end
		end
	end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
----------MAKE BULLETS----------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
function fire2(target,gun)

head = gun
for i = 1, 6 do
	local dir = target - head.Position
	dir = computeDirection(dir)

	local missile = Instance.new("Part")
	missile.Name = "Missile"
	missile.Size = Vector3.new(1,1,3)
	missile.Position = Vector3.new(1,1000,3)
	missile.BrickColor = BrickColor.new("Bright yellow")
	missile.TopSurface = "Studs"
	missile.BackSurface = "Studs"
	missile.FrontSurface = "Studs"
	missile.RightSurface = "Studs"
	missile.LeftSurface = "Studs"

	m = script.Parent.RocketScript:clone()
	m.Hurt.Disabled = false
	m.loop.Disabled = false
	m.Parent = missile
	me = Instance.new("BlockMesh")
	me.Parent = missile
	me.Scale = Vector3.new(0.5,0.5,1/3/2)
	local spawnPos = gun.Position
	local pos = spawnPos + (dir * math.random(1,10))
	
	--missile.Position = pos
	missile.CFrame = CFrame.new(pos,  pos + dir)*CFrame.new(0,0,-3)

	local creator_tag = Instance.new("ObjectValue")
	creator_tag.Value = Player
	creator_tag.Name = "creator"
	creator_tag.Parent = missile

	missile.RocketScript.Disabled = false
	missile.Parent = game.Workspace
end
end
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-------FIRE-------------------------------------------------------------------
--------------------------------------------------------------------------------
function fire(obj)
	snd = obj.Fire:clone()
	obj.Fire:Remove()
	snd.Parent = obj

	bl = script.Parent.BL:clone()
	bl.Parent = game.workspace
	script.Parent.REM_BL:clone().Parent = bl

	bll = Instance.new("Weld") 
	bll.Part0 = obj
	bll.Part1 = bl
	bll.Parent = obj
	bll.C0 = CFrame.new(0,1.2,-0.55)*CFrame.fromEulerAnglesXYZ(0,-.2,math.pi) 	

	if obj.Name == "Handle" then
		for i=1,3 do
		wait(0.03)
		LAW.C0 = LAW.C0*CFrame.fromEulerAnglesXYZ(0.08,0,0)
		RAW.C0 = RAW.C0*CFrame.fromEulerAnglesXYZ(0.08,0,0)
		end
		for i=1,3 do
		wait(0.03)
		LAW.C0 = LAW.C0*CFrame.fromEulerAnglesXYZ(-0.08,0,0)
		RAW.C0 = RAW.C0*CFrame.fromEulerAnglesXYZ(-0.08,0,0)
		end
	end

end
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function onButton1Down(mouse)
	if reload == 0 then
		if ammo >=1 then
			if wt == 0 then
				wt = 1
				ammo = ammo-1
				script.Parent.Name = "[".. ammo.. "] [".. maxammo2.. "]"
				local cf = mouse.Hit
				local target = cf.p
				fire2(target,h)
				fire(h)
				wait(0.2)
				wt = 0
			end
		end
	end
end

function select(mouse)
sel = 1
script.Parent.Name = "[".. ammo.. "] [".. maxammo2.. "]"

	RAW = Instance.new("Weld") 
	RAW.Part0 = guy["Torso"]
	RAW.Part1 = guy["Right Arm"]
	RAW.Parent = guy["Torso"]
	RAW.C0 = CFrame.new(1,-0.15,-0.2)*CFrame.fromEulerAnglesXYZ(math.pi/9,0,-0) 

	LAW = Instance.new("Weld") 
	LAW.Part0 = guy["Torso"]
	LAW.Part1 = guy["Left Arm"]
	LAW.Parent = guy["Torso"]
	LAW.C0 = CFrame.new(-0.6,-0.15,-0.3)*CFrame.fromEulerAnglesXYZ(math.pi/9,0,0) 


	guns = script.Parent.Handle:clone()
	guns.Parent = game.workspace
	h = guns.Handle

	GW = Instance.new("Weld") 
	GW.Part0 = guy["Right Arm"]
	GW.Part1 = h
	GW.Parent = guy["Right Arm"]
	GW.C0 = CFrame.new(-0.6,-1.6,-0.2)*CFrame.fromEulerAnglesXYZ(-1.56,-0.2,0) 

	mouse.Button1Down:connect(function() onButton1Down(mouse) end)
	mouse.KeyDown:connect(onKeyDown)

		LAW.C0 = LAW.C0*CFrame.new(0.4,0.5,-0.6)*CFrame.fromEulerAnglesXYZ(0.115*10,0,0.06*15)
		RAW.C0 = RAW.C0*CFrame.new(.2,0.5,-0.9)*CFrame.fromEulerAnglesXYZ(0.115*10,0,-0.2)

end

function unselect(mouse)
sel = 0
script.Parent.Name = name
	RAW:Remove()
	LAW:Remove()
	guns:Remove()

	m = Instance.new("Motor")
	m.Parent = guy.Torso
	m.Part1=guy.Torso
	m.Part0=guy:findFirstChild("Right Arm")
	m.Name = "Right Shoulder"
	m.MaxVelocity = 0.15
	m.C0 = CFrame.new(0,guy["Right Arm"].Size.y/4,-guy["Torso"].Size.y/2-guy["Right Arm"].Size.y/4) * CFrame.fromEulerAnglesXYZ(0,0,0) 
	m.C1 = CFrame.new(0,guy["Right Arm"].Size.y/4,0) * CFrame.fromEulerAnglesXYZ(0,3.14/2,0)

	m = Instance.new("Motor")
	m.Parent = guy.Torso
	m.Name = "Left Shoulder"
	m.Part1=guy.Torso
	m.Part0=guy:findFirstChild("Left Arm")
	m.MaxVelocity = 0.15
	m.C0 = CFrame.new(0,guy["Left Arm"].Size.y/4,-guy["Torso"].Size.y/2-guy["Left Arm"].Size.y/4) * CFrame.fromEulerAnglesXYZ(0,0,0) 
	m.C1 = CFrame.new(0,guy["Left Arm"].Size.y/4,0) * CFrame.fromEulerAnglesXYZ(0,-3.14/2,0)

	ani = guy.Animate:clone()
	guy.Animate:Remove()
	ani.Parent = guy

end

script.Parent.Selected:connect(select)
script.Parent.Deselected:connect(unselect)


while true do
wait(0.1)
if ammo<=-1 then
ammo = 0
script.Parent.Name = "[".. ammo.. "] [".. maxammo2.. "]"
end
end
