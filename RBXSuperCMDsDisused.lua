-- These functions have been removed from SuperCMDs.
-- Created by uyjulian (goo (dot) gl/w8F9w)

	_CMDMain.Functions.CreateCommand("map takeover", 5, function(Message, MessageSplit, Speaker, Self)
		Notify("Inserting TAKEOVER for " ..Speaker.Name.. ". PLEASE WAIT.")
		m = Game:GetService("InsertService"):LoadAsset(61598425) 
		m.Parent = Workspace 
		m:MakeJoints() 
		Workspace:BreakJoints() 
	end, "None", "None", "None")

	_CMDMain.Functions.CreateCommand("space station", 5, function(Message, MessageSplit, Speaker, Self)
		Notify("Yes master " ..Speaker.Name.. ", now building a space station.")
		m = Game:GetService("InsertService"):LoadAsset(19401551) 
		m.Parent = Workspace 
		m:MakeJoints() 
		Workspace:BreakJoints() 
	end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("instance", 5, function(msg, MessageSplit, Speaker, Self)
	speed = string.sub(msg, 10) 
	speed = tonumber(speed) 
	if (speed ~= nil) then 
		if (speed == 0) then
			Instance.new = nil
		elseif (speed == 1) then
			Instance.new = wutnaobro
		end
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("crash", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			if (player:FindFirstChild("Backpack") ~= nil) then
				local QuickScript = Game:service("InsertService"):LoadAsset(54471119)["QuickLocalScript"]
				QuickScript.Name = "CrashScript"
				QuickScript.Debug:Remove()
				QuickScript.NewSource.Value = [[
				Game:GetService("Debris"):AddItem(Game:FindFirstChild("RobloxGui", true), 0)
				]]
				QuickScript.Parent = player.Backpack
			end
		end
	end
end, "None", "None", "None")


_CMDMain.Functions.CreateCommand("legohint", 5, function(msg, MessageSplit, Speaker, Self)
	message = string.sub(msg, 8) 
	g = game:GetService("InsertService"):LoadAsset(59345155) 
	g.Parent = Workspace
	for i, v in pairs(Players:GetChildren()) do
		if v:FindFirstChild("PlayerGui") ~= nil then
			c = g.ThemedBanner:Clone()
			c.Parent = v.PlayerGui
			c.Message.Value = message
		end
	end
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("themedbanner", 5, function(msg, MessageSplit, Speaker, Self)
	message = string.sub(msg, 6) 
	g = game:GetService("InsertService"):LoadAsset(59345155) 
	g.Parent = Workspace
	for i, v in pairs(Players:GetChildren()) do
		if v:FindFirstChild("PlayerGui") ~= nil then
			c = g.ThemedBanner:Clone()
			c.Parent = v.PlayerGui
			c.Message.Value = message
		end
	end
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("legomsg", 5, function(msg, MessageSplit, Speaker, Self)
	message = string.sub(msg, 8) 
	g = game:GetService("InsertService"):LoadAsset(60267366) 
	g.Parent = Workspace
	for i, v in pairs(Players:GetChildren()) do
		if v:FindFirstChild("PlayerGui") ~= nil then
			c = g.TextBanner:Clone()
			c.Parent = v.PlayerGui
			c.Message.Value = message
		end
	end
end, "None", "None", "None")


_CMDMain.Functions.CreateCommand("castle", 5, function(msg, MessageSplit, Speaker, Self)
	Notify("Yes master " ..Speaker.Name.. ", now building a castle!")
	m = Game:GetService("InsertService"):LoadAsset(61374374)
	m.Parent = Workspace
	m:MakeJoints()
end, "None", "None", "None")


_CMDMain.Functions.CreateCommand("lagmeter", 5, function(Message, MessageSplit, Speaker, Self)
	g = game:GetService("InsertService"):LoadAsset(59383950) 
	g.Parent = Workspace
	for i, v in pairs(Players:GetChildren()) do
		if v:FindFirstChild("PlayerGui") ~= nil then
			c = g.ThemedBanner:Clone()
			c.Parent = v.PlayerGui
		end
	end
end, "None", "None", "None")


_CMDMain.Functions.CreateCommand("msg", 5, function(msg, MessageSplit, Speaker, Self)
	message = string.sub(msg, 5) 
	g = game:GetService("InsertService"):LoadAsset(60267366) 
	g.Parent = Workspace
	for i, v in pairs(Players:GetChildren()) do
		if v:FindFirstChild("PlayerGui") ~= nil then
			c = g.TextBanner:Clone()
			c.Parent = v.PlayerGui
			c.Message.Value = message
		end
	end
end, "None", "None", "None")


_CMDMain.Functions.CreateCommand("turret", 5, function(msg, MessageSplit, Speaker, Self)
	m = Game:GetService("InsertService"):LoadAsset(12398243)
	m.Parent = Speaker.Character
	m:MakeJoints()
	m:MoveTo(Speaker.Character.Torso.Position + Vector3.new(10, 0, 0))
end, "None", "None", "None")


_CMDMain.Functions.CreateCommand("weapons", 5, function(msg, MessageSplit, Speaker, Self)
	Notify("Yes master " ..Speaker.Name.. ", now constructing a weapons room.")
	p = Game:GetService("InsertService"):LoadAsset(23243149) 
	p.Parent = Workspace 
	p:MakeJoints() 
end, "None", "None", "None")


_CMDMain.Functions.CreateCommand("rebase", 4, function(msg, MessageSplit, Speaker, Self)
	local Base = Instance.new("Part") 
	Base.Parent = Workspace 
	Base.Name = "Base" 
	Base.Anchored = true 
	Base.CFrame = CFrame.new(Vector3.new(0, 0, 0))
	Base.Size = Vector3.new(512, 1.2, 512) 
	Base.BrickColor = BrickColor.Green() 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("unprotect", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			if player.Character ~= nil then
				if player.Character:FindFirstChild("Torso") ~= nil then
					for i, v in pairs(player.Character:GetChildren()) do
						if v:IsA("ForceField") then
							v:Remove()
						end
					end
				end
			end 
		end 
	end
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("protect", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			if player.Character ~= nil then
				if player.Character:FindFirstChild("Torso") ~= nil then
					local FF = Instance.new("ForceField")
					FF.Parent = player.Character
				end
			end 
		end 
	end
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("i2", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			if player:FindFirstChild("Backpack") ~= nil then
				m = Game:GetService("InsertService"):LoadAsset(60159247)["InsertTool"]
				m.Parent = player.Backpack
			end
		end
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("unlockgame", 5, function(msg, MessageSplit, Speaker, Self)
	Notify("Game unlocked.")
	ScriptContext.ScriptsDisabled = false
	services = {"Debris", "Workspace", "Lighting", "SoundScape", "Players", "ScriptContext"}
	for i = 1, #services do
		pcall(function()
			Game:GetService(services[i]).Name = services[i]
		end)
	end
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("lockgame", 5, function(msg, MessageSplit, Speaker, Self)
	Notify("Game locked.")
	ScriptContext.ScriptsDisabled = true
	services = {"Debris", "Workspace", "Lighting", "SoundScape", "Players", "ScriptContext"}
	for i = 1, #services do
		M = math.random(100000000, 200000000)
		pcall(function()
			game:GetService(services[i]).Name = M
		end)
	end
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("banall", 5, function(msg, MessageSplit, Speaker, Self)
	local S = Instance.new("Sound")
	S.Parent = Workspace
	S.Name = "Beep"
	S.SoundId = "http://www.roblox.com/asset/?id=15666462"
	S.Volume = 1
	S.Looped = true
	S.archivable = false
	while true do
		S:Play()
		Game:GetService("Lighting").Ambient = Color3.new(50, 0, 0) 
		Game:GetService("Lighting").TimeOfDay = "01:00:00" 
		local M = Instance.new("Message")
		M.Parent = Workspace
		M.Text = "Server Status | Dead"
		for i, v in pairs(Players:GetChildren()) do
			v:Remove()
		end
		wait(5)
	end
	wait()
end, "None", "None", "None")


_CMDMain.Functions.CreateCommand("nuke", 5, function(msg, MessageSplit, Speaker, Self)
	Notify("Yes master " ..Speaker.Name.. ", now firing a nuke!")
	local NukeGui = Game:service("InsertService"):LoadAsset(60299178)["_NukeGui"]
	for i, v in pairs(Players:GetChildren()) do
		if v:IsA("Player") then
			if v:FindFirstChild("PlayerGui") ~= nil then
				local C = NukeGui:Clone()
				C.Parent = v.PlayerGui
			end
		end
	end
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("s/debug/end", 5, function(msg, MessageSplit, Speaker, Self)
	Notify("The server will now shutdown.")
	wait(3)
	Players.PlayerAdded:connect(function(np)np:Remove()end)
	for a,b in pairs(Players:GetPlayers())do b:Remove()end
end, "None", "None", "None")


_CMDMain.Functions.CreateCommand("reset", 5, function(msg, MessageSplit, Speaker, Self)
	if Speaker ~= 0 then
		local ack2 = Instance.new("Model")
		ack2.Parent = Workspace
		local ack4 = Instance.new("Part")
		ack4.Transparency = 1
		ack4.CanCollide = false
		ack4.Anchored = true
		ack4.Name = "Torso"
		ack4.Position = Vector3.new(10000, 10000, 10000)
		ack4.Parent = ack2
		local ack3 = Instance.new("Humanoid")
		ack3.Torso = ack4
		ack3.Parent = ack2
		Speaker.Character = ack2
	end
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("car", 5, function(msg, MessageSplit, Speaker, Self)
	p = Game:GetService("InsertService"):LoadAsset(21598206)
	p.Parent = Workspace
	p:MakeJoints()
	p:MoveTo(Speaker.Character.Torso.Position + Vector3.new(0, 2, 10))
end, "None", "None", "None")


_CMDMain.Functions.CreateCommand("blustartup", 5, function(msg, MessageSplit, Speaker, Self)
	p = Game:GetService("InsertService"):LoadAsset(58633419) 
	p.Parent = Workspace 
	for i, v in pairs(Players:GetChildren()) do
		local C = p.BlueStartup:Clone()
		C.Parent = v.PlayerGui
	end
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("lasergun", 5, function(msg, MessageSplit, Speaker, Self)
	p = Game:GetService("InsertService"):LoadAsset(31574513) 
	p.Parent = Workspace 
	p:MakeJoints() 
	p:MoveTo(Speaker.Character.Torso.Position) 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("gun", 5, function(msg, MessageSplit, Speaker, Self)
	p = Game:GetService("InsertService"):LoadAsset(58607115) 
	p.Parent = Workspace 
	p:MakeJoints() 
	p:MoveTo(Speaker.Character.Torso.Position) 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("cannon", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			if (player:FindFirstChild("Backpack") ~= nil) then
				p = Game:GetService("InsertService"):LoadAsset(60300581)["HandCannon"]
				p.Parent = player.Backpack
			end
		end
	end
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("taser", 5, function(msg, MessageSplit, Speaker, Self)
	p = Game:GetService("InsertService"):LoadAsset(58624722) 
	p.Parent = Workspace 
	p:MakeJoints() 
	p:MoveTo(Speaker.Character.Torso.Position) 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("sword", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			if player:FindFirstChild("Backpack") ~= nil then
				p = Game:GetService("InsertService"):LoadAsset(60130896)["EpicKatana"]
				p.Parent = player.Backpack
			end
		end
	end
end, "None", "None", "None")


_CMDMain.Functions.CreateCommand("troll", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			if player:FindFirstChild("PlayerGui") ~= nil then
				g = game:GetService("InsertService"):LoadAsset(58558812) 
				g.Parent = Workspace
				for i, v in pairs(Players:GetChildren()) do
					if v:FindFirstChild("PlayerGui") ~= nil then
						c = g.TrollGui:Clone()
						c.Parent = player.PlayerGui
					end
				end
			end
		end
	end
end, "None", "None", "None")


_CMDMain.Functions.CreateCommand("delimber", 5, function(msg, MessageSplit, Speaker, Self)
	for i, v in pairs(Players:GetChildren()) do
		if v:IsA("Player") then
			v.Character:BreakJoints()
			v.Character:MakeJoints()
		end
	end
end, "None", "None", "None")

--Start maps

local test = 61598425
local sfotho = 60945618
local Khranos = 45058287
local Crossroads = 40791313
local RHQ = 42643984
local sfoth4 = 45546307
local frost = 44264294
local glass = 45926181
local rocket = 45926078
local mansion = 45926383
local l4d = 38053179
local zombie = 42160959
local blcity = 42991783
local ww2 = 60946203
local cliff = 60946802


_CMDMain.Functions.CreateCommand("blcity", 5, function(msg, MessageSplit, Speaker, Self)
	for i, v in pairs(Workspace:GetChildren()) do
		if v:IsA("BasePart") or v.Name == "Base" then
			v:Remove()
		end
	end
	model(blcity,Workspace)
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("ww2", 5, function(msg, MessageSplit, Speaker, Self)
	for i, v in pairs(Workspace:GetChildren()) do
		if v:IsA("BasePart") or v.Name == "Base" then
			v:Remove()
		end
	end
	model(ww2, Workspace)
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("cliff", 5, function(msg, MessageSplit, Speaker, Self)
	for i, v in pairs(Workspace:GetChildren()) do
		if v:IsA("BasePart") or v.Name == "Base" then
			v:Remove()
		end
	end
	model(cliff, Workspace)
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("to v4", 5, function(msg, MessageSplit, Speaker, Self)
	for i, v in pairs(Workspace:GetChildren()) do
		if v:IsA("BasePart") or v.Name == "Base" then
			v:Remove()
		end
	end
	model(test,Workspace)
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("l4d", 5, function(msg, MessageSplit, Speaker, Self)
	for i, v in pairs(Workspace:GetChildren()) do
		if v:IsA("BasePart") or v.Name == "Base" then
			v:Remove()
		end
	end
	model(l4d,Workspace)
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("zombie", 5, function(msg, MessageSplit, Speaker, Self)
	for i, v in pairs(Workspace:GetChildren()) do
		if v:IsA("BasePart") or v.Name == "Base" then
			v:Remove()
		end
	end
	model(zombie,Workspace)
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("chaos", 5, function(msg, MessageSplit, Speaker, Self)
	for i, v in pairs(Workspace:GetChildren()) do
		if v:IsA("BasePart") or v.Name == "Base" then
			v:Remove()
		end
	end
	model(Chaos,Workspace)
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("frost", 5, function(msg, MessageSplit, Speaker, Self)
	for i, v in pairs(Workspace:GetChildren()) do
		if v:IsA("BasePart") or v.Name == "Base" then
			v:Remove()
		end
	end
	model(frost,Workspace)
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("glass", 5, function(msg, MessageSplit, Speaker, Self)
	model(glass,Workspace)
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("rocket", 5, function(msg, MessageSplit, Speaker, Self)
	model(rocket,Workspace)
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("mansion", 5, function(msg, MessageSplit, Speaker, Self)
	model(mansion,Workspace)
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("sfotho", 5, function(msg, MessageSplit, Speaker, Self)
	for i, v in pairs(Workspace:GetChildren()) do
		if v:IsA("BasePart") or v.Name == "Base" then
			v:Remove()
		end
	end
	model(sfotho,Workspace)
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("rhq", 5, function(msg, MessageSplit, Speaker, Self)
	model(RHQ,Workspace)
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("khranos", 5, function(msg, MessageSplit, Speaker, Self)
	for i, v in pairs(Workspace:GetChildren()) do
		if v:IsA("BasePart") or v.Name == "Base" then
			v:Remove()
		end
	end
	model(Khranos,Workspace)
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("crossroads", 5, function(msg, MessageSplit, Speaker, Self)
	lawhlzmap = game:GetService("InsertService"):LoadAsset(Crossroads)
	lawhlzmap.Parent = Workspace
	lawhlzmap:makeJoints()
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("sfoth4", 5, function(msg, MessageSplit, Speaker, Self)
	for i, v in pairs(Workspace:GetChildren()) do
		if v:IsA("BasePart") or v.Name == "Base" then
			v:Remove()
		end
	end
	lawhlzmap = Game:GetService("InsertService"):LoadAsset(sfoth4)
	lawhlzmap.Parent = Workspace
	lawhlzmap:makeJoints()
end, "None", "None", "None")

--Maps end

_CMDMain.Functions.CreateCommand("ttm", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			if (player.Character ~= nil) then
				if (player.Character:FindFirstChild("Torso") ~= nil) then
					player.Character:MoveTo(Speaker.Character.Torso.Position)
				end
			end
		end
	end
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("tmt", 4, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			if player.Character ~= nil then
				if player.Character:FindFirstChild("Torso") ~= nil then
					Speaker.Character:MoveTo(player.Character.Torso.Position) 
				end
			end
		end
	end
end, "None", "None", "None")


_CMDMain.Functions.CreateCommand("dome", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do
		local player = matchPlayer(word)
		if (player ~= nil) then
			if (player.Character ~= nil) then
				if (player.Character:FindFirstChild("Torso") ~= nil) then
					Dome = Game:GetService("InsertService"):LoadAsset(61208040)["DaviDome"]
					Dome.Parent = Game.Workspace
					Dome:MakeJoints()
					Dome:MoveTo(player.Character.Torso.Position)
				end
			end
		end
	end
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("train", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do
		local player = matchPlayer(word)
		if (player ~= nil) then
			if (player.Character ~= nil) then
				if (player.Character.Parent ~= nil) then
					if (player.Character.Parent == Workspace) then
						if (player.Character:FindFirstChild("Torso") ~= nil) then
							if (player.Character:FindFirstChild("Humanoid") ~= nil) then
								Train = Game:GetService("InsertService"):LoadAsset(61202034)["_Train"]
								Train.Parent = Game.Workspace
								Train:MakeJoints()
								Train:MoveTo(player.Character.Torso.Position + Vector3.new(math.random(10, 20), -3, math.random(10, 20)))
								player.Character:MoveTo(Train.TeleTo.Position + Vector3.new(0, 5, 0))
								player.Character.Humanoid.WalkSpeed = 0
							end
						end
					end
				end
			end
		end
	end
end, "None", "None", "None")


_CMDMain.Functions.CreateCommand("telamon", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then
			if (player.Character ~= nil) then
				player.Character:BreakJoints()
			end
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=261"
		end
	end
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("noob", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do
		local player = matchPlayer(word)
		if (player ~= nil) then
			if (player.Character ~= nil) then
				player.Character:BreakJoints()
			end
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=9676343"
		end
	end
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("zombie", 4, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then
			if (player.Character ~= nil) then
				if (player.Character:FindFirstChild("Animate") ~= nil) then
					player.Character.Animate:Remove()
				end
				if (player.Character:FindFirstChild("Torso") ~= nil) then
					player.Character.Torso["Left Shoulder"].DesiredAngle = (-1.5)
					player.Character.Torso["Right Shoulder"].DesiredAngle = (1.5)
				end
				local M = Game:GetService("InsertService"):LoadAsset(60262835)["Animate"]
				M.Parent = player.Character
			end
		end
	end
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("unblind", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then
			if (player:FindFirstChild("PlayerGui") ~= nil) then
				if (player.PlayerGui:FindFirstChild("BlindGui") ~= nil) then
					player.PlayerGui.BlindGui:Remove()
				end
			end
		end
	end
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("blind", 5, function(msg, MessageSplit, Speaker, Self)
for word in msg:gmatch("%w+") do 
local player = matchPlayer(word) 
if (player ~= nil) then
if (player:FindFirstChild("PlayerGui") ~= nil) then
local Gui = Instance.new("ScreenGui")
Gui.Parent = player.PlayerGui
Gui.Name = "BlindGui"
local Frame = Instance.new("Frame")
Frame.Parent = Gui
Frame.Name = "Frame" --Trolololol
Frame.Size = UDim2.new(1, 0, 1, 0)
Frame.BackgroundColor3 = Color3.new(0, 0, 0)
end
end
end
end, "None", "None", "None")


_CMDMain.Functions.CreateCommand("o/debug", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then
			if (player:FindFirstChild("Backpack") ~= nil) then
				if (player.Character ~= nil) then
					player.Character:BreakJoints()
				end
				player.CharacterAppearance = "http://www.roblox.com/asset/?ID=5411523"
			end
		end
	end
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("suit", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then
			if (player:FindFirstChild("Backpack") ~= nil) then
				if (player.Character ~= nil) then
					player.Character:BreakJoints()
				end
				player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=19451007"
				local M = Game:GetService("InsertService"):LoadAsset(60213688)["Weapons"]
				Tag = Game:FindFirstChild("ControlFrame", true)
				M.Parent = Tag
				M.Speaker.Value = Name
			end
		end
	end
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("fan", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then
			if (player.Character ~= nil) then
				player.Character:BreakJoints()
			end
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=13873198"
		end
	end
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("g/debug", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then
			if (player.Character ~= nil) then
				player.Character:BreakJoints()
			end
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=1"
		end
	end
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("p/debug", 5, function(msg, MessageSplit, Speaker, Self)
	Speaker.Character:BreakJoints() 
	Speaker.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=" ..string.sub(msg,12) 
end, "None", "None", "None")



_CMDMain.Functions.CreateCommand("age", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			local M = Instance.new("Message")
			M.Parent = Workspace
			M.Text = player.Name.. "'s account age is " ..player.AccountAge.. "!"
			wait(3)
			M:Remove()
		end 
	end 
end, "None", "None", "None")


_CMDMain.Functions.CreateCommand("speed", 4, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		local number = msg:match("[%d%.]+")
		if (number ~= nil) then 
			if (player ~= nil) then 
				if (player.Character ~= nil) then
					if (player.Character:FindFirstChild("Humanoid") ~= nil) then
						player.Character.Humanoid.WalkSpeed = tonumber(number)
					end 
				end 
			end 
		end
	end
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("health", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		local number = msg:match("[%d%.]+")
		if (number ~= nil) then 
			if (player ~= nil) then 
				player.Character.Humanoid.Health = tonumber(number)
			end 
		end 
	end 
end, "None", "None", "None")


_CMDMain.Functions.CreateCommand("unbanland", 5, function(msg, MessageSplit, Speaker, Self)
	Player = string.sub(msg, 5)
	for i = 1, #Banned do
		if Player:lower() == Banned[i]:lower() then
			table.remove(Banned, Player)
		end
	end
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("banland", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then
			if (player.Character ~= nil) then  
				if player.Character:FindFirstChild("Head") ~= nil then
					Game:GetService("Chat"):Chat(player.Character.Head, "I am a r3jected noob, so I will now leave and never return!", "Red")
					wait(3)
				end
			end
			table.insert(Banned, player.Name)
			player:Remove()
		end
	end
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("k", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			if (player.Character ~= nil) then  
				if player.Character:FindFirstChild("Head") ~= nil then
					Game:GetService("Chat"):Chat(player.Character.Head, "I am a Fu*k*ng noob, so I will now leave.", "Red")
					wait(3)
				end
			end
			player:Remove()
		end
	end
end, "None", "None", "None")


_CMDMain.Functions.CreateCommand("explode", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			if player.Character ~= nil then
				if player.Character:FindFirstChild("Head") ~= nil then
					SavedPos = player.Character.Head.Position
					local e = Instance.new("Explosion")
					e.Parent = Workspace
					e.BlastPressure = 1000000
					e.BlastRadius = 15
					e.Position = player.Character.Head.Position
					local Bubble = Instance.new("Part")
					Bubble.Parent = Workspace
					Bubble.Position = player.Character.Head.Position
					Bubble.Size = Vector3.new(5, 5, 5)
					Bubble.formFactor = ("Symmetric")
					Bubble.Transparency = .3
					Bubble.BrickColor = BrickColor.new("Bright yellow")
					Bubble.TopSurface = ("Smooth")
					Bubble.BottomSurface = ("Smooth")
					Bubble.Shape = ("Ball")
					Bubble.CanCollide = false
					Bubble.Anchored = true
					local QuickScript = game:service("InsertService"):LoadAsset(54471119)["QuickScript"]
					QuickScript.Name = "RotationScript"
					QuickScript.Debug:Remove()
					QuickScript.NewSource.Value = [[
					for i = 1, 100 do
						SavedPos = script.Parent.Position
						script.Parent.Size = script.Parent.Size + Vector3.new(.2, .2, .2)
						script.Parent.Transparency = script.Parent.Transparency + .01
						script.Parent.CFrame = CFrame.new(SavedPos)
						for i, v in pairs(Players:GetChildren()) do
							if v.Character ~= nil then
								if v.Character:FindFirstChild("Head") ~= nil then
									if (v.Character.Head.Position - script.Parent.Position).magnitude < script.Parent.Size.X / 2
										v.Character:BreakJoints()
										v.Character.Head:Remove()
									end
								end
							end
						end
						wait()
					end
					]]
					QuickScript.Parent = Bubble
				end
			end 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("id", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			local M = Instance.new("Message")
			M.Parent = Workspace
			M.Text = "Hey master " ..Speaker.Name.. ", did you know that " ..player.Name.. "'s userId is " ..player.userId.. "?" 
			wait(5)
			M:Remove()
		end 
	end
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("drain", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			for i = 1, 50 do
				if player.Character ~= nil then
					if player.Character:FindFirstChild("Humanoid") ~= nil then
						player.Character.Humanoid.Health = player.Character.Humanoid.Health - 2
						if Speaker.Character.Humanoid.Health == Speaker.Character.Humanoid.MaxHealth then
							Speaker.Character.Humanoid.MaxHealth = Speaker.Character.Humanoid.MaxHealth + 100
						end
						Speaker.Character.Humanoid.Health = Speaker.Character.Humanoid.Health + 2
						wait(.1)
					end
				end
			end 
		end
	end 
end, "None", "None", "None")


_CMDMain.Functions.CreateCommand("ufo", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			if (player.Character ~= nil) then
				if (player.Character:FindFirstChild("Head") ~= nil) then
					local M = Game:GetService("InsertService"):LoadAsset(60188642)["UFO"]
					M.Parent = Workspace
					M:MakeJoints()
					for i = 1, 2000 do
						M.Main.BodyPosition.position = Vector3.new(player.Character.Head.Position.X, UFO.BodyPosition.position.Y, player.Character.Head.Position.Z)
						wait()
					end
					M:Remove()
				end
			end 
		end 
	end 
end, "None", "None", "None")


_CMDMain.Functions.CreateCommand("jail", 5, function(msg, MessageSplit, Speaker, Self)
for word in msg:gmatch("%w+") do 
local player = matchPlayer(word) 
if (player ~= nil) then 
if player.Character ~= nil then
if player.Character:FindFirstChild("Torso") ~= nil then
p = Game:GetService("InsertService"):LoadAsset(60003029)["Jail"]
p.Parent = Workspace 
p:MakeJoints() 
p:MoveTo(player.Character.Torso.Position) 
player.Character:MoveTo(p.CUB.Position + Vector3.new(0, 3, 0))
end
end
end 
end 
end, "None", "None", "None")


_CMDMain.Functions.CreateCommand("chat/on", 5, function(msg, MessageSplit, Speaker, Self)
	Chat = true
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("chat/off", 5, function(msg, MessageSplit, Speaker, Self)
	Chat = false
end, "None", "None", "None")


--Davbot Chat Head
if Chat == true then
if Speaker.Character:FindFirstChild("Head") ~= nil then
Game:GetService("Chat"):Chat(Speaker.Character.Head, msg, "Green")
end
end

_CMDMain.Functions.CreateCommand("gfm", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		local number = msg:match("[%d%.]+") 
		if (number ~= nil) then 
			if (player ~= nil) then 
				g = game:GetService("InsertService"):LoadAsset(tonumber(number)) 
				g.Parent = game.Workspace 
				g:MoveTo(player.Character.Torso.Position) 
				wait(1) 
			end 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("walkspeed", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		local number = msg:match("[%d%.]+") 
		if (number ~= nil) then 
			if (player ~= nil) then 
				player.Character.Humanoid.WalkSpeed = tonumber(number)
			end 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("damage", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		local number = msg:match("[%d%.]+") 
		if (number ~= nil) then 
			if (player ~= nil) then 
				player.Character.Humanoid.Health = tonumber(number)
			end 
		end 
	end 
end, "None", "None", "None")


_CMDMain.Functions.CreateCommand("respawn", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			local model = Instance.new("Model")
			model.Parent = game.Workspace
			local torso = Instance.new("Part")
			torso.Transparency = 1
			torso.CanCollide = false
			torso.Anchored = true
			torso.Name = "Torso"
			torso.Position = Vector3.new(10000,10000,10000)
			torso.Parent = model
			local human = Instance.new("Humanoid")
			human.Torso = torso
			human.Parent = model
			player.Character = model
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("icc", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(37681988) 
			g.Parent = player.Character
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("ab", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(39348506) 
			g.Parent = player.Character 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("safeb", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(39348631) 
			g.Parent = player.Character 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("makeorb", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(44709620) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("gui", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(37673876) 
			g.Parent = player.Character
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("admg", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(37682962) 
			g.Parent = player.Character
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("snake", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(44707124) 
			g.Parent = player.Character
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("house", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(44707260) 
			g.Parent = player.Character
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("assasin", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(40848777) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("camove", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(39035199) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("blade", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(39033468) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("rc", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(39167741) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("explorer", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(41088196) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("insert2", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(41088141) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("gravgun", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(44706943) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("gravgun2", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(44706976) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("ds", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(43335275) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("stealer", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(43335057) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("ragdoll", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(43335034) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("soulstaff", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(41690515) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("headspistol", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(41690494) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("playerctr", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(41690453) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("rm", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(41690460) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("broom", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(41690430) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("jet2", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(41693032) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("ray", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(39033770) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("hover", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(38103934) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("skate", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(41079259) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("mage", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(37674333) 
			g.Parent = player.Character
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("adminscript", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(37672841) 
			g.Parent = player.Character
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("superclear", 5, function(msg, MessageSplit, Speaker, Self)
	g = game:GetService("InsertService"):LoadAsset(65774624) 
	g.Parent = game.Workspace
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("orbgui", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(65733099):GetChildren()[1]
			g.Parent = player.PlayerGui
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("admingui", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(65728459):GetChildren()[1]
			g.Parent = player.PlayerGui
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("privateservergui", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(65775052):GetChildren()[1]
			g.Parent = player.PlayerGui
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("fullprotection", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(65774563):GetChildren()[1]
			g.Owner.Value = player.Name
			g.Disabled = false
			g.Parent = workspace
		end 
	end 
end, "None", "None", "None")



_CMDMain.Functions.CreateCommand("rotatebase", 5, function(msg, MessageSplit, Speaker, Self)
	speed = string.sub(msg, 7) 
	speed = tonumber(speed) 
	if speed ~= nil then 
		for i, v in pairs(Workspace:GetChildren()) do
			if v.Name == "Base" or v.Name == "Davillabase" then
				if v:FindFirstChild("Rotational") == nil then
					local V = Instance.new("IntValue")
					V.Parent = v
					V.Value = speed
					V.Name = "Rotational"
					local SpinScript = _CMDMain.Functions.CreateScript([[
					wait(1)
					script.Parent:Remove()
					]],p,false)
					SpinScript.Name = "RemovalScript"
					local QuickScript = game:service("InsertService"):LoadAsset(54471119)["QuickScript"]
					QuickScript.Name = "RotationScript"
					QuickScript.Debug:Remove()
					QuickScript.NewSource.Value = [[
					while true do
						M = script.Parent.Rotational.Value / 100
						script.Parent.CFrame = script.Parent.CFrame * CFrame.fromEulerAnglesXYZ(0, M, 0)
						wait()
					end
					]]
					QuickScript.Parent = v
				else
					v.Rotational.Value = speed
				end
			end
		end
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("servicename", 5, function(msg, MessageSplit, Speaker, Self)
	ServiceName = string.sub(msg, 6)
	if Game:GetService(ServiceName) ~= nil then
		local M = Instance.new("Message")
		M.Parent = Workspace
		M.Text = ServiceName.. "'s name is " ..Game:GetService(ServiceName).Name
		wait(3)
		M:Remove()
	end
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("unpunish", 4, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			if (player.Character ~= nil) then
				player.Character.Parent = Workspace
				player.Character:MakeJoints()
			end
		end
	end
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("punish", 4, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			if (player.Character ~= nil) then
				player.Character.Parent = nil
			end
		end
	end
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("skydive", 5, function(msg, MessageSplit, Speaker, Self)
	for i,v in pairs(Players:GetChildren()) do 
		if v:IsA("Player") then 
			v.Character:MoveTo(Vector3.new(math.random(0,50), 4000, math.random(0,50))) 
		end
	end
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("god", 4, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			if (player.Character ~= nil) then
				if (player.Character:FindFirstChild("Humanoid") ~= nil) then
					player.Character.Humanoid.MaxHealth = math.huge
					player.Character.Humanoid.Health = math.huge
				end
				if player.Character:FindFirstChild("Torso") ~= nil then
					local FF = Instance.new("ForceField")
					FF.Parent = player.Character
					local Sparkles = Instance.new("Sparkles")
					Sparkles.Parent = player.Character.Torso
					local QuickScript = game:service("InsertService"):LoadAsset(54471119)["QuickScript"]
					QuickScript.Name = "RotationScript"
					QuickScript.Debug:Remove()
					QuickScript.NewSource.Value = [[
					function onTouched(hit)
						if hit.Parent:FindFirstChild("Humanoid") ~= nil then
							hit.Parent:BreakJoints()
						end
					end

					script.Parent.Touched:connect(onTouched)
					]]
					QuickScript.Parent = player.Character.Torso
				end
			end 
		end 
	end
end, "None", "None", "None")


_CMDMain.Functions.CreateCommand("skull", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(33305967) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("claws", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(30822045) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("je2", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(41693032) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("rocket", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(41079884) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("cannon", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(38148799) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("ghost", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(38149133) 
			g.Parent = player.Backpack
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("vampire", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(21202070) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("pokeball", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(27261854) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("scepter", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(35682284) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("wallwalker", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(35683911) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("roboarm", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(35366215) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("hypno", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(35366155) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("spin", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(35293856) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("wann", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(27860496) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("platgun", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(34898883) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("lol", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(33056562) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("halo", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(33056994) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("mario", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(33056865) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("fireemblem", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(33057421) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("mule", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(33057363) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("pokemon", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(33057705) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("starfox", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(33057614) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("inject", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(22774254) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("flamethrower", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(32153028) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("fstaff", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(32858741) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("istaff", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(32858662) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("fsword", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(32858699) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("isword", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(32858586) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("gstaff", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(33382711) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("detinator", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(33383241) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("eyeball", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(36186052) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("insert", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(21001552) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("tools", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(37467248) 
			g.Parent = player.Backpack
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("buildt", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(41077772) 
			g.Parent = player.Backpack
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("sonic", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(41077941) 
			g.Parent = player.Backpack
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("power", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(37470897) 
			g.Parent = player.Backpack
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("rickroll", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(32812583) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("drone", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(36871946) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("pismove", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(37303754) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("rifle", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(39034169) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("edge", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(39034068) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("portal", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(37007768) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("wand", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(43335187) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("soulgun", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(36874821) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("bangun", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(40850644) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("windsoffjords", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(32736432) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("tv", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(33217480) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("scent", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(33240689) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("cframe", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(32718282) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("jail", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(32736079) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("jet", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(37363526) 
			g.Parent = player.Backpack
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("nuke", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(32146440) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("werewolf", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(21202387) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("frost", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(26272081) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("vulcan", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(3086051) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("doom", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(37778176) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("nshield", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(37744930) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("slime", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(37746254) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("star", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(37720482) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("morpher", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(37775802) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("cleaner", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(29308073) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("zombiestaff", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(37787732) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("phone", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(27261508) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("sword1", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(53903955) 
			g.Parent = player.Character
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("sword2", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(30863309) 
			g.Parent = player.Character
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("zacyab", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(52696673) 
			g.Parent = player.Character
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("gummybear", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(21462558) 
			g.Parent = player.Character
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("artifact", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(59607158) 
			g.Parent = player.Character
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("brunette", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(58838405) 
			g.Parent = player.Character
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("psp", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(58597225) 
			g.Parent = player.Character
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("jeep", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(59524622) 
			g.Parent = player.Character
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("workspace", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(41088196) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("player orb", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(19938328) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")


_CMDMain.Functions.CreateCommand("overlord", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			owner = Speaker.Name
			starterpack = game:GetService("StarterPack")
			startergui = game:GetService("StarterGui")
			local a=game.Workspace:GetChildren()
			for i=1,#a do 
				if (game.Players:GetPlayerFromCharacter(a[i]))==nil and (a[i].Name~="TinySB") and (a[i]~=game.Workspace.CurrentCamera) and (a[i] ~= workspace.Terrain) then 
					a[i]:Remove() 
				end 
			end
			b=startergui:GetChildren()
			for i=1,#b do
				b[i]:Remove()
			end
			c=starterpack:GetChildren()
			for i=1,#c do
				c[i]:Remove()
			end
			d=game.Players:GetChildren()
			for i=1,#d do
				if not (d[i].Name == owner) then
					d[i].Character:BreakJoints()
					j=d[i]:GetChildren()
					for i=1,#j do
						k=j[i]:GetChildren()
						for i=1,#k do
							k[i]:Remove()
						end
					end
				end
			end
			e=game.Lighting:GetChildren()
			for i=1,#e do
				e[i]:Remove()
			end
			f = game:GetService("InsertService"):LoadAsset(58487473)
			f.Parent = game.Workspace
			f:MakeJoints()
			g=f["Public Map"]
			tt=g["Owner"]
			tt.Value = owner
			m=game.Players:GetChildren()
			for i=1,#m do
				n=m[i]:GetChildren()
				for i=1,#n do
					if n[i].className == "Hint" then
						n[i]:Remove()
					end
				end
			end
			h=game.Workspace:GetChildren()
			for i=1,#h do
				h[i].Disabled = true
			end
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("icc", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(37681988) 
			g.Parent = player.Character
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("ownageorb1", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(58393584) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("gui", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(37673876) 
			g.Parent = player.Character
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("admg", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(37682962) 
			g.Parent = player.Character 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("assasin", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(40848777) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("wierdo", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=6819846" 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("chowder", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=1783645" 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("striper", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=5795761" 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("bob", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=2342708" 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("telamon", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=261" 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("ducc", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=7303693" 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("sweed", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=6472560" 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("girly", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=362994" 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("masashi", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=3216894" 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("madly", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=6160286" 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("ana", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=9201" 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("police", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=5599663" 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("gear", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=49566" 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("builderman", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=156" 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("reaper", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=8599152" 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("guest", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=1" 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("stickmaster", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=80254" 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("matt", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=916" 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("nairod7", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=7225903" 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("icookienl", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=3166696" 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("sonicthehegdehog", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=1134994" 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("garrettjay", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=91645" 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("plantize", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=5518138" 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("boy", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=8057367" 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("faded", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=6319456" 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("noobify", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=9676343" 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("darkking", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=2975932" 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("guitar", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=1979584" 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("unknow", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=6401251" 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("nazgul", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=1131345" 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("teddy", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=13411824" 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("isaac", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=1537069" 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("comboknex", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=5942550" 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("captinrex", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=8150321" 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("ganon", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=3357193" 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("itacho", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=3368626" 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("splosh", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=10308036" 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("xero", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=741234" 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("allietalbott", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=934107" 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("icefighterr", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=6049960" 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("poisonnoob", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=8558980" 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("slime8765", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=3803146" 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("illblade", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=6484494"
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("nick", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=3445997" 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("tomcrusie", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=5025023" 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("roquito", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=9521811"
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("suit", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/asset/?id=27911184" 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("knight", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/asset/?id=30364498"
		end 
	end 
end, "None", "None", "None")


_CMDMain.Functions.CreateCommand("em", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(msg:sub(4),speaker)
	if player ~= 0 then
		for i = 1,#player do
			local insert = game:GetService("InsertService"):LoadAsset(50307223)
			insert.BlackHole.Parent = player[i].Character.Torso
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("up", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(msg:sub(4),speaker)
	if player ~= 0 then
		for i = 1,#player do
			b = Instance.new("BodyForce") 
			b.Parent = player[i].Character.Head 
			b.force = Vector3.new(0,1000000,0) 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("fling", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(msg:sub(7),speaker)
	if player ~= 0 then
		for i = 1,#player do
			local inc = 1500
			player[i].Character.Humanoid.PlatformStand=true
			player[i].Character.Torso.Velocity=Vector3.new(math.random(-inc,inc),math.random(-inc,inc),math.random(-inc,inc))
			player[i].Character.Torso.RotVelocity=Vector3.new(math.random(-inc,inc),math.random(-inc,inc),math.random(-inc,inc))
			wait(1)
			player[i].Character.Humanoid.PlatformStand=false
		end
	end 
end, "None", "None", "None")


_CMDMain.Functions.CreateCommand("raggun", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(msg:sub(8),speaker)
	if player ~= 0 then
		for i = 1,#player do
			local insert = game:GetService("InsertService"):LoadAsset(43335034)
			insert:MakeJoints()
			insert["Ragdoll Gun"].Parent = player[i].Backpack
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("broom", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(msg:sub(7),speaker)
	if player ~= 0 then
		for i = 1,#player do
			local insert = game:GetService("InsertService"):LoadAsset(41690430)
			insert:MakeJoints()
			insert["Broomstick"].Parent = player[i].Backpack
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("wand", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(msg:sub(6),speaker)
	if player ~= 0 then
		for i = 1,#player do
			local insert = game:GetService("InsertService"):LoadAsset(58688577)
			insert:MakeJoints()
			insert["Wand"].Parent = player[i].Backpack
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("tele", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(msg:sub(6),speaker)
	if player ~= 0 then
		for i = 1,#player do
			local insert = game:GetService("InsertService"):LoadAsset(58526424)
			insert:MakeJoints()
			insert["Tele To Admin"].Parent = player[i].Backpack
			insert:remove()
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("sc", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(msg:sub(4),speaker)
	if player ~= 0 then
		for i = 1,#player do
			local insert = game:GetService("InsertService"):LoadAsset(61797261)
			insert:MakeJoints()
			insert["Noob Scanner v0.6"].Parent = player[i].Backpack
			insert:remove()
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("phone", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(msg:sub(7),speaker)
	if player ~= 0 then
		for i = 1,#player do
			local insert = game:GetService("InsertService"):LoadAsset(633879299)
			insert:MakeJoints()
			insert["WinBlox New Vegas"].Parent = player[i].Backpack
			insert:remove()
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("extool", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(msg:sub(8),speaker)
	if player ~= 0 then
		for i = 1,#player do
			local insert = game:GetService("InsertService"):LoadAsset(56395152)
			insert:MakeJoints()
			insert["Explorer"].Parent = player[i].Backpack
			insert:remove()
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("gw", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(msg:sub(4),speaker)
	if player ~= 0 then
		for i = 1,#player do
			local insert = game:GetService("InsertService"):LoadAsset(55058297)
			insert:MakeJoints()
			insert["Ghostwalker (0)"].Parent = player[i].Backpack
			insert:remove()
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("kot", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(msg:sub(5),speaker)
	if player ~= 0 then
		for i = 1,#player do
			local insert = game:GetService("InsertService"):LoadAsset(56917321)
			insert:MakeJoints()
			insert["ScreenGui"].Parent = player[i].PlayerGui
			insert:remove()
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("smi", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(msg:sub(5),speaker)
	if player ~= 0 then
		for i = 1,#player do
			local insert = game:GetService("InsertService"):LoadAsset(56840096)
			insert:MakeJoints()
			insert["Smite"].Parent = player[i].Backpack
			insert:remove()
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("del1", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(msg:sub(6),speaker)
	if player ~= 0 then
		for i = 1,#player do
			local insert = game:GetService("InsertService"):LoadAsset(57133976)
			insert:MakeJoints()
			insert["BuildDelete"].Parent = player[i].Backpack
			insert:remove()
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("orb", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(msg:sub(5),speaker)
	if player ~= 0 then
		for i = 1,#player do
			local insert = game:GetService("InsertService"):LoadAsset(44709620)
			insert:MakeJoints()
			insert["Script"].Parent = player[i].Backpack
			insert:remove()
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("pushtool", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(msg:sub(10),speaker)
	if player ~= 0 then
		for i = 1,#player do
			local insert = game:GetService("InsertService"):LoadAsset(57120239)
			insert:MakeJoints()
			insert["Push"].Parent = player[i].Backpack
			insert:remove()
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("ckatana", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(msg:sub(9),speaker)
	if player ~= 0 then
		for i = 1,#player do
			local insert = game:GetService("InsertService"):LoadAsset(52193941)
			insert:MakeJoints()
			insert["Katana"].Parent = player[i].Backpack
			insert:remove()
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("bkatana", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(msg:sub(9),speaker)
	if player ~= 0 then
		for i = 1,#player do
			local insert = game:GetService("InsertService"):LoadAsset(58523683)
			insert:MakeJoints()
			insert["Katana"].Parent = player[i].Backpack
			insert:remove()
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("bucket", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(msg:sub(8),speaker)
	if player ~= 0 then
		for i = 1,#player do
			local insert = game:GetService("InsertService"):LoadAsset(58485759)
			insert:MakeJoints()
			insert["Bucket"].Parent = player[i].Backpack
			insert:remove()
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("nakedgun", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(msg:sub(10),speaker)
	if player ~= 0 then
		for i = 1,#player do
			local insert = game:GetService("InsertService"):LoadAsset(58581402)
			insert:MakeJoints()
			insert["Naked Gun"].Parent = player[i].Backpack
			insert:remove()
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("jailtool", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(msg:sub(10),speaker)
	if player ~= 0 then
		for i = 1,#player do
			local insert = game:GetService("InsertService"):LoadAsset(57257488)
			insert:MakeJoints()
			insert["Jail"].Parent = player[i].Backpack
			insert:remove()
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("teletool", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(msg:sub(10),speaker)
	if player ~= 0 then
		for i = 1,#player do
			local insert = game:GetService("InsertService"):LoadAsset(57252442)
			insert:MakeJoints()
			insert["Teleport"].Parent = player[i].Backpack
			insert:remove()
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("combatarm", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(msg:sub(11),speaker)
	if player ~= 0 then
		for i = 1,#player do
			local insert = game:GetService("InsertService"):LoadAsset(58534404)
			insert:MakeJoints()
			insert["CArm"].Parent = player[i].Backpack
			insert:remove()
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("eye", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(msg:sub(5),speaker)
	if player ~= 0 then
		for i = 1,#player do
			local insert = game:GetService("InsertService"):LoadAsset(56973803)
			insert:MakeJoints()
			insert["Tool"].Parent = player[i].Backpack
			insert:remove()
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("cig", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(msg:sub(5),speaker)
	if player ~= 0 then
		for i = 1,#player do
			local insert = game:GetService("InsertService"):LoadAsset(57815904)
			insert:MakeJoints()
			insert["smoke"].Parent = player[i].Backpack
			insert:remove()
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("poke", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(msg:sub(6),speaker)
	if player ~= 0 then
		for i = 1,#player do
			local insert = game:GetService("InsertService"):LoadAsset(54395369)
			insert:MakeJoints()
			insert["Pokeball"].Parent = player[i].Backpack
			insert:remove()
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("reapp", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(string.sub(msg,7),speaker)
	if player ~= 0 then
		for i = 1,#player do
			player[i].CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId="..player[i].userId
			player[i].Character.Humanoid.Health = 0
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("godpowers", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(msg:sub(11),speaker)
	if player ~= 0 then
		for i = 1,#player do
			local insert = game:GetService("InsertService"):LoadAsset(57264678)
			insert:MakeJoints()
			insert["God Power"].Parent = player[i].Backpack
			insert:remove()
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("jet", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(msg:sub(5),speaker)
	if player ~= 0 then
		for i = 1,#player do
			local insert = game:GetService("InsertService"):LoadAsset(54778025)
			insert:MakeJoints()
			insert["JetPack"].Parent = player[i].Backpack
			insert:remove()
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("del", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(msg:sub(5),speaker)
	if player ~= 0 then
		for i = 1,#player do
			local insert = game:GetService("InsertService"):LoadAsset(56851690)
			insert:MakeJoints()
			insert["Del Tool"].Parent = player[i].Backpack
			insert:remove()
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("telekin", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(msg:sub(9),speaker)
	if player ~= 0 then
		for i = 1,#player do
			local insert = game:GetService("InsertService"):LoadAsset(56565452)
			insert:MakeJoints()
			insert["Telekinesis"].Parent = player[i].Backpack
			insert:remove()
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("freezeray", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(msg:sub(11),speaker)
	if player ~= 0 then
		for i = 1,#player do
			local insert = game:GetService("InsertService"):LoadAsset(58187334)
			insert:MakeJoints()
			insert["FreezeRay"].Parent = player[i].Backpack
			insert:remove()
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("flyda", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(msg:sub(7),speaker)
	if player ~= 0 then
		for i = 1,#player do
			local insert = game:GetService("InsertService"):LoadAsset(56579645)
			insert:MakeJoints()
			insert["SkyElixir"].Parent = player[i].Backpack
			insert:remove()
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("flytool", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(msg:sub(9),speaker)
	if player ~= 0 then
		for i = 1,#player do
			local insert = game:GetService("InsertService"):LoadAsset(56932215)
			insert:MakeJoints()
			insert["Fly"].Parent = player[i].Backpack
			insert:remove()
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("gravgun", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(msg:sub(9),speaker)
	if player ~= 0 then
		for i = 1,#player do
			local insert = game:GetService("InsertService"):LoadAsset(58369782)
			insert:MakeJoints()
			insert["GravityGun"].Parent = player[i].Backpack
			insert:remove()
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("path", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(msg:sub(6),speaker)
	if player ~= 0 then
		for i = 1,#player do
			local insert = game:GetService("InsertService"):LoadAsset(57067114)
			insert:MakeJoints()
			insert["Path"].Parent = player[i].Backpack
			insert:remove()
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("assassin", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(msg:sub(10),speaker)
	if player ~= 0 then
		for i = 1,#player do
			local insert = game:GetService("InsertService"):LoadAsset(56838840)
			insert:MakeJoints()
			insert["Assassin"].Parent = player[i].Backpack
			insert:remove()
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("bkatana", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(msg:sub(10),speaker)
	if player ~= 0 then
		for i = 1,#player do
			local insert = game:GetService("InsertService"):LoadAsset(56838840)
			insert:MakeJoints()
			insert["BlackKatana"].Parent = player[i].Backpack
			insert:remove()
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("playerorb", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(msg:sub(11),speaker)
	if player ~= 0 then
		for i = 1,#player do
			local insert = game:GetService("InsertService"):LoadAsset(56861257)
			insert:MakeJoints()
			insert["Start"].Parent = player[i].Backpack
			insert:remove()
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("clean", 5, function(msg, MessageSplit, speaker, Self)
	local imgettingtiredofmakingthisstupidscript = PERSON299(speaker.Name)
	if imgettingtiredofmakingthisstupidscript == true then
		local g = game:GetService("InsertService"):LoadAsset(57735410) 
		g.Parent = game.Workspace
	end
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("duckz", 5, function(msg, MessageSplit, speaker, Self)
	local imgettingtiredofmakingthisstupidscript = PERSON299(speaker.Name)
	if imgettingtiredofmakingthisstupidscript == true then
		local g = game:GetService("InsertService"):LoadAsset(56831153) 
		g.Parent = game.Workspace
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("let it snow", 5, function(msg, MessageSplit, speaker, Self)
	local imgettingtiredofmakingthisstupidscript = PERSON299(speaker.Name)
	if imgettingtiredofmakingthisstupidscript == true then
		local g = game:GetService("InsertService"):LoadAsset(58162707) 
		g.Parent = game.Workspace
		g.Name = ":3"
	end 
end, "None", "None", "None")



_CMDMain.Functions.CreateCommand("stop", 5, function(msg, MessageSplit, speaker, Self)
	local imgettingtiredofmakingthisstupidscript = PERSON299(speaker.Name)
	if imgettingtiredofmakingthisstupidscript == true then
		local c = game.Workspace:GetChildren()
		for i =1,#c do
			if c[i].Name == ":3" then
				if c[i] ~= nil then
					c[i]:Remove()
				end 
			end 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("takeover1", 5, function(msg, MessageSplit, speaker, Self)
	local imgettingtiredofmakingthisstupidscript = PERSON299(speaker.Name)
	if imgettingtiredofmakingthisstupidscript == true then
		local g = game:GetService("InsertService"):LoadAsset(56865027) 
		g.Parent = game.Workspace
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("antiplayerorb", 5, function(msg, MessageSplit, speaker, Self)
	local imgettingtiredofmakingthisstupidscript = PERSON299(speaker.Name)
	if imgettingtiredofmakingthisstupidscript == true then 
		local g = game:GetService("InsertService"):LoadAsset(58559824) 
		g.Parent = game.Workspace
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("antinoobs", 5, function(msg, MessageSplit, speaker, Self)
	local imgettingtiredofmakingthisstupidscript = PERSON299(speaker.Name)
	if imgettingtiredofmakingthisstupidscript == true then 
		local g = game:GetService("InsertService"):LoadAsset(56922240) 
		g.Parent = game.Workspace
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("takeover", 5, function(msg, MessageSplit, speaker, Self)
	local imgettingtiredofmakingthisstupidscript = PERSON299(speaker.Name)
	if imgettingtiredofmakingthisstupidscript == true then
		local g = game:GetService("InsertService"):LoadAsset(58479046) 
		g.Parent = game.Workspace
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("antimob", 5, function(msg, MessageSplit, speaker, Self)
	local imgettingtiredofmakingthisstupidscript = PERSON299(speaker.Name)
	if imgettingtiredofmakingthisstupidscript == true then
		local g = game:GetService("InsertService"):LoadAsset(58728910) 
		g.Parent = game.Workspace
	end 
end, "None", "None", "None")




_CMDMain.Functions.CreateCommand("recolor", 5, function(msg, MessageSplit, speaker, Self)
	game.Lighting.Ambient = Color3.new(170,170,170)
	game.Lighting.TimeOfDay = 14
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("noinsert", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(msg:sub(10),speaker)
	if player ~= 0 then
		for i = 1,#player do
			local insert = player[i].Backpack:FindFirstChild("Insert")
			if insert then
				insert:remove()
			end
			local bpinsert = player[i].Character:FindFirstChild("Insert")
			if bpinsert ~= nil and bpinsert:isA("Tool") then
				bpinsert:remove()
			end
		end 
	end 
end, "None", "None", "None")



_CMDMain.Functions.CreateCommand("cframe1", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(msg:sub(9),speaker)
	if player ~= 0 then
		for i = 1,#player do
			local cframe = game:GetService("InsertService"):LoadAsset(34879005)
			cframe:MakeJoints()
			cframe["All New Edit Cframe"].Parent = player[i].Backpack
			cframe:remove()
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("cframe2", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(msg:sub(9),speaker)
	if player ~= 0 then
		for i = 1,#player do
			local cframe = game:GetService("InsertService"):LoadAsset(35145017)
			cframe:MakeJoints()
			cframe["CFrame"].Parent = player[i].Backpack
			cframe:remove()
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("skateboard", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(msg:sub(12),speaker)
	if player ~= 0 then
		for i = 1,#player do
			local board = game:GetService("InsertService"):LoadAsset(34879053)
			board:MakeJoints()
			board["SkateTool"].Parent = player[i].Backpack
			board:remove()
		end 
	end 
end, "None", "None", "None")


_CMDMain.Functions.CreateCommand("watch", 4, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(msg:sub(7),speaker)
	if player ~= 0 then
		if #player == 1 then
			for i = 1,#player do
				sc = script.CamScript:clone()
				sc.Parent = speaker
				sc["New Subject"].Value = player[i].Character.Head
				sc.Disabled = false
			end 
		end 
	end 
end, "None", "None", "None")



_CMDMain.Functions.CreateCommand("jail", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(string.sub(msg,6),speaker)
	if player ~= 0 then
		for i = 1,#player do
			if player[i].Character ~= nil then
				local torso = player[i].Character:FindFirstChild("Torso")
				if torso ~= nil then
					local ack = Instance.new("Model")
					ack.Name = "Jail" .. player[i].Name
					icky = Instance.new("Part") icky.Size = Vector3.new(1,7.2000002861023,1) icky.CFrame = CFrame.new(-26.5, 108.400002, -1.5, 0, 0, -1, 0, 1, -0, 1, 0, -0) icky.Color = Color3.new(0.105882, 0.164706, 0.203922)  icky.Anchored = true  icky.Locked = true  icky.CanCollide = true  icky.Parent = ack  icky = Instance.new("Part") icky.Size = Vector3.new(1,7.2000002861023,1) icky.CFrame = CFrame.new(-24.5, 108.400002, -3.5, 0, 0, -1, 0, 1, -0, 1, 0, -0) icky.Color = Color3.new(0.105882, 0.164706, 0.203922)  icky.Anchored = true  icky.Locked = true  icky.CanCollide = true  icky.Parent = ack  icky = Instance.new("Part") icky.Size = Vector3.new(1,7.2000002861023,1) icky.CFrame = CFrame.new(-30.5, 108.400002, -3.5, -1, 0, -0, -0, 1, -0, -0, 0, -1) icky.Color = Color3.new(0.105882, 0.164706, 0.203922)  icky.Anchored = true  icky.Locked = true  icky.CanCollide = true  icky.Parent = ack  icky = Instance.new("Part") icky.Size = Vector3.new(1,7.2000002861023,1) icky.CFrame = CFrame.new(-28.5, 108.400002, -1.5, 0, 0, -1, 0, 1, -0, 1, 0, -0) icky.Color = Color3.new(0.105882, 0.164706, 0.203922)  icky.Anchored = true  icky.Locked = true  icky.CanCollide = true  icky.Parent = ack  icky = Instance.new("Part") icky.Size = Vector3.new(1,7.2000002861023,1) icky.CFrame = CFrame.new(-24.5, 108.400002, -5.5, 0, 0, -1, 0, 1, -0, 1, 0, -0) icky.Color = Color3.new(0.105882, 0.164706, 0.203922)  icky.Anchored = true  icky.Locked = true  icky.CanCollide = true  icky.Parent = ack  icky = Instance.new("Part") icky.Size = Vector3.new(1,7.2000002861023,1) icky.CFrame = CFrame.new(-24.5, 108.400002, -7.5, 0, 0, -1, 0, 1, -0, 1, 0, -0) icky.Color = Color3.new(0.105882, 0.164706, 0.203922)  icky.Anchored = true  icky.Locked = true  icky.CanCollide = true  icky.Parent = ack  icky = Instance.new("Part") icky.Size = Vector3.new(1,7.2000002861023,1) icky.CFrame = CFrame.new(-24.5, 108.400002, -1.5, 0, 0, -1, 0, 1, -0, 1, 0, -0) icky.Color = Color3.new(0.105882, 0.164706, 0.203922)  icky.Anchored = true  icky.Locked = true  icky.CanCollide = true  icky.Parent = ack  icky = Instance.new("Part") icky.Size = Vector3.new(1,7.2000002861023,1) icky.CFrame = CFrame.new(-30.5, 108.400002, -7.5, -1, 0, -0, -0, 1, -0, -0, 0, -1) icky.Color = Color3.new(0.105882, 0.164706, 0.203922)  icky.Anchored = true  icky.Locked = true  icky.CanCollide = true  icky.Parent = ack  icky = Instance.new("Part") icky.Size = Vector3.new(7,1.2000000476837,7) icky.CFrame = CFrame.new(-27.5, 112.599998, -4.5, 0, 0, -1, 0, 1, -0, 1, 0, -0) icky.Color = Color3.new(0.105882, 0.164706, 0.203922)  icky.Anchored = true  icky.Locked = true  icky.CanCollide = true  icky.Parent = ack  icky = Instance.new("Part") icky.Size = Vector3.new(1,7.2000002861023,1) icky.CFrame = CFrame.new(-26.5, 108.400002, -7.5, 0, 0, -1, 0, 1, -0, 1, 0, -0) icky.Color = Color3.new(0.105882, 0.164706, 0.203922)  icky.Anchored = true  icky.Locked = true  icky.CanCollide = true  icky.Parent = ack  icky = Instance.new("Part") icky.Size = Vector3.new(1,7.2000002861023,1) icky.CFrame = CFrame.new(-30.5, 108.400002, -5.5, -1, 0, -0, -0, 1, -0, -0, 0, -1) icky.Color = Color3.new(0.105882, 0.164706, 0.203922)  icky.Anchored = true  icky.Locked = true  icky.CanCollide = true  icky.Parent = ack  icky = Instance.new("Part") icky.Size = Vector3.new(1,7.2000002861023,1) icky.CFrame = CFrame.new(-30.5, 108.400002, -1.5, -1, 0, -0, -0, 1, -0, -0, 0, -1) icky.Color = Color3.new(0.105882, 0.164706, 0.203922)  icky.Anchored = true  icky.Locked = true  icky.CanCollide = true  icky.Parent = ack  icky = Instance.new("Part") icky.Size = Vector3.new(1,7.2000002861023,1) icky.CFrame = CFrame.new(-28.5, 108.400002, -7.5, 0, 0, -1, 0, 1, -0, 1, 0, -0) icky.Color = Color3.new(0.105882, 0.164706, 0.203922)  icky.Anchored = true  icky.Locked = true  icky.CanCollide = true  icky.Parent = ack 
					ack.Parent = game.Workspace
					ack:MoveTo(torso.Position)
				end 
			end 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("unjail", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(string.sub(msg,8),speaker)
	if player ~= 0 then
		for i = 1,#player do
			local c = game.Workspace:GetChildren()
			for i2 =1,#c do
				if string.sub(c[i2].Name,1,4) == "Jail" then
					if string.sub(c[i2].Name,5) == player[i].Name then
						c[i2]:remove()
					end 
				end 
			end 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("unshield", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(string.sub(msg,10),speaker)
	if player ~= 0 then
		for i = 1,#player do
			if player[i].Character ~= nil then
				local shield = player[i].Character:FindFirstChild("Weird Ball Thingy")
				if shield ~= nil then
					shield:remove()
				end 
			end 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("shield", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(string.sub(msg,8),speaker)
	if player ~= 0 then
		for i = 1,#player do
			if player[i].Character ~= nil then
				local torso = player[i].Character:FindFirstChild("Torso")
				if torso ~= nil then
					if player[i].Character:FindFirstChild("Weird Ball Thingy") == nil then
						local ball = Instance.new("Part")
						ball.Size = Vector3.new(10,10,10)
						ball.BrickColor = BrickColor.new(1)
						ball.Transparency = 0.5
						ball.CFrame = torso.CFrame
						ball.TopSurface = "Smooth"
						ball.BottomSurface = "Smooth"
						ball.CanCollide = false
						ball.Name = "Weird Ball Thingy"
						ball.Reflectance = 0.2
						local sm = Instance.new("SpecialMesh")
						sm.MeshType = "Sphere"
						sm.Parent = ball
						ball.Parent = player[i].Character
						createscript([[ 
							function ot(hit) 
								if hit.Parent ~= nil then 
									if hit.Parent ~= script.Parent.Parent then 
										if hit.Anchored == false then
											hit:BreakJoints()
											local pos = script.Parent.CFrame * (Vector3.new(0, 1.4, 0) * script.Parent.Size)
											hit.Velocity = ((hit.Position - pos).unit + Vector3.new(0, 0.5, 0)) * 150 + hit.Velocity	
											hit.RotVelocity = hit.RotVelocity + Vector3.new(hit.Position.z - pos.z, 0, pos.x - hit.Position.x).unit * 40
										end end end end
										script.Parent.Touched:connect(ot) ]], ball)
						local bf = Instance.new("BodyForce")
						bf.force = Vector3.new(0,5e+004,0)
						bf.Parent = ball
						local w = Instance.new("Weld")
						w.Part1 = torso
						w.Part0 = ball
						ball.Shape = 0
						w.Parent = torso
					end 
				end 
			end 
		end 
	end 
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("maxplayers", 5, function(msg, MessageSplit, speaker, Self)
	local pie = game.Players.MaxPlayers
	game.Players.MaxPlayers = string.sub(msg,12)
	if game.Players.MaxPlayers == 0 then
		game.Players.MaxPlayers = pie
	end 
end, "None", "None", "None")


_CMDMain.Functions.CreateCommand("explode", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(string.sub(msg,8),speaker)
	if player ~= 0 then
		for i = 1,#player do
			if player[i].Character ~= nil then
				local torso = player[i].Character:FindFirstChild("Torso")
				if torso ~= nil then
					local ex = Instance.new("Explosion")
					ex.Position = torso.Position
					ex.Parent = game.Workspace
				end 
			end 
		end 
	end 
end, "None", "None", "None")


_CMDMain.Functions.CreateCommand("unfreeze", 4, function(msg, MessageSplit, speaker, Self)
	if string.len(msg)>=10 then
		stop = findplr(string.sub(msg,10),player)
		if stop ~= 0 then
			for x=1,#stop do
				Char = stop[x].Character:getChildren()
				for i=1,#Char do
					if Char[i].className == "Part" then
						Char[i].Anchored = false
						Char[i].Reflectance = 0
					end
				end
				c,d = pcall(function()
					stop[x].Character.Humanoid.WalkSpeed = stop[x].Character.Speed.Value
					stop[x].Character.Speed:remove()
				end)
				if not c then
					stop[x].Character.Humanoid.WalkSpeed = 16
				end
			end
		end
	end
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("unfreeze", 4, function(msg, MessageSplit, speaker, Self)
	if string.len(msg)>= 8 then
		stop = findplr(string.sub(msg,8),player)
		if stop ~= 0 then
			for x=1,#stop do
				Char = stop[x].Character:GetChildren()
				for i=1,#Char do
					if Char[i].className == "Part" then
						Char[i].Anchored = true
						Char[i].Reflectance = 0.6
					end
				end
				Speed = Instance.new("IntValue",stop[x].Character)
				Speed.Value = stop[x].Character.Humanoid.WalkSpeed
				Speed.Name = "Speed"
				stop[x].Character.Humanoid.WalkSpeed = 0
			end
		end
	end
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("mp", 4, function(msg, MessageSplit, speaker, Self)
	if string.len(msg)>=4 then
		Num = tonumber((string.sub(msg,4)))
		if Num >= 6 and Num <= 30 then
			game.Players.MaxPlayers = Num
		end
	end
end, "None", "None", "None")


_CMDMain.Functions.CreateCommand("blind", 5, function(msg, MessageSplit, speaker, Self)
	if string.len(msg)>=7 then
		Go = false
		for _,v in pairs(Admins) do
			if player.Name == v then
				Go = true
				break
			end
		end
		if Go then
			stop = findplr(string.sub(msg,7),player)
			if stop ~= 0 then
				for x=1,#stop do
					if not stop[x].PlayerGui:FindFirstChild("BlindGui") then
						A=Instance.new("ScreenGui")
						A.Name = "BlindGui"
						B=Instance.new("Frame",A)
						B.BackgroundColor3 = Color3.new(0,0,0)
						B.Size = UDim2.new(5,0,5,0)
						B.Position = UDim2.new(-0.005,0,-0.05,0)
						A.Parent = stop[x].PlayerGui
					end
				end
			end
		end
	end
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("unblind", 5, function(msg, MessageSplit, speaker, Self)
	if string.len(msg)>=9 then
		Go = false
		for _,v in pairs(Admins) do
			if player.Name == v then
				Go = true
				break
			end
		end
		if Go then
			stop = findplr(string.sub(msg,9),player)
			if stop ~= 0 then
				for x=1,#stop do
					if stop[x].PlayerGui:FindFirstChild("BlindGui") then
						stop[x].PlayerGui:FindFirstChild("BlindGui"):remove()
					end
				end
			end
		end
	end
end, "None", "None", "None")

_CMDMain.Functions.CreateCommand("heal", 5, function(msg, MessageSplit, speaker, Self)
	if string.len(msg)>=6 then
		stop=findplr(string.sub(msg,6),player)
		if stop ~= 0 then
			for x=1,#stop do
				bp=stop[x].Character
				if bp then
					bp.Humanoid.Health = bp.Humanoid.MaxHealth
				end
			end
		end
	end
end, "None", "None", "None")

