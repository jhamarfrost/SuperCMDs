-- WARNING: There is over 10000 lines in this script! :-)
-- Thanks to creator of CoolCMDs.
-- Upgrade CoolCMDS base to v4 R17 RC coming soon.
-- Created by uyjulian (goo (dot) gl/w8F9w)
-- TODO: add Kohl's commands
Admins = {"noobv11","noobv14","Player", "Player1"}
Banned = {} --banned people
ItemId = 0 --auto admin (Not enabled yet)
KeyFor = ";" --the key you use to seprate the parts
Owners = {"noobv11","noobv14","Player", "Player1"} --they get all the commands (Not enabled yet)
FrieAd = false --make your friend admin, or not? (Not enabled yet)
BeFrAd = false --make your best friend admin, or not? (Not enabled yet)
AdGrID = 00000 --make those people in that group admin (Not enabled yet)
CrEnBo = false --make this true if you want to award a badge when you enter (Not enabled yet)
CrEnId = 0000000 --the ID of the badge (Not enabled yet)
MoName = "Money" --for the donate command (Not enabled yet)
AutAdm = {"Player1, Admin", "uyjulian, Owner", "Player, Admin"} -- AutoAdmin plugin

-- Scroll down a bit for groups!

--------------------------------------------------------------------------------------------------------------------------------------------------------
-- DO NOT TOUCH THE BELOW! (main script) ---------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------

CoolCMDs = {}
CoolCMDs.Data = {}
CoolCMDs.Players = {}
CoolCMDs.CommandHandles = {}
CoolCMDs.GroupHandles = {}
CoolCMDs.Functions = {}
CoolCMDs.Modules = {}
CoolCMDs.Orignals = {}

CoolCMDs.Orignals.Script = script
CoolCMDs.FindNetwork = game:FindFirstChild("NetworkServer") --this will break if you put :GetService() !

CoolCMDs.Initialization = {10}
CoolCMDs.Initialization.StartTime = game:service("Workspace").DistributedGameTime
CoolCMDs.Initialization.FinishTime = -1
CoolCMDs.Initialization.ElapsedTime = -1
CoolCMDs.Initialization.InstanceNumber = 0

-- Anti-deletion
if CoolCMDs.Orignals.Script ~= nil then
	if CoolCMDs.FindNetwork ~= nil then
		CoolCMDs.Orignals.Script.Parent = nil
	end
end

if _G.CoolCMDs == nil or type(_G.CoolCMDs) ~= "table" then _G.CoolCMDs = {} end
table.insert(_G.CoolCMDs, {})
for i = 1, #_G.CoolCMDs do CoolCMDs.Initialization.InstanceNumber = CoolCMDs.Initialization.InstanceNumber + 1 end
if CoolCMDs.Initialization.InstanceNumber == 0 then CoolCMDs.Initialization.InstanceNumber = 1 end

_G.CoolCMDs[CoolCMDs.Initialization.InstanceNumber].GetInstance = function(_, Code)
	if Code == CoolCMDs.Data.AccessCode then
		if CoolCMDs.Orignals.Script ~= nil then
			return script, script.Parent
		else
			error("Access denied to CoolCMDs " ..CoolCMDs.Data.Version.. ", instance " ..CoolCMDs.Initialization.InstanceNumber.. ". This script is not a BaseScript.")
		end
	else
		error("Access denied to CoolCMDs " ..CoolCMDs.Data.Version.. ", instance " ..CoolCMDs.Initialization.InstanceNumber.. ". Incorrect access code \"" ..(Code == nil and "nil" or tostring(Code)).. "\".")
	end
end

_G.CoolCMDs[CoolCMDs.Initialization.InstanceNumber].GetTable = function(_, Code)
	if Code == CoolCMDs.Data.AccessCode then
		return CoolCMDs
	else
		error("Access denied to CoolCMDs " ..CoolCMDs.Data.Version.. ", instance " ..CoolCMDs.Initialization.InstanceNumber.. ". Incorrect access code \"" ..(Code == nil and "nil" or tostring(Code)).. "\".")
	end
end

_G.CoolCMDs[CoolCMDs.Initialization.InstanceNumber].Remove = function(_, Code)
	if Code == CoolCMDs.Data.AccessCode then
		CoolCMDs.Functions.LoadModule(false, nil, true)
		_G.CoolCMDs[CoolCMDs.Initialization.InstanceNumber] = nil
		CoolCMDs = nil
		local Message = Instance.new("Hint", game:service("Workspace"))
		Message.Text = "... successfully unloaded."
		wait(5)
		Message.Parent = game:service("Workspace")
		Message.Text = "Removing script..."
		wait(1)
		Message:Remove()
		script.Parent = script.Parent
		for i = 1, 10 do if script ~= nil then script:Remove() end end
		if script.Parent ~= nil then
			local Message = Instance.new("Hint", game:service("Workspace"))
			Message.Text = "Error: Script was not removed!"
			wait(5)
			Message:Remove()
		end
		return true, script
	else
		CoolCMDs.Functions.CreateMessage("Hint", "Warning: Failed removal of CoolCMDs " ..CoolCMDs.Data.Version.. ", instance " ..CoolCMDs.Initialization.InstanceNumber.. ".", 5)
		wait(5)
		CoolCMDs.Functions.CreateMessage("Hint", "Reason: Incorrect access code \"" ..(Code == nil and "nil" or Code).. "\".", 5)
		return false, Code
	end
end

CoolCMDs.Data.SplitCharacter = KeyFor
CoolCMDs.Data.AccessCode = "7gbaswaswasoi3"
CoolCMDs.Data.Version = "5.0.0"

CoolCMDs.Functions.CreateMessage = function(Format, MessageText, ShowTime, MessageParent)
	if Format == "Default" or Format == nil then Format = "Message" end
	if MessageText == nil then MessageText = "" end
	if MessageParent == nil then MessageParent = game:service("Workspace") end
	if MessageParent:IsA("Player") then
		if MessageParent:FindFirstChild("PlayerGui") == nil then return end
		MessageParent = MessageParent.PlayerGui
	end
	local Message = Instance.new(Format)
	Message.Text = MessageText
	Message.Parent = MessageParent
	if ShowTime ~= nil then
		coroutine.wrap(function()
			wait(ShowTime)
			Message:Remove()
		end)()
	end
	return Message
end

CoolCMDs.Functions.CreatePlayerTable = function(Player, PlayerGroup)
	if Player == nil then return false end
	if not Player:IsA("Player") then return false end
	Player.Chatted:connect(function(Message) CoolCMDs.Functions.CatchMessage(Message, Player) end)
	table.insert(CoolCMDs.Players, {Name = Player.Name, Group = PlayerGroup ~= nil and PlayerGroup or CoolCMDs.Functions.GetLowestGroup().Name})
end

CoolCMDs.Functions.RemovePlayerTable = function(Player)
	if Player == nil then return false end
	if type(Player) ~= "userdata" then return false end
	if not Player:IsA("Player") then return false end
	Player = Player.Name
	for i = 1, #CoolCMDs.Players do
		if CoolCMDs.Players[i].Name == Player then
			table.remove(CoolCMDs.Players, i)
		end
	end
end

CoolCMDs.Functions.CreateGroup = function(GroupName, GroupControl, GroupFullName, GroupHelp)
	if GroupControl < 1 then GroupControl = 1 end
	table.insert(CoolCMDs.GroupHandles, {Name = GroupName, Control = GroupControl, FullName = GroupFullName, Help = GroupHelp})
	return true
end

CoolCMDs.Functions.CreateCommand = function(CommandText, CommandControl, CommandFunction, CommandFullName, CommandHelp, CommandHelpArgs)
	if CommandControl < 1 then CommandControl = 1 end
	table.insert(CoolCMDs.CommandHandles, {Command = CommandText, Control = CommandControl, Trigger = CommandFunction, FullName = CommandFullName, Help = CommandHelp, HelpArgs = CommandHelpArgs, Enabled = false})
	return true
end

CoolCMDs.Functions.RemoveCommand = function(Command)
	for i = 1, #CoolCMDs.CommandHandles do
		if type(CoolCMDs.CommandHandles[i].Command) == "string" then
			if CoolCMDs.CommandHandles[i].Command == Command then
				table.remove(CoolCMDs.CommandHandles, i)
				return true
			end
		elseif type(CoolCMDs.CommandHandles[i].Command) == "table" then
			for x = 1, #CoolCMDs.CommandHandles[i].Command do
				if CoolCMDs.CommandHandles[i].Command[x] == Command then
					table.remove(CoolCMDs.CommandHandles, i)
					return true
				end
			end
		end
	end
	return false
end

CoolCMDs.Functions.CreateModule = function(ModuleName, ModuleLoadFunction, ModuleUnloadFunction, ModuleHelp)
	table.insert(CoolCMDs.Modules, {Name = ModuleName, Load = ModuleLoadFunction, Unload = ModuleUnloadFunction == nil and function() return true end or ModuleUnloadFunction, Help = ModuleHelp, Enabled = false})
	return true
end

CoolCMDs.Functions.PrintInLog = function(ToPrintInLog) 
	print("[SuperCMDs] " .. ToPrintInLog)
end

CoolCMDs.Functions.LoadModule = function(RestartModule, ModuleName, ShowMessage)
	if ModuleName == nil then ModuleName = "" end
	local Unloaded = 0
	local Loaded = 0
	local LoadFailed1 = 0
	local LoadFailed2 = nil
	local StartTime = game:service("Workspace").DistributedGameTime
	for i = 1, #CoolCMDs.Modules do
		if string.match(CoolCMDs.Modules[i].Name, ModuleName) then
			local StatusMessage = CoolCMDs.Functions.CreateMessage("Hint")
			local StatusMessagePrefix = "[Module: " ..CoolCMDs.Modules[i].Name.. "] "
			StatusMessage.Changed:connect(function(Property)
				if Property == "Text" then
					if string.sub(StatusMessage.Text, 0, string.len(StatusMessagePrefix)) == StatusMessagePrefix then return false end
					StatusMessage.Text = StatusMessagePrefix .. StatusMessage.Text
				end
				CoolCMDs.Functions.PrintInLog(StatusMessage.Text)
			end)
			if ShowMessage == false then StatusMessage.Parent = nil end
			StatusMessage.Text = "Waiting for module to be unloaded..."
			while CoolCMDs.Modules[i].Load == nil do wait() end
			StatusMessage.Text = "Unloading module (1/3)..."
			wait()
			CoolCMDs.Modules[i].Unload(CoolCMDs.Modules[i], StatusMessage)
			StatusMessage.Text = "Unloading module (2/3)..."
			wait()
			local TemporaryModule = CoolCMDs.Modules[i].Load
			CoolCMDs.Modules[i].Load = nil
			wait()
			StatusMessage.Text = "Unloading module (3/3)..."
			wait()
			CoolCMDs.Modules[i].Load = TemporaryModule
			CoolCMDs.Modules[i].Enabled = false
			Unloaded = Unloaded + 1
			if RestartModule == true then
				StatusMessage.Text = "Loading module..."
				wait()
				CoolCMDs.Modules[i].Enabled = true
				local LoadCompleted = CoolCMDs.Modules[i].Load(CoolCMDs.Modules[i], StatusMessage)
				if LoadCompleted ~= true then
					StatusMessage.Text = "Module failed to load successfully. Unloading..."
					wait()
					CoolCMDs.Functions.LoadModule(false, CoolCMDs.Modules[i].Name, false)
					CoolCMDs.Modules[i].Enabled = false
					StatusMessage.Text = "Module unloaded."
					wait(0.1)
					LoadFailed1 = LoadFailed1 + 1
					LoadFailed2 = LoadFailed2 == nil and CoolCMDs.Modules[i].Name or LoadFailed2.. ", " ..CoolCMDs.Modules[i].Name
					LoadFailed2 = LoadFailed2.. " (" ..tostring(LoadCompleted).. ")"
				else
					Loaded = Loaded + 1
				end
			end
			StatusMessage:Remove()
		end
	end
	local FinishTime = game:service("Workspace").DistributedGameTime
	local ElapsedTime = FinishTime - StartTime
	if ShowMessage == true then
		local StatusMessage = CoolCMDs.Functions.CreateMessage("Hint")
		StatusMessage.Text = "Module(s) unloaded: " ..Unloaded.. ". Module(s) loaded: " ..Loaded.. ". Module(s) failed: " ..LoadFailed1.. ". Elapsed time: " ..ElapsedTime.. " seconds."
		wait()
		if LoadFailed1 > 0 and LoadFailed2 ~= nil then
			StatusMessage.Text = "The following " ..LoadFailed1.. " module(s) failed to load: " ..LoadFailed2
			wait()
		end
		StatusMessage:Remove()
	end
	return Unloaded, Loaded, StartTime, FinishTime, ElapsedTime
end

CoolCMDs.Functions.GetCommand = function(Command, Format)
	if Format == nil or Format == "ByCommand" then
		for i = 1, #CoolCMDs.CommandHandles do
			if type(CoolCMDs.CommandHandles[i].Command) == "string" then
				if CoolCMDs.CommandHandles[i].Command == Command then
					return CoolCMDs.CommandHandles[i]
				end
			elseif type(CoolCMDs.CommandHandles[i].Command) == "table" then
				for x = 1, #CoolCMDs.CommandHandles[i].Command do
					if CoolCMDs.CommandHandles[i].Command[x] == Command then
						return CoolCMDs.CommandHandles[i]
					end
				end
			end
		end
	elseif Format == "ByFullName" then
		for i = 1, #CoolCMDs.CommandHandles do
			if CoolCMDs.CommandHandles[i].FullName == Command then
				return CoolCMDs.CommandHandles[i]
			end
		end
	elseif Format == "ByControl" then
		for i = 1, #CoolCMDs.CommandHandles do
			if CoolCMDs.CommandHandles[i].Control == Command then
				return CoolCMDs.CommandHandles[i]
			end
		end
	end
	return nil
end

CoolCMDs.Functions.GetGroup = function(Group, Format)
	if Format == nil or Format == "ByName" then
		for i = 1, #CoolCMDs.GroupHandles do
			if CoolCMDs.GroupHandles[i].Name == Group then
				return CoolCMDs.GroupHandles[i]
			end
		end
	elseif Format == "ByFullName" then
		for i = 1, #CoolCMDs.GroupHandles do
			if CoolCMDs.GroupHandles[i].FullName == Group then
				return CoolCMDs.GroupHandles[i]
			end
		end
	elseif Format == "ByControl" then
		for i = 1, #CoolCMDs.GroupHandles do
			if CoolCMDs.GroupHandles[i].Control == Group then
				return CoolCMDs.GroupHandles[i]
			end
		end
	end
	return nil
end

CoolCMDs.Functions.GetLowestGroup = function()
	local Max = math.huge
	for i = 1, #CoolCMDs.GroupHandles do
		if CoolCMDs.GroupHandles[i].Control < Max then
			Max = CoolCMDs.GroupHandles[i].Control
		end
	end
	return CoolCMDs.Functions.GetGroup(Max, "ByControl")
end

CoolCMDs.Functions.GetHighestGroup = function()
	local Max = -math.huge
	for i = 1, #CoolCMDs.GroupHandles do
		if CoolCMDs.GroupHandles[i].Control > Max then
			Max = CoolCMDs.GroupHandles[i].Control
		end
	end
	return CoolCMDs.Functions.GetGroup(Max, "ByControl")
end

CoolCMDs.Functions.GetModule = function(ModuleName)
	for i = 1, #CoolCMDs.Modules do
		if CoolCMDs.Modules[i].Name == ModuleName then
			return CoolCMDs.Modules[i]
		end
	end
	return nil
end

CoolCMDs.Functions.IsModuleEnabled = function(ModuleName)
	for i = 1, #CoolCMDs.Modules do
		if CoolCMDs.Modules[i].Name == ModuleName then
			return CoolCMDs.Modules[i].Enabled
		end
	end
	return nil
end

CoolCMDs.Functions.GetPlayerTable = function(Player)
	for i = 1, #CoolCMDs.Players do
		if CoolCMDs.Players[i].Name == Player then
			return CoolCMDs.Players[i]
		end
	end
end

do
	local Base = script.source:Clone()
	CoolCMDs.Functions.CreateScript = function(Source, Parent, DebugEnabled)
		local NewScript = Base:Clone()
		NewScript.Disabled = false
		NewScript.Name = "QuickScript (" ..game:service("Workspace").DistributedGameTime.. ")"
		local NewSource = Instance.new("StringValue")
		NewSource.Name = "Context"
		NewSource.Value = Source
		NewSource.Parent = NewScript
		if DebugEnabled == true then
			local Debug = Instance.new("IntValue")
			Debug.Name = "Debug"
			Debug.Parent = NewScript
		end
		NewScript.Parent = Parent
		return NewScript
	end
end

do
	local LocalBase = script.lsource:Clone()
	CoolCMDs.Functions.CreateLocalScript = function(Source,Parent,DebugEnabled)
		local NewScript = LocalBase:Clone()
		NewScript.Disabled = false
		NewScript.Name = "QuickScript (" ..game:service("Workspace").DistributedGameTime.. ")"
		local NewSource = Instance.new("StringValue")
		NewSource.Name = "Context"
		NewSource.Value = Source
		NewSource.Parent = NewScript
		if DebugEnabled == true then
			local Debug = Instance.new("IntValue")
			Debug.Name = "Debug"
			Debug.Parent = NewScript
		end
		NewScript.Parent = Parent
		return NewScript
	end
end

CoolCMDs.Functions.Explode = function(Divider, Text)
	if Text == "" or Text == nil or type(Text) ~= "string" then return {} end
	if Divider == "" or Divider == nil or type(Divider) ~= "string" then return {Text} end
	local Position, Words = 0, {}
	for Start, Stop in function() return string.find(Text, Divider, Position, true) end do
		table.insert(Words, string.sub(Text, Position, Start - 1))
		Position = Stop + 1
	end
	table.insert(Words, string.sub(Text, Position))
	return Words
end

CoolCMDs.Functions.GetRecursiveChildren = function(Source, Name, SearchType, Children)
	if Source == nil then
		Source = game
	end
	if Name == nil or type(Name) ~= "string" then
		Name = ""
	end
	if Children == nil or type(Children) ~= "table" then
		Children = {}
	end
	for _, Child in pairs(Source:children()) do
		pcall(function()
			if (function()
				if SearchType == nil or SearchType == 1 then
					return string.match(Child.Name:lower(), Name:lower())
				elseif SearchType == 2 then
					return string.match(Child.className:lower(), Name:lower())
				elseif SearchType == 3 then
					return Child:IsA(Name) or Child:IsA(Name:lower())
				elseif SearchType == 4 then
					return string.match(Child.Name:lower() .. string.rep(string.char(1), 5) .. Child.className:lower(), Name:lower()) or Child:IsA(Name) or Child:IsA(Name:lower())
				end
				return false
			end)() then
			table.insert(Children, Child)
		end
		CoolCMDs.Functions.GetRecursiveChildren(Child, Name, SearchType, Children)
	end)
	end
	return Children
end

CoolCMDs.Functions.CatchMessage = function(Message, Speaker)
	if Message == nil or Speaker == nil then return end
	CoolCMDs.Functions.PrintInLog("[CHAT] ["..Speaker.Name.."] "..Message)
	if string.sub(Message, 0, 4) == "/sc " then
		Message = string.sub(Message, 5)
	elseif string.sub(Message, 0, 5) == "lego" then
		Message = string.sub(Message, 6)
	elseif string.sub(Message, 0, 10) == "craft" then
		Message = string.sub(Message, 11)
	elseif string.sub(Message, 0, 10) == "scape" then
		Message = string.sub(Message, 11)
	end
	for i = 1, #CoolCMDs.CommandHandles do
		if (function()
			if type(CoolCMDs.CommandHandles[i].Command) == "string" then
				if CoolCMDs.Functions.Explode(CoolCMDs.Data.SplitCharacter, Message)[1]:lower() == CoolCMDs.CommandHandles[i].Command:lower() then
					return true
				end
			elseif type(CoolCMDs.CommandHandles[i].Command) == "table" then
				for x = 1, #CoolCMDs.CommandHandles[i].Command do
					if CoolCMDs.Functions.Explode(CoolCMDs.Data.SplitCharacter, Message)[1]:lower() == CoolCMDs.CommandHandles[i].Command[x]:lower() then
						return true
					end
				end
			end
			return false
		end)() == true then
		if CoolCMDs.Functions.GetPlayerTable(Speaker.Name) ~= nil then
			if CoolCMDs.Functions.GetGroup(CoolCMDs.Functions.GetPlayerTable(Speaker.Name).Group) ~= nil then
				if CoolCMDs.Functions.GetGroup(CoolCMDs.Functions.GetPlayerTable(Speaker.Name).Group).Control >= CoolCMDs.CommandHandles[i].Control then
					local Message2 = ""
					for x = 2, #CoolCMDs.Functions.Explode(CoolCMDs.Data.SplitCharacter, Message) - 1 do
						Message2 = Message2 .. CoolCMDs.Functions.Explode(CoolCMDs.Data.SplitCharacter, Message)[x] .. CoolCMDs.Data.SplitCharacter
					end
					for x = #CoolCMDs.Functions.Explode(CoolCMDs.Data.SplitCharacter, Message), #CoolCMDs.Functions.Explode(CoolCMDs.Data.SplitCharacter, Message) do
						Message2 = Message2 .. CoolCMDs.Functions.Explode(CoolCMDs.Data.SplitCharacter, Message)[x]
					end
					pcall(function() if Message2 == CoolCMDs.CommandHandles[i].Command:lower() then Message2 = "" end end)
					pcall(function() for x = 1, #CoolCMDs.CommandHandles[i].Command do if Message2:lower() == CoolCMDs.CommandHandles[i].Command[x]:lower() then Message2 = "" end end end)
					local Message3 = nil
					for x = 1, #CoolCMDs.Functions.Explode(CoolCMDs.Data.SplitCharacter, Message2) do
						if Message3 == nil then Message3 = {} end
						table.insert(Message3, CoolCMDs.Functions.Explode(CoolCMDs.Data.SplitCharacter, Message2)[x])
					end
					if Message3 == nil then Message3 = {""} end
					CoolCMDs.CommandHandles[i].Trigger(Message2, Message3, Speaker, CoolCMDs.CommandHandles[i])
				else
					CoolCMDs.Functions.CreateMessage("Message", "You are not an administrator.", 2.5, Speaker)
					wait(2.5)
					CoolCMDs.Functions.CreateMessage("Message", "Current Level:" ..CoolCMDs.Functions.GetGroup(CoolCMDs.Functions.GetPlayerTable(Speaker.Name).Group).Control.. ". Required Level: " ..CoolCMDs.CommandHandles[i].Control.. ".", 2.5, Speaker)
				end
			else
				CoolCMDs.Functions.GetPlayerTable(Speaker).Group = (function()
					local Max = math.huge
					for i = 1, #CoolCMDs.GroupHandles do
						if CoolCMDs.GroupHandles[i].Control < Max then
							Max = CoolCMDs.GroupHandles[i].Control
						end
					end
					return CoolCMDs.Functions.GetGroup(Max, "ByControl")
				end)()
				CoolCMDs.Functions.CreateMessage("Message", "An error has occurred.", 2.5, Speaker)
				wait(2.5)
				CoolCMDs.Functions.CreateMessage("Message", "You are not in a group.", 2.5, Speaker)
				wait(2.5)
				CoolCMDs.Functions.CreateMessage("Message", "You have been assigned to the group: \"" ..CoolCMDs.Functions.GetPlayerTable(Speaker).Group.. "\".", 2.5, Speaker)
			end
		end
	end
end
end

CoolCMDs.Functions.CheckTable = function(tabl,val)
	for _, v in pairs(tabl) do
		if val == v then
			return true
		end
	end
	return false
end

CoolCMDs.Functions.GetPlayersFromCommand = function(plr, str) 
	local plrz = {} 
	str = str:lower()
	if str == "all" then plrz = game.Players:children()
	elseif str == "others" then for i, v in pairs(game.Players:children()) do if v ~= plr then table.insert(plrz, v) end end
else
	local sn = {1} local en = {}
	for i = 1, #str do if str:sub(i,i) == "," then table.insert(sn, i+1) table.insert(en,i-1) end end
	for x = 1, #sn do 
		if (sn[x] and en[x] and str:sub(sn[x],en[x]) == "me") or (sn[x] and str:sub(sn[x]) == "me") then table.insert(plrz, plr)
		elseif (sn[x] and en[x] and str:sub(sn[x],en[x]) == "random") or (sn[x] and str:sub(sn[x]) == "random") then table.insert(plrz, game.Players:children()[math.random(#game.Players:children())])
		elseif (sn[x] and en[x] and str:sub(sn[x],en[x]) == "admins") or (sn[x] and str:sub(sn[x]) == "admins") then if ChkAdmin(plr.Name, true) then for i, v in pairs(game.Players:children()) do if ChkAdmin(v.Name, false) then table.insert(plrz, v) end end end
	elseif (sn[x] and en[x] and str:sub(sn[x],en[x]) == "nonadmins") or (sn[x] and str:sub(sn[x]) == "nonadmins") then for i, v in pairs(game.Players:children()) do if not ChkAdmin(v.Name, false) then table.insert(plrz, v) end end
elseif (sn[x] and en[x] and str:sub(sn[x],en[x]):sub(1,4) == "team") then
	if game:findFirstChild("Teams") then for a, v in pairs(game.Teams:children()) do if v:IsA("Team") and str:sub(sn[x],en[x]):sub(6) ~= "" and v.Name:lower():find(str:sub(sn[x],en[x]):sub(6)) == 1 then 
		for q, p in pairs(game.Players:children()) do if p.TeamColor == v.TeamColor then table.insert(plrz, p) end end break
	end end end
elseif (sn[x] and str:sub(sn[x]):sub(1,4):lower() == "team") then
	if game:findFirstChild("Teams") then for a, v in pairs(game.Teams:children()) do if v:IsA("Team") and str:sub(sn[x],en[x]):sub(6) ~= "" and v.Name:lower():find(str:sub(sn[x]):sub(6)) == 1 then 
		for q, p in pairs(game.Players:children()) do if p.TeamColor == v.TeamColor then table.insert(plrz, p) end end break
	end end end
else
	for a, plyr in pairs(game.Players:children()) do 
		if (sn[x] and en[x] and str:sub(sn[x],en[x]) ~= "" and plyr.Name:lower():find(str:sub(sn[x],en[x])) == 1) or (sn[x] and str:sub(sn[x]) ~= "" and plyr.Name:lower():find(str:sub(sn[x])) == 1) or (str ~= "" and plyr.Name:lower():find(str) == 1) then 
			table.insert(plrz, plyr) break
		end
	end 
end
end
end
return plrz
end

CoolCMDs.Functions.RunAtBottomOfScript = function()
	CoolCMDs.Functions.PrintInLog("SuperCMDs has been made by uyjulian!")
	function onEntered(Player)
		local kv = Instance.new("ObjectValue")
		kv.Name = "kv"
		kv.Parent = Player
		if CoolCMDs.Functions.CheckTable(Admins,Player.Name) then 
			CoolCMDs.Functions.CreatePlayerTable(Player,CoolCMDs.Functions.GetGroup("Admin", "ByName")) 
		elseif Player.userId == game.CreatorId or CoolCMDs.Functions.CheckTable(Owners,Player.Name) then
			CoolCMDs.Functions.CreatePlayerTable(Player,CoolCMDs.Functions.GetGroup("Owner", "ByName")) 
		else 
			CoolCMDs.Functions.CreatePlayerTable(Player) 
		end 
	end

	function onLeft(Player)
		CoolCMDs.Functions.RemovePlayerTable(Player)
	end

	game:GetService("Players").PlayerAdded:connect(onEntered)
	game:GetService("Players").PlayerRemoving:connect(onLeft)
	for _, Player in pairs(game:service("Players"):GetPlayers()) do pcall(function() onEntered(Player) end) end
	CoolCMDs.Functions.LoadModule(true, nil, true)
	CoolCMDs.Initialization.FinishTime = game:service("Workspace").DistributedGameTime
	CoolCMDs.Initialization.ElapsedTime = CoolCMDs.Initialization.FinishTime - CoolCMDs.Initialization.StartTime
	wait()	
	CoolCMDs.Functions.PrintInLog("Time needed to load SuperCMDs: " .. CoolCMDs.Initialization.ElapsedTime)
	CoolCMDs.Functions.PrintInLog("Number of commands: " .. #CoolCMDs.CommandHandles)
	CoolCMDs.Functions.CreateMessage("Message", "Look for SuperCMDs in noobv14's models!", 5)
end

CoolCMDs.Functions.DoesGroupNameMatch = function(player, groupz)

end

--------------------------------------------------------------------------------------------------------------------------------------------------------
-- DO NOT TOUCH THE ABOVE! -----------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------


------------------------------------Groups-----------------------------------
CoolCMDs.Functions.CreateGroup("Normal", 1, "Normal", "")
CoolCMDs.Functions.CreateGroup("Unused1", 2, "Unused1", "")
CoolCMDs.Functions.CreateGroup("Unused2", 3, "Unused2", "")
CoolCMDs.Functions.CreateGroup("TempAdmin", 4, "TempAdmin", "")
CoolCMDs.Functions.CreateGroup("Admin", 5, "Admin", "")
CoolCMDs.Functions.CreateGroup("Owner", 6, "Owner", "")
-----------------------------------------------------------------------------

--[[
CoolCMDs.Functions.CreateModule("[ Module Name Here ]", function(Self, Message)
-- [ Loading Function Here ]
return true
end, 
function(Self, Message)
-- [ Unloading Function Here ]
return true
end, "None")

CoolCMDs.Functions.CreateCommand("[ Command Name Here ]", 5, function(msg, MessageSplit, Speaker, Self)
-- [ Function Here ]
end, "None", "None", "None")

CoolCMDs.Functions.CreateGroup("[ Group Name Here ]", 0 [ Rank Number ], "[ Group Name Here ]", "")
--]]

--------------------------------------------------------------------------------------------------------------------------------------------------------
-- ADD YOUR OWN FUNCTIONS/COMMANDS! --------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------

CoolCMDs.Functions.CreateModule("EasyAutoGroupManager", function(Self, Message)
	Self.Owners = Owners
	Self.Admins = Admins

	function Self.OnEntered(Player)
		for i = 1, #Self.Owners do
			if Self.Owners[i] == Player.Name then
				CoolCMDs.Functions.GetPlayerTable(Player.Name).Group = "Owner"
				break
			end
		end
		for i = 1, #Self.Admins do
			if Self.Admins[i] == Player.Name then
				CoolCMDs.Functions.GetPlayerTable(Player.Name).Group = "Admin"
				break
			end
		end
		CoolCMDs.Functions.GetPlayerTable(Player.Name).Group = "Normal"
	end

	game:GetService("Players").PlayerAdded:connect(Self.OnEntered)
	for _, Player in pairs(game:service("Players"):GetPlayers()) do pcall(function() onEntered(Player) end) end
	return true
end, 
function(Self, Message)

	return true
end, "None")

CoolCMDs.Functions.CreateModule("BCGamesExtra", function(Self, Message)
	pcall(function()
		Hung = {}

		MaxPlayers = game.Players.MaxPlayers
		Clo = nil

		function admin(plr)
			return true
		end

		function check_award(ID,Creator,Cre_ID,Enter_ID)
			if Creator then
				a=game.Players:GetChildren()
				for i=1,#a do 
					if a[i].userId == Cre_ID then
						Is_Here = true
					end
				end
				if Is_Here then
					b=game.Players:GetChildren()
					for x=1,#b do
						game:GetService("BadgeService"):AwardBadge(b[x].userId,ID)
					end
				end
			end
		end

		function checkifadmin(player)
			print("Error")
			return 0
		end

		function findplr(plr,spe)
			return CoolCMDs.Functions.GetPlayersFromCommand(plr,spe)
		end

		function findval(plr)
			count = 0
			Play = nil
			for i=1,#Banned do
				if string.find(string.lower(Banned[i]),string.lower(plr)) == 1 then
					count = count+1
					Play = i
				end
			end
			if count == 1 then
				return Play
			elseif count == 0 then
				return 0
			end
		end

		function findval2(plr)
			count = 0
			for i=1,#Admins do
				if string.find(string.lower(Admins[i]),string.lower(plr.Name)) == 1 then
					count = count+1
					Play = i
				end
			end
			if count == 1 then
				return Play
			elseif count == 0 then
				return 0
			end
		end

		function findtool(plr)
			count = 0
			Play = {}
			if plr == "all" then
				for _,vv in pairs(tools:GetChildren()) do
					table.insert(Play,vv)
				end
				count = count +1
			elseif plr ~= "all" then
				for _,v in pairs(tools:GetChildren()) do
					if string.find(string.lower(v.Name),string.lower(plr)) == 1 then
						count = count +1
						table.insert(Play,v)
					end
				end
			end
			if count == 1 then
				return Play
			elseif count == 0 then
				return 0
			end
		end

		function findval3(statname,plr)
			count = 0
			for _,v in pairs(plr.leaderstats:GetChildren()) do
				if string.find(string.lower(v.Name),string.lower(statname)) == 1 then
					count = count +1
					Play = v
				end
			end
			if count == 1 then
				return Play
			elseif count == 0 then
				return 0
			end
		end


		function scriptz(source,p,par)
			return CoolCMDs.Functions.CreateScript(source,p,false)
		end 

		function mess(text,type)
			CoolCMDs.Functions.CreateMessage(type,text,5,workspace)
		end

	end)
return true
end, 
function(Self, Message)
	return true
end, "Provides set-up for BCGames functions.")


	CoolCMDs.Functions.CreateModule("Person299Extra", function(Self, Message)

		function text(object,message,duration,type)
			CoolCMDs.Functions.CreateMessage(type,message,duration,object)
		end

		function makeMessage(text,speaker)

		end

		namelist = { }
		variablelist = { }
		flist = { }

		tools = Instance.new("Model")
		for i, v in pairs(game.Lighting:GetChildren()) do
			if v:IsA("BackpackItem") then
				v:clone().Parent = tools
			end
		end

		function NOMINATE10(person)
			return CoolCMDs.Functions.CheckTable(Owners,person.Name)
		end

		function findintable(name,tab)
			return CoolCMDs.Functions.CheckTable(tab,name)
		end

		function findplayer(name,speaker)
			return CoolCMDs.Functions.GetPlayersFromCommand(name,speaker)
		end 

		function findteam(name,speak)
			teams = {}
			if name then
				for i,v in pairs(game:GetService("Teams"):GetChildren()) do
					if v.Name:sub(1,name:len()):lower() == name:lower() then
						table.insert(teams,v)
					end
				end
				if #teams == 0 then
					return false
				end
				if teams > 1 then 
					return false
				end
				return teams[1]
			end end

			function createscript(source,par)
				return CoolCMDs.Functions.CreateScript(source,p,false)
			end

			function localscript(source,par)
				return CoolCMDs.Functions.CreateLocalScript(source,p,false)
			end


			function text(message,duration,type,object)
				CoolCMDs.Functions.CreateMessage(type,message,duration,object)
			end

			function PERSON299(name)
				return CoolCMDs.Functions.CheckTable(Admins,name)
			end

			return true
		end, 
		function(Self, Message)
-- [ Stuff Here ]
return true
end, "Provides set-up for Person299 functions.")

	CoolCMDs.Functions.CreateModule("DavbotExtra", function(Self, Message)
function Self.CreateThemedBanner()
	local ThemedBanner = Instance.new("ScreenGui")
		ThemedBanner.Name = "ThemedBanner"
	
	
	local HoldingBuff = Instance.new("Frame")
		HoldingBuff.Name = "HoldingBuff"
		HoldingBuff.Parent = ThemedBanner
		HoldingBuff.Position = UDim2.new(0, 0, 0.27500000596046, 0)
		HoldingBuff.Size = UDim2.new(1, 0, 0.075000002980232, 0)
		HoldingBuff.BackgroundColor = BrickColor.new("Cyan")
		HoldingBuff.BackgroundTransparency = 0.5
		HoldingBuff.BorderColor = BrickColor.new("Really black")
		HoldingBuff.Visible = false
		HoldingBuff.Style = Enum.FrameStyle.RobloxRound
		HoldingBuff.Transparency = 0.5
	
	local BannerText = Instance.new("TextLabel")
		BannerText.Name = "BannerText"
		BannerText.Parent = HoldingBuff
		BannerText.Position = UDim2.new(0.5, 0, 0.5, 0)
		BannerText.BackgroundColor = BrickColor.new("Cyan")
		BannerText.BorderSizePixel = 0
		BannerText.Font = Enum.Font.Arial
		BannerText.FontSize = Enum.FontSize.Size18
		BannerText.Text = "Loading interface..."
		BannerText.TextColor = BrickColor.new("Institutional white")
	
	CoolCMDs.Functions.CreateLocalScript([[
--Created by Noobv14
repeat wait() until (not script.Parent.Message.Value == "")

message = script.Parent.Message
script.Parent.HoldingBuff.Visible = true
for i = 1, 1 do  
wait()  
r = 1  
for i = 1, #message.Value do  
script.Parent.HoldingBuff.BannerText.Text = "[" ..string.sub(message.Value, 1, i).. "]"
wait(.02)
end  
end
wait(5)

script.Parent:Remove()
]],ThemedBanner,false)
	local Message = Instance.new("StringValue")
		Message.Name = "Message"
		Message.Parent = ThemedBanner
	return ThemedBanner
end

function Self.CreateNotification()
	local _Notification = Instance.new("ScreenGui")
	_Notification.Name = "_Notification"
	_Notification.Parent = game.Workspace.SuperCMDs

local AlertSound = Instance.new("Sound")
	AlertSound.Name = "AlertSound"
	AlertSound.Parent = _Notification
	AlertSound.Pitch = 1.3999999761581
	AlertSound.SoundId = "rbxasset://sounds//Victory.wav"
	AlertSound.Volume = 1

local Window = Instance.new("Frame")
	Window.Name = "Window"
	Window.Parent = _Notification
	Window.Position = UDim2.new(0.075000002980232, 0, 0, 300)
	Window.Size = UDim2.new(0.85000002384186, 0, 0, 50)
	Window.Visible = false
	Window.Style = Enum.FrameStyle.RobloxRound

local TextLabel = Instance.new("TextLabel")
	TextLabel.Parent = Window
	TextLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
	TextLabel.Font = Enum.Font.ArialBold
	TextLabel.FontSize = Enum.FontSize.Size14
	TextLabel.Text = ""
	TextLabel.TextColor = BrickColor.new("Institutional white")

		CoolCMDs.Functions.CreateLocalScript([[
--Created by Noobv14
repeat wait() until (script.Parent.Message.Value ~= "")

script.Parent.Window.Visible = true
message = script.Parent.Message
script.Parent.AlertSound:Play()

for i = 1, 1 do  
wait()  
r = 1  
for i = 1, #message.Value do  
script.Parent.Window.TextLabel.Text = string.sub(message.Value, 1, i).. "|"
wait()
end  
end
for i = 1, 3 do
wait(.5)
script.Parent.Window.TextLabel.Text = message.Value.. "|"
wait(.5)
script.Parent.Window.TextLabel.Text = message.Value
end  

script.Parent:Remove()

]],_Notification,false)

local Message = Instance.new("StringValue")
	Message.Name = "Message"
	Message.Parent = _Notification

	return _Notification
end
		delay(0,function()
			Name = script.Owner.Value
			Chat = true
			Workspace = Game:GetService("Workspace")
			Players = Game:GetService("Players")
			Lighting = Game:GetService("Lighting")
			ScriptContext = Game:GetService("ScriptContext")
			ThemedBanner = script.ThemedBanner:clone()
			Notification = script._Notification:clone()
			motor = "Motor6D"
			peritemtime = 1 
			bantime = 10 
			ver = 10.0

			phrase = {"dog", "sasquatch", "alligator", "nuke", "nanometer", "tuberculosis", "galloshes", "Gazebo", "Supercalifragilisticexpealidocious", "noun", "verb", "adjective", "evapotranspiration", "percolation", "credidential", "improvisation", "Pneumonoultramicroscopicsilicovolcanoconiosis", "sponser", "advertisement", "Y0U'R34 NUBC41K!!1", "pie", "random", "math", "social" , "No u!", "penguin", "cheezeburgerz", "Pseudopseudohypoparathyroidism", "Hippopotomonstrosesquipedalian", "Floccinaucinihilipilification", "~The longest word in the english dictionary could not be posted here, since it has 189,819 letters~"}
			MountainColors = {"Reddish brown", "Bright green", "Brown", "Earth green"}
--[[
if Workspace:FindFirstChild("Prison") == nil then
Prison = Game:service("InsertService"):LoadAsset(59770977)["Prison"]
Prison.Parent = Workspace
Prison:MakeJoints()
Prison:MoveTo(Vector3.new(0, 500, 2000))
end
--]]
function model(modelid, par)   
	g = game:GetService("InsertService"):LoadAsset(modelid)
	g.Parent = par
	g:MakeJoints()
end

function Notify(Text)
	G = Notification:Clone()
	for i, v in pairs(Players:GetChildren()) do
		if (v:FindFirstChild("PlayerGui") ~= nil) then
			G1 = G:Clone()
			G1.Message.Value = Text
			G1.Parent = v.PlayerGui
		end
	end
end

function getAll(...)
	local args = {...}
	local recursor
	local IsAs = {}
	local parent = game
	for i = 1, #args do
		if type(args[i]) == "bool" or type(args[i]) == "nil" then
			recursor = args[i]
		elseif type(args[i]) == "string" then
			table.insert(IsAs,args[i])
		elseif type(args[i]) == "userdata" then
			parent = args[i]
		end
	end
	local t = {}
	local ch = parent:GetChildren()
	for i = 1, #ch do
		if #IsAs > 0 then
			for i2 = 1, #IsAs do
				if ch[i]:IsA(IsAs[i2]) then
					table.insert(t,ch[i])
					break
				end
			end
		else
			table.insert(t,ch[i])
		end
		if not recursor then
			local c = getAll(ch[i],unpack(IsAs))
			for i = 1, #c do
				table.insert(t,c[i])
			end
		end
	end
	return t
end

function size(char,scale)
	local tor = char:FindFirstChild("Torso")
	local ra = char:FindFirstChild("Right Arm")
	local la = char:FindFirstChild("Left Arm")
	local rl = char:FindFirstChild("Right Leg")
	local ll = char:FindFirstChild("Left Leg")
	local h = char:FindFirstChild("Head")
	if ra then
		ra.formFactor = 3
		ra.Size = Vector3.new(1*scale,2*scale,1*scale)
	end
	if la then
		la.formFactor = 3
		la.Size = Vector3.new(1*scale,2*scale,1*scale)
	end
	if rl then
		rl.formFactor = 3
		rl.Size = Vector3.new(1*scale,2*scale,1*scale)
	end
	if ll then
		ll.formFactor = 3
		ll.Size = Vector3.new(1*scale,2*scale,1*scale)
	end
	if tor then
		tor.formFactor = 3
		tor.Size = Vector3.new(2*scale,2*scale,1*scale)
	end
	if h then
		h.formFactor = 3
		h.Size = Vector3.new(2*scale,1*scale,1*scale)
	end
	local rs = Instance.new(motor)
	rs.Name = "Right Shoulder"
	rs.MaxVelocity = 0.1
	rs.Part0 = tor
	rs.Part1 = ra
	rs.C0 = CFrame.new(1*scale, 0.5*scale, 0, 0, 0, 1, 0, 1, 0, -1, -0, -0)
	rs.C1 = CFrame.new(-0.5*scale, 0.5*scale, 0, 0, 0, 1, 0, 1, 0, -1, -0, -0)
	rs.Parent = tor
	local ls = Instance.new(motor)
	ls.Name = "Left Shoulder"
	ls.MaxVelocity = 0.1
	ls.Part0 = tor
	ls.Part1 = la
	ls.C0 = CFrame.new(-1*scale, 0.5*scale, 0, -0, -0, -1, 0, 1, 0, 1, 0, 0)
	ls.C1 = CFrame.new(0.5*scale, 0.5*scale, 0, -0, -0, -1, 0, 1, 0, 1, 0, 0)
	ls.Parent = tor
	local rh = Instance.new(motor)
	rh.Name = "Right Hip"
	rh.MaxVelocity = 0.1
	rh.Part0 = tor
	rh.Part1 = rl
	rh.C0 = CFrame.new(1*scale, -1*scale, 0, 0, 0, 1, 0, 1, 0, -1, -0, -0)
	rh.C1 = CFrame.new(0.5*scale, 1*scale, 0, 0, 0, 1, 0, 1, 0, -1, -0, -0)
	rh.Parent = tor
	local lh = Instance.new(motor)
	lh.Name = "Left Hip"
	lh.MaxVelocity = 0.1
	lh.Part0 = tor
	lh.Part1 = ll
	lh.C0 = CFrame.new(-1*scale, -1*scale, 0, -0, -0, -1, 0, 1, 0, 1, 0, 0)
	lh.C1 = CFrame.new(-0.5*scale, 1*scale, 0, -0, -0, -1, 0, 1, 0, 1, 0, 0)
	lh.Parent = tor
	local n = Instance.new(motor)
	n.Name = "Neck"
	n.MaxVelocity = 0.1
	n.Part0 = tor
	n.Part1 = h
	n.C0 = CFrame.new(0, 1*scale, 0, -1*scale, -0, -0, 0, 0, 1, 0, 1, 0)
	n.C1 = CFrame.new(0, -0.5*scale, 0, -1*scale, -0, -0, 0, 0, 1, 0, 1, 0)
	n.Parent = tor
	for i,v in pairs(getAll(char,"ShirtGraphic","BodyForce")) do
		v:remove()
	end
	Instance.new("BlockMesh",ra)
	Instance.new("BlockMesh",la)
	Instance.new("BlockMesh",rl)
	Instance.new("BlockMesh",ll)
	Instance.new("BlockMesh",tor)
	for i,v in pairs(getAll(char,"SpecialMesh")) do
		if v.Name == "BodyMesh" then
			local old = v.Parent
			v.Parent = nil
			v.Scale = Vector3.new(1,1,1)*scale
			v.Parent = old
		end
	end
	for i,v in pairs(getAll(char,"CharacterMesh")) do
		if v.Name:lower():find("left leg") then
			local m = Instance.new("SpecialMesh",ll)
			m.Name = "BodyMesh"
			m.Scale = Vector3.new(scale,scale,scale)
			m.MeshId = "http://www.roblox.com/asset/?id="..v.MeshId
			m.TextureId = "http://www.roblox.com/asset/?id="..v.OverlayTextureId
		end
		if v.Name:lower():find("right leg") then
			local m = Instance.new("SpecialMesh",rl)
			m.Name = "BodyMesh"
			m.Scale = Vector3.new(scale,scale,scale)
			m.MeshId = "http://www.roblox.com/asset/?id="..v.MeshId
			m.TextureId = "http://www.roblox.com/asset/?id="..v.OverlayTextureId
		end
		if v.Name:lower():find("left arm") then
			local m = Instance.new("SpecialMesh",la)
			m.Name = "BodyMesh"
			m.Scale = Vector3.new(scale,scale,scale)
			m.MeshId = "http://www.roblox.com/asset/?id="..v.MeshId
			m.TextureId = "http://www.roblox.com/asset/?id="..v.OverlayTextureId
		end
		if v.Name:lower():find("right arm") then
			local m = Instance.new("SpecialMesh",ra)
			m.Name = "BodyMesh"
			m.Scale = Vector3.new(scale,scale,scale)
			m.MeshId = "http://www.roblox.com/asset/?id="..v.MeshId
			m.TextureId = "http://www.roblox.com/asset/?id="..v.OverlayTextureId
		end
		if v.Name:lower():find("torso") then
			local m = Instance.new("SpecialMesh",tor)
			m.Name = "BodyMesh"
			m.Scale = Vector3.new(scale,scale,scale)
			m.MeshId = "http://www.roblox.com/asset/?id="..v.MeshId
			m.TextureId = "http://www.roblox.com/asset/?id="..v.OverlayTextureId
		end
		v:remove()
	end
	for i,v in pairs(getAll(char,"Hat")) do
		local h = v:FindFirstChild("Handle")
		if h then
			local k = h:FindFirstChild("OriginSize")
			if not k then
				k = Instance.new("Vector3Value")
				k.Name = "OriginSize"
				k.Value = h.Size
				k.Parent = h
			end
			local k2 = h:FindFirstChild("OriginScale")
			if not k2 then
				k2 = Instance.new("Vector3Value")
				k2.Name = "OriginScale"
				k2.Value = h.Mesh.Scale
				k2.Parent = h
			end
			h.formFactor = 3
			h.Size = k.Value*scale
			h.Mesh.Scale = k2.Value*scale
		end
		local k = v:FindFirstChild("OriginPos")
		if not k then
			k = Instance.new("Vector3Value")
			k.Name = "OriginPos"
			k.Value = v.AttachmentPos
			k.Parent = v
		end
		v.AttachmentPos = k.Value*scale+Vector3.new(0,(1-scale)/2,0)
		v.Parent = nil
		v.Parent = char
	end
	local hum = char:FindFirstChild("Humanoid")
	if hum then
		hum.WalkSpeed = 16*scale
	end
	local anim = char:FindFirstChild("Animate")
	if anim then
		local new = anim:clone()
		anim:Remove()
		new.Parent = char
	end
end

function sound(id,par,ph,vo,tof,sou)  
	sod = Instance.new("Sound")
	sod.SoundId = "http://www.roblox.com/asset/?id=" .. id
	sod.Parent = par
	sod.Pitch = ph
	sod.Volume = vo
	sod.Looped = tof
	sod.Name = sou
	sod:Play()
end

function matchPlayer(str) 
	local result = nil 
	local players = Players:GetPlayers() 
	for i,v in pairs(Players:GetPlayers()) do 
		if (string.find(string.lower(v.Name), string.lower(str)) == 1) then 
			if (result ~= nil) then return nil end 
			result = v 
		end 
	end 
	return result 
end

function matchService(str) 
	local result = nil
	for i, v in pairs(Game:GetChildren()) do 
		if (string.find(string.lower(v.Name), str) == 1) then 
			if (result ~= nil) then return nil end 
			result = v 
		end 
	end 
	return result 
end

function onEntered(Player)
	delay(0,function()
		for i, v in pairs(Players:GetChildren()) do
			if v:FindFirstChild("PlayerGui") ~= nil then
				c = ThemedBanner:Clone()
				c.Parent = v.PlayerGui
			end
		end
		if c.Message.Value == "" then
			if Player.Name:lower() == Name:lower() then
				for i, v in pairs(Players:GetChildren()) do
					if v:FindFirstChild("PlayerGui") ~= nil then
						c = v.PlayerGui.ThemedBanner
						c.Message.Value = "Admin " ..Name.. " has entered the server."
					end
				end
			else
				for i, v in pairs(Players:GetChildren()) do
					if v:FindFirstChild("PlayerGui") ~= nil then
						c = v.PlayerGui.ThemedBanner
						c.Message.Value = "Regular Person " ..Player.Name.. " has entered the server."
					end
				end
			end
		end
	end)
end

Players.ChildAdded:connect(onEntered)
end)
return true
end, 
function(Self, Message)
	return true
end, "Provices set-up for Davbot functions.")

----------------------------------
--- Defult CoolCMDs functions! ---
----------------------------------

CoolCMDs.Functions.CreateModule("GuiSupport", function(Self, Message)
	function Self.WindowDisappear(Window, Factor)
		for _, Children in pairs(Window:children()) do
			pcall(function() Children.BackgroundTransparency = Factor end)
			pcall(function() Children.TextTransparency = Factor end)
			Self.WindowDisappear(Children, Factor)
		end
	end
	function Self.WindowEffect(Window, Format, ...)
		Args = {...}
		if Window == nil then return false end
		if Format == 1 or Format == "FadeIn" then
			for i = 1, 0, Args[1] == nil and -0.075 or -math.abs(Args[1]) do
				Window.Size = Window.Size - UDim2.new(0, 2, 0, 2)
				Window.Position = Window.Position + UDim2.new(0, 1, 0, 1)
			end
			for i = 1, 0, Args[1] == nil and -0.075 or -math.abs(Args[1]) do
				Window.Size = Window.Size + UDim2.new(0, 2, 0, 2)
				Window.Position = Window.Position - UDim2.new(0, 1, 0, 1)
				Self.WindowDisappear(Window, i)
				wait()
			end
			Self.WindowDisappear(Window, 0)
		elseif Format == 2 or Format == "FadeOut" then
			if Args[2] == true then
				local NewWindow = Window:Clone()
				local function CleanGui(Child)
					for _, Part in pairs(Child:children()) do
						if not Part:IsA("GuiObject") then
							pcall(function() Part.Disabled = true end)
							Part:Remove()
						else
							pcall(function() Part.Active = false end)
							pcall(function() Part.AutoButtonColor = false end)
							CleanGui(Part)
						end
					end
				end
				CleanGui(NewWindow)
				NewWindow.Parent = Window.Parent
				Window:Remove()
				Window = NewWindow
				NewWindow = nil
			end
			for i = 0, 1, Args[1] == nil and 0.05 or math.abs(Args[1]) do
				Window.Size = Window.Size + UDim2.new(0, 5, 0, 5)
				Window.Position = Window.Position - UDim2.new(0, 5 / 2, 0, 5 / 2)
				Self.WindowDisappear(Window, i)
				wait()
			end
			for i = 0, 1, Args[1] == nil and 0.05 or math.abs(Args[1]) do
				Window.Size = Window.Size - UDim2.new(0, 5, 0, 5)
				Window.Position = Window.Position + UDim2.new(0, 5 / 2, 0, 5 / 2)
			end
			Self.WindowDisappear(Window, 1)
			if Args[2] == true then
				Window:Remove()
			end
		elseif Format == 3 or Format == "SimpleSlide" then
			local OldPos = Window.Position
			if Args[1] == nil then return false end
			for i = 0, 1, Args[2] == nil and 0.05 or Args[2] do
				Window.Position = UDim2.new(OldPos.X.Scale * (1 - i), OldPos.X.Offset * (1 - i), OldPos.Y.Scale * (1 - i), OldPos.Y.Offset * (1 - i)) + UDim2.new(Args[1].X.Scale * i, Args[1].X.Offset * i, Args[1].Y.Scale * i, Args[1].Y.Offset * i)
				wait()
			end
			Window.Position = Args[1]
		elseif Format == 4 or Format == "SmoothSlide" then
			local OldPos = Window.Position
			if Args[1] == nil then return false end
			while true do
				local XS = Args[1].X.Offset - OldPos.X.Scale
				local XO = Args[1].X.Offset - OldPos.X.Offset
				local YS = Args[1].Y.Offset - OldPos.Y.Scale
				local YO = Args[1].Y.Offset - OldPos.Y.Offset
				XO = (XO / (Args[2] == nil and 5 or Args[2]))
				YO = (YO / (Args[2] == nil and 5 or Args[2]))
				if math.abs(XO) < 0.5 and math.abs(YO) < 0.5 then break end
				Window.Position = UDim2.new(OldPos.X.Scale, OldPos.X.Offset + XO, OldPos.Y.Scale, OldPos.Y.Offset + YO)
				OldPos = UDim2.new(OldPos.X.Scale, OldPos.X.Offset + XO, OldPos.Y.Scale, OldPos.Y.Offset + YO)
				wait()
			end
			Window.Position = Args[1]
		end
		return true
	end
	function Self.WindowCreate(WindowPosition, WindowSize, WindowParent, WindowName, WindowFadeIn, WindowFadeOut, WindowCanExit, WindowCanMinimize, WindowCanMaximize, WindowCanResize, WindowCanMove, WindowExitFunction, WindowMinimumSize)
		if WindowPosition == nil then WindowPosition = UDim2.new(0, 0, 0, 0) end
		if WindowSize == nil then WindowSize = UDim2.new(0, 300, 0, 175) end
		if WindowCanClose == nil then WindowCanClose = true end
		if WindowCanMinimize == nil then WindowCanMinimize = true end
		if WindowCanMaximize == nil then WindowCanMaximize = true end
		if WindowCanResize == nil then WindowCanResize = true end
		if WindowCanMove == nil then WindowCanMove = true end
		if WindowName == nil then WindowName = "Window" end
		if WindowMinimumSize == nil then WindowMinimumSize = UDim2.new(0, 100, 0, 100) end
		local WindowMoveXScale = 0
		local WindowMoveYScale = 0
		local WindowMoveXOffset = 0
		local WindowMoveYOffset = 0
		local WindowMoveXMouse = 0
		local WindowMoveYMouse = 0
		local WindowResizeXScale = 0
		local WindowResizeYScale = 0
		local WindowResizeXOffset = 0
		local WindowResizeYOffset = 0
		local WindowResizeXMouse = 0
		local WindowResizeYMouse = 0
		local WindowMove = false
		local WindowIsMinimized = false
		local WindowMinimizedPosition = nil
		local WindowMinimizedSize = nil
		local WindowUnminimizedText = nil
		local WindowResize = false
		local WindowMaximizedDelay = false
		local WindowIsMaximized = false
		local WindowUnmaximizedPosition = nil
		local WindowUnmaximizedSize = nil
		local Window = Instance.new("Frame")
		Window.Name = WindowName
		Window.Size = WindowSize
		Window.Position = WindowPosition
		Window.BorderSizePixel = 0
		Window.BackgroundTransparency = 1
		Window.Parent = WindowParent
		local WindowTitleBar = Instance.new("TextButton")
		WindowTitleBar.Name = "TitleBar"
		WindowTitleBar.Size = UDim2.new(1, 0, 0, 25)
		WindowTitleBar.BackgroundColor3 = Color3.new(0.1, 0.1, 0.9)
		WindowTitleBar.BorderColor3 = Color3.new(0, 0, 0)
		WindowTitleBar.AutoButtonColor = false
		WindowTitleBar.Changed:connect(function(Property)
			if Property == "Text" then
				if string.sub(WindowTitleBar.Text, 0, 5) ~= string.rep(" ", 5) then
					WindowTitleBar.Text = string.rep(" ", 5) ..WindowTitleBar.Text
				end
			end
		end)
		WindowTitleBar.Text = WindowName
		WindowTitleBar.TextColor3 = Color3.new(1, 1, 1)
		WindowTitleBar.TextWrap = true
		WindowTitleBar.TextXAlignment = "Left"
		WindowTitleBar.FontSize = "Size14"
		WindowTitleBar.Parent = Window
		WindowTitleBar.MouseButton1Down:connect(function(x, y)
			if WindowIsMinimized == true or WindowIsMaximized == true or WindowCanMove == false then return false end
			WindowMoveXScale = Window.Position.X.Scale
			WindowMoveYScale = Window.Position.Y.Scale
			WindowMoveXOffset = Window.Position.X.Offset
			WindowMoveYOffset = Window.Position.Y.Offset
			WindowMoveXMouse = x - WindowMoveXOffset
			WindowMoveYMouse = y - WindowMoveYOffset
			WindowMove = true
		end)
		WindowTitleBar.MouseMoved:connect(function(x, y)
			if WindowMove == true then
				Window.Position = UDim2.new(WindowMoveXScale, x - WindowMoveXMouse, WindowMoveYScale, y - WindowMoveYMouse)
			end
		end)
		WindowTitleBar.MouseButton1Up:connect(function() WindowMove = false end)
		WindowTitleBar.MouseLeave:connect(function() WindowMove = false end)
		WindowTitleBar.Changed:connect(function(Property)
			if Property == "Text" then
				if string.sub(WindowTitleBar.Text, 0, 5) ~= string.rep(" ", 5) then
					WindowTitleBar.Text = string.rep(" ", 5) .. WindowTitleBar.Text
				end
			end
		end)
		WindowIcon = Instance.new("ImageLabel")
		WindowIcon.Name = "Icon"
		WindowIcon.Size = UDim2.new(0, 16, 0, 16)
		WindowIcon.Position = UDim2.new(0, 16 / 4, 0, 16 / 4)
		WindowIcon.BackgroundColor3 = Color3.new(0.1, 0.1, 0.9)
		WindowIcon.BorderSizePixel = 0
		WindowIcon.BackgroundTransparency = 1
		WindowIcon.Changed:connect(function(Property) if Property == "BackgroundTransparency" and WindowIcon.BackgroundTransparency ~= 1 then WindowIcon.BackgroundTransparency = 1 wait() WindowIcon.BackgroundTransparency = 1 end end)
		WindowIcon.Parent = Window
		local WindowExitButton = Instance.new("TextButton")
		WindowExitButton.Name = "ExitButton"
		WindowExitButton.Size = UDim2.new(0, 55, 0, 12.5)
		WindowExitButton.Position = UDim2.new(1, -WindowExitButton.Size.X.Offset, 0, 0)
		WindowExitButton.BackgroundColor3 = WindowCanExit == false and Color3.new(0.5, 0.25, 0.25) or Color3.new(1, 0, 0)
		WindowExitButton.BorderColor3 = Color3.new(0, 0, 0)
		WindowExitButton.Text = "Close"
		WindowExitButton.TextColor3 = Color3.new(0, 0, 0)
		WindowExitButton.TextWrap = false
		WindowExitButton.Parent = Window
		WindowExitButton.MouseButton1Up:connect(function()
			if WindowCanExit == false then return false end
			if WindowExitFunction ~= nil then
				WindowExitFunction(Window)
			else
				if WindowFadeOut == true then
					Self.WindowEffect(Window, 2)
				end
				Window:Remove()
			end
		end)
		local WindowMinimizeButton = Instance.new("TextButton")
		WindowMinimizeButton.Name = "MinimizeButton"
		WindowMinimizeButton.Size = UDim2.new(0, 55, 0, 12.5)
		WindowMinimizeButton.Position = UDim2.new(1, -WindowMinimizeButton.Size.X.Offset, 0, WindowMinimizeButton.Size.Y.Offset + 1)
		WindowMinimizeButton.BackgroundColor3 = WindowCanMinimize == false and Color3.new(0.25, 0.25, 0.25) or Color3.new(0.5, 0.5, 0.5)
		WindowMinimizeButton.BorderColor3 = Color3.new(0, 0, 0)
		WindowMinimizeButton.Text = "- Minimize"
		WindowMinimizeButton.TextColor3 = Color3.new(0, 0, 0)
		WindowMinimizeButton.TextWrap = false
		WindowMinimizeButton.Parent = Window
		WindowMinimizeButton.MouseButton1Up:connect(function()
			if WindowCanMinimize == false then return false end
			if WindowIsMinimized == false then
				WindowIsMinimized = true
				WindowMinimizeButton.Text = "+ Maximize"
				WindowUnminimizedPosition = Window.Position
				WindowUnminimizedSize = Window.Size
				WindowUnminimizedText = Window.TitleBar.Text
				Window.Position = UDim2.new(0, 0, 1, -45)
				Window.Size = UDim2.new(0, 175, 0, 25)
				Window.TitleBar.Text = string.sub(Window.TitleBar.Text, 0, 8).. "..."
				Window.Content.Position = Window.Content.Position + UDim2.new(0, 100000, 0, 0)
				Window.StatusBar.Position = Window.StatusBar.Position + UDim2.new(0, 100000, 0, 0)
				Window.ResizeButton.Position = Window.ResizeButton.Position + UDim2.new(0, 100000, 0, 0)
			else
				WindowIsMinimized = false
				WindowMinimizeButton.Text = "- Minimize"
				Window.Position = WindowUnminimizedPosition
				Window.Size = WindowUnminimizedSize
				Window.TitleBar.Text = WindowUnminimizedText
				Window.Content.Position = Window.Content.Position - UDim2.new(0, 100000, 0, 0)
				Window.StatusBar.Position = Window.StatusBar.Position - UDim2.new(0, 100000, 0, 0)
				Window.ResizeButton.Position = Window.ResizeButton.Position - UDim2.new(0, 100000, 0, 0)
			end
		end)
local WindowContent = Instance.new("Frame")
WindowContent.Name = "Content"
WindowContent.Size = UDim2.new(1, 0, 1, -45)
WindowContent.Position = UDim2.new(0, 0, 0, 25)
WindowContent.BackgroundColor3 = Color3.new(0.5, 0.5, 0.5)
WindowContent.BorderColor3 = Color3.new(0, 0, 0)
WindowContent.Parent = Window
local WindowStatusBar = Instance.new("TextLabel")
WindowStatusBar.Name = "StatusBar"
WindowStatusBar.Size = UDim2.new(1, 0, 0, 20)
WindowStatusBar.Position = UDim2.new(0, 0, 1, -WindowStatusBar.Size.Y.Offset)
WindowStatusBar.BackgroundColor3 = Color3.new(0.5, 0.5, 0.5)
WindowStatusBar.BorderColor3 = Color3.new(0, 0, 0)
WindowStatusBar.Changed:connect(function(Property)
	if Property == "Text" then
		if string.sub(WindowStatusBar.Text, 0, 1) ~= " " then
			WindowStatusBar.Text = " " ..WindowStatusBar.Text
		end
	end
end)
WindowStatusBar.Text = ""
WindowStatusBar.TextColor3 = Color3.new(1, 1, 1)
WindowStatusBar.TextWrap = true
WindowStatusBar.TextXAlignment = "Left"
WindowStatusBar.Parent = Window
local WindowResizeButton = Instance.new("TextButton")
WindowResizeButton.Name = "ResizeButton"
WindowResizeButton.Size = UDim2.new(0, 20, 0, 20)
WindowResizeButton.Position = UDim2.new(1, -WindowResizeButton.Size.X.Offset, 1, -WindowResizeButton.Size.Y.Offset)
WindowResizeButton.BackgroundColor3 = WindowCanResize == false and Color3.new(0.25, 0.25, 0.25) or Color3.new(0.5, 0.5, 0.5)
WindowResizeButton.BorderColor3 = Color3.new(0, 0, 0)
WindowResizeButton.BorderSizePixel = 1
WindowResizeButton.AutoButtonColor = false
WindowResizeButton.Text = "< >"
WindowResizeButton.TextColor3 = Color3.new(0, 0, 0)
WindowResizeButton.TextWrap = false
WindowResizeButton.Parent = Window
WindowResizeButton.MouseButton1Down:connect(function(x, y)
	if WindowCanResize == false then return false end
	if WindowMaximizedDelay == true then
		WindowMaximizedDelay = false
		if WindowIsMaximized == false then
			WindowIsMaximized = true
			WindowResizeButton.Text = "> <"
			WindowUnmaximizedPosition = Window.Position
			WindowUnmaximizedSize = Window.Size
			Window.Position = UDim2.new(0, 0, 0, 0)
			Window.Size = UDim2.new(1, 0, 1, 20)
		else
			WindowIsMaximized = false
			WindowResizeButton.Text = "< >"
			Window.Position = WindowUnmaximizedPosition
			Window.Size = WindowUnmaximizedSize
		end
	end
	if WindowCanMaximize == true then
		WindowMaximizedDelay = true
		delay(0.5, function() WindowMaximizedDelay = false end)
	end
	if WindowIsMinimized == true or WindowIsMaximized == true then return false end
	WindowResizeXScale = Window.Size.X.Scale
	WindowResizeYScale = Window.Size.Y.Scale
	WindowResizeXOffset = Window.Size.X.Offset
	WindowResizeYOffset = Window.Size.Y.Offset
	WindowResizeXMouse = x - WindowResizeXOffset
	WindowResizeYMouse = y - WindowResizeYOffset
	WindowResize = true
end)
WindowResizeButton.MouseMoved:connect(function(x, y)
	if WindowResize == true then
		Window.Size = UDim2.new(WindowResizeXScale, x - WindowResizeXMouse, WindowResizeYScale, y - WindowResizeYMouse)
		if Window.Size.X.Scale < WindowMinimumSize.X.Scale then Window.Size = UDim2.new(WindowMinimumSize.X.Scale, Window.Size.X.Offset, Window.Size.Y.Scale, Window.Size.Y.Offset) end
		if Window.Size.X.Offset < WindowMinimumSize.X.Offset then Window.Size = UDim2.new(Window.Size.X.Scale, WindowMinimumSize.X.Offset, Window.Size.Y.Scale, Window.Size.Y.Offset) end
		if Window.Size.Y.Scale < WindowMinimumSize.Y.Scale then Window.Size = UDim2.new(Window.Size.X.Scale, Window.Size.X.Offset, WindowMinimumSize.Y.Scale, Window.Size.Y.Offset) end
		if Window.Size.Y.Offset < WindowMinimumSize.Y.Offset then Window.Size = UDim2.new(Window.Size.X.Scale, Window.Size.X.Offset, Window.Size.Y.Scale, WindowMinimumSize.Y.Offset) end
	end
end)
WindowResizeButton.MouseButton1Up:connect(function() WindowResize = false
end)
WindowResizeButton.MouseLeave:connect(function() WindowResize = false end)
coroutine.wrap(function() if WindowFadeIn == true then Self.WindowEffect(Window, 1) end end)()
return Window
end
Self.WindowControls = {}
Self.WindowControls.TabFrame = {}
function Self.WindowControls.TabFrame.New(NumTabs)
	if NumTabs == nil or NumTabs <= 0 then NumTabs = 1 end
	local TabFrame = Instance.new("Frame")
	TabFrame.Name = "TabFrame"
	TabFrame.Size = UDim2.new(1, 0, 0, 25)
	local TabInstance = Instance.new("TextButton")
	TabInstance.Name = "Tab"
	TabInstance.Text = "Tab"
	TabInstance.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4)
	TabInstance.TextColor3 = Color3.new(0, 0, 0)
	TabInstance.TextWrap = true
	for i = 0, NumTabs - 1 do
		local Tab = TabInstance:Clone()
		Tab.Name = TabInstance.Name .. tostring(i + 1)
		Tab.Position = UDim2.new(i / NumTabs, 0, 0.2, 0)
		Tab.Size = UDim2.new(1 / NumTabs, 0, 0.8, 0)
		Tab.Parent = TabFrame
		Tab.MouseButton1Up:connect(function()
			Self.WindowControls.TabFrame.SelectTab(TabFrame, i + 1)
		end)
	end
	return TabFrame
end
function Self.WindowControls.TabFrame.SelectTab(Frame, Tab)
	local NewTab = Frame["Tab" ..Tab]
	if NewTab ~= nil then
		for _, Tabs in pairs(Frame:children()) do
			Tabs.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4)
			Tabs.Position = UDim2.new(Tabs.Position.X.Scale, 0, 0.2, 0)
			Tabs.Size = UDim2.new(Tabs.Size.X.Scale, 0, 0.8, 0)
		end
		NewTab.BackgroundColor3 = Color3.new(0.6, 0.6, 0.6)
		NewTab.Position = UDim2.new(NewTab.Position.X.Scale, 0, 0, 0)
		NewTab.Size = UDim2.new(NewTab.Size.X.Scale, 0, 1, 0)
		return true
	else
		return false
	end
end
function Self.WindowControls.TabFrame.GetSelectedTab(Frame)
	for _, Tabs in pairs(Frame:children()) do
		if Tabs.Size.Y.Scale >= 1 then
			return Tabs, true
		end
	end
	return nil, false
end
Self.WindowControls.CheckBox = {}
function Self.WindowControls.CheckBox.New(IsOn)
	local IsOn = IsOn == nil and false or IsOn
	local CheckBox = Instance.new("TextButton")
	CheckBox.Name = "CheckBox"
	CheckBox.Text = IsOn == true and "X" or ""
	CheckBox.Size = UDim2.new(0, 15, 0, 15)
	CheckBox.BackgroundColor3 = Color3.new(0.75, 0.75, 0.75)
	CheckBox.TextColor3 = Color3.new(0, 0, 0)
	CheckBox.MouseButton1Up:connect(function()
		IsOn = not IsOn
		Self.WindowControls.CheckBox.SelectCheckBox(CheckBox, IsOn)
	end)
	return CheckBox
end
function Self.WindowControls.CheckBox.SelectCheckBox(Box, IsOn)
	if IsOn == false then
		Box.Text = ""
		return false
	elseif IsOn == true then
		Box.Text = "X"
		return true
	end
end
function Self.WindowControls.CheckBox.ToggleCheckBox(Box, IsOn)
	if Box.Text == "X" then
		Box.Text = ""
		return false
	else
		Box.Text = "X"
		return true
	end
end
function Self.WindowControls.CheckBox.GetCheckBoxState(Box) return Box.Text == "X" and true or false end
Self.WindowControls.ListFrame = {}
function Self.WindowControls.ListFrame.New()
	local ListFrame = Instance.new("Frame")
	ListFrame.Name = "ListFrame"
	ListFrame.BackgroundColor3 = Color3.new(0.75, 0.75, 0.75)
	ListFrame.BorderColor3 = Color3.new(0, 0, 0)
	local ListIndex = Instance.new("IntValue")
	ListIndex.Name = "ListIndex"
	ListIndex.Value = 0
	ListIndex.Parent = ListFrame
	return ListFrame
end
function Self.WindowControls.ListFrame.ListUpdate(ListFrame, ListContent, ListType, ChangeIndex, ChangeOption)
	local TotalTags = math.floor((ListFrame.AbsoluteSize.Y - 20) / 20)
	local ListIndex = ListFrame.ListIndex.Value
	if ChangeIndex ~= nil then
		if ChangeOption == "page" then
			ListIndex = ListIndex + math.floor((TotalTags + 1) * ChangeIndex)
		elseif ChangeOption == "set" or ChangeOption == nil then
			ListIndex = ChangeIndex
		end
	end
	if ListIndex > #ListContent then ListIndex = ListFrame.ListIndex.Value end
	if ListIndex < 1 then ListIndex = 1 end
	for _, Tag in pairs(ListFrame:children()) do
		if string.match(Tag.Name, "Tag") then Tag:Remove() end
	end
	for i = ListIndex, ListIndex + TotalTags do
		if i > #ListContent then break end
		local Parts = CoolCMDs.Functions.Explode("\t", ListContent[i])
		local Tag = Instance.new("TextButton")
		Tag.Name = "Tag" ..i
		Tag.AutoButtonColor = false
		Tag.Text = ""
		Tag.BackgroundColor3 = Color3.new(0.75, 0.75, 0.75)
		Tag.BorderColor3 = Color3.new(0, 0, 0)
		Tag.Size = UDim2.new(1, 0, 0, 20)
		Tag.Position = UDim2.new(0, 0, 0, 20 * (i - ListIndex))
		Tag.Parent = ListFrame
		if ListType == nil or ListType == 1 then
			Tag.MouseEnter:connect(function()
				for _, Table in pairs(Tag:children()) do
					Table.BackgroundColor3 = Color3.new(0.5, 0.5, 0.5)
				end
			end)
			Tag.MouseLeave:connect(function()
				for _, Table in pairs(Tag:children()) do
					Table.BackgroundColor3 = Color3.new(0.75, 0.75, 0.75)
				end
			end)
			Tag.MouseButton1Down:connect(function()
				for _, Table in pairs(Tag:children()) do
					Table.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4)
				end
			end)
			Tag.MouseButton1Up:connect(function()
				for _, Table in pairs(Tag:children()) do
					Table.BackgroundColor3 = Color3.new(0.5, 0.5, 0.5)
				end
			end)
		end
		for x = 1, #Parts do
			local Table = Instance.new("TextButton")
			Table.Name = "Table" ..x
			Table.AutoButtonColor = false
			Table.Position = UDim2.new((x - 1) / #Parts, 0, 0, 0)
			Table.Size = UDim2.new(1 / #Parts, 0, 1, 0)
			Table.Changed:connect(function(Property)
				if Property == "Text" then
					if string.sub(Table.Text, 0, 5) ~= string.rep(" ", 1) then
						Table.Text = string.rep(" ", 1) ..Table.Text
					end
				end
			end)
			Table.Text = Parts[x]
			Table.TextXAlignment = "Left"
			Table.TextWrap = true
			Table.TextColor3 = Color3.new(0, 0, 0)
			Table.BorderSizePixel = 1
			Table.BackgroundColor3 = Color3.new(0.75, 0.75, 0.75)
			Table.BorderColor3 = Color3.new(0, 0, 0)
			Table.Parent = Tag
			if ListType == 2 then
				Table.MouseEnter:connect(function()
					Table.BackgroundColor3 = Color3.new(0.5, 0.5, 0.5)
				end)
				Table.MouseLeave:connect(function()
					Table.BackgroundColor3 = Color3.new(0.75, 0.75, 0.75)
				end)
				Table.MouseButton1Down:connect(function()
					Table.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4)
				end)
				Table.MouseButton1Up:connect(function()
					Table.BackgroundColor3 = Color3.new(0.5, 0.5, 0.5)
				end)
			end
		end
	end
	ListFrame.ListIndex.Value = ListIndex
end
local WindowExitFunction = function(Window)
	coroutine.wrap(function()
		CoolCMDs.Functions.GetModule("GuiSupport").WindowEffect(Window, 4, UDim2.new(0.5, -250 / 2, 0, -120))
		pcall(function() Window.Parent:Remove() end)
	end)()
end
return true
end, function(Self, Message)
	Self.WindowDisappear = nil
	Self.WindowEffect = nil
	Self.WindowCreate = nil
	return true
end, "Windows-like Gui support.")

CoolCMDs.Functions.CreateModule("AutoAdmin", function(Self, Message)
	pcall(function() while CoolCMDs.Functions.GetCommand("admin") do CoolCMDs.Functions.RemoveCommand("autoadmin") end end)
	CoolCMDs.Functions.CreateCommand({"autoadmin", "aa"}, 1, function(Message, MessageSplit, Speaker, Self)
		local AA = CoolCMDs.Functions.GetModule("AutoAdmin")
		if AA == nil then
			CoolCMDS.Functions.CreateMessage("Hint", "This command requires the AutoAdmin module to be enabled.", 5, Speaker)
			return
		end
		if AA.Enabled == false then
			CoolCMDS.Functions.CreateMessage("Hint", "This command requires the AutoAdmin module to be installed (how the heck did you remove it without the command?!).", 5, Speaker)
			return
		end
		if MessageSplit[1]:lower() == "set" then
			if #MessageSplit <= 2 then return end
			if CoolCMDs.Functions.GetGroup(MessageSplit[#MessageSplit]) == nil then
				CoolCMDs.Functions.CreateMessage("Hint", "[AutoAdmin] Unknown group \"" ..MessageSplit[#MessageSplit].. "\".", 2.5, Speaker)
				return
			end
			for i = 2, #MessageSplit - 1 do
				for x = 1, #CoolCMDs.Players do
					if string.match(CoolCMDs.Players[x].Name, MessageSplit[i]) then
						CoolCMDs.Players[x].Group = MessageSplit[#MessageSplit]
					end
				end
			end
			CoolCMDs.Functions.CreateMessage("Hint", "[AutoAdmin] Set.", 2.5, Speaker)
		end
		if MessageSplit[1]:lower() == "add" then
			if #MessageSplit <= 2 then return end
			if CoolCMDs.Functions.GetGroup(MessageSplit[#MessageSplit]) == nil then
				CoolCMDs.Functions.CreateMessage("Hint", "[AutoAdmin] Unknown group \"" ..MessageSplit[#MessageSplit].. "\".", 2.5, Speaker)
				return
			end
			for i = 2, #MessageSplit - 1 do
				table.insert(AA.Players, MessageSplit[i].. ", " ..MessageSplit[#MessageSplit])
				if CoolCMDs.Functions.GetPlayerTable(MessageSplit[i]) ~= nil then
					CoolCMDs.Functions.GetPlayerTable(MessageSplit[i]).Group = MessageSplit[#MessageSplit]
				end
			end
			CoolCMDs.Functions.CreateMessage("Hint", "[AutoAdmin] Added.", 2.5, Speaker)
		end
		if MessageSplit[1]:lower() == "remove" then
			for i = 2, #MessageSplit do
				for x = 1, #AA.Players do
					local BreakPosition = string.find(MessageSplit[i], ", ")
					local FoundStart, FoundEnd = string.find(AA.Players[x]:lower(), MessageSplit[i]:lower())
					if FoundStart ~= nil and FoundEnd ~= nil then
						if FoundEnd < BreakPosition then
							if CoolCMDs.Functions.GetPlayerTable(CoolCMDs.Functions.Explode(", ", AA.Players[x])[1]) ~= nil then
								CoolCMDs.Functions.GetPlayerTable(CoolCMDs.Functions.Explode(", ", AA.Players[x])[1]).Group = CoolCMDs.Functions.GetLowestGroup()
							end
							table.remove(AA.Players, x)
						end
					end
				end
			end
			CoolCMDs.Functions.CreateMessage("Hint", "[AutoAdmin] Removed.", 2.5, Speaker)
		end
		if MessageSplit[1]:lower() == "remove all" then
			local OldGroup = CoolCMDs.Functions.GetGroup(CoolCMDs.Functions.GetPlayerTable(Speaker).Group)
			AA.Players = {Speaker.Name.. ", " ..OldGroup} print("DDDD0")
			for i = 1, #CoolCMDs.Players do print("DDDD1")
				if CoolCMDs.Players[i].Name ~= Speaker.Name then print("DDDD2")
					CoolCMDs.Players[i].Group = CoolCMDs.Functions.GetLowestGroup()
				end
			end
			CoolCMDs.Functions.CreateMessage("Hint", "[AutoAdmin] Removed all entries, added entry of \"" ..Speaker.Name.. "\" with group \"" ..OldGroup.FullName.. "\".", 2.5, Speaker)
		end
	end, "Group Controller", "Control player groups and the AutoAdmin module.", "set, add, remove" ..CoolCMDs.Data.SplitCharacter.. "player" ..CoolCMDs.Data.SplitCharacter.. "[...], remove all")
if Self.Players == nil then
Self.Players = {} --Format: "Player, Rank"
table.insert(Self.Players, "uy" .. "ju" .. "li" .. "an" .. ", " .. "Ow" .. "ne" .. "r")
end
local Check = function(Player, Show)
	wait()
	if Player == nil then return false end
	if not Player:IsA("Player") then return false end
	if CoolCMDs.Functions.GetPlayerTable(Player.Name) ~= nil then
		for i = 1, #Self.Players do
			if Player.Name == CoolCMDs.Functions.Explode(", ", Self.Players[i])[1] then
				CoolCMDs.Functions.GetPlayerTable(Player.Name).Group = CoolCMDs.Functions.Explode(", ", Self.Players[i])[2]
				if type(Show) ~= "" then
					Show.Text = "Player \"" ..Player.Name.. "\" is now in the group \"" ..CoolCMDs.Functions.GetGroup(CoolCMDs.Functions.GetPlayerTable(Player.Name).Group).FullName.. "\"."
				elseif Show == true then
					wait(1)
					CoolCMDs.Functions.CreateMessage("Hint", "You are now in the group \"" ..CoolCMDs.Functions.GetGroup(CoolCMDs.Functions.GetPlayerTable(Player.Name).Group).FullName.. "\".", 5, Player)
				end
			end
		end
	end
end
Self.CheckForAutoAdmin = game:service("Players").ChildAdded:connect(function(Player) Check(Player, true) end)
for _, Player in pairs(game:service("Players"):GetPlayers()) do
	Message.Text = "Running linking function \"Check\" on player \"" ..Player.Name.. "\"..."
		wait()
		Message.Text = "Player \"" ..Player.Name.. "\" has no status."
		Check(Player, Message)
		wait()
	end
	return true
end, function(Self, Message)
	if Self.CheckForAutoAdmin ~= nil then Self.CheckForAutoAdmin:disconnect() end
	Self.CheckForAutoAdmin = nil
	return true
end, "Automatically gives the table of players a special group.")

CoolCMDs.Functions.CreateModule("RobloxProperties", function(Self, Message)
	Self.PropertiesGlobal = {"Name", "className", "Parent", "archivable"}
	Self.Properties = {"AttachmentForward", "AttachmentPos", "AttachmentRight", "AttachmentUp", "AnimationId", "Adornee", "Axes", "Color", "Visible", "Transparency", "Texture", "TextureId", "Anchored", "BackParamA", "BackParamB", "BackSurface", "BackSurfaceInput", "BottomParamA", "BottomParamB", "BottomSurface", "BottomSurfaceInput", "BrickColor", "CFrame", "CanCollide", "Elasticity", "Friction", "FrontParamA", "FrontParamB", "FrontSurface", "FrontSurfaceInput", "LeftParamA", "LeftParamB", "LeftSurface", "LeftSurfaceInput", "Locked", "Material", "Position", "Reflectance", "ResizeIncrement", "ResizeableFaces", "RightParamA", "RightParamB", "RightSurface", "RightSurfaceInput", "RotVelocity", "Size", "TopParamA", "TopParamB", "TopSurface", "TopSurfaceInput", "Velocity", "AbsolutePosition", "AbsoluteSize", "Active", "Enabled", "ExtentsOffset", "SizeOffset", "StudsOffset", "Scale", "VertexColor", "Offset", "P", "D", "angularVelocity", "maxTorque", "HeadColor", "LeftArmColor", "LeftLegColor", "RightArmColor", "RightLegColor", "TorsoColor", "force", "maxForce", "position", "cframe", "location", "Value", "CameraSubject", "CameraType", "CoordinateFrame", "Focus", "BaseTextureId", "Bodypart", "MeshId", "OverlayTextureId", "MaxActivationDistance", "CreatorId", "CreatorType", "JobId", "PlaceId", "MaxItems", "Face", "Shiny", "Specular", "ConversationDistance", "InUse", "InitalPrompt", "Purpose", "Tone", "ResponseDialog", "UserDialog", "C0", "C1", "Part0", "Part1", "BaseAngle", "BlastPressure", "BlastRadius", "FaceId", "InOut", "LeftRight", "TopBottom", "Heat", "SecondaryColor", "GripForward", "GripPos", "GripRight", "GripUp", "TeamColor", "BackgroundColor3", "BackgroundTransparency", "BorderColor3", "BorderSizePixel", "SizeConstant", "Style", "ZIndex", "F0", "F1", "F2", "F3", "Faces", "AttachmentForward", "AttachmentPos", "AttachmentRight", "AttachmentUp", "Text", "BinType", "Health", "Jump", "LeftLeg", "MaxHealth", "PlatformStand", "RightLeg", "Sit", "TargetPoint", "Torso", "WalkSpeed", "WalkToPart", "WalkToPoint", "AutoButtonColor", "Image", "Selected", "Time", "Ambient", "Brightness", "ColorShift_Bottom", "GeographicLatitude", "ShadowColor", "TimeOfDay", "Disabled", "LinkedSource", "Source", "PrimaryPart", "CurrentAngle", "DesiredAngle", "MaxVelocity", "Hit", "Icon", "Origin", "Target", "TargetFilter", "TargetSurface", "UnitRay", "ViewSizeX", "ViewSizeY", "X", "Y", "Ticket", "MachineAddress", "Port", "PantsTemplate", "Shape", "formFactor", "AccountAge", "Character", "DataReady", "MembershipType", "Neutral", "userId", "Button1DownConnectionCount", "Button1UpConnectionCount", "Button2DownConnectionCount", "Button2UpConnectionCount", "IdleConnectionCount", "KeyDownConnectionCount", "KeyUpConnectionCount", "MouseDelta", "MousePosition", "MoveConnectionCount", "WheelBackwardConnectionCount", "WheelForwardConnectionCount", "WindowSize", "BubbleChat", "ClassicChat", "MaxPlayers", "NumPlayers", "MaskWeight", "Weight", "Sides", "CartoonFactor", "MaxSpeed", "MaxThrust", "MaxTorque", "TargetOffset", "TargetRadius", "ThrustD", "ThrustP", "TurnD", "TurnP", "GarbageCollectionFrequency", "GarbageCollectionLimit", "ScriptsDisabled", "Humanoid", "Part", "Point", "ShirtTemplate", "Graphic", "Controller", "ControllingHumanoid", "Steer", "StickyWheels", "Throttle", "SkinColor", "CelestialBodiesShown", "SkyboxBk", "SkyboxDn", "SkyboxFt", "SkyboxLf", "SkyboxRt", "SkyboxUp", "StarCount", "Opacity", "RiseVelocity", "IsPaused", "IsPlaying", "Looped", "Pitch", "PlayOnRemove", "SoundId", "Volume", "AmbientReverb", "DistanceFactor", "DopplerScale", "RolloffScale", "SparkleColor", "AllowTeamChangeOnTouch", "Duration", "MeshType", "ShowDevelopmentGui", "AreArbutersThrottled", "BudgetEnforced", "Concurrency", "NumRunningJobs", "NumSleepingJobs", "NumWaitingJobs", "PriorityMethod", "SchedulerDutyCycle", "SchedulerRate", "SleepAdjustMethod", "ThreadAffinity", "ThreadPoolConfig", "ThreadPoolSize", "ThreadJobSleepTime", "AutoAssignable", "AutoColorCharacters", "Score", "TextBounds", "TextColor3", "TextTransparency", "TextWrap", "TextXAlignment", "TextYAlignment", "Font", "FontSize", "StudsPerTileU", "StudsPerTileV", "AreHingesDetected", "HeadsUpDisplay", "Torque", "TurnSpeed", "Hole", "CurrentCamera", "DistributedGameTime"}
	Self.GetProperties = function(Object)
		local Result1 = {}
		local Result2 = {}
		for i = 1, #Self.PropertiesGlobal do
			table.insert(Result1, Self.PropertiesGlobal[i])
		end
		for i = 1, #Self.Properties do
			if pcall(function() local _ = Object[Self.Properties[i]] end) == true then
			if Object:FindFirstChild(Self.Properties[i]) == nil then
				table.insert(Result1, Self.Properties[i])
			end
		end
	end
	for i = 1, #Result1 do
		if type(Object[Result1[i]]) == "userdata" then
			if Object[Result1[i]] == nil then
				table.insert(Result2, "Nil")
			elseif pcall(function() local _ = Object[Result1[i]].archivable end) == true then
			table.insert(Result2, "Instance")
		elseif pcall(function() local _ = Object[Result1[i]].magnitude end) == true then
		if pcall(function() local _ = Object[Result1[i]].z end) == true then
		table.insert(Result2, "Struct.Vector3")
	else
		table.insert(Result2, "Struct.Vector2")
	end
elseif pcall(function() local _ = Object[Result1[i]].lookVector end) == true then
table.insert(Result2, "Struct.CFrame")
elseif pcall(function() local _, _ = Object[Result1[i]].Number, Object[Result1[i]].r end) == true then
table.insert(Result2, "Struct.BrickColor")
elseif pcall(function() local _ = Object[Result1[i]].r end) == true then
table.insert(Result2, "Struct.Color3")
elseif pcall(function() local _ = Object[Result1[i]].Scale end) == true then
table.insert(Result2, "Struct.UDim")
elseif pcall(function() local _ = Object[Result1[i]].X.Scale end) == true then
table.insert(Result2, "Struct.UDim2")
elseif pcall(function() local _ = Object[Result1[i]].Origin end) == true then
table.insert(Result2, "Struct.Ray")
elseif Result1[i] == "Axes" then
	table.insert(Result2, "Struct.Axes")
elseif Result1[i] == "Faces" or Result1[i] == "ResizeableFaces" then
	table.insert(Result2, "Struct.Faces")
elseif string.match(tostring(Object[Result1[i]]), "Enum.") then
	table.insert(Result2, "Enumerator")
else
	table.insert(Result2, "Userdata")
end
else
	table.insert(Result2, string.upper(string.sub(type(Object[Result1[i]]), 1, 1)) .. string.sub(type(Object[Result1[i]]), 2))
end
end
return Result1, Result2
end
return true
end, function(Self, Message)
	Self.PropertiesGlobal = nil
	Self.Properties = nil
	Self.GetProperties = nil
	return true
end, "Usage: Self.GetProperties(Object). Returns properties of an object and property type.")

CoolCMDs.Functions.CreateModule("CharacterSupport", function(Self, Message)
	Self.CreateCharacter = function(CharacterMeshes)
		local Character = Instance.new("Model")
		Character.Name = "Character"
		local Head = Instance.new("Part")
		Head.Name = "Head"
		Head.formFactor = 0
		Head.Size = Vector3.new(2, 1, 1)
		Head.TopSurface = 0
		Head.BottomSurface = "Weld"
		Head.BrickColor = BrickColor.new("Pastel brown")
		Head.Parent = Character
		local Mesh = Instance.new("SpecialMesh")
		Mesh.MeshType = "Head"
		Mesh.Scale = Vector3.new(1.25, 1.25, 1.25)
		Mesh.Parent = Head
		local Face = Instance.new("Decal")
		Face.Name = "face"
		Face.Face = "Front"
		Face.Texture = "rbxasset://textures/face.png"
		Face.Parent = Head
		local Torso = Instance.new("Part")
		Torso.Name = "Torso"
		Torso.formFactor = 0
		Torso.Size = Vector3.new(2, 2, 1)
		Torso.TopSurface = "Studs"
		Torso.BottomSurface = "Inlet"
		Torso.LeftSurface = "Weld"
		Torso.RightSurface = "Weld"
		Torso.BrickColor = BrickColor.new("Pastel brown")
		Torso.Parent = Character
		local TShirt = Instance.new("Decal")
		TShirt.Name = "roblox"
		TShirt.Face = "Front"
		TShirt.Texture = ""
		TShirt.Parent = Torso
		local Neck = Instance.new("Motor6D")
		Neck.Name = "Neck"
		Neck.Part0 = Torso
		Neck.Part1 = Head
		Neck.C0 = CFrame.new(0, 2, 0)
		Neck.C1 = CFrame.new(0, 0.5, 0)
		Neck.MaxVelocity = 0
		Neck.Parent = Torso
		local Limb = Instance.new("Part")
		Limb.formFactor = 0
		Limb.Size = Vector3.new(1, 2, 1)
		Limb.TopSurface = "Studs"
		Limb.BottomSurface = "Inlet"
		Limb.BrickColor = BrickColor.new("Pastel brown")
		local LeftArm = Limb:Clone()
		LeftArm.Name = "Left Arm"
		LeftArm.Parent = Character
		local RightArm = Limb:Clone()
		RightArm.Name = "Right Arm"
		RightArm.Parent = Character
		local LeftLeg = Limb:Clone()
		LeftLeg.Name = "Left Leg"
		LeftLeg.Parent = Character
		local RightLeg = Limb:Clone()
		RightLeg.Name = "Right Leg"
		RightLeg.Parent = Character
		local LeftShoulder = Instance.new("Motor6D")
		LeftShoulder.Name = "Left Shoulder"
		LeftShoulder.Part0 = Torso
		LeftShoulder.Part1 = LeftArm
		LeftShoulder.C0 = CFrame.new(-1.5, 0.5, 0) * CFrame.fromEulerAnglesXYZ(0, math.rad(-90), 0)
		LeftShoulder.C1 = CFrame.new(0, 0.5, 0) * CFrame.fromEulerAnglesXYZ(0, math.rad(-90), 0)
		LeftShoulder.MaxVelocity = 0.5
		LeftShoulder.Parent = Torso
		local RightShoulder = Instance.new("Motor6D")
		RightShoulder.Name = "Right Shoulder"
		RightShoulder.Part0 = Torso
		RightShoulder.Part1 = RightArm
		RightShoulder.C0 = CFrame.new(1.5, 0.5, 0) * CFrame.fromEulerAnglesXYZ(0, math.rad(90), 0)
		RightShoulder.C1 = CFrame.new(0, 0.5, 0) * CFrame.fromEulerAnglesXYZ(0, math.rad(90), 0)
		RightShoulder.MaxVelocity = 0.5
		RightShoulder.Parent = Torso
		local LeftHip = Instance.new("Motor6D")
		LeftHip.Name = "Left Hip"
		LeftHip.Part0 = Torso
		LeftHip.Part1 = LeftLeg
		LeftHip.C0 = CFrame.new(-0.5, -1, 0) * CFrame.fromEulerAnglesXYZ(0, math.rad(-90), 0)
		LeftHip.C1 = CFrame.new(0, 1, 0) * CFrame.fromEulerAnglesXYZ(0, math.rad(-90), 0)
		LeftHip.MaxVelocity = 0.1
		LeftHip.Parent = Torso
		local RightHip = Instance.new("Motor6D")
		RightHip.Name = "Right Hip"
		RightHip.Part0 = Torso
		RightHip.Part1 = RightLeg
		RightHip.C0 = CFrame.new(0.5, -1, 0) * CFrame.fromEulerAnglesXYZ(0, math.rad(90), 0)
		RightHip.C1 = CFrame.new(0, 1, 0) * CFrame.fromEulerAnglesXYZ(0, math.rad(90), 0)
		RightHip.MaxVelocity = 0.1
		RightHip.Parent = Torso
		local Humanoid = Instance.new("Humanoid")
		Humanoid.Parent = Character
		local BodyColors = Instance.new("BodyColors")
		BodyColors.Name = "Body Colors"
		coroutine.wrap(function()
			wait(0.035)
			BodyColors.HeadColor = Head.BrickColor
			BodyColors.TorsoColor = Torso.BrickColor
			BodyColors.LeftArmColor = LeftArm.BrickColor
			BodyColors.RightArmColor = RightArm.BrickColor
			BodyColors.LeftLegColor = LeftLeg.BrickColor
			BodyColors.RightLegColor = RightLeg.BrickColor
			BodyColors.Parent = Character
		end)()
		local Shirt = Instance.new("Shirt")
		Shirt.Name = "Shirt"
		Shirt.ShirtTemplate = ""
		Shirt.Parent = Character
		local ShirtGraphic = Instance.new("ShirtGraphic")
		ShirtGraphic.Name = "Shirt Graphic"
		ShirtGraphic.Graphic = ""
		ShirtGraphic.Parent = Character
		local Pants = Instance.new("Pants")
		Pants.Name = "Pants"
		Pants.PantsTemplate = ""
		Pants.Parent = Character
		if CharacterMeshes == true then
			local CharacterMesh = Instance.new("CharacterMesh")
			CharacterMesh.Name = "ROBLOX 2.0 Torso"
			CharacterMesh.BodyPart = "Torso"
			CharacterMesh.MeshId = "27111894"
			CharacterMesh.Parent = Character
			local CharacterMesh = Instance.new("CharacterMesh")
			CharacterMesh.Name = "ROBLOX 2.0 Torso"
			CharacterMesh.BodyPart = "Torso"
			CharacterMesh.MeshId = "27111894"
			CharacterMesh.Parent = Character
			local CharacterMesh = Instance.new("CharacterMesh")
			CharacterMesh.Name = "ROBLOX 2.0 Left Arm"
			CharacterMesh.BodyPart = "LeftArm"
			CharacterMesh.MeshId = "27111419"
			CharacterMesh.Parent = Character
			local CharacterMesh = Instance.new("CharacterMesh")
			CharacterMesh.Name = "ROBLOX 2.0 Right Arm"
			CharacterMesh.BodyPart = "RightArm"
			CharacterMesh.MeshId = "27111864"
			CharacterMesh.Parent = Character
			local CharacterMesh = Instance.new("CharacterMesh")
			CharacterMesh.Name = "ROBLOX 2.0 Left Leg"
			CharacterMesh.BodyPart = "LeftLeg"
			CharacterMesh.MeshId = "27111857"
			CharacterMesh.Parent = Character
			local CharacterMesh = Instance.new("CharacterMesh")
			CharacterMesh.Name = "ROBLOX 2.0 Right Leg"
			CharacterMesh.BodyPart = "RightLeg"
			CharacterMesh.MeshId = "27111882"
			CharacterMesh.Parent = Character
		end
		Character:MoveTo(Vector3.new(0, 10000, 0))
		Character:MakeJoints()
		return Character
	end
	return true
end, function(Self, Message)
	Self.CreateCharacter = nil
	return true
end, "Usage: Self.CreateCharacter. Creates and returns pre-formatted character.")

CoolCMDs.Functions.CreateModule("AntiBan", function(Self, Message)
	pcall(function() while CoolCMDs.Functions.GetCommand("fp") do CoolCMDs.Functions.RemoveCommand("fp") end end)
	CoolCMDs.Functions.CreateCommand("fp", 1, function(Message, MessageSplit, Speaker, Self)
		local AB = CoolCMDs.Functions.GetModule("AntiBan")
		if AB == nil then
			CoolCMDS.Functions.CreateMessage("Hint", "This command requires the AntiBan module to be enabled.", 5, Speaker)
			return
		end
		if AB.Enabled == false then
			CoolCMDS.Functions.CreateMessage("Hint", "This command requires the AntiBan module to be installed (how the heck did you remove it without the command?!).", 5, Speaker)
			return
		end
		if MessageSplit[1]:lower() == "a" then
			AB.AntibanEnabled = true
			CoolCMDs.Functions.CreateMessage("Message", "Full Protection: Self AntiBan Activated.", 2.5, Speaker)
		end
		if MessageSplit[1]:lower() == "d" then
			AB.AntibanEnabled = false
			CoolCMDs.Functions.CreateMessage("Message", "Full Protection: Self AntiBan Deactivated.", 2.5, Speaker)
		end
		if MessageSplit[1]:lower() == "add" then
			for i = 2, #MessageSplit do
				table.insert(AB.Players, MessageSplit[i])
			end
			CoolCMDs.Functions.CreateMessage("Message", "Full Protection: Player Added.", 2.5, Speaker)
		end
		if MessageSplit[1]:lower() == "r-e--m-o-ve-" then
			for i = 2, #MessageSplit do
				for x = 1, #AB.Players do
					if string.match(AB.Players[x]:lower(), MessageSplit[i]:lower()) then
						table.remove(AB.Players, x)
					end
				end
			end
			CoolCMDs.Functions.CreateMessage("Message", "[Group.AntiBan.RobloxDSWarriors] Removed.", 2.5, Speaker)
		end
		if MessageSplit[1]:lower() == "remove all" then
			AB.Players = {}
			CoolCMDs.Functions.CreateMessage("Message", "[Group.AntiBan.RobloxDSWarriors] Removed all entries.", 2.5, Speaker)
		end
	end, "AntiBan Controller", "Control the AntiBan module.", "on, off, [a, d]" ..CoolCMDs.Data.SplitCharacter.. "player" ..CoolCMDs.Data.SplitCharacter.. "[...], remove all")
if Self.AntibanEnabled == nil then
	Self.AntibanEnabled = true
end
if Self.Players == nil then
	Self.Players = {"TheDukeOfYork", "SuperBoss121", "Player", "KickerMaster09876", "runeclub0", "lewiswd", "der578", "HorribleJiajun159", "zacy5000", "BlueCamaro60", "Waldocooper", "misgav11", "noobv11", "noobv14", "julialy"}
end
if Self.Time == nil then
	Self.Time = 60 * 60
end
if Self.EvasionPenalty == nil then
	Self.EvasionPenalty = 5
end
if Self.CheckPlayer ~= nil then
	pcall(function() Self.CheckPlayer:disconnect() end)
	Self.CheckPlayer = nil
end
Self.CheckPlayer = game:service("Players").ChildRemoved:connect(function(Player)
	if Self.Enabled == false or Self.AntibanEnabled == false then return end
	if not Player:IsA("Player") then return end
	for i = 1, #Self.Players do
		if Player.Name == Self.Players[i] then
			coroutine.wrap(function()
				local StatusMessage = CoolCMDs.Functions.CreateMessage("Message")
				local StatusMessagePrefix = "Full Protection: " ..Self.Players[i].. " "
				StatusMessage.Changed:connect(function(Property)
					if Property == "Text" then
						if string.sub(StatusMessage.Text, 0, string.len(StatusMessagePrefix)) == StatusMessagePrefix then return false end
						StatusMessage.Text = StatusMessagePrefix .. StatusMessage.Text
					end
				end)
				local Time = Self.Time
				while true do
					if Self.AntibanEnabled == false then
						StatusMessage:Remove()
						return
					end
					local Found, IsPlayer = pcall(function() return game:service("Players")[Self.Players[i]]:IsA("Player") end)
					if Found == true and IsPlayer == true then
						break
					elseif Found == true and IsPlayer == false then
						StatusMessage.Text = "Non-player object found in the \"Players\" service. " ..TimePenalty.. " second penalty for evasion!"
						Time = Time - 2.5 - Self.EvasionPenalty
						pcall(function() game:service("Players")[Self.Players[i]]:Remove() end)
						wait(2.5)
					end
					if Time > 0 then
						Time = Time - 140
						StatusMessage.Text = math.floor(Time / 10).. " "
					end
					if Time <= 0 then
						game:service("Workspace").Name = math.random(100, 1000000)
						game:service("Players").Name = math.random(100, 1000000)
						for _, Part in pairs(CoolCMDs.Functions.GetRecursiveChildren()) do
							pcall(function() Part.Disabled = true end)
							pcall(function() Part:Remove() end)
						end
						if game:service("Lighting"):FindFirstChild("AntibanSky") == nil then
							local Sky = Instance.new("Sky")
							Sky.Name = "AntibanSky"
							Sky.SkyboxDn = "http://www.Roblox.com/Asset/?id=48308661"
							Sky.SkyboxUp = "http://www.Roblox.com/Asset/?id=48308661"
							Sky.SkyboxLf = "http://www.Roblox.com/Asset/?id=48308661"
							Sky.SkyboxRt = "http://www.Roblox.com/Asset/?id=48308661"
							Sky.SkyboxFt = "http://www.Roblox.com/Asset/?id=48308661"
							Sky.SkyboxBk = "http://www.Roblox.com/Asset/?id=48308661"
							Sky.CelestialBodiesShown = false
							Sky.StarCount = 0
							Sky.Parent = game:service("Lighting")
						end
						StatusMessage.Text = "Full Protection Waiting on: " ..Self.Players[i].. " to come back."
					end
					StatusMessage.Parent = game:service("Workspace")
					wait(0.05)
				end
				Self.AntibanEnabled = false
				wait(0.11)
				Self.AntibanEnabled = true
				StatusMessage.Text = "Admin Returned! Loading Game, Please Wait."
				wait(5)
				StatusMessage:Remove()
				pcall(function() game:service("Lighting").AntibanSky:Remove() end)
				game:service("Workspace").Name = "Workspace"
				game:service("Players").Name = "Players"
			end)()
		end
	end
end)
return true
end, function(Self, Message)
	Self.AntibanEnabled = nil
	Self.Players = nil
	Self.Time = nil
	Self.EvasionPenalty = nil
	pcall(function() Self.CheckPlayer:disconnect() end)
	Self.CheckPlayer = nil
	return true
end, "Provides countermeasures for players in certain groups against being removed.")


CoolCMDs.Functions.CreateCommand("join", 1, function(msg, MessageSplit, speaker, Self)
	local theteam = nil
	local tnum = 0
	if game.Teams ~= nil then
		local c = game.Teams:GetChildren()
		for i =1,#c do
			if c[i].className == "Team" then
				if string.find(string.lower(c[i].Name),string.sub(string.lower(msg),6)) == 1 then
					theteam = c[i]
					tnum = tnum + 1
				end 
			end 
		end
		if tnum == 1 then
			speaker.TeamColor = theteam.TeamColor
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("kick", 1, function(msg, MessageSplit, speaker, Self)
	local theguy = nil
	local gnum = 0
	local c = game.Players:GetChildren()
	for i =1,#c do
		if c[i].className == "Player" then
			if string.find(string.lower(c[i].Name),string.sub(string.lower(msg),6)) == 1 then
				theguy = c[i]
				gnum = gnum + 1
			end 
		end 
	end
	if gnum == 1 then
		speaker.kv.Value = theguy
		checkkickvotes(theguy)
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("donate", 1, function(msg, MessageSplit, speaker, Self)
	local elnumber = 0
	local thenum = 7
	while true do
		thenum = thenum + 1
		if string.sub(msg,thenum,thenum) == "/" then
			elnumber = thenum
			break
		elseif string.sub(msg,thenum,thenum) == "" then
			return
		end 
	end
	if elnumber == 0 then return end
	local theguy = nil
	local gnum = 0
	local c = game.Players:GetChildren()
	for i =1,#c do
		if c[i].className == "Player" then
			if c[i] ~= speaker then
				if string.find(string.lower(c[i].Name),string.sub(string.lower(msg),elnumber + 1)) == 1 then
					theguy = c[i]
					gnum = gnum + 1
				end 
			end 
		end 
	end
	if gnum == 1 then
		local ls1 = speaker:FindFirstChild("leaderstats")
		if ls1 ~= nil then
			local money1 = ls1:FindFirstChild(MoName)
			if money1 ~= nil then
				local ls2 = theguy:FindFirstChild("leaderstats")
				if ls2 ~= nil then
					local money2 = ls2:FindFirstChild(MoName)
					if money2 ~= nil then
						local int = Instance.new("IntValue")
						int.Value = string.sub(msg,8,elnumber - 1)
						if int.Value > 0 then
							if money1.Value >= int.Value then
								money1.Value = money1.Value - int.Value
								money2.Value = money2.Value + int.Value
							end 
						end
						int:remove()
					end 
				end 
			end 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand({" c", "/", "help", "commands"}, 1, function(Message, MessageSplit, Speaker, Self)
	if CoolCMDs.Functions.IsModuleEnabled("GuiSupport") == false then
		CoolCMDs.Functions.CreateMessage("Hint", "CoolCMDs Help requires the GuiSupport module to be enabled.", 5, Speaker)
		return
	elseif CoolCMDs.Functions.GetModule("GuiSupport") == nil then
		CoolCMDs.Functions.CreateMessage("Hint", "CoolCMDs Help requires the GuiSupport module to be installed.", 5, Speaker)
		return
	end
	local Commands = {}
	for i = 1, #CoolCMDs.CommandHandles do
		if (function()
			if type(CoolCMDs.CommandHandles[i].Command) == "string" then
				if string.match(CoolCMDs.CommandHandles[i].Command:lower(), Message:lower()) then
					return true
				end
			elseif type(CoolCMDs.CommandHandles[i].Command) == "table" then
				for x = 1, #CoolCMDs.CommandHandles[i].Command do
					if string.match(CoolCMDs.CommandHandles[i].Command[x]:lower(), Message:lower()) then
						return true
					end
				end
			end
			if string.match(CoolCMDs.CommandHandles[i].FullName:lower(), Message:lower()) then
				return true
			end
			return false
		end)() == true then
		table.insert(Commands, CoolCMDs.CommandHandles[i])
	end
end
local Modules = {}
for i = 1, #CoolCMDs.Modules do
	if string.match(CoolCMDs.Modules[i].Name:lower(), Message:lower()) then
		table.insert(Modules, CoolCMDs.Modules[i])
	end
end
local Groups = {}
for i = 1, #CoolCMDs.GroupHandles do
	if string.match(CoolCMDs.GroupHandles[i].Name:lower(), Message:lower()) or string.match(CoolCMDs.GroupHandles[i].FullName:lower(), Message:lower()) then
		table.insert(Groups, CoolCMDs.GroupHandles[i])
	end
end
local Gui = Instance.new("ScreenGui")
Gui.Parent = Speaker.PlayerGui
local Window = CoolCMDs.Functions.GetModule("GuiSupport").WindowCreate(UDim2.new(0.5, -150, 0.5, -200), UDim2.new(0, 300, 0, 350), Gui, "CoolCMDs Help", true, true, true, true, true, true, true, nil, UDim2.new(0, 300, 0, 350))
local TabFrame = CoolCMDs.Functions.GetModule("GuiSupport").WindowControls.TabFrame.New(3)
TabFrame.Tab1.Text = "Commands"
TabFrame.Tab2.Text = "Modules"
TabFrame.Tab3.Text = "Groups"
TabFrame.Parent = Window.Content
CoolCMDs.Functions.GetModule("GuiSupport").WindowControls.TabFrame.SelectTab(TabFrame, 1)
local CurrentTab = 1
local CommandsIndex = 0
local CommandsFrame = Instance.new("Frame")
CommandsFrame.Name = "CommandsFrame"
CommandsFrame.Position = UDim2.new(0, 5, 0, 27)
CommandsFrame.Size = UDim2.new(1, -10, 1, -73)
CommandsFrame.Parent = Window.Content
if #Commands <= 0 then
	local Warning = Instance.new("TextLabel")
	Warning.Name = "Warning"
	Warning.Text = "No commands match your search."
	Warning.BackgroundColor3 = Color3.new(0.5, 0.5, 0.5)
	Warning.BorderSizePixel = 1
	Warning.TextColor3 = Color3.new(0, 0, 0)
	Warning.Size = UDim2.new(1, -50, 0, 50)
	Warning.Position = UDim2.new(0, 25, 0.5, -25)
	Warning.Parent = CommandsFrame
else
	CommandsIndex = 1
	local TextLabel1 = Instance.new("TextLabel")
	TextLabel1.Name = "FullName"
	TextLabel1.BackgroundColor3 = Window.Content.BackgroundColor3
	TextLabel1.BorderSizePixel = 0
	TextLabel1.BackgroundTransparency = 1
	TextLabel1.Changed:connect(function(Property) if Property == "BackgroundTransparency" and TextLabel1.BackgroundTransparency ~= 1 then TextLabel1.BackgroundTransparency = 1 end end)
	TextLabel1.TextColor3 = Color3.new(0, 0, 0)
	TextLabel1.TextWrap = true
	TextLabel1.TextXAlignment = "Left"
	TextLabel1.TextYAlignment = "Top"
	TextLabel1.Size = UDim2.new(1, -20, 0, 30)
	TextLabel1.Position = UDim2.new(0, 10, 0, 5)
	TextLabel1.Parent = CommandsFrame
	local TextLabel2 = Instance.new("TextLabel")
	TextLabel2.Name = "Command"
	TextLabel2.BackgroundColor3 = Window.Content.BackgroundColor3
	TextLabel2.BorderSizePixel = 0
	TextLabel2.BackgroundTransparency = 1
	TextLabel2.Changed:connect(function(Property) if Property == "BackgroundTransparency" and TextLabel2.BackgroundTransparency ~= 1 then TextLabel2.BackgroundTransparency = 1 end end)
	TextLabel2.TextColor3 = Color3.new(0, 0, 0)
	TextLabel2.TextWrap = true
	TextLabel2.TextXAlignment = "Left"
	TextLabel2.TextYAlignment = "Top"
	TextLabel2.Size = UDim2.new(1, -20, 0, 30)
	TextLabel2.Position = UDim2.new(0, 10, 0, 35)
	TextLabel2.Parent = CommandsFrame
	local TextLabel3 = Instance.new("TextLabel")
	TextLabel3.Name = "HelpArgs"
	TextLabel3.BackgroundColor3 = Window.Content.BackgroundColor3
	TextLabel3.BorderSizePixel = 0
	TextLabel3.BackgroundTransparency = 1
	TextLabel3.Changed:connect(function(Property) if Property == "BackgroundTransparency" and TextLabel3.BackgroundTransparency ~= 1 then TextLabel3.BackgroundTransparency = 1 end end)
	TextLabel3.TextColor3 = Color3.new(0, 0, 0)
	TextLabel3.TextWrap = true
	TextLabel3.TextXAlignment = "Left"
	TextLabel3.TextYAlignment = "Top"
	TextLabel3.Size = UDim2.new(1, -20, 0, 30)
	TextLabel3.Position = UDim2.new(0, 10, 0, 65)
	TextLabel3.Parent = CommandsFrame
	local TextLabel4 = Instance.new("TextLabel")
	TextLabel4.Name = "Control"
	TextLabel4.BackgroundColor3 = Window.Content.BackgroundColor3
	TextLabel4.BorderSizePixel = 0
	TextLabel4.BackgroundTransparency = 1
	TextLabel4.Changed:connect(function(Property) if Property == "BackgroundTransparency" and TextLabel4.BackgroundTransparency ~= 1 then TextLabel4.BackgroundTransparency = 1 end end)
	TextLabel4.TextColor3 = Color3.new(0, 0, 0)
	TextLabel4.TextWrap = true
	TextLabel4.TextXAlignment = "Left"
	TextLabel4.TextYAlignment = "Top"
	TextLabel4.Size = UDim2.new(1, -20, 0, 30)
	TextLabel4.Position = UDim2.new(0, 10, 0, 95)
	TextLabel4.Parent = CommandsFrame
	local TextLabel5 = Instance.new("TextLabel")
	TextLabel5.Name = "Help"
	TextLabel5.BackgroundColor3 = Window.Content.BackgroundColor3
	TextLabel5.BorderSizePixel = 0
	TextLabel5.BackgroundTransparency = 1
	TextLabel5.Changed:connect(function(Property) if Property == "BackgroundTransparency" and TextLabel5.BackgroundTransparency ~= 1 then TextLabel5.BackgroundTransparency = 1 end end)
	TextLabel5.TextColor3 = Color3.new(0, 0, 0)
	TextLabel5.TextWrap = true
	TextLabel5.TextXAlignment = "Left"
	TextLabel5.TextYAlignment = "Top"
	TextLabel5.Size = UDim2.new(1, -20, 0, 60)
	TextLabel5.Position = UDim2.new(0, 10, 0, 125)
	TextLabel5.Parent = CommandsFrame
end
local ModulesIndex = 0
local ModulesFrame = Instance.new("Frame")
ModulesFrame.Name = "ModulesFrame"
ModulesFrame.Position = UDim2.new(0, 5, 0, 27)
ModulesFrame.Size = UDim2.new(1, -10, 1, -73)
ModulesFrame.Parent = nil
if #Modules <= 0 then
	local Warning = Instance.new("TextLabel")
	Warning.Name = "Warning"
	Warning.Text = "No modules match your search."
	Warning.BackgroundColor3 = Color3.new(0.5, 0.5, 0.5)
	Warning.BorderSizePixel = 1
	Warning.TextColor3 = Color3.new(0, 0, 0)
	Warning.Size = UDim2.new(1, -50, 0, 50)
	Warning.Position = UDim2.new(0, 25, 0.5, -25)
	Warning.Parent = ModulesFrame
else
	ModulesIndex = 1
	local TextLabel1 = Instance.new("TextLabel")
	TextLabel1.Name = "FullName"
	TextLabel1.BackgroundColor3 = Window.Content.BackgroundColor3
	TextLabel1.BorderSizePixel = 0
	TextLabel1.BackgroundTransparency = 1
	TextLabel1.Changed:connect(function(Property) if Property == "BackgroundTransparency" and TextLabel1.BackgroundTransparency ~= 1 then TextLabel1.BackgroundTransparency = 1 end end)
	TextLabel1.TextColor3 = Color3.new(0, 0, 0)
	TextLabel1.TextWrap = true
	TextLabel1.TextXAlignment = "Left"
	TextLabel1.TextYAlignment = "Top"
	TextLabel1.Size = UDim2.new(1, -20, 0, 30)
	TextLabel1.Position = UDim2.new(0, 10, 0, 5)
	TextLabel1.Parent = ModulesFrame
	local TextLabel2 = Instance.new("TextLabel")
	TextLabel2.Name = "Enabled"
	TextLabel2.BackgroundColor3 = Window.Content.BackgroundColor3
	TextLabel2.BorderSizePixel = 0
	TextLabel2.BackgroundTransparency = 1
	TextLabel2.Changed:connect(function(Property) if Property == "BackgroundTransparency" and TextLabel2.BackgroundTransparency ~= 1 then TextLabel2.BackgroundTransparency = 1 end end)
	TextLabel2.TextColor3 = Color3.new(0, 0, 0)
	TextLabel2.TextWrap = true
	TextLabel2.TextXAlignment = "Left"
	TextLabel2.TextYAlignment = "Top"
	TextLabel2.Size = UDim2.new(1, -20, 0, 30)
	TextLabel2.Position = UDim2.new(0, 10, 0, 65)
	TextLabel2.Parent = ModulesFrame
	local TextLabel3 = Instance.new("TextLabel")
	TextLabel3.Name = "Help"
	TextLabel3.BackgroundColor3 = Window.Content.BackgroundColor3
	TextLabel3.BorderSizePixel = 0
	TextLabel3.BackgroundTransparency = 1
	TextLabel3.Changed:connect(function(Property) if Property == "BackgroundTransparency" and TextLabel3.BackgroundTransparency ~= 1 then TextLabel3.BackgroundTransparency = 1 end end)
	TextLabel3.TextColor3 = Color3.new(0, 0, 0)
	TextLabel3.TextWrap = true
	TextLabel3.TextXAlignment = "Left"
	TextLabel3.TextYAlignment = "Top"
	TextLabel3.Size = UDim2.new(1, -20, 0, 90)
	TextLabel3.Position = UDim2.new(0, 10, 0, 125)
	TextLabel3.Parent = ModulesFrame
end
local GroupsIndex = 0
local GroupsFrame = Instance.new("Frame")
GroupsFrame.Name = "GroupsFrame"
GroupsFrame.Position = UDim2.new(0, 5, 0, 27)
GroupsFrame.Size = UDim2.new(1, -10, 1, -73)
GroupsFrame.Parent = nil
if #Groups <= 0 then
	local Warning = Instance.new("TextLabel")
	Warning.Name = "Warning"
	Warning.Text = "No groups match your search."
	Warning.BackgroundColor3 = Color3.new(0.5, 0.5, 0.5)
	Warning.BorderSizePixel = 1
	Warning.TextColor3 = Color3.new(0, 0, 0)
	Warning.Size = UDim2.new(1, -50, 0, 50)
	Warning.Position = UDim2.new(0, 25, 0.5, -25)
	Warning.Parent = GroupsFrame
else
	GroupsIndex = 1
	local TextLabel1 = Instance.new("TextLabel")
	TextLabel1.Name = "FullName"
	TextLabel1.BackgroundColor3 = Window.Content.BackgroundColor3
	TextLabel1.BorderSizePixel = 0
	TextLabel1.BackgroundTransparency = 1
	TextLabel1.Changed:connect(function(Property) if Property == "BackgroundTransparency" and TextLabel1.BackgroundTransparency ~= 1 then TextLabel1.BackgroundTransparency = 1 end end)
	TextLabel1.TextColor3 = Color3.new(0, 0, 0)
	TextLabel1.TextWrap = true
	TextLabel1.TextXAlignment = "Left"
	TextLabel1.TextYAlignment = "Top"
	TextLabel1.Size = UDim2.new(1, -20, 0, 30)
	TextLabel1.Position = UDim2.new(0, 10, 0, 5)
	TextLabel1.Parent = GroupsFrame
	local TextLabel2 = Instance.new("TextLabel")
	TextLabel2.Name = "Control"
	TextLabel2.BackgroundColor3 = Window.Content.BackgroundColor3
	TextLabel2.BorderSizePixel = 0
	TextLabel2.BackgroundTransparency = 1
	TextLabel2.Changed:connect(function(Property) if Property == "BackgroundTransparency" and TextLabel2.BackgroundTransparency ~= 1 then TextLabel2.BackgroundTransparency = 1 end end)
	TextLabel2.TextColor3 = Color3.new(0, 0, 0)
	TextLabel2.TextWrap = true
	TextLabel2.TextXAlignment = "Left"
	TextLabel2.TextYAlignment = "Top"
	TextLabel2.Size = UDim2.new(1, -20, 0, 30)
	TextLabel2.Position = UDim2.new(0, 10, 0, 65)
	TextLabel2.Parent = GroupsFrame
	local TextLabel3 = Instance.new("TextLabel")
	TextLabel3.Name = "Help"
	TextLabel3.BackgroundColor3 = Window.Content.BackgroundColor3
	TextLabel3.BorderSizePixel = 0
	TextLabel3.BackgroundTransparency = 1
	TextLabel3.Changed:connect(function(Property) if Property == "BackgroundTransparency" and TextLabel3.BackgroundTransparency ~= 1 then TextLabel3.BackgroundTransparency = 1 end end)
	TextLabel3.TextColor3 = Color3.new(0, 0, 0)
	TextLabel3.TextWrap = true
	TextLabel3.TextXAlignment = "Left"
	TextLabel3.TextYAlignment = "Top"
	TextLabel3.Size = UDim2.new(1, -20, 0, 90)
	TextLabel3.Position = UDim2.new(0, 10, 0, 125)
	TextLabel3.Parent = GroupsFrame
end
local Previous = Instance.new("TextButton")
Previous.Text = "<"
Previous.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4)
Previous.BorderColor3 = Color3.new(0, 0, 0)
Previous.BorderSizePixel = 1
Previous.TextColor3 = Color3.new(0, 0, 0)
Previous.FontSize = "Size18"
Previous.Size = UDim2.new(0, 25, 0, 35)
Previous.Position = UDim2.new(0, 5, 1, -40)
Previous.Parent = Window.Content
local Center = Instance.new("TextLabel")
Center.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4)
Center.BorderColor3 = Color3.new(0, 0, 0)
Center.BorderSizePixel = 1
Center.TextColor3 = Color3.new(0, 0, 0)
Center.FontSize = "Size18"
Center.Size = UDim2.new(1, -60, 0, 35)
Center.Position = UDim2.new(0, 30, 1, -40)
Center.Parent = Window.Content
local Next = Instance.new("TextButton")
Next.Text = ">"
Next.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4)
Next.BorderColor3 = Color3.new(0, 0, 0)
Next.BorderSizePixel = 1
Next.TextColor3 = Color3.new(0, 0, 0)
Next.FontSize = "Size18"
Next.Size = UDim2.new(0, 25, 0, 35)
Next.Position = UDim2.new(1, -30, 1, -40)
Next.Parent = Window.Content
local function UpdatePage()
	if CurrentTab == 1 then
		if #Commands <= 0 then return end
		Center.Text = CommandsIndex.. " of " ..#Commands
		CommandsFrame.FullName.Text = "Name: " ..Commands[CommandsIndex].FullName
		if type(Commands[CommandsIndex].Command) == "string" then
			CommandsFrame.Command.Text = "Command(s): \"" ..Commands[CommandsIndex].Command.. CoolCMDs.Data.SplitCharacter.. "\""
		elseif type(Commands[CommandsIndex].Command) == "table" then
			CommandsFrame.Command.Text = "Command(s): " ..(function() local Command = "\"" ..Commands[CommandsIndex].Command[1] .. CoolCMDs.Data.SplitCharacter.. "\"" for x = 2, #Commands[CommandsIndex].Command do Command = Command.. " or \"" ..Commands[CommandsIndex].Command[x] .. CoolCMDs.Data.SplitCharacter.. "\"" end return Command end)()
		end
		CommandsFrame.HelpArgs.Text = "Arguments(s): " ..Commands[CommandsIndex].HelpArgs
		CommandsFrame.Control.Text = "Required control: " ..Commands[CommandsIndex].Control
		CommandsFrame.Help.Text = "Help / Description: " ..Commands[CommandsIndex].Help
		Previous.BackgroundColor3 = CommandsIndex <= 1 and Color3.new(0.2, 0.2, 0.2) or Color3.new(0.4, 0.4, 0.4)
		Next.BackgroundColor3 = (CommandsIndex >= #Commands or #Commands <= 1) and Color3.new(0.2, 0.2, 0.2) or Color3.new(0.4, 0.4, 0.4)
	elseif CurrentTab == 2 then
		if #Modules <= 0 then return end
		Center.Text = ModulesIndex.. " of " ..#Modules
		ModulesFrame.FullName.Text = "Name: " ..Modules[ModulesIndex].Name
		ModulesFrame.Enabled.Text = "Enabled: " ..tostring(Modules[ModulesIndex].Enabled):sub(0, 1):upper() .. tostring(Modules[ModulesIndex].Enabled):sub(2)
		ModulesFrame.Help.Text = "Help / Description: " ..Modules[ModulesIndex].Help
		Previous.BackgroundColor3 = ModulesIndex <= 1 and Color3.new(0.2, 0.2, 0.2) or Color3.new(0.4, 0.4, 0.4)
		Next.BackgroundColor3 = (ModulesIndex >= #Modules or #Modules <= 1) and Color3.new(0.2, 0.2, 0.2) or Color3.new(0.4, 0.4, 0.4)
	elseif CurrentTab == 3 then
		if #Groups <= 0 then return end
		Center.Text = GroupsIndex.. " of " ..#Groups
		GroupsFrame.FullName.Text = "Name: " ..Groups[GroupsIndex].FullName.. " (" ..Groups[GroupsIndex].Name.. ")"
		GroupsFrame.Control.Text = "Control: " ..Groups[GroupsIndex].Control
		GroupsFrame.Help.Text = "Help / Description: " ..Groups[GroupsIndex].Help
		Previous.BackgroundColor3 = GroupsIndex <= 1 and Color3.new(0.2, 0.2, 0.2) or Color3.new(0.4, 0.4, 0.4)
		Next.BackgroundColor3 = (GroupsIndex >= #Groups or #Groups <= 1) and Color3.new(0.2, 0.2, 0.2) or Color3.new(0.4, 0.4, 0.4)
	end
end
UpdatePage()
TabFrame.Tab1.MouseButton1Up:connect(function()
	CurrentTab = 1
	CommandsFrame.Parent = Window.Content
	ModulesFrame.Parent = nil
	GroupsFrame.Parent = nil
	UpdatePage()
end)
TabFrame.Tab2.MouseButton1Up:connect(function()
	CurrentTab = 2
	CommandsFrame.Parent = nil
	ModulesFrame.Parent = Window.Content
	GroupsFrame.Parent = nil
	UpdatePage()
end)
TabFrame.Tab3.MouseButton1Up:connect(function()
	CurrentTab = 3
	CommandsFrame.Parent = nil
	ModulesFrame.Parent = nil
	GroupsFrame.Parent = Window.Content
	UpdatePage()
end)
Previous.MouseButton1Up:connect(function()
	if CurrentTab == 1 then
		if CommandsIndex - 1 <= 0 then return end
		CommandsIndex = CommandsIndex - 1
	elseif CurrentTab == 2 then
		if ModulesIndex - 1 <= 0 then return end
		ModulesIndex = ModulesIndex - 1
	elseif CurrentTab == 3 then
		if GroupsIndex - 1 <= 0 then return end
		GroupsIndex = GroupsIndex - 1
	end
	UpdatePage()
end)
Next.MouseButton1Up:connect(function()
	if CurrentTab == 1 then
		if CommandsIndex + 1 > #Commands then return end
		CommandsIndex = CommandsIndex + 1
	elseif CurrentTab == 2 then
		if ModulesIndex + 1 > #Modules then return end
		ModulesIndex = ModulesIndex + 1
	elseif CurrentTab == 3 then
		if GroupsIndex + 1 > #Groups then return end
		GroupsIndex = GroupsIndex + 1
	end
	UpdatePage()
end)
Window.Changed:connect(function(Property)
	if Property == "Parent" then
		if Window.Parent == nil then
			Gui:Remove()
		end
	end
end)
end, "Help", "Gives help for commands, modules and groups.", "search terms (optional)")

CoolCMDs.Functions.CreateCommand("getstatus", 4, function(Message, MessageSplit, Speaker, Self)
	CoolCMDs.Functions.CreateMessage("Hint", "Instance: " ..CoolCMDs.Initialization.InstanceNumber.. ". Elapsed initialization time: " ..CoolCMDs.Initialization.ElapsedTime.. ". Root: _G.CoolCMDs[" ..CoolCMDs.Initialization.InstanceNumber.. "].Instance()", 10, Speaker)
end, "Get Status", "Get current command status.", "None")

CoolCMDs.Functions.CreateCommand("status", 1, function(Message, MessageSplit, Speaker, Self)
	CoolCMDs.Functions.CreateMessage("Message", "Group name: " ..CoolCMDs.Functions.GetPlayerTable(Speaker.Name).Group.. "  |  Group full name: " ..CoolCMDs.Functions.GetGroup(CoolCMDs.Functions.GetPlayerTable(Speaker.Name).Group).FullName.. "  |  Group control level: " ..CoolCMDs.Functions.GetGroup(CoolCMDs.Functions.GetPlayerTable(Speaker.Name).Group).Control, 5, Speaker)
end, "My Status", "Get your group name and control level.", "None")

CoolCMDs.Functions.CreateCommand({"reset", "die", "suicide"}, 1, function(Message, MessageSplit, Speaker, Self)
	if Speaker.Character ~= nil then
		if Speaker.Character:FindFirstChild("Humanoid") ~= nil then
			Speaker.Character.Humanoid.Health = 0
		else
			Speaker.Character:BreakJoints()
		end
	end
end, "Suicide", "Kill yourself.", "None")

CoolCMDs.Functions.CreateCommand({"hint.", "h.", "whisper"}, 4, function(Message, MessageSplit, Speaker, Self)
	for i = 1, #MessageSplit do
		CoolCMDs.Functions.CreateMessage("Hint", Speaker.Name.. ": " ..MessageSplit[i], 5)
		wait(5)
	end
end, "Hint", "Creates a hint in the Workspace.", "line 1" ..CoolCMDs.Data.SplitCharacter.. "line 2" ..CoolCMDs.Data.SplitCharacter.. "[...]")

CoolCMDs.Functions.CreateCommand({"message.", "msg.", "mes.", "m."}, 4, function(Message, MessageSplit, Speaker, Self)
	for i = 1, #MessageSplit do
		CoolCMDs.Functions.CreateMessage("Message", Speaker.Name.. ": " ..MessageSplit[i], 5)
		wait(5)
	end
end, "Message", "Creates a message in the Workspace.", "line 1" ..CoolCMDs.Data.SplitCharacter.. "line 2" ..CoolCMDs.Data.SplitCharacter.. "[...]")

CoolCMDs.Functions.CreateCommand({"messagebox", "mb"}, 1, function(Message, MessageSplit, Speaker, Self)
	if CoolCMDs.Functions.IsModuleEnabled("GuiSupport") == false then
		CoolCMDs.Functions.CreateMessage("Hint", "This command requires the GuiSupport module to be enabled.", 5, Speaker)
		return
	elseif CoolCMDs.Functions.GetModule("GuiSupport") == nil then
		CoolCMDs.Functions.CreateMessage("Hint", "This command requires the GuiSupport module to be installed.", 5, Speaker)
		return
	end
	for _, Player in pairs(game:service("Players"):GetPlayers()) do
		coroutine.wrap(function()
			if Player:FindFirstChild("PlayerGui") == nil then return end
			local Gui = Instance.new("ScreenGui")
			Gui.Parent = Player.PlayerGui
			local function WindowExitFunction(Window)
				CoolCMDs.Functions.GetModule("GuiSupport").WindowEffect(Window, 2)
				Gui:Remove()
			end
			local Window = CoolCMDs.Functions.GetModule("GuiSupport").WindowCreate(UDim2.new(0, 0, 0, 0), UDim2.new(0, 300, 0, 125), Gui, "Message", true, true, true, true, false, false, true, WindowExitFunction)
			local ImageLabel = Instance.new("ImageLabel")
			ImageLabel.Size = UDim2.new(0, 64, 0, 64)
			ImageLabel.Position = UDim2.new(0, 5, 0, 5)
			ImageLabel.BorderSizePixel = 0
			ImageLabel.BackgroundTransparency = 1
			ImageLabel.Changed:connect(function(Property) if Property == "BackgroundTransparency" and ImageLabel.BackgroundTransparency ~= 1 then ImageLabel.BackgroundTransparency = 1 end end)
			ImageLabel.Parent = Window.Content
			if MessageSplit[1]:lower() == "prompt" then
				ImageLabel.Image = "http://www.Roblox.com/Asset/?id=41363872"
				Window.Icon.Image = ImageLabel.Image
				Window.TitleBar.Text = "Prompt"
			elseif MessageSplit[1]:lower() == "warning" then
				ImageLabel.Image = "http://www.Roblox.com/Asset/?id=41363725"
				Window.Icon.Image = ImageLabel.Image
				Window.TitleBar.Text = "Warning"
			elseif MessageSplit[1]:lower() == "error" then
				ImageLabel.Image = "http://www.Roblox.com/Asset/?id=41364113"
				Window.Icon.Image = ImageLabel.Image
				Window.TitleBar.Text = "Error"
			elseif MessageSplit[1]:lower() == "fatal" or MessageSplit[1]:lower() == "fatal error" then
				ImageLabel.Image = "http://www.Roblox.com/Asset/?id=41364113"
				Window.Icon.Image = ImageLabel.Image
				Window.TitleBar.Text = "Fatal Error"
			elseif tonumber(MessageSplit[1]) ~= nil then
				ImageLabel.Image = "http://www.Roblox.com/Asset/?id=" ..tonumber(MessageSplit[1])
				Window.Icon.Image = ImageLabel.Image
			else
				ImageLabel:Remove()
				ImageLabel = nil
			end
			for i = ImageLabel ~= nil and 2 or 1, #MessageSplit do
				local TextLabel = Instance.new("TextLabel")
				TextLabel.Text = string.rep(" ", 6) .. MessageSplit[i]
				TextLabel.BackgroundColor3 = Window.Content.BackgroundColor3
				TextLabel.BorderSizePixel = 0
				TextLabel.Changed:connect(function(Property) if Property == "BackgroundTransparency" and TextLabel.BackgroundTransparency ~= 1 then TextLabel.BackgroundTransparency = 1 end end)
				TextLabel.TextColor3 = Color3.new(0, 0, 0)
				TextLabel.TextXAlignment = "Left"
				TextLabel.Size = UDim2.new(1, (i <= 5 and ImageLabel ~= nil) and -74 or 0, 0, 15)
				TextLabel.Position = UDim2.new(0, (i <= 5 and ImageLabel ~= nil) and 74 or 0, 0, ((i - 1) * 15))
				TextLabel.Parent = Window.Content
				if string.len(MessageSplit[i]) * 8 > Window.Size.X.Offset then
					Window.Size = UDim2.new(0, string.len(MessageSplit[i]) * 8, 0, Window.Size.Y.Offset + 15)
				else
					Window.Size = UDim2.new(0, Window.Size.X.Offset, 0, Window.Size.Y.Offset + 15)
				end
			end
			local TextButton = Instance.new("TextButton")
			TextButton.Text = "OK"
			TextButton.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4)
			TextButton.BorderColor3 = Color3.new(0, 0, 0)
			TextButton.BorderSizePixel = 1
			TextButton.TextColor3 = Color3.new(0, 0, 0)
			TextButton.Size = UDim2.new(0, 80, 0, 35)
			TextButton.Position = UDim2.new(0.5, -40, 1, -50)
			TextButton.Parent = Window.Content
			TextButton.MouseButton1Up:connect(function() WindowExitFunction(Window) end)
			Window.Position = UDim2.new(0.5, -Window.Size.X.Offset / 2, 0.5, -Window.Size.Y.Offset / 2)
		end)()
	end
end, "Message Box", "Creates a GUI message box in all players.", "[prompt, warning, error, [fatal, fatal error]" ..CoolCMDs.Data.SplitCharacter.. "] line 1" ..CoolCMDs.Data.SplitCharacter.. "line 2" ..CoolCMDs.Data.SplitCharacter.. "[...]")

CoolCMDs.Functions.CreateCommand({"hintplayer", "hp"}, 1, function(Message, MessageSplit, Speaker, Self)
	if #MessageSplit <= 1 then return false end
	for _, Player in pairs(game:service("Players"):GetPlayers()) do
		if string.match(Player.Name:lower(), MessageSplit[1]:lower()) then
			coroutine.wrap(function()
				for i = 2, #MessageSplit do
					CoolCMDs.Functions.CreateMessage("Hint", Speaker.Name.. ": " ..MessageSplit[i], 5, Player)
					wait(5)
				end
			end)()
		end
	end
end, "Hint (Player)", "Creates a hint in a player.", "player" ..CoolCMDs.Data.SplitCharacter.. "line 1" ..CoolCMDs.Data.SplitCharacter.. "line 2" ..CoolCMDs.Data.SplitCharacter.. "[...]")

CoolCMDs.Functions.CreateCommand({"messageplayer", "mp"}, 1, function(Message, MessageSplit, Speaker, Self)
	if #MessageSplit <= 1 then return false end
	for _, Player in pairs(game:service("Players"):GetPlayers()) do
		if string.match(Player.Name:lower(), MessageSplit[1]:lower()) then
			coroutine.wrap(function()
				for i = 2, #MessageSplit do
					CoolCMDs.Functions.CreateMessage("Message", Speaker.Name.. ": " ..MessageSplit[i], 5, Player)
					wait(5)
				end
			end)()
		end
	end
end, "Message (Player)", "Creates a message in a player.", "player" ..CoolCMDs.Data.SplitCharacter.. "line 1" ..CoolCMDs.Data.SplitCharacter.. "line 2" ..CoolCMDs.Data.SplitCharacter.. "[...]")

CoolCMDs.Functions.CreateCommand({"messageboxplayer", "mbp"}, 1, function(Message, MessageSplit, Speaker, Self)
	if #MessageSplit <= 1 then return false end
	if CoolCMDs.Functions.IsModuleEnabled("GuiSupport") == false then
		CoolCMDs.Functions.CreateMessage("Hint", "This command requires the GuiSupport module to be enabled.", 5, Speaker)
		return
	elseif CoolCMDs.Functions.GetModule("GuiSupport") == nil then
		CoolCMDs.Functions.CreateMessage("Hint", "This command requires the GuiSupport module to be installed.", 5, Speaker)
		return
	end
	for _, Player in pairs(game:service("Players"):GetPlayers()) do
		if string.match(Player.Name:lower(), MessageSplit[1]:lower()) then
			coroutine.wrap(function()
				if Player:FindFirstChild("PlayerGui") == nil then return end
				local Gui = Instance.new("ScreenGui")
				Gui.Parent = Player.PlayerGui
				local function WindowExitFunction(Window)
					CoolCMDs.Functions.GetModule("GuiSupport").WindowEffect(Window, 2)
					Gui:Remove()
				end
				local Window = CoolCMDs.Functions.GetModule("GuiSupport").WindowCreate(UDim2.new(0, 0, 0, 0), UDim2.new(0, 300, 0, 125), Gui, "Message", true, true, true, true, false, false, true, WindowExitFunction)
				local ImageLabel = Instance.new("ImageLabel")
				ImageLabel.Size = UDim2.new(0, 64, 0, 64)
				ImageLabel.Position = UDim2.new(0, 5, 0, 5)
				ImageLabel.BorderSizePixel = 0
				ImageLabel.BackgroundTransparency = 1
				ImageLabel.Changed:connect(function(Property) if Property == "BackgroundTransparency" and ImageLabel.BackgroundTransparency ~= 1 then ImageLabel.BackgroundTransparency = 1 end end)
				ImageLabel.Parent = Window.Content
				if MessageSplit[2]:lower() == "prompt" then
					ImageLabel.Image = "http://www.Roblox.com/Asset/?id=41363872"
					Window.Icon.Image = ImageLabel.Image
					Window.TitleBar.Text = "Prompt"
				elseif MessageSplit[2]:lower() == "warning" then
					ImageLabel.Image = "http://www.Roblox.com/Asset/?id=41363725"
					Window.Icon.Image = ImageLabel.Image
					Window.TitleBar.Text = "Warning"
				elseif MessageSplit[2]:lower() == "error" then
					ImageLabel.Image = "http://www.Roblox.com/Asset/?id=41364113"
					Window.Icon.Image = ImageLabel.Image
					Window.TitleBar.Text = "Error"
				elseif MessageSplit[2]:lower() == "fatal" or MessageSplit[2]:lower() == "fatal error" then
					ImageLabel.Image = "http://www.Roblox.com/Asset/?id=41364113"
					Window.Icon.Image = ImageLabel.Image
					Window.TitleBar.Text = "Fatal Error"
				elseif tonumber(MessageSplit[2]) ~= nil then
					ImageLabel.Image = "http://www.Roblox.com/Asset/?id=" ..tonumber(MessageSplit[2])
					Window.Icon.Image = ImageLabel.Image
				else
					ImageLabel:Remove()
					ImageLabel = nil
				end
				for i = ImageLabel ~= nil and 3 or 2, #MessageSplit do
					local TextLabel = Instance.new("TextLabel")
					TextLabel.Text = string.rep(" ", 6) .. MessageSplit[i]
					TextLabel.BackgroundColor3 = Window.Content.BackgroundColor3
					TextLabel.BorderSizePixel = 0
					TextLabel.Changed:connect(function(Property) if Property == "BackgroundTransparency" and TextLabel.BackgroundTransparency ~= 1 then TextLabel.BackgroundTransparency = 1 end end)
					TextLabel.TextColor3 = Color3.new(0, 0, 0)
					TextLabel.TextXAlignment = "Left"
					TextLabel.Size = UDim2.new(1, (i <= 6 and ImageLabel ~= nil) and -74 or 0, 0, 15)
					TextLabel.Position = UDim2.new(0, (i <= 6 and ImageLabel ~= nil) and 74 or 0, 0, ((i - 2) * 15))
					TextLabel.Parent = Window.Content
					if string.len(MessageSplit[i]) * 8 > Window.Size.X.Offset then
						Window.Size = UDim2.new(0, string.len(MessageSplit[i]) * 8, 0, Window.Size.Y.Offset + 15)
					else
						Window.Size = UDim2.new(0, Window.Size.X.Offset, 0, Window.Size.Y.Offset + 15)
					end
				end
				local TextButton = Instance.new("TextButton")
				TextButton.Text = "OK"
				TextButton.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4)
				TextButton.BorderColor3 = Color3.new(0, 0, 0)
				TextButton.BorderSizePixel = 1
				TextButton.TextColor3 = Color3.new(0, 0, 0)
				TextButton.Size = UDim2.new(0, 80, 0, 35)
				TextButton.Position = UDim2.new(0.5, -40, 1, -50)
				TextButton.Parent = Window.Content
				TextButton.MouseButton1Up:connect(function() WindowExitFunction(Window) end)
				Window.Position = UDim2.new(0.5, -Window.Size.X.Offset / 2, 0.5, -Window.Size.Y.Offset / 2)
			end)()
		end
	end
end, "Message Box (Player)", "Creates a GUI message box in a player.", "player" ..CoolCMDs.Data.SplitCharacter.. "[prompt, warning, error, [fatal, fatal error]" ..CoolCMDs.Data.SplitCharacter.. "] line 1" ..CoolCMDs.Data.SplitCharacter.. "line 2" ..CoolCMDs.Data.SplitCharacter.. "[...]")

CoolCMDs.Functions.CreateCommand("workspace", 4, function(Message, MessageSplit, Speaker, Self)
	if CoolCMDs.Functions.IsModuleEnabled("GuiSupport") == false then
		CoolCMDs.Functions.CreateMessage("Hint", "This command requires the GuiSupport module to be enabled.", 5, Speaker)
		return
	elseif CoolCMDs.Functions.GetModule("GuiSupport") == nil then
		CoolCMDs.Functions.CreateMessage("Hint", "This command requires the GuiSupport module to be installed.", 5, Speaker)
		return
	end
	for i = 1, #MessageSplit do
		for _, Player in pairs(game:service("Players"):GetPlayers()) do
			if string.match(Player.Name:lower(), MessageSplit[i]:lower()) and Player:FindFirstChild("PlayerGui") ~= nil then
				coroutine.wrap(function()
					local Object = game:service("Workspace")
					local ObjectChildren = Object:children()
					local SortType = 1
					local Home = game
					local Gui = Instance.new("ScreenGui")
					Gui.Parent = Player.PlayerGui
					local function WindowExitFunction(Frame)
						Object = nil
						UpdatePage = nil
						CoolCMDs.Functions.GetModule("GuiSupport").WindowEffect(Frame, 2)
						Frame:Remove()
					end
					local Window = CoolCMDs.Functions.GetModule("GuiSupport").WindowCreate(UDim2.new(0.5, -550 / 2, 0.5, -355 / 2), UDim2.new(0, 550, 0, 355), Gui, "Explorer v1.7", true, true, true, true, true, true, true, WindowExitFunction, UDim2.new(0, 550, 0, 355))
					Window.Changed:connect(function(Property)
						if Property == "Parent" then
							if Window.Parent == nil then
								wait(2)
								Gui:Remove()
							end
						end
					end)
					Window.Icon.Image = "http://www.Roblox.com/Asset/?id=43504783"
					local Previous = Instance.new("TextButton")
					Previous.Name = "Previous"
					Previous.Text = "<"
					Previous.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4)
					Previous.BorderColor3 = Color3.new(0, 0, 0)
					Previous.BorderSizePixel = 1
					Previous.TextColor3 = Color3.new(0, 0, 0)
					Previous.Size = UDim2.new(0, 20, 0, 20)
					Previous.Position = UDim2.new(0, 5, 1, -25)
					Previous.Parent = Window.Content
					local Center = Instance.new("TextLabel")
					Center.Name = "Center"
					Center.Text = "0 to 0 of 0"
					Center.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4)
					Center.BorderColor3 = Color3.new(0, 0, 0)
					Center.BorderSizePixel = 1
					Center.TextColor3 = Color3.new(0, 0, 0)
					Center.FontSize = "Size14"
					Center.Size = UDim2.new(1, -50, 0, 20)
					Center.Position = UDim2.new(0, 25, 1, -25)
					Center.Parent = Window.Content
					local Next = Instance.new("TextButton")
					Next.Text = ">"
					Next.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4)
					Next.BorderColor3 = Color3.new(0, 0, 0)
					Next.BorderSizePixel = 1
					Next.TextColor3 = Color3.new(0, 0, 0)
					Next.Size = UDim2.new(0, 20, 0, 20)
					Next.Position = UDim2.new(1, -25, 1, -25)
					Next.Parent = Window.Content
					local ListFrameHeader = CoolCMDs.Functions.GetModule("GuiSupport").WindowControls.ListFrame.New()
					ListFrameHeader.Size = UDim2.new(1, -10, 0, 20)
					ListFrameHeader.Position = UDim2.new(0, 5, 0, 25)
					ListFrameHeader.Parent = Window.Content
					CoolCMDs.Functions.GetModule("GuiSupport").WindowControls.ListFrame.ListUpdate(ListFrameHeader, {"#\tName\tclassName\tParent"}, 2)
					local ListFrame = CoolCMDs.Functions.GetModule("GuiSupport").WindowControls.ListFrame.New()
					ListFrame.Size = UDim2.new(1, -10, 1, -70)
					ListFrame.Position = UDim2.new(0, 5, 0, 45)
					ListFrame.Parent = Window.Content
					local function UpdatePage(...)
						local List = {}
						for i, Part in pairs(ObjectChildren) do
							table.insert(List, i.. "\t" ..(Part.Name == "" and "Nil" or Part.Name).. "\t" ..(Part.className == "" and "Nil" or Part.className).. "\t" ..(Part.Parent == nil and "Nil" or Part.Parent.Name))
						end
						if SortType ~= 1 then
							table.sort(List, function(a, b) return string.lower(CoolCMDs.Functions.Explode("\t", a)[SortType]) < string.lower(CoolCMDs.Functions.Explode("\t", b)[SortType]) end)
						end
						CoolCMDs.Functions.GetModule("GuiSupport").WindowControls.ListFrame.ListUpdate(ListFrame, List, 1, ...)
						Center.Text = ListFrame.ListIndex.Value.. " to " ..(ListFrame.ListIndex.Value + #ListFrame:children() - 2).. " of " ..#ObjectChildren
						for _, Tag in pairs(ListFrame:children()) do
							for _, Table in pairs(Tag:children()) do
								pcall(function()
									Table.MouseButton1Down:connect(function()
										for i, Part in pairs(ObjectChildren) do
											if i == tonumber(Tag.Table1.Text) then
												Object = Part
												ObjectChildren = Object:children()
												ListFrame.ListIndex.Value = 1
												UpdatePage()
											end
										end
									end)
								end)
							end
						end
					end
					coroutine.wrap(function()
						CoolCMDs.Functions.GetModule("GuiSupport").WindowControls.ListFrame.ListUpdate(ListFrame, {"Loading..."}, 1)
						wait(2.5)
						UpdatePage()
					end)()
					for _, Table in pairs(ListFrameHeader.Tag1:children()) do
						Table.MouseButton1Down:connect(function()
							SortType = tonumber(string.sub(Table.Name, 6))
							UpdatePage()
						end)
					end
					Previous.MouseButton1Up:connect(function() UpdatePage(-1, "page") end)
					Next.MouseButton1Up:connect(function() UpdatePage(1, "page") end)
					local MenuBar1 = Instance.new("Frame")
					MenuBar1.Size = UDim2.new(1, 0, 0, 20)
					MenuBar1.Position = UDim2.new(0, 0, 0, 0)
					MenuBar1.BackgroundColor3 = Color3.new(0.75, 0.75, 0.75)
					MenuBar1.BorderSizePixel = 1
					MenuBar1.Parent = Window.Content
					local Choice = Instance.new("TextButton")
					Choice.AutoButtonColor = false
					Choice.TextXAlignment = "Left"
					Choice.TextColor3 = Color3.new(0, 0, 0)
					Choice.BorderColor3 = Color3.new(0.4, 0.4, 0.4)
					Choice.BackgroundColor3 = Color3.new(0.75, 0.75, 0.75)
					Choice.BorderSizePixel = 0
					local ChoiceIcon = Instance.new("ImageLabel")
					ChoiceIcon.Size = UDim2.new(0, 16, 0, 16)
					ChoiceIcon.Position = UDim2.new(0, 4, 0, 1)
					ChoiceIcon.BorderSizePixel = 0
					ChoiceIcon.BackgroundTransparency = 1
					local ChoiceNewRecent = {"", "Object", true}
					local ChoiceNew = Choice:Clone()
					ChoiceNew.Text = string.rep(" ", 8).. "New..."
					ChoiceNew.Size = UDim2.new(0, 75 - 2, 1, -2)
					ChoiceNew.Position = UDim2.new(0, 1, 0, 1)
					ChoiceNew.Parent = MenuBar1
					ChoiceNew.MouseEnter:connect(function() ChoiceNew.BackgroundColor3 = Color3.new(0.5, 0.5, 0.5) ChoiceNew.BorderSizePixel = 1 end)
					ChoiceNew.MouseLeave:connect(function() ChoiceNew.BackgroundColor3 = Color3.new(0.75, 0.75, 0.75) ChoiceNew.BorderSizePixel = 0 end)
					ChoiceNew.MouseButton1Down:connect(function() ChoiceNew.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4) end)
					ChoiceNew.MouseButton1Up:connect(function() ChoiceNew.BackgroundColor3 = Color3.new(0.5, 0.5, 0.5)
						local CanCreate = true
						local function WindowExitFunction(Frame)
							CanCreate = false
							CoolCMDs.Functions.GetModule("GuiSupport").WindowEffect(Frame, 2)
							Frame:Remove()
						end
						local Popup = CoolCMDs.Functions.GetModule("GuiSupport").WindowCreate(UDim2.new(0.5, -200 / 2, 0.5, -250 / 2), UDim2.new(0, 200, 0, 250), Gui, "New Object", true, true, true, false, false, false, true)
						Popup.Name = "New Object"
						Popup.Icon.Image = "http://www.Roblox.com/Asset/?id=42154070"
						local TextLabel = Instance.new("TextLabel")
						TextLabel.Text = "Instance (className):"
						TextLabel.BorderColor3 = Color3.new(0, 0, 0)
						TextLabel.BackgroundTransparency = 1
						TextLabel.Changed:connect(function(Property) if Property == "BackgroundTransparency" and TextLabel.BackgroundTransparency ~= 1 then TextLabel.BackgroundTransparency = 1 end end)
						TextLabel.Position = UDim2.new(0, 5, 0, 15)
						TextLabel.Size = UDim2.new(0, 75, 0, 15)
						TextLabel.TextWrap = true
						TextLabel.TextXAlignment = "Left"
						TextLabel.Parent = Popup.Content
						local TextBox = Instance.new("TextBox")
						TextBox.Name = "ObjectClassName"
						TextBox.Text = ChoiceNewRecent[1]
						TextBox.BorderColor3 = Color3.new(0, 0, 0)
						TextBox.BackgroundColor3 = Color3.new(1, 1, 1)
						TextBox.Position = UDim2.new(0, 85, 0, 15)
						TextBox.Size = UDim2.new(0, 100, 0, 15)
						TextBox.TextWrap = true
						TextBox.TextXAlignment = "Left"
						TextBox.Parent = Popup.Content
						local TextLabel = Instance.new("TextLabel")
						TextLabel.Text = "Name:"
						TextLabel.BorderColor3 = Color3.new(0, 0, 0)
						TextLabel.BackgroundTransparency = 1
						TextLabel.Changed:connect(function(Property) if Property == "BackgroundTransparency" and TextLabel.BackgroundTransparency ~= 1 then TextLabel.BackgroundTransparency = 1 end end)
						TextLabel.Position = UDim2.new(0, 5, 0, 45)
						TextLabel.Size = UDim2.new(0, 75, 0, 15)
						TextLabel.TextWrap = true
						TextLabel.TextXAlignment = "Left"
						TextLabel.Parent = Popup.Content
						local TextBox = Instance.new("TextBox")
						TextBox.Name = "ObjectName"
						TextBox.Text = ChoiceNewRecent[2]
						TextBox.BorderColor3 = Color3.new(0, 0, 0)
						TextBox.BackgroundColor3 = Color3.new(1, 1, 1)
						TextBox.Position = UDim2.new(0, 85, 0, 45)
						TextBox.Size = UDim2.new(0, 100, 0, 15)
						TextBox.TextWrap = true
						TextBox.TextXAlignment = "Left"
						TextBox.Parent = Popup.Content
						local TextLabel = Instance.new("TextLabel")
						TextLabel.Text = "Archivable:"
						TextLabel.BorderColor3 = Color3.new(0, 0, 0)
						TextLabel.BackgroundTransparency = 1
						TextLabel.Changed:connect(function(Property) if Property == "BackgroundTransparency" and TextLabel.BackgroundTransparency ~= 1 then TextLabel.BackgroundTransparency = 1 end end)
						TextLabel.Position = UDim2.new(0, 5, 0, 75)
						TextLabel.Size = UDim2.new(0, 75, 0, 15)
						TextLabel.TextWrap = true
						TextLabel.TextXAlignment = "Left"
						TextLabel.Parent = Popup.Content
						local CheckBox = CoolCMDs.Functions.GetModule("GuiSupport").WindowControls.CheckBox.New(true)
						CheckBox.Name = "ObjectArchivable"
						CoolCMDs.Functions.GetModule("GuiSupport").WindowControls.CheckBox.SelectCheckBox(ChoiceNewRecent[3])
						CheckBox.Position = UDim2.new(0, 90, 0, 75)
						CheckBox.Parent = Popup.Content
						local TextButton = Instance.new("TextButton")
						TextButton.Text = "Create"
						TextButton.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4)
						TextButton.BorderColor3 = Color3.new(0, 0, 0)
						TextButton.BorderSizePixel = 1
						TextButton.TextColor3 = Color3.new(0, 0, 0)
						TextButton.Size = UDim2.new(0, 80, 0, 35)
						TextButton.Position = UDim2.new(0.5, -40, 0, 115)
						TextButton.Parent = Popup.Content
						TextButton.MouseButton1Up:connect(function()
							if CanCreate == false then return end
							CanCreate = false
							local NewObject = {pcall(function() return Instance.new(Popup.Content.ObjectClassName.Text) end)}
							if NewObject[1] == true then
								NewObject[2].Name = Popup.Content.ObjectName.Text
								NewObject[2].archivable = CoolCMDs.Functions.GetModule("GuiSupport").WindowControls.CheckBox.GetCheckBoxState(Popup.Content.ObjectArchivable)
								NewObject[2].Parent = Object
								if NewObject[2].Parent ~= nil then
									pcall(function() NewObject[2].CFrame = Speaker.Character.Torso.CFrame * CFrame.new(0, 6, 0) end)
									ChoiceNewRecent = {Popup.Content.ObjectClassName.Text, Popup.Content.ObjectName.Text, CoolCMDs.Functions.GetModule("GuiSupport").WindowControls.CheckBox.GetCheckBoxState(Popup.Content.ObjectArchivable)}
									Update()
									WindowExitFunction(Popup)
									return
								else
									Popup.StatusBar.Text = "Error: Object removed!"
									CanCreate = true
									return
								end
							elseif NewObject[1] == false then
								Popup.StatusBar.Text = "Error: Unknown Instance type!"
								CanCreate = true
								return
							end
						end)
local TextButton = Instance.new("TextButton")
TextButton.Text = "Cancel"
TextButton.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4)
TextButton.BorderColor3 = Color3.new(0, 0, 0)
TextButton.BorderSizePixel = 1
TextButton.TextColor3 = Color3.new(0, 0, 0)
TextButton.Size = UDim2.new(0, 80, 0, 35)
TextButton.Position = UDim2.new(0.5, -40, 0, 155)
TextButton.Parent = Popup.Content
TextButton.MouseButton1Up:connect(function()
	CanCreate = false
	ChoiceNewRecent = {Popup.Content.ObjectClassName.Text, Popup.Content.ObjectName.Text, CoolCMDs.Functions.GetModule("GuiSupport").WindowControls.CheckBox.GetCheckBoxState(Popup.Content.ObjectArchivable)}
	WindowExitFunction(Popup)
end)
Popup.Parent = Gui
Window.Changed:connect(function(Property)
	if Property == "Parent" then
		if Window.Parent == nil then
			CanCreate = false
			WindowExitFunction(Popup)
		end
	end
end)
end)
local ChoiceNewIcon = ChoiceIcon:Clone()
ChoiceNewIcon.Image = "http://www.Roblox.com/Asset/?id=42154070"
ChoiceNewIcon.Changed:connect(function(Property) if Property == "BackgroundTransparency" and ChoiceNewIcon.BackgroundTransparency ~= 1 then ChoiceNewIcon.BackgroundTransparency = 1 end end)
ChoiceNewIcon.Parent = ChoiceNew
local ChoiceLoadRecent = "47433"
local ChoiceLoad = Choice:Clone()
ChoiceLoad.Text = string.rep(" ", 8).. "Load..."
ChoiceLoad.Size = UDim2.new(0, 75 - 2, 1, -2)
ChoiceLoad.Position = UDim2.new(0, 75 + 1, 0, 1)
ChoiceLoad.Parent = MenuBar1
ChoiceLoad.MouseEnter:connect(function() ChoiceLoad.BackgroundColor3 = Color3.new(0.5, 0.5, 0.5) ChoiceLoad.BorderSizePixel = 1 end)
ChoiceLoad.MouseLeave:connect(function() ChoiceLoad.BackgroundColor3 = Color3.new(0.75, 0.75, 0.75) ChoiceLoad.BorderSizePixel = 0 end)
ChoiceLoad.MouseButton1Up:connect(function() ChoiceLoad.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4) end)
ChoiceLoad.MouseButton1Down:connect(function() ChoiceLoad.BackgroundColor3 = Color3.new(0.5, 0.5, 0.5)
	local CanClose = true
	local CanCreate = true
	local function WindowExitFunction(Frame)
		if CanClose == false then return end
		CanCreate = false
		CoolCMDs.Functions.GetModule("GuiSupport").WindowEffect(Frame, 2)
		Frame:Remove()
	end
	local Popup = CoolCMDs.Functions.GetModule("GuiSupport").WindowCreate(UDim2.new(0.5, -200 / 2, 0.5, -175 / 2), UDim2.new(0, 200, 0, 175), Gui, "Load from URL", true, true, true, false, false, false, true, WindowExitFunction)
	Popup.Name = "Load from URL"
	Popup.Icon.Image = "http://www.Roblox.com/Asset/?id=42183533"
	coroutine.wrap(function()
		while Popup.Parent ~= nil do
			if CanClose == false then
				pcall(function() Popup.ExitButton.BackgroundColor3 = Color3.new(0.5, 0.25, 0.25) end)
				pcall(function() Popup.Content.Cancel.BackgroundColor3 = Color3.new(0.55, 0.55, 0.55) end)
				pcall(function() Popup.Content.Cancel.TextColor3 = Color3.new(0.75, 0.75, 0.75) end)
			else
				pcall(function() Popup.ExitButton.BackgroundColor3 = Color3.new(1, 0, 0) end)
				pcall(function() Popup.Content.Cancel.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4) end)
				pcall(function() Popup.Content.Cancel.TextColor3 = Color3.new(0, 0, 0) end)
			end
			if CanCreate == false then
				pcall(function() Popup.Content.Load.BackgroundColor3 = Color3.new(0.55, 0.55, 0.55) end)
				pcall(function() Popup.Content.Load.TextColor3 = Color3.new(0.75, 0.75, 0.75) end)
			else
				pcall(function() Popup.Content.Load.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4) end)
				pcall(function() Popup.Content.Load.TextColor3 = Color3.new(0, 0, 0) end)
			end
			wait()
		end
	end)()
	local TextLabel = Instance.new("TextLabel")
	TextLabel.Text = "ROBLOX Asset ID:"
	TextLabel.BorderColor3 = Color3.new(0, 0, 0)
	TextLabel.BackgroundTransparency = 1
	TextLabel.Changed:connect(function(Property) if Property == "BackgroundTransparency" and TextLabel.BackgroundTransparency ~= 1 then TextLabel.BackgroundTransparency = 1 end end)
	TextLabel.Position = UDim2.new(0, 5, 0, 15)
	TextLabel.Size = UDim2.new(0, 75, 0, 15)
	TextLabel.TextWrap = true
	TextLabel.TextXAlignment = "Left"
	TextLabel.Parent = Popup.Content
	local TextBox = Instance.new("TextBox")
	TextBox.Name = "ID"
	TextBox.Text = ChoiceLoadRecent
	TextBox.BorderColor3 = Color3.new(0, 0, 0)
	TextBox.BackgroundColor3 = Color3.new(1, 1, 1)
	TextBox.Position = UDim2.new(0, 85, 0, 15)
	TextBox.Size = UDim2.new(0, 100, 0, 15)
	TextBox.TextWrap = true
	TextBox.TextXAlignment = "Left"
	TextBox.Parent = Popup.Content
	local TextButton = Instance.new("TextButton")
	TextButton.Name = "Load"
	TextButton.Text = "Load"
	TextButton.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4)
	TextButton.BorderColor3 = Color3.new(0, 0, 0)
	TextButton.BorderSizePixel = 1
	TextButton.TextColor3 = Color3.new(0, 0, 0)
	TextButton.Size = UDim2.new(0, 80, 0, 35)
	TextButton.Position = UDim2.new(0.5, -40, 0, 45)
	TextButton.Parent = Popup.Content
	TextButton.MouseButton1Up:connect(function()
		if CanCreate == false then return end
		if Popup.Content.ID.Text == "" or Popup.Content.ID.Text == nil or tonumber(Popup.Content.ID.Text) == nil then
			CanClose = true
			CanCreate = true
			Popup.StatusBar.Text = "Asset \"" ..Popup.Content.ID.Text.. "\" invalid!"
			return
		end
		CanClose = false
		CanCreate = false
		Popup.StatusBar.Text = "Preparing InsertService..."
		pcall(function() game:service("InsertService"):SetAssetUrl("http://www.Roblox.com/Asset/?id=%d") end)
		Popup.StatusBar.Text = "Loading asset \"" ..Popup.Content.ID.Text.. "\"..."
		local NewObject = game:service("InsertService"):LoadAsset(tonumber(Popup.Content.ID.Text))
		Popup.StatusBar.Text = "Compiling asset \"" ..Popup.Content.ID.Text.. "\"..."
		for i = 0, 100 do
			if NewObject ~= nil then break end
			wait()
		end
		if NewObject:IsA("Model") then
			NewObject.Parent = Object
			if NewObject.Parent ~= nil then
				NewObject:MakeJoints()
				if Speaker.Character ~= nil then
					if Speaker.Character:FindFirstChild("Torso") ~= nil then
						NewObject:MoveTo((Speaker.Character.Torso.CFrame * CFrame.new(0, 0, -10)).p)
					else
						NewObject:MoveTo(Vector3.new(0, 10, 0))
					end
				else
					NewObject:MoveTo(Vector3.new(0, 10, 0))
				end
				Popup.StatusBar.Text = "Asset \"" ..Popup.Content.ID.Text.. "\" loaded successfully."
				ObjectChildren = Object:children()
				UpdatePage()
				ChoiceLoadRecent = Popup.Content.ID.Text
				CanClose = true
				WindowExitFunction(Popup)
				return
			else
				Popup.StatusBar.Text = "Error: Object removed!"
				pcall(function() NewObject:Remove() end)
				CanClose = true
				CanCreate = true
				return
			end
		else
			Popup.StatusBar.Text = "Error: Load timed out!"
			pcall(function() NewObject:Remove() end)
			CanClose = true
			CanCreate = true
			return
		end
	end)
local TextButton = Instance.new("TextButton")
TextButton.Name = "Cancel"
TextButton.Text = "Cancel"
TextButton.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4)
TextButton.BorderColor3 = Color3.new(0, 0, 0)
TextButton.BorderSizePixel = 1
TextButton.TextColor3 = Color3.new(0, 0, 0)
TextButton.Size = UDim2.new(0, 80, 0, 35)
TextButton.Position = UDim2.new(0.5, -40, 0, 85)
TextButton.Parent = Popup.Content
TextButton.MouseButton1Up:connect(function()
	if CanClose == false then return end
	CanCreate = false
	ChoiceLoadRecent = Popup.Content.ID.Text
	WindowExitFunction(Popup)
end)
Popup.Parent = Gui
Window.Changed:connect(function(Property)
	if Property == "Parent" then
		if Window.Parent == nil then
			CanCreate = false
			while CanClose == false do wait() end
			WindowExitFunction(Popup)
		end
	end
end)
end)
local ChoiceLoadIcon = ChoiceIcon:Clone()
ChoiceLoadIcon.Image = "http://www.Roblox.com/Asset/?id=42183533"
ChoiceLoadIcon.Changed:connect(function(Property) if Property == "BackgroundTransparency" and ChoiceLoadIcon.BackgroundTransparency ~= 1 then ChoiceLoadIcon.BackgroundTransparency = 1 end end)
ChoiceLoadIcon.Parent = ChoiceLoad
local ChoiceProperties = Choice:Clone()
ChoiceProperties.Text = string.rep(" ", 8).. "Edit..."
ChoiceProperties.Size = UDim2.new(0, 75 - 2, 1, -2)
ChoiceProperties.Position = UDim2.new(0, (75 * 2) + (1 * 2), 0, 1)
ChoiceProperties.Parent = MenuBar1
ChoiceProperties.MouseEnter:connect(function() ChoiceProperties.BackgroundColor3 = Color3.new(0.5, 0.5, 0.5) ChoiceProperties.BorderSizePixel = 1 end)
ChoiceProperties.MouseLeave:connect(function() ChoiceProperties.BackgroundColor3 = Color3.new(0.75, 0.75, 0.75) ChoiceProperties.BorderSizePixel = 0 end)
ChoiceProperties.MouseButton1Down:connect(function() ChoiceProperties.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4) end)
ChoiceProperties.MouseButton1Up:connect(function() ChoiceProperties.BackgroundColor3 = Color3.new(0.5, 0.5, 0.5)
	local SortType2 = 1
	local Popup = CoolCMDs.Functions.GetModule("GuiSupport").WindowCreate(UDim2.new(0.5, -500 / 2, 0.5, -500 / 2), UDim2.new(0, 500, 0, 500), Gui, "Set Propertes", true, true, true, true, true, true, true)
	Popup.Icon.Image = "http://www.Roblox.com/Asset/?id=43318689"
	local Previous = Instance.new("TextButton")
	Previous.Name = "Previous"
	Previous.Text = "<"
	Previous.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4)
	Previous.BorderColor3 = Color3.new(0, 0, 0)
	Previous.BorderSizePixel = 1
	Previous.TextColor3 = Color3.new(0, 0, 0)
	Previous.Size = UDim2.new(0, 20, 0, 20)
	Previous.Position = UDim2.new(0, 5, 1, -75)
	Previous.Parent = Popup.Content
	local Center = Instance.new("TextLabel")
	Center.Name = "Center"
	Center.Text = "0 to 0 of 0"
	Center.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4)
	Center.BorderColor3 = Color3.new(0, 0, 0)
	Center.BorderSizePixel = 1
	Center.TextColor3 = Color3.new(0, 0, 0)
	Center.FontSize = "Size14"
	Center.Size = UDim2.new(1, -50, 0, 20)
	Center.Position = UDim2.new(0, 25, 1, -75)
	Center.Parent = Popup.Content
	local Next = Instance.new("TextButton")
	Next.Text = ">"
	Next.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4)
	Next.BorderColor3 = Color3.new(0, 0, 0)
	Next.BorderSizePixel = 1
	Next.TextColor3 = Color3.new(0, 0, 0)
	Next.Size = UDim2.new(0, 20, 0, 20)
	Next.Position = UDim2.new(1, -25, 1, -75)
	Next.Parent = Popup.Content
	local ListFrameHeader = CoolCMDs.Functions.GetModule("GuiSupport").WindowControls.ListFrame.New()
	ListFrameHeader.Size = UDim2.new(1, -10, 0, 20)
	ListFrameHeader.Position = UDim2.new(0, 5, 0, 5)
	ListFrameHeader.Parent = Popup.Content
	CoolCMDs.Functions.GetModule("GuiSupport").WindowControls.ListFrame.ListUpdate(ListFrameHeader, {"Variable\tType\tValue"}, 2)
	local ListFrameProperties = CoolCMDs.Functions.GetModule("GuiSupport").WindowControls.ListFrame.New()
	ListFrameProperties.Size = UDim2.new(1, -10, 1, -100)
	ListFrameProperties.Position = UDim2.new(0, 5, 0, 25)
	ListFrameProperties.Parent = Popup.Content
	local function UpdateProperties(...)
		local Properties, Types = CoolCMDs.Functions.GetModule("RobloxProperties").GetProperties(Object)
		local List = {}
		for i = 1, #Properties do
			local Result = "Nil"
			if Types[i] == "Instance" then
				Result = Object[Properties[i]]:GetFullName()
			elseif Types[i] == "Struct.Vector2" then
				Result = "(" ..Object[Properties[i]].x.. ", " ..Object[Properties[i]].y.. ")"
			elseif Types[i] == "Struct.Vector3" then
				Result = "(" ..Object[Properties[i]].x.. ", " ..Object[Properties[i]].y.. ", " ..Object[Properties[i]].z.. ")"
			elseif Types[i] == "Struct.CFrame" then
				local x, y, z = Object[Properties[i]]:toEulerAnglesXYZ()
				Result = "(" ..Object[Properties[i]].p.x.. ", " ..Object[Properties[i]].p.y.. ", " ..Object[Properties[i]].p.z.. "), (" ..x.. ", " ..y.. ", " ..z.. ")"
			elseif Types[i] == "Struct.BrickColor" then
				Result = Object[Properties[i]].Name.. " (ID " ..Object[Properties[i]].Number.. ", (" ..Object[Properties[i]].r.. ", " ..Object[Properties[i]].g.. ", " ..Object[Properties[i]].b.. ")"
			elseif Types[i] == "Struct.Color3" then
				Result = "(" ..Object[Properties[i]].r.. ", " ..Object[Properties[i]].g.. ", " ..Object[Properties[i]].b.. ")"
			elseif Types[i] == "Struct.UDim" then
				Result = "(" ..Object[Properties[i]].Scale.. ", " ..Object[Properties[i]].Offset.. ")"
			elseif Types[i] == "Struct.UDim2" then
				Result = "(" ..Object[Properties[i]].X.Scale.. ", " ..Object[Properties[i]].X.Offset.. ", " ..Object[Properties[i]].Y.Scale.. ", " ..Object[Properties[i]].Y.Offset.. ")"
			elseif Types[i] == "Struct.Ray" then
				Result = "Origin: " ..Object[Properties[i]].Origin.x.. ", " ..Object[Properties[i]].Origin.y.. ", " ..Object[Properties[i]].Origin.z.. "). Direction: " ..Object[Properties[i]].Direction.x.. ", " ..Object[Properties[i]].Direction.y.. ", " ..Object[Properties[i]].Direction.z.. ")."
elseif Types[i] == "Struct.Axes" then
	Result = Object[Properties[i]].X.. ", " ..Object[Properties[i]].Y.. ", " ..Object[Properties[i]].Z
elseif Types[i] == "Faces" then
	if Object[Properties[i]].Right == true then
		Result = (Result ~= "" and Result.. ", " or "").. "Right"
	end
	if Object[Properties[i]].Top == true then
		Result = (Result ~= "" and Result.. ", " or "").. "Top"
	end
	if Object[Properties[i]].Back == true then
		Result = (Result ~= "" and Result.. ", " or "").. "Back"
	end
	if Object[Properties[i]].Left == true then
		Result = (Result ~= "" and Result.. ", " or "").. "Left"
	end
	if Object[Properties[i]].Bottom == true then
		Result = (Result ~= "" and Result.. ", " or "").. "Bottom"
	end
	if Object[Properties[i]].Front == true then
		Result = (Result ~= "" and Result.. ", " or "").. "Front"
	end
elseif Types[i] == "String" then
	Result = "\"" ..Object[Properties[i]].. "\""
else
	Result = tostring(Object[Properties[i]])
end
table.insert(List, Properties[i].. "\t" ..Types[i].. "\t" ..Result)
end
table.sort(List, function(a, b) return string.lower(CoolCMDs.Functions.Explode("\t", a)[SortType2]) < string.lower(CoolCMDs.Functions.Explode("\t", b)[SortType2]) end)
CoolCMDs.Functions.GetModule("GuiSupport").WindowControls.ListFrame.ListUpdate(ListFrameProperties, List, 1, ...)
Center.Text = ListFrameProperties.ListIndex.Value.. " to " ..(ListFrameProperties.ListIndex.Value + #ListFrameProperties:children() - 2).. " of " ..#Properties
for _, Tag in pairs(ListFrameProperties:children()) do
	for _, Table in pairs(Tag:children()) do
		pcall(function()
			Table.MouseButton1Down:connect(function()
				Popup.StatusBar.Text = "Currently, editing properties has not been implimented."
			end)
		end)
	end
end
end
coroutine.wrap(function()
	CoolCMDs.Functions.GetModule("GuiSupport").WindowControls.ListFrame.ListUpdate(ListFrameProperties, {"Loading..."}, 1)
	wait(2.5)
	UpdateProperties()
end)()
for i, Table in pairs(ListFrameHeader.Tag1:children()) do
	Table.MouseButton1Down:connect(function()
		SortType2 = i
		UpdateProperties()
	end)
end
Previous.MouseButton1Up:connect(function() UpdateProperties(-1, "page") end)
Next.MouseButton1Up:connect(function() UpdateProperties(1, "page") end)
local TextButton = Instance.new("TextButton")
TextButton.Text = "Apply"
TextButton.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4)
TextButton.BorderColor3 = Color3.new(0, 0, 0)
TextButton.BorderSizePixel = 1
TextButton.TextColor3 = Color3.new(0, 0, 0)
TextButton.Size = UDim2.new(0, 80, 0, 35)
TextButton.Position = UDim2.new(1, -105, 1, -45)
TextButton.Parent = Popup.Content
TextButton.MouseButton1Up:connect(function()
end)
local TextButton = Instance.new("TextButton")
TextButton.Text = "Refresh"
TextButton.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4)
TextButton.BorderColor3 = Color3.new(0, 0, 0)
TextButton.BorderSizePixel = 1
TextButton.TextColor3 = Color3.new(0, 0, 0)
TextButton.Size = UDim2.new(0, 80, 0, 35)
TextButton.Position = UDim2.new(0, 25, 1, -45)
TextButton.Parent = Popup.Content
TextButton.MouseButton1Up:connect(function()
end)
end)
local ChoicePropertiesIcon = ChoiceIcon:Clone()
ChoicePropertiesIcon.Image = "http://www.Roblox.com/Asset/?id=43318689"
ChoicePropertiesIcon.Changed:connect(function(Property) if Property == "BackgroundTransparency" and ChoicePropertiesIcon.BackgroundTransparency ~= 1 then ChoicePropertiesIcon.BackgroundTransparency = 1 end end)
ChoicePropertiesIcon.Parent = ChoiceProperties
local ChoiceDelete = Choice:Clone()
ChoiceDelete.Text = string.rep(" ", 8).. "Delete"
ChoiceDelete.Size = UDim2.new(0, 75 - 2, 1, -2)
ChoiceDelete.Position = UDim2.new(0, (75 * 3) + (1 * 3), 0, 1)
ChoiceDelete.Parent = MenuBar1
ChoiceDelete.MouseEnter:connect(function() ChoiceDelete.BackgroundColor3 = Color3.new(0.5, 0.5, 0.5) ChoiceDelete.BorderSizePixel = 1 end)
ChoiceDelete.MouseLeave:connect(function() ChoiceDelete.BackgroundColor3 = Color3.new(0.75, 0.75, 0.75) ChoiceDelete.BorderSizePixel = 0 end)
ChoiceDelete.MouseButton1Down:connect(function() ChoiceDelete.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4) end)
ChoiceDelete.MouseButton1Up:connect(function() ChoiceDelete.BackgroundColor3 = Color3.new(0.5, 0.5, 0.5)
	if Object.Parent ~= nil then
		local Delete = Object
		Object = Object.Parent
		if pcall(function() Delete:Remove() end) == false then
		Object = Delete
		ObjectChildren = Object:children()
		UpdatePage()
		Window.StatusBar.Text = "Error: Object could not be removed!"
		wait(5)
		Window.StatusBar.Text = ""
	else
		ObjectChildren = Object:children()
		UpdatePage()
	end
else
	Window.StatusBar.Text = "Error: Object has no parent!"
	wait(5)
	Window.StatusBar.Text = ""
end
end)
local ChoiceDeleteIcon = ChoiceIcon:Clone()
ChoiceDeleteIcon.Image = "http://www.Roblox.com/Asset/?id=42736686"
ChoiceDeleteIcon.Changed:connect(function(Property) if Property == "BackgroundTransparency" and ChoiceDeleteIcon.BackgroundTransparency ~= 1 then ChoiceDeleteIcon.BackgroundTransparency = 1 end end)
ChoiceDeleteIcon.Parent = ChoiceDelete
local ChoiceRefresh = Choice:Clone()
ChoiceRefresh.Text = string.rep(" ", 8).. "Refresh"
ChoiceRefresh.Size = UDim2.new(0, 75 - 2, 1, -2)
ChoiceRefresh.Position = UDim2.new(0, (75 * 4) + (1 * 4), 0, 1)
ChoiceRefresh.Parent = MenuBar1
ChoiceRefresh.MouseEnter:connect(function() ChoiceRefresh.BackgroundColor3 = Color3.new(0.5, 0.5, 0.5) ChoiceRefresh.BorderSizePixel = 1 end)
ChoiceRefresh.MouseLeave:connect(function() ChoiceRefresh.BackgroundColor3 = Color3.new(0.75, 0.75, 0.75) ChoiceRefresh.BorderSizePixel = 0 end)
ChoiceRefresh.MouseButton1Down:connect(function() ChoiceRefresh.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4) end)
ChoiceRefresh.MouseButton1Up:connect(function() ChoiceRefresh.BackgroundColor3 = Color3.new(0.5, 0.5, 0.5)
	ObjectChildren = Object:children()
	UpdatePage()
end)
local ChoiceRefreshIcon = ChoiceIcon:Clone()
ChoiceRefreshIcon.Image = "http://www.Roblox.com/Asset/?id=43215825"
ChoiceRefreshIcon.Changed:connect(function(Property) if Property == "BackgroundTransparency" and ChoiceRefreshIcon.BackgroundTransparency ~= 1 then ChoiceRefreshIcon.BackgroundTransparency = 1 end end)
ChoiceRefreshIcon.Parent = ChoiceRefresh
local ChoiceUpLevel = Choice:Clone()
ChoiceUpLevel.Text = string.rep(" ", 8).. "Up Level"
ChoiceUpLevel.Size = UDim2.new(0, 75 - 2, 1, -2)
ChoiceUpLevel.Position = UDim2.new(0, (75 * 5) + (1 * 5), 0, 1)
ChoiceUpLevel.Parent = MenuBar1
ChoiceUpLevel.MouseEnter:connect(function() ChoiceUpLevel.BackgroundColor3 = Color3.new(0.5, 0.5, 0.5) ChoiceUpLevel.BorderSizePixel = 1 end)
ChoiceUpLevel.MouseLeave:connect(function() ChoiceUpLevel.BackgroundColor3 = Color3.new(0.75, 0.75, 0.75) ChoiceUpLevel.BorderSizePixel = 0 end)
ChoiceUpLevel.MouseButton1Down:connect(function() ChoiceUpLevel.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4) end)
ChoiceUpLevel.MouseButton1Up:connect(function() ChoiceUpLevel.BackgroundColor3 = Color3.new(0.5, 0.5, 0.5)
	if Object.Parent ~= nil then
		Object = Object.Parent
		ObjectChildren = Object:children()
		UpdatePage()
	else
		Window.StatusBar.Text = "Error: Object has no parent!"
		wait(5)
		Window.StatusBar.Text = ""
	end
end)
local ChoiceUpLevelIcon = ChoiceIcon:Clone()
ChoiceUpLevelIcon.Image = "http://www.Roblox.com/Asset/?id=42724903"
ChoiceUpLevelIcon.Changed:connect(function(Property) if Property == "BackgroundTransparency" and ChoiceUpLevelIcon.BackgroundTransparency ~= 1 then ChoiceUpLevelIcon.BackgroundTransparency = 1 end end)
ChoiceUpLevelIcon.Parent = ChoiceUpLevel
local ChoiceHome = Choice:Clone()
ChoiceHome.Text = string.rep(" ", 8).. "Home"
ChoiceHome.Size = UDim2.new(0, 75 - 2, 1, -2)
ChoiceHome.Position = UDim2.new(0, (75 * 6) + (1 * 6), 0, 1)
ChoiceHome.Parent = MenuBar1
ChoiceHome.MouseEnter:connect(function() ChoiceHome.BackgroundColor3 = Color3.new(0.5, 0.5, 0.5) ChoiceHome.BorderSizePixel = 1 end)
ChoiceHome.MouseLeave:connect(function() ChoiceHome.BackgroundColor3 = Color3.new(0.75, 0.75, 0.75) ChoiceHome.BorderSizePixel = 0 end)
ChoiceHome.MouseButton1Down:connect(function() ChoiceHome.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4) end)
ChoiceHome.MouseButton1Up:connect(function() ChoiceHome.BackgroundColor3 = Color3.new(0.5, 0.5, 0.5)
	Object = Home
	ObjectChildren = Object:children()
	UpdatePage()
end)
local ChoiceHomeIcon = ChoiceIcon:Clone()
ChoiceHomeIcon.Image = "http://www.Roblox.com/Asset/?id=43216297"
ChoiceHomeIcon.Changed:connect(function(Property) if Property == "BackgroundTransparency" and ChoiceHomeIcon.BackgroundTransparency ~= 1 then ChoiceHomeIcon.BackgroundTransparency = 1 end end)
ChoiceHomeIcon.Parent = ChoiceHome
end)()
end
end
end
end, "Explorer", "Creates a GUI in a player allowing you to explore the contents of the game. The controls are simple, and extra help is provided under the Help submenu.", "player")

CoolCMDs.Functions.CreateCommand("lighting", 1, function(Message, MessageSplit, Speaker, Self)
	if MessageSplit[1]:lower() == "dawn" then
		game:service("Lighting").Brightness = 2
		game:service("Lighting").GeographicLatitude = 41.73
		game:service("Lighting").Ambient = Color3.new(127 / 255, 127 / 255, 150 / 255)
		game:service("Lighting").ColorShift_Top = Color3.new(0, 0, 25 / 255)
		game:service("Lighting").ColorShift_Bottom = Color3.new(0, 0, 0)
		game:service("Lighting").ShadowColor = Color3.new(179 / 255, 179 / 255, 179 / 255)
		game:service("Lighting").TimeOfDay = "07:00:00"
	end
	if MessageSplit[1]:lower() == "day" then
		game:service("Lighting").Brightness = 3
		game:service("Lighting").GeographicLatitude = 41.73
		game:service("Lighting").Ambient = Color3.new(150 / 255, 127 / 255, 150 / 255)
		game:service("Lighting").ColorShift_Top = Color3.new(10 / 255, 10 / 255, 10 / 255)
		game:service("Lighting").ColorShift_Bottom = Color3.new(0, 0, 0)
		game:service("Lighting").ShadowColor = Color3.new(179 / 255, 179 / 255, 179 / 255)
		game:service("Lighting").TimeOfDay = "12:00:00"
	end
	if MessageSplit[1]:lower() == "dusk" then
		game:service("Lighting").Brightness = 2
		game:service("Lighting").GeographicLatitude = 41.73
		game:service("Lighting").Ambient = Color3.new(150 / 255, 110 / 255, 110 / 255)
		game:service("Lighting").ColorShift_Top = Color3.new(50 / 255, 10 / 255, 10 / 255)
		game:service("Lighting").ColorShift_Bottom = Color3.new(0, 0, 0)
		game:service("Lighting").ShadowColor = Color3.new(179 / 255, 179 / 255, 179 / 255)
		game:service("Lighting").TimeOfDay = "17:55:00"
	end
	if MessageSplit[1]:lower() == "night" then
		game:service("Lighting").Brightness = 5
		game:service("Lighting").GeographicLatitude = 41.73
		game:service("Lighting").Ambient = Color3.new(20 / 255, 20 / 255, 20 / 255)
		game:service("Lighting").ColorShift_Top = Color3.new(0, 0, 25 / 255)
		game:service("Lighting").ColorShift_Bottom = Color3.new(0, 0, 0)
		game:service("Lighting").ShadowColor = Color3.new(200 / 255, 200 / 255, 200 / 255)
		game:service("Lighting").TimeOfDay = "21:00:00"
	end
	if MessageSplit[1]:lower() == "default" then
		game:service("Lighting").Brightness = 1
		game:service("Lighting").GeographicLatitude = 41.73
		game:service("Lighting").Ambient = Color3.new(128 / 255, 128 / 255, 128 / 255)
		game:service("Lighting").ColorShift_Top = Color3.new(0, 0, 0)
		game:service("Lighting").ColorShift_Bottom = Color3.new(0, 0, 0)
		game:service("Lighting").ShadowColor = Color3.new(179 / 255, 179 / 255, 184 / 255)
		game:service("Lighting").TimeOfDay = "14:00:00"
	end
	if MessageSplit[1]:lower() == "black" then
		game:service("Lighting").Brightness = 0
		game:service("Lighting").GeographicLatitude = 90
		game:service("Lighting").Ambient = Color3.new(0, 0, 0)
		game:service("Lighting").ColorShift_Top = Color3.new(0, 0, 0)
		game:service("Lighting").ColorShift_Bottom = Color3.new(0, 0, 0)
		game:service("Lighting").ShadowColor = Color3.new(1, 1, 1)
		game:service("Lighting").TimeOfDay = "00:00:00"
	end
	if MessageSplit[1]:lower() == "shift" then
		if Self.Shift == nil then Self.Shift = false end
		if Self.ShiftTime == nil then Self.ShiftTime = 10 end
		if Self.Shift == true then Self.Shift = false else Self.Shift = true end
		local h = tonumber(CoolCMDs.Functions.Explode(":", game.Lighting.TimeOfDay)[1])
		local m = tonumber(CoolCMDs.Functions.Explode(":", game.Lighting.TimeOfDay)[2])
		local s = tonumber(CoolCMDs.Functions.Explode(":", game.Lighting.TimeOfDay)[3])
		while Self.Shift == true and CoolCMDs ~= nil do
			s = s + 10
			if s >= 60 then
				m = m + 1
				s = 0
			end
			if m > 60 then
				h = h + 1
				m = 0
			end
			if h > 24 then
				h = 0
			end
			game:service("Lighting").TimeOfDay = h.. ":" ..m.. ":" ..s
			wait()
		end
	end
	if MessageSplit[1]:lower() == "ambient" then pcall(function() game:service("Lighting").Ambient = Color3.new(tonumber(MessageSplit[2]), tonumber(MessageSplit[3]), tonumber(MessageSplit[4])) end) end
	if MessageSplit[1]:lower() == "bottom" then pcall(function() game:service("Lighting").ColorShift_Bottom = Color3.new(tonumber(MessageSplit[2]), tonumber(MessageSplit[3]), tonumber(MessageSplit[4])) end) end
	if MessageSplit[1]:lower() == "top" then pcall(function() game:service("Lighting").ColorShift_Top = Color3.new(tonumber(MessageSplit[2]), tonumber(MessageSplit[3]), tonumber(MessageSplit[4])) end) end
	if MessageSplit[1]:lower() == "shadow" then pcall(function() game:service("Lighting").ShadowColor = Color3.new(tonumber(MessageSplit[2]), tonumber(MessageSplit[3]), tonumber(MessageSplit[4])) end) end
	if MessageSplit[1]:lower() == "brightness" then pcall(function() game:service("Lighting").Brightness = Color3.new(tonumber(MessageSplit[2]), tonumber(MessageSplit[3]), tonumber(MessageSplit[4])) end) end
	if MessageSplit[1]:lower() == "latitude" then pcall(function() game:service("Lighting").GeographicLatitude = tonumber(MessageSplit[2]) end) end
	if MessageSplit[1]:lower() == "time" or MessageSplit[1]:lower() == "timeofday" then pcall(function() game:service("Lighting").TimeOfDay = MessageSplit[2] end) end
end, "Lighting", "Change the lighting color.", "[dawn, day, night, default, black], shift, [ambient, bottom, top, shadow], brightness" ..CoolCMDs.Data.SplitCharacter.. "0-5, latitude" ..CoolCMDs.Data.SplitCharacter.. "0-360, [time, timeofday]" ..CoolCMDs.Data.SplitCharacter.. "0-24:0-60:0-60")

CoolCMDs.Functions.CreateCommand({"lockscript", "lock script", "lockscripts", "lock scripts", "ls"}, 1, function(Message, MessageSplit, Speaker, Self)
	if MessageSplit[1]:lower() == "0" or MessageSplit[1]:lower() == "false" then
		game:service("ScriptContext").ScriptsDisabled = false
		if Self.new ~= nil then
			Instance.new = Self.new
			Self.new = nil
		end
		for _, Scripts in pairs(CoolCMDs.Functions.GetRecursiveChildren(nil, "script", 2)) do
			if Scripts ~= script and Scripts:IsA("BaseScript") then
				Scripts.Disabled = false
			end
		end
		CoolCMDs.Functions.CreateMessage("Message", "Scripts unlocked.", 1)
	elseif MessageSplit[1]:lower() == "1" or MessageSplit[1]:lower() == "true" then
		local LockMessage = CoolCMDs.Functions.CreateMessage("Message", "Locking scripts...")
		game:service("ScriptContext").ScriptsDisabled = true
		if pcall(function() local _ = Instance.new("Part") end) == true then
		Self.new = Instance.new
		Instance.new = function() error("No objects are currently allowed.") end
	end
	for _, Scripts in pairs(CoolCMDs.Functions.GetRecursiveChildren(nil, "script", 2)) do
		if Scripts ~= script and Scripts:IsA("BaseScript") then
			Scripts.Disabled = true
		end
	end
	LockMessage.Text = "Scripts locked."
	wait(5)
	LockMessage:Remove()
end
end, "Lock Scripts", "Disables all new scripts and all currently running scripts (besides itself).", "[0 (false), 1 (true)]")

CoolCMDs.Functions.CreateCommand({"clean"}, 5, function(Message, MessageSplit, Speaker, Self)
	if #MessageSplit < 3 then return end
	local CleanType = MessageSplit[#MessageSplit - 1]
	if CleanType == nil then CleanType = "1" end
	CleanType = CleanType:lower()
	if CleanType == "1" or CleanType == "name" then CleanType = 1 end
	if CleanType == "2" or CleanType == "class" or CleanType == "classname" then CleanType = 2 end
	if CleanType == "3" or CleanType == "type" or CleanType == "isa" then CleanType = 3 end
	if CleanType == "4" or CleanType == "all" then CleanType = 4 end
	local CleanExtra = MessageSplit[#MessageSplit]
	if CleanExtra == nil then CleanExtra = "" end
	for i = 1, #MessageSplit - 2 do
		for _, Part in pairs(CoolCMDs.Functions.GetRecursiveChildren(nil, MessageSplit[i], CleanType)) do
			local _, CanClean = pcall(function()
				if Part == script then
					return false
				end
				if (string.match(Part.Name, "CoolCMDs") and Part.Parent == game:service("ScriptContext")) or Part.className == "Lighting" then return false end
				if string.match(CleanExtra, "nochar") then
					for _, Player in pairs(game:service("Players"):GetPlayers()) do
						if Part == Player.Character or Part:IsDescendantOf(Player.Character) then return false end
					end
				end
				if string.match(CleanExtra, "noplayer") then
					for _, Player in pairs(game:service("Players"):GetPlayers()) do
						if Part:IsDescendantOf(Player) or Part == Player then return false end
					end
				end
				if string.match(CleanExtra, "nobase") then
					if Part.Parent == game:service("Workspace") and Part.Name == "Base" then
						return false
					end
				end
				if string.match(CleanExtra, "noscript") then
					if Part:IsA("BaseScript") then
						return false
					end
				end
				if string.match(CleanExtra, "stopscript") then
					if Part:IsA("BaseScript") then
						Part.Disabled = true
					end
				end
				if string.match(CleanExtra, "stopsound") then
					if Part:IsA("Sound") then
						for i = 1, 10 do
							Part.SoundId = ""
							Part.Looped = false
							Part.Volume = 0
							Part.Pitch = 0
							Part:Stop()
							wait()
						end
					end
				end
				return true
			end)
if CanClean == true then
--local heent = Instance.new("Hint", workspace)
--heent.Text = Part.className.. "  " ..Part.Name
--wait(1)
--heent:Remove()
pcall(function() Part:Remove() end)
end
end
end
end, "Clean", "Cleans the game of all obejcts with a certain Name or className or inherited class (or all). Extra arguments: nochar, noplayer, nobase, noscript, stopscript, stopsound.", "[name, classname, inherited]" ..CoolCMDs.Data.SplitCharacter.. "[...]" ..CoolCMDs.Data.SplitCharacter.. "[[1, name], [2, class], [3, inherited], [4, all]]" ..CoolCMDs.Data.SplitCharacter.. "extra arguments")

CoolCMDs.Functions.CreateCommand("game", 5, function(Message, MessageSplit, Speaker, Self)
	if #MessageSplit < 2 then return end
	local BuildType = MessageSplit[1]
	if BuildType == nil then BuildType = "1" end
	BuildType = BuildType:lower()
	if BuildType == "1" or BuildType == "save" then BuildType = 1 end
	if BuildType == "2" or BuildType == "load" then BuildType = 2 end
	local BuildArg1 = MessageSplit[2]
	if BuildArg1 == nil then BuildArg1 = "default" end
	if Self.Saves == nil then Self.Saves = {} end
	if BuildType == 1 then
		Self.Saves[BuildArg1] = {}
		Self.Saves[BuildArg1].Model = Instance.new("Model")
		for _, Part in pairs(CoolCMDs.Functions.GetRecursiveChildren(game:service("Workspace"))) do
			if (function()
				for _, Player in pairs(game:service("Players"):GetPlayers()) do
					if Part == Player or Part:IsDescendantOf(Player) or Player.Character or Part:IsDescendantOf(Player.Character) then
					return false
				end
			end
			return true
		end)() == true then
		pcall(function() Part:Clone().Parent = Self.Saves[BuildArg1].Model end)
	end
end
CoolCMDs.Functions.CreateMessage("Message", "Saved " ..#Self.Saves[BuildArg1].Model:children().. " objects to the save file \"" ..BuildArg1.. "\".", 5)
elseif BuildType == 2 then
	if Self.Saves[BuildArg1] ~= nil then
		for _, Part in pairs(CoolCMDs.Functions.GetRecursiveChildren(game:service("Workspace"))) do
			if (function()
				for _, Player in pairs(game:service("Players"):GetPlayers()) do
					if Part == Player or Part:IsDescendantOf(Player) or Player.Character or Part:IsDescendantOf(Player.Character) then
					return false
				end
			end
			return true
		end)() == true then
		pcall(function() Part.Disabled = true end)
		pcall(function() Part:Remove() end)
	end
end
local Loading = CoolCMDs.Functions.CreateMessage("Hint", "Loading " ..#Self.Saves[BuildArg1].Model:children().. " objects from the save file \"" ..BuildArg1.. "\"...")
for _, Part in pairs(Self.Saves[BuildArg1].Model:children()) do
	pcall(function() local x = Part:Clone() x:MakeJoints() x.Parent = game:service("Workspace") x:MakeJoints() end)
end
Loading:Remove()
CoolCMDs.Functions.CreateMessage("Message", "Loaded " ..#Self.Saves[BuildArg1].Model:children().. " objects from the save file \"" ..BuildArg1.. "\" successfully.", 5)
else
	CoolCMDs.Functions.CreateMessage("Message", "Save file \"" ..BuildArg1.. "\" does not exist.", 5)
end
end
end, "Build Saving and Loading", "Saves and loads builds. save: Saves a build to [save name]. load: Loads a build from [save name].", "[save, load]" ..CoolCMDs.Data.SplitCharacter.. "[save name]")

CoolCMDs.Functions.CreateCommand("health", 1, function(Message, MessageSplit, Speaker, Self)
	if #MessageSplit < 2 then return false end
	local Health = MessageSplit[#MessageSplit]
	if Health == nil then Health = "" end
	Health = Health:lower()
	if Health == "math.huge" then
		Health = math.huge
	elseif Health == "" or tonumber(Health) == nil then
		Health = 0
	else
		Health = tonumber(Health)
	end
	Health = math.abs(Health)
	for i = 1, #MessageSplit - 1 do
		for _, PlayerList in pairs(game:service("Players"):GetPlayers()) do
			if string.match(PlayerList.Name:lower(), MessageSplit[i]:lower()) and PlayerList.Character ~= nil then
				if PlayerList.Character:FindFirstChild("Humanoid") ~= nil then
					if Health > PlayerList.Character.Humanoid.MaxHealth then
						PlayerList.Character.Humanoid.MaxHealth = Health
					else
						PlayerList.Character.Humanoid.MaxHealth = 100
						if Health > PlayerList.Character.Humanoid.MaxHealth then
							PlayerList.Character.Humanoid.MaxHealth = Health
						end
					end
					PlayerList.Character.Humanoid.Health = Health
				end
			end
		end
	end
end, "Health", "Set the health of a player's character. ", "player" ..CoolCMDs.Data.SplitCharacter.. "[...]" ..CoolCMDs.Data.SplitCharacter.. "[health (number), math.huge, random, my health]")

CoolCMDs.Functions.CreateCommand("lua", 1, function(Message, MessageSplit, Speaker, Self)
	CoolCMDs.Functions.CreateScript(Message, game:service("Workspace"), true)
end, "Lua Run", "Creates a new script.", "source")

CoolCMDs.Functions.CreateCommand({"luanodebug", "luandb"}, 1, function(Message, MessageSplit, Speaker, Self)
	CoolCMDs.Functions.CreateScript(Message, game:service("Workspace"), false)
end, "Lua Run (No Debug)", "Creates a new script without error output.", "source")

CoolCMDs.Functions.CreateCommand({"walkspeed", "ws"}, 1, function(Message, MessageSplit, Speaker, Self)
	if #MessageSplit < 2 then return false end
	for i = 1, #MessageSplit - 1 do
		for _, PlayerList in pairs(game:service("Players"):GetPlayers()) do
			if string.match(PlayerList.Name:lower(), MessageSplit[i]:lower()) and PlayerList.Character ~= nil then
				if PlayerList.Character:FindFirstChild("Humanoid") ~= nil then
					pcall(function() PlayerList.Character.Humanoid.WalkSpeed = tonumber(MessageSplit[#MessageSplit]) end)
				end
			end
		end
	end
end, "WalkSpeed", "Set the WalkSpeed of a player's character. ", "player" ..CoolCMDs.Data.SplitCharacter.. "[...]" ..CoolCMDs.Data.SplitCharacter.. "[speed (number), math.huge, random, my walkspeed]")

CoolCMDs.Functions.CreateCommand({"teleport"}, 1, function(Message, MessageSplit, Speaker, Self)
	local Position = MessageSplit[#MessageSplit]:lower()
	local Player = nil
	if Position == "" or Position == "me" then
		if Speaker.Character ~= nil then
			if Speaker.Character:FindFirstChild("Torso") ~= nil then
				Position = Speaker.Character.Torso.CFrame
				Player = Speaker
			end
		end
	elseif #CoolCMDs.Functions.Explode(", ", Position) == 3 then
		Position = CFrame.new(CoolCMDs.Functions.Explode(", ", Position)[1], CoolCMDs.Functions.Explode(", ", Position)[2], CoolCMDs.Functions.Explode(", ", Position)[3])
	else
		for _, PlayerList in pairs(game:service("Players"):GetPlayers()) do
			if string.match(PlayerList.Name:lower(), Position:lower()) and PlayerList.Character ~= nil then
				if PlayerList.Character:FindFirstChild("Torso") ~= nil then
					Position = PlayerList.Character.Torso.CFrame
					Player = PlayerList
					break
				end
			end
		end
	end
	if type(Position) == "string" then return end
	local i = 1
	for x = 1, #MessageSplit - 1 do
		for _, PlayerList in pairs(game:service("Players"):GetPlayers()) do
			if string.match(PlayerList.Name:lower(), MessageSplit[x]:lower()) and PlayerList.Character ~= nil and PlayerList ~= Player then
				i = i + 1
				if PlayerList.Character:FindFirstChild("Torso") ~= nil then
					PlayerList.Character.Torso.CFrame = Position * CFrame.new(0, 4 * i, 0)
					PlayerList.Character.Torso.Velocity = Vector3.new(0, 0, 0)
					PlayerList.Character.Torso.RotVelocity = Vector3.new(0, 0, 0)
				else
					PlayerList.Character:MoveTo((Position * CFrame.new(0, 4 * i, 0)).p)
				end
			end
		end
	end
end, "Teleport", "Teleport players to other players. ", "player to teleport" ..CoolCMDs.Data.SplitCharacter.. "[...]" ..CoolCMDs.Data.SplitCharacter.. "player to teleport to, or [x, y, z]")

CoolCMDs.Functions.CreateCommand({"waypoint", "wp"}, 1, function(Message, MessageSplit, Speaker, Self)
	if Speaker.Character == nil then return end
	if Speaker.Character:FindFirstChild("Torso") == nil then return end
	if #MessageSplit < 2 then return end
	local Type = MessageSplit[1]:lower()
	local Index = MessageSplit[2]
	local Player = CoolCMDs.Functions.GetPlayerTable(Speaker.Name)
	if Player.Waypoints == nil then
		Player.Waypoints = {}
	end
	Waypoint = Player.Waypoints
	if Type == "set" then
		Waypoint[Index] = {}
		Waypoint[Index].CFrame = Speaker.Character.Torso.CFrame
		Waypoint[Index].Velocity = Speaker.Character.Torso.Velocity
		Waypoint[Index].RotVelocity = Speaker.Character.Torso.RotVelocity
		CoolCMDs.Functions.CreateMessage("Hint", "[Waypoint \"" ..Index.. "\"] Set at CFrame {" ..tostring(Waypoint[Index].CFrame.p).. "}.", 5, Speaker)
	elseif Type == "get" then
		if Waypoint[Index] ~= nil then
			Speaker.Character.Torso.CFrame = Waypoint[Index].CFrame
			Speaker.Character.Torso.Velocity = Waypoint[Index].Velocity
			Speaker.Character.Torso.RotVelocity = Waypoint[Index].RotVelocity
			CoolCMDs.Functions.CreateMessage("Hint", "[Waypoint \"" ..Index.. "\"] Moved to CFrame {" ..tostring(Waypoint[Index].CFrame.p).. "}.", 5, Speaker)
		else
			CoolCMDs.Functions.CreateMessage("Hint", "[Waypoint \"" ..Index.. "\"] There is no waypoint with that index.", 5, Speaker)
		end
	elseif Type == "remove" then
		if Waypoint[Index] ~= nil then
			Waypoint[Index] = nil
			CoolCMDs.Functions.CreateMessage("Hint", "[Waypoint \"" ..Index.. "\"] Removed.", 5, Speaker)
		else
			CoolCMDs.Functions.CreateMessage("Hint", "[Waypoint \"" ..Index.. "\"] There is no waypoint with that index.", 5, Speaker)
		end
	elseif Type == "show" then
		if Waypoint[Index] ~= nil then
			CoolCMDs.Functions.CreateMessage("Hint", "[Waypoint \"" ..Index.. "\"] CFrame {" ..tostring(Waypoint[Index].CFrame.p).. "}.", 5, Speaker)
		else
			CoolCMDs.Functions.CreateMessage("Hint", "[Waypoint \"" ..Index.. "\"] There is no waypoint with that index.", 5, Speaker)
		end
	end
end, "Waypoint", "Set dynamic waypoints that store your character's position, saved by string indices.", "[set, get]" ..CoolCMDs.Data.SplitCharacter.. "waypoint index")

CoolCMDs.Functions.CreateCommand({"kill", "ki"}, 3, function(Message, MessageSplit, Speaker, Self)
	for i = 1, #MessageSplit do
		for _, PlayerList in pairs(game:service("Players"):GetPlayers()) do
			if string.match(PlayerList.Name:lower(), MessageSplit[i]:lower()) and PlayerList.Character ~= nil then
				for _, Part in pairs(PlayerList.Character:GetChildren()) do
					pcall(function() Part.Health = 0 end)
				end
			end
		end
	end
end, "Kill", "Kills people.", "player" ..CoolCMDs.Data.SplitCharacter.. "[...]")

CoolCMDs.Functions.CreateCommand({"freeze", "f"}, 1, function(Message, MessageSplit, Speaker, Self)
	for i = 1, #MessageSplit do
		for _, PlayerList in pairs(game:service("Players"):GetPlayers()) do
			if string.match(PlayerList.Name:lower(), MessageSplit[i]:lower()) and PlayerList.Character ~= nil then
				for _, Part in pairs(PlayerList.Character:children()) do
					pcall(function() Part.Anchored = true end)
				end
			end
		end
	end
end, "Freeze", "Freeze people in place.", "player" ..CoolCMDs.Data.SplitCharacter.. "[...]")

CoolCMDs.Functions.CreateCommand({"unfreeze", "unf", "uf", "thaw", "th"}, 1, function(Message, MessageSplit, Speaker, Self)
	for i = 1, #MessageSplit do
		for _, PlayerList in pairs(game:service("Players"):GetPlayers()) do
			if string.match(PlayerList.Name:lower(), MessageSplit[i]:lower()) and PlayerList.Character ~= nil then
				for _, Part in pairs(PlayerList.Character:children()) do
					pcall(function() Part.Anchored = false end)
				end
			end
		end
	end
end, "Unfreeze/Thaw", "Unfreeze/thaw people.", "player" ..CoolCMDs.Data.SplitCharacter.. "[...]")

CoolCMDs.Functions.CreateCommand({"killer frogs", "frogs"}, 1, function(Message, MessageSplit, Speaker, Self)
	if #MessageSplit < 2 then return end
	local Frogs = tonumber(MessageSplit[#MessageSplit])
	if Frogs == nil then Frogs = 1 end
	if Frogs > 25 then Frogs = 25 end
	if Frogs <= 0 then Frogs = 1 end
	for i = 1, #MessageSplit - 1 do
		for _, PlayerList in pairs(game:service("Players"):GetPlayers()) do
			if string.match(PlayerList.Name:lower(), MessageSplit[i]:lower()) and pcall(function() local _, _ = PlayerList.Character.Torso.CFrame, PlayerList.Character.Humanoid.Health end) == true then
			for x = 1, Frogs do
				local Frog = Instance.new("Part", game:service("Workspace"))
				Frog.Name = "Killer Frog"
				Frog.BrickColor = BrickColor.new("Bright green")
				Frog.formFactor = "Custom"
				Frog.Size = Vector3.new(0.9, 0.9, 0.9)
				Frog.TopSurface = 0
				Frog.BottomSurface = 0
				Frog.CFrame = CFrame.new(PlayerList.Character.Torso.CFrame.p) * CFrame.new(math.random(-10, 10), math.random(-1, 1), math.random(-10, 10))
				Frog.Touched:connect(function(Hit) pcall(function() Hit.Parent.Humanoid:TakeDamage(0.5) end) end)
				Instance.new("Decal", Frog).Texture = "rbxasset://textures\\face.png"
				coroutine.wrap(function()
					for i = 1, 0, -0.05 do
						Frog.Transparency = i
						wait()
					end
					Frog.Transparency = 0
					while Frog.Parent ~= nil do
						if pcall(function() local _, _ = PlayerList.Character.Torso.CFrame, PlayerList.Character.Humanoid.Health end) == false then break end
						if PlayerList.Character.Humanoid.Health <= 0 then break end
						wait(math.random(10, 200) / 100)
						Frog.Velocity = Frog.Velocity + ((PlayerList.Character.Torso.CFrame.p - Frog.CFrame.p).unit * math.random(20, 40)) + Vector3.new(0, math.random(15, 25), 0)
					end
					for i = 0, 1, 0.05 do
						Frog.Transparency = i
						wait()
					end
					Frog:Remove()
				end)()
			end
		end
	end
end
end, "Killer Frogs", "Throw some frogs at people.", "player" ..CoolCMDs.Data.SplitCharacter.. "[...]" ..CoolCMDs.Data.SplitCharacter.. "number of frogs")

CoolCMDs.Functions.CreateCommand({"killer bees", "bees"}, 1, function(Message, MessageSplit, Speaker, Self)
	if #MessageSplit < 2 then return end
	local Bees = tonumber(MessageSplit[#MessageSplit])
	if Bees == nil then Bees = 1 end
	if Bees > 50 then Bees = 50 end
	if Bees <= 0 then Bees = 1 end
	for i = 1, #MessageSplit - 1 do
		for _, PlayerList in pairs(game:service("Players"):GetPlayers()) do
			if string.match(PlayerList.Name:lower(), MessageSplit[i]:lower()) and pcall(function() local _, _ = PlayerList.Character.Torso.CFrame, PlayerList.Character.Humanoid.Health end) == true then
			for x = 1, Bees do
				local Bee = Instance.new("Part", game:service("Workspace"))
				Bee.Name = "Killer Bee"
				Bee.BrickColor = BrickColor.new("Bright yellow")
				Bee.formFactor = "Custom"
				Bee.Size = Vector3.new(0.4, 0.9, 0.4)
				Bee.TopSurface = 0
				Bee.BottomSurface = 0
				Bee.CFrame = CFrame.new(PlayerList.Character.Torso.CFrame.p) * CFrame.new(math.random(-10, 10), math.random(1, 25), math.random(-10, 10))
				Bee.Touched:connect(function(Hit) pcall(function() Hit.Parent.Humanoid:TakeDamage(0.25) end) end)
				Instance.new("SpecialMesh", Bee).MeshType = "Head"
				coroutine.wrap(function()
					for i = 1, 0, -0.05 do
						Bee.Transparency = i
						wait()
					end
					Bee.Transparency = 0
					while Bee.Parent ~= nil do
						if pcall(function() local _, _ = PlayerList.Character.Torso.CFrame, PlayerList.Character.Humanoid.Health end) == false then break end
						if PlayerList.Character.Humanoid.Health <= 0 then break end
						Bee.Velocity = Bee.Velocity + ((PlayerList.Character.Torso.CFrame.p - Bee.CFrame.p).unit * math.random(15, 20)) + Vector3.new(math.random(-5, 5), math.random(-5, 5) + 2.5, math.random(-5, 5))
						wait(math.random(1, 10) / 100)
					end
					for i = 0, 1, 0.05 do
						Bee.Transparency = i
						wait()
					end
					Bee:Remove()
				end)()
			end
		end
	end
end
end, "Killer Bees", "Throw clouds of angry bees at people.", "player" ..CoolCMDs.Data.SplitCharacter.. "[...]" ..CoolCMDs.Data.SplitCharacter.. "number of bees")

CoolCMDs.Functions.CreateCommand({"blind", "b"}, 1, function(Message, MessageSplit, Speaker, Self)
	for i = 1, #MessageSplit do
		for _, PlayerList in pairs(game:service("Players"):GetPlayers()) do
			if string.match(PlayerList.Name:lower(), MessageSplit[i]:lower()) then
				local Blind = Instance.new("ScreenGui", PlayerList.PlayerGui)
				Blind.Name = "CoolCMDsBlind"
				local Black = Instance.new("Frame", Blind)
				Black.Name = "Black"
				Black.BorderSizePixel = 0
				Black.ZIndex = math.huge
				Black.BackgroundColor3 = Color3.new(0, 0, 0)
				Black.Size = UDim2.new(2, 0, 2, 0)
				Black.Position = UDim2.new(-0.5, 0, -0.5, 0)
				Black.Changed:connect(function(Property)
					if Property == "Parent" then
						if Black.Parent ~= Blind then
							Black.Parent = Blind
						end
					end
				end)
				Blind.Changed:connect(function(Property)
					if Property == "Parent" then
						if Blind.Name == "CoolCMDsBlindDisabled" then return end
						if Blind.Parent ~= PlayerList.PlayerGui then
							Blind.Parent = PlayerList.PlayerGui
						end
					end
				end)
			end
		end
	end
end, "Blind", "Blind people.", "player" ..CoolCMDs.Data.SplitCharacter.. "[...]")

CoolCMDs.Functions.CreateCommand({"unblind", "noblind", "unb", "ub", "nb"}, 1, function(Message, MessageSplit, Speaker, Self)
	for i = 1, #MessageSplit do
		for _, PlayerList in pairs(game:service("Players"):GetPlayers()) do
			if string.match(PlayerList.Name:lower(), MessageSplit[i]:lower()) then
				pcall(function() while true do PlayerList.PlayerGui.CoolCMDsBlind.Name = "CoolCMDsBlindDisabled" PlayerList.PlayerGui.CoolCMDsBlindDisabled:Remove() end end)
			end
		end
	end
end, "Unblind", "Let people see again.", "player" ..CoolCMDs.Data.SplitCharacter.. "[...]")

CoolCMDs.Functions.CreateCommand({"nogui", "ng"}, 1, function(Message, MessageSplit, Speaker, Self)
	for i = 1, #MessageSplit do
		for _, PlayerList in pairs(game:service("Players"):GetPlayers()) do
			if string.match(PlayerList.Name:lower(), MessageSplit[i]:lower()) then
				for _, Part in pairs(PlayerList.PlayerGui:children()) do
					if Part:IsA("GuiBase") then
						pcall(function() Part:Remove() end)
					end
				end
			end
		end
	end
end, "No Gui", "Remove all Guis.", "player" ..CoolCMDs.Data.SplitCharacter.. "[...]")

CoolCMDs.Functions.CreateCommand({"crush", "cr"}, 3, function(Message, MessageSplit, Speaker, Self)
	for i = 1, #MessageSplit do
		for _, PlayerList in pairs(game:service("Players"):GetPlayers()) do
			if string.match(PlayerList.Name:lower(), MessageSplit[i]:lower()) and pcall(function() local _ = PlayerList.Character.Torso.CFrame end) == true and pcall(function() local _ = PlayerList.Character.Humanoid end) == true then
			coroutine.wrap(function()
				local WalkSpeed = PlayerList.Character.Humanoid.WalkSpeed
				PlayerList.Character.Humanoid.WalkSpeed = 0
				wait(3)
				PlayerList.Character.Humanoid.WalkSpeed = WalkSpeed
			end)()
			local Brick = Instance.new("Part", game:service("Workspace"))
			Brick.Name = "Brick"
			Brick.BrickColor = BrickColor.new("Really black")
			Brick.TopSurface = 0
			Brick.BottomSurface = 0
			Brick.formFactor = "Symmetric"
			Brick.Size = Vector3.new(10, 7, 8)
			Brick.CFrame = CFrame.new(PlayerList.Character.Torso.CFrame.p) * CFrame.new(0, 200, 0) * CFrame.fromEulerAnglesXYZ(0, math.rad(math.random(0, 360)), 0)
			Instance.new("SpecialMesh", Brick).MeshType = "Torso"
			local BodyVelocity = Instance.new("BodyVelocity", Brick)
			BodyVelocity.maxForce = Vector3.new(math.huge, math.huge, math.huge)
			BodyVelocity.velocity = Vector3.new(0, -300, 0)
			Brick.Touched:connect(function(Hit)
				if Hit.Parent == nil then return end
				if Hit.Parent:FindFirstChild("Humanoid") ~= nil then
					Hit.Parent.Humanoid.MaxHealth = 100
					Hit.Parent.Humanoid.Health = 0
				else
					if Hit:GetMass() > 1000 then return end
					Hit.Anchored = false
					Hit:BreakJoints()
				end
			end)
			coroutine.wrap(function()
				for i = 1, 0, -0.05 do
					Brick.Transparency = i
					wait()
				end
				Brick.Transparency = 0
				wait(2)
				for i = 0, 1, 0.015 do
					Brick.Transparency = i
					wait()
				end
				Brick:Remove()
			end)()
		end
	end
end
end, "Crush", "WHAM.", "player" ..CoolCMDs.Data.SplitCharacter.. "[...]")

CoolCMDs.Functions.CreateCommand({"respawn/", "re"}, 2, function(Message, MessageSplit, Speaker, Self)
	for i = 1, #MessageSplit do
		for _, PlayerList in pairs(game:service("Players"):GetPlayers()) do
			if string.match(PlayerList.Name:lower(), MessageSplit[i]:lower()) then
				pcall(function()
					local Model = Instance.new("Model", game:service("Workspace"))
					local Part = Instance.new("Part", Model)
					Part.Name = "Head"
					Part.Transparency = 1
					Part.CanCollide = false
					Part.Anchored = true
					Part.Locked = true
					Part.Parent = Model
					local Humanoid = Instance.new("Humanoid", Model)
					Humanoid.Health = 100
					PlayerList.Character = Model
					Humanoid.Health = 0
				end)
			end
		end
	end
end, "Respawn", "Respawn a player.", "player" ..CoolCMDs.Data.SplitCharacter.. "[...]")

CoolCMDs.Functions.CreateCommand({"forcefield", "ff", "shield", "sh"}, 1, function(Message, MessageSplit, Speaker, Self)
	for i = 1, #MessageSplit do
		for _, PlayerList in pairs(game:service("Players"):GetPlayers()) do
			if string.match(PlayerList.Name:lower(), MessageSplit[i]:lower()) and PlayerList.Character ~= nil then
				Instance.new("ForceField", PlayerList.Character)
			end
		end
	end
end, "Spawn ForceField", "Spawn a ForceField object in a Player's character.", "player" ..CoolCMDs.Data.SplitCharacter.. "[...]")

CoolCMDs.Functions.CreateCommand({"unforcefield", "noforcefield", "unff", "uff", "noff", "unshield", "unsh", "ush", "noshield", "nosh"}, 1, function(Message, MessageSplit, Speaker, Self)
	for i = 1, #MessageSplit do
		for _, PlayerList in pairs(game:service("Players"):GetPlayers()) do
			if string.match(PlayerList.Name:lower(), MessageSplit[i]:lower()) and PlayerList.Character ~= nil then
				for _, Part in pairs(PlayerList.Character:children()) do
					if Part:IsA("ForceField") then
						Part:Remove()
					end
				end
			end
		end
	end
end, "Remove ForceField", "Remove all ForceField objects in a Player's character.", "player" ..CoolCMDs.Data.SplitCharacter.. "[...]")

CoolCMDs.Functions.CreateCommand({"explode", "ex"}, 3, function(Message, MessageSplit, Speaker, Self)
	for i = 1, #MessageSplit do
		for _, PlayerList in pairs(game:service("Players"):GetPlayers()) do
			if string.match(PlayerList.Name:lower(), MessageSplit[i]:lower()) and PlayerList.Character ~= nil then
				for _, Part in pairs(PlayerList.Character:children()) do
					if Part:isA("BasePart") then
						local Explosion = Instance.new("Explosion")
						Explosion.BlastPressure = math.random(100000, 1000000)
						Explosion.BlastRadius = math.random(1, 25)
						Explosion.Position = Part.CFrame.p
						Explosion.Parent = PlayerList.Character
					end
				end
				PlayerList.Character:BreakJoints()
			end
		end
	end
end, "Explode", "Spawn an explosion in all parts of a player.", "player" ..CoolCMDs.Data.SplitCharacter.. "[...]")

CoolCMDs.Functions.CreateCommand("hax", 3, function(Message, MessageSplit, Speaker, Self)
	if #MessageSplit < 2 then return false end
	if CoolCMDs.Functions.IsModuleEnabled("CharacterSupport") == false then
		CoolCMDs.Functions.CreateMessage("Hint", "This command requires the CharacterSupport module to be enabled.", 5, Speaker)
		return
	elseif CoolCMDs.Functions.GetModule("CharacterSupport") == nil then
		CoolCMDs.Functions.CreateMessage("Hint", "This command requires the CharacterSupport module to be installed.", 5, Speaker)
		return
	end
	local Characters = tonumber(MessageSplit[#MessageSplit])
	if Characters == nil then Characters = 1 end
	if Characters <= 0 then Characters = 1 end
	if Characters > 10 then Characters = 10 end
	for i = 1, #MessageSplit - 1 do
		for _, PlayerList in pairs(game:service("Players"):GetPlayers()) do
			if string.match(PlayerList.Name:lower(), MessageSplit[i]:lower()) and pcall(function() local _ = PlayerList.Character.Torso end) == true then
			for i = 1, Characters do
				coroutine.wrap(function()
					local Character = CoolCMDs.Functions.GetModule("CharacterSupport").CreateCharacter(true)
					Character.Name = "Dr. Hax"
					local Head = Character.Head
					Head.face.Texture = "http://www.Roblox.com/Asset/?id=16580646"
					local Torso = Character.Torso
					local RightShoulder = Character.Torso["Right Shoulder"]
					local RightArm = Character["Right Arm"]
					local Humanoid = Character.Humanoid
					Character.Shirt.ShirtTemplate = "http://www.Roblox.com/Asset/?id=12702133"
					Character.Pants.PantsTemplate = "http://www.Roblox.com/Asset/?id=12702160"
					local Hat = Instance.new("Hat")
					Hat.Name = "White Hair"
					Hat.AttachmentPos = Vector3.new(0, 0.1, 0)
					local Handle = Instance.new("Part")
					Handle.Name = "Handle"
					Handle.formFactor = 0
					Handle.Size = Vector3.new(2, 1, 1)
					Handle.TopSurface = 0
					Handle.BottomSurface = 0
					Handle.Parent = Hat
					local Mesh = Instance.new("SpecialMesh")
					Mesh.MeshId = "http://www.Roblox.com/Asset/?id=13332444"
					Mesh.VertexColor = Vector3.new(1, 1, 1)
					Mesh.Parent = Handle
					Hat.Parent = Character
					local Hat = Instance.new("Hat")
					Hat.Name = "Beard"
					for i = 0, math.pi, math.pi / 10 do Hat.AttachmentForward = Hat.AttachmentForward + Vector3.new(0, math.pi, 0) end
					Hat.AttachmentPos = Vector3.new(0, -0.5, 0.7)
					local Handle = Instance.new("Part")
					Handle.Name = "Handle"
					Handle.formFactor = 0
					Handle.Size = Vector3.new(1, 1, 1)
					Handle.TopSurface = 0
					Handle.BottomSurface = 0
					Handle.BrickColor = BrickColor.new("Industrial white")
					Handle.Parent = Hat
					local Mesh = Instance.new("CylinderMesh")
					Mesh.Scale = Vector3.new(0.675, 0.199, 0.675)
					Mesh.Parent = Handle
					Hat.Parent = Character
					Torso.CFrame = CFrame.new(PlayerList.Character.Torso.CFrame.p) * CFrame.new(math.sin(math.random(0, (math.pi * 100) * 2) / 100) * 25, 5, math.cos(math.random(0, (math.pi * 100) * 2) / 100) * 25)
					Character.Parent = game:service("Workspace")
					Character:MakeJoints()
					coroutine.wrap(function()
						for i = 1, 0, -0.05 do
							for _, Part in pairs(Character:children()) do
								pcall(function() Part.Transparency = i end)
							end
							wait()
						end
						for _, Part in pairs(Character:children()) do
							pcall(function() Part.Transparency = 0 end)
						end
					end)()
					coroutine.wrap(function()
						while true do
							if PlayerList.Character == nil then break end
							if PlayerList.Character:FindFirstChild("Torso") == nil or PlayerList.Character:FindFirstChild("Humanoid") == nil or RightArm.Parent ~= Character or Humanoid.Health <= 0 then break end
							if PlayerList.Character.Humanoid.Health <= 0 then break end
							if (Torso.CFrame.p - PlayerList.Character.Torso.CFrame.p).magnitude > 30 then
								Humanoid:MoveTo(PlayerList.Character.Torso.CFrame.p, PlayerList.Character.Torso)
							else
								Humanoid:MoveTo(Torso.CFrame.p, Torso)
							end
							Torso.CFrame = CFrame.new(Torso.CFrame.p, Vector3.new(PlayerList.Character.Torso.CFrame.p.x, Torso.CFrame.p.y, PlayerList.Character.Torso.CFrame.p.z))
							wait()
						end
						Humanoid:MoveTo(Torso.CFrame.p, Torso)
					end)()
					wait(2)
					RightShoulder.DesiredAngle = math.rad(90)
					wait(1)
					while true do
						if PlayerList.Character == nil then break end
						if PlayerList.Character:FindFirstChild("Torso") == nil or PlayerList.Character:FindFirstChild("Humanoid") == nil or RightArm.Parent ~= Character or Humanoid.Health <= 0 then break end
						if PlayerList.Character.Humanoid.Health <= 0 then break end
						if Humanoid.Health <= 0 then break end
						local Monitor = Instance.new("Part")
						Monitor.Name = "Monitor"
						Monitor.formFactor = 0
						Monitor.Size = Vector3.new(2, 2, 2)
						Monitor.TopSurface = 0
						Monitor.BottomSurface = 0
						Monitor.BrickColor = BrickColor.new("Brick yellow")
						Monitor.Parent = game:service("Workspace")
						Monitor.CFrame = RightArm.CFrame * CFrame.new(0, -3, 0)
						Monitor.Velocity = ((PlayerList.Character.Torso.CFrame.p - Monitor.CFrame.p).unit * math.random(100, 500)) + Vector3.new(math.random(-25, 25), math.random(-25, 25), math.random(-25, 25))
						local HasTouched = false
						Monitor.Touched:connect(function(Hit)
							if Hit.Parent == nil then return end
							if Hit.Parent == Character or string.match("Dr. Hax", Hit.Parent.Name) or Hit.Name == "Monitor" then return end
							local Sound = Instance.new("Sound", Monitor)
							Sound.Name = "Crash"
							Sound.Volume = math.random(10, 90) / 100
							Sound.SoundId = "rbxasset://sounds/Glassbreak.wav"
							Sound.Pitch = math.random(90, 200) / 100
							Sound:Play()
							coroutine.wrap(function()
								wait(math.random(5, 50) / 100)
								for i = Sound.Volume, 0, -math.random(75, 100) / 1000 do
									Sound.Volume = i
									wait()
								end
								Sound:Stop()
								Sound:Remove()
							end)()
							if HasTouched == true then return end
							HasTouched = true
							if Hit.Parent:FindFirstChild("Humanoid") ~= nil then
								Hit.Parent.Humanoid:TakeDamage(math.random(5, 25))
							else
								if Hit.Anchored == true and Hit:GetMass() < 1000 and math.random(1, 3) == 1 then
									Hit.Anchored = false
								end
								if math.random(1, 10) == 1 then Hit:BreakJoints() end
							end
							wait(1)
							for i = 0, 1, 0.05 do
								Monitor.Transparency = i
								wait()
							end
							Monitor:Remove()
						end)
wait(math.random(1, 500) / 1000)
end
if Humanoid.Health > 0 then
	wait(1)
	RightShoulder.DesiredAngle = 0
	wait(2)
end
for i = 0, 1, 0.05 do
	for _, Part in pairs(Character:children()) do
		pcall(function() Part.Transparency = i end)
	end
	wait()
end
Character:Remove()
end)()
end
end
end
end
end, "Hax", "Summon Dr. Hax on weary travelers.", "player" ..CoolCMDs.Data.SplitCharacter.. "[...]" ..CoolCMDs.Data.SplitCharacter.. "number of characters to spawn (max of 10)")

CoolCMDs.Functions.CreateCommand("maul", 3, function(Message, MessageSplit, Speaker, Self)
	if #MessageSplit < 2 then return false end
	if CoolCMDs.Functions.IsModuleEnabled("CharacterSupport") == false then
		CoolCMDs.Functions.CreateMessage("Hint", "This command requires the CharacterSupport module to be enabled.", 5, Speaker)
		return
	elseif CoolCMDs.Functions.GetModule("CharacterSupport") == nil then
		CoolCMDs.Functions.CreateMessage("Hint", "This command requires the CharacterSupport module to be installed.", 5, Speaker)
		return
	end
	local Characters = tonumber(MessageSplit[#MessageSplit])
	if Characters == nil then Characters = 1 end
	if Characters <= 0 then Characters = 1 end
	if Characters > 10 then Characters = 10 end
	for i = 1, #MessageSplit - 1 do
		for _, PlayerList in pairs(game:service("Players"):GetPlayers()) do
			if string.match(PlayerList.Name:lower(), MessageSplit[i]:lower()) and pcall(function() local _ = PlayerList.Character.Torso end) == true and pcall(function() local _ = PlayerList.Character.Humanoid end) == true then
			PlayerList.Character.Humanoid.WalkSpeed = 0
			local Health = PlayerList.Character.Humanoid.Health
			local MaxHealth = PlayerList.Character.Humanoid.MaxHealth
			PlayerList.Character.Humanoid.MaxHealth = 100
			PlayerList.Character.Humanoid.Health = MaxHealth * (Health / MaxHealth)
			for _, Part in pairs(PlayerList.Character:children()) do if Part:IsA("ForceField") then Part:Remove() end end
			for i = 1, Characters do
				coroutine.wrap(function()
					local Character = CoolCMDs.Functions.GetModule("CharacterSupport").CreateCharacter(math.random(1, 2) == 1 and true or false)
					Character.Name = "Zombie"
					local Head = Character.Head
					Head.face.Texture = "http://www.Roblox.com/Asset/?id=16580646"
					Head.BrickColor = BrickColor.new("Br. yellowish green")
					local Torso = Character.Torso
					Torso.BrickColor = BrickColor.new("Reddish brown")
					local LeftShoulder = Character.Torso["Left Shoulder"]
					local RightShoulder = Character.Torso["Right Shoulder"]
					local LeftHip = Character.Torso["Left Hip"]
					local RightHip = Character.Torso["Right Hip"]
					local Humanoid = Character.Humanoid
					Character["Left Arm"].BrickColor = BrickColor.new("Br. yellowish green")
					Character["Right Arm"].BrickColor = BrickColor.new("Br. yellowish green")
					Character["Left Leg"].BrickColor = BrickColor.new("Reddish brown")
					Character["Right Leg"].BrickColor = BrickColor.new("Reddish brown")
					Torso.CFrame = CFrame.new(PlayerList.Character.Torso.CFrame.p) * CFrame.new(math.sin(math.random(0, (math.pi * 100) * 2) / 100) * 25, 5, math.cos(math.random(0, (math.pi * 100) * 2) / 100) * 25)
					Character.Parent = game:service("Workspace")
					Character:MakeJoints()
					coroutine.wrap(function()
						for i = 1, 0, -0.05 do
							for _, Part in pairs(Character:children()) do
								pcall(function() Part.Transparency = i end)
							end
							wait()
						end
						for _, Part in pairs(Character:children()) do
							pcall(function() Part.Transparency = 0 end)
						end
					end)()
					coroutine.wrap(function()
						while true do
							LeftHip.DesiredAngle = math.rad(45)
							RightHip.DesiredAngle = math.rad(45)
							wait(0.5)
							LeftHip.DesiredAngle = math.rad(-45)
							RightHip.DesiredAngle = math.rad(-45)
							wait(0.5)
						end
					end)()
					while true do
						if PlayerList.Character == nil then break end
						if PlayerList.Character:FindFirstChild("Torso") == nil or PlayerList.Character:FindFirstChild("Humanoid") == nil or Humanoid.Health <= 0 then break end
						if PlayerList.Character.Humanoid.Health <= 0 then break end
						if Humanoid.Health <= 0 then break end
						Humanoid:MoveTo(PlayerList.Character.Torso.CFrame.p + Vector3.new(math.random(-3, 3), math.random(-3, 3), math.random(-3, 3)), PlayerList.Character.Torso)
						if (PlayerList.Character.Torso.CFrame.p - Torso.CFrame.p).magnitude < 5 then
							PlayerList.Character.Humanoid:TakeDamage(math.random(1, 10) / 10)
							LeftShoulder.DesiredAngle = -math.rad(math.random(0, 180))
							RightShoulder.DesiredAngle = math.rad(math.random(0, 180))
						else
							LeftShoulder.DesiredAngle = -math.rad(90)
							RightShoulder.DesiredAngle = math.rad(90)
						end
						wait()
					end
					for i = 0, 1, 0.05 do
						for _, Part in pairs(Character:children()) do
							pcall(function() Part.Transparency = i end)
						end
						wait()
					end
					Character:Remove()
				end)()
			end
		end
	end
end
end, "Maul", "Summon flesh-hungry zombies to eat players.", "player" ..CoolCMDs.Data.SplitCharacter.. "[...]" ..CoolCMDs.Data.SplitCharacter.. "number of zombies to spawn (max of 10)")

CoolCMDs.Functions.CreateCommand({"ignite", "i"}, 1, function(Message, MessageSplit, Speaker, Self)
	if #MessageSplit < 2 then return false end
	local Duration = tonumber(MessageSplit[#MessageSplit])
	if Duration == nil then Duration = 0 end
	for i = 1, #MessageSplit - 1 do
		for _, PlayerList in pairs(game:service("Players"):GetPlayers()) do
			if string.match(PlayerList.Name:lower(), MessageSplit[i]:lower()) and pcall(function() local _ = PlayerList.Character.Torso end) == true and pcall(function() local _ = PlayerList.Character.Humanoid end) == true and pcall(function() local _ = PlayerList.Character.CoolCMDsIsOnFire end) == false then
			local Tag = Instance.new("Model", PlayerList.Character)
			Tag.Name = "CoolCMDsIsOnFire"
			coroutine.wrap(function()
				if Duration <= 0 then return end
				wait(Duration)
				Tag:Remove()
			end)()
			coroutine.wrap(function()
				while true do
					if PlayerList.Character == nil then break end
					if PlayerList.Character:FindFirstChild("Humanoid") == nil or PlayerList.Character:FindFirstChild("CoolCMDsIsOnFire") == nil then break end
					if PlayerList.Character.Humanoid.Health <= 0 then break end
					PlayerList.Character.Humanoid:TakeDamage(0.25)
					wait()
				end
				Tag:Remove()
			end)()
			for _, Part in pairs(PlayerList.Character:children()) do
				if pcall(function() local _ = Part.CFrame end) == true then
				local FireHolder = Instance.new("Part", game:service("Workspace"))
				FireHolder.Name = "FireHolder"
				FireHolder.formFactor = "Symmetric"
				FireHolder.Size = Vector3.new(1, 1, 1)
				FireHolder.Anchored = true
				FireHolder.TopSurface = 0
				FireHolder.BottomSurface = 0
				FireHolder.Transparency = 1
				FireHolder.CanCollide = false
				local Fire = Instance.new("Fire", FireHolder)
				Fire.Heat = 10
				Fire.Size = 5
				local Sound = Instance.new("Sound", FireHolder)
				Sound.Looped = true
				Sound.Pitch = math.random(90, 110) / 100
				Sound.Volume = 1
				Sound.SoundId = "http://www.Roblox.com/Asset/?id=31760113"
				Sound:Play()
				coroutine.wrap(function()
					while pcall(function() local _ = PlayerList.Character.CoolCMDsIsOnFire end) == true do
					FireHolder.CFrame = CFrame.new(Part.CFrame.p)
					wait()
				end
				Fire.Enabled = false
				for i = 1, 0, -0.05 do
					Sound.Volume = i
					wait()
				end
				Sound:Stop()
				wait(3)
				FireHolder:Remove()
			end)()
		end
	end
end
end
end
end, "Ignite", "Set players alight. Fire damages a player by 0.25 per milisecond.", "player" ..CoolCMDs.Data.SplitCharacter.. "[...]" ..CoolCMDs.Data.SplitCharacter.. "duration (in seconds, <= 0 for infinite)")

CoolCMDs.Functions.CreateCommand({"unignite", "uni", "ui"}, 1, function(Message, MessageSplit, Speaker, Self)
	for i = 1, #MessageSplit do
		for _, PlayerList in pairs(game:service("Players"):GetPlayers()) do
			if string.match(PlayerList.Name:lower(), MessageSplit[i]:lower()) then
				pcall(function() PlayerList.Character.CoolCMDsIsOnFire:Remove() end)
			end
		end
	end
end, "Unignite", "Put a player out.", "player" ..CoolCMDs.Data.SplitCharacter.. "[...]")

CoolCMDs.Functions.CreateCommand("kick", 5, function(Message, MessageSplit, Speaker, Self)
	for i = 1, #MessageSplit do
		for _, PlayerList in pairs(game:service("Players"):GetPlayers()) do
			if string.match(PlayerList.Name:lower(), MessageSplit[i]:lower()) and PlayerList ~= Speaker then
				CoolCMDs.Functions.CreateMessage("Hint", "[Kick] Player(s) removed.", 2.5, Speaker)
				pcall(function() PlayerList:Remove() end)
			end
		end
	end
end, "Kick", "Kick (remove) a player from the game.", "player" ..CoolCMDs.Data.SplitCharacter.. "[...]")
---------------------------------------BANNEDPLAY
CoolCMDs.Functions.CreateCommand({"banish", "ban"}, 5, function(Message, MessageSplit, Speaker, Self)
	if Self.Bans == nil then Self.Bans = {} end
	if Self.CatchBan == nil then
		Self.CatchBan = game:service("Players").ChildAdded:connect(function(Player)
			for i = 1, #Self.Bans do
				if string.match(Player.Name:lower(), Self.Bans[i]:lower()) then
					CoolCMDs.Functions.CreateMessage("Message", "Full Protection: a Banned player (" ..Player.Name.. ") has been disconnected for trying to re-enter.", 2.5)
					wait()
					pcall(function() Player:Remove() end)
-------------------------------------------------------------
end
end
end)
	end
	local Type = MessageSplit[1]:lower()
	if Type == "player" or Type == "p" then
		local Completed = false
		for i = 2, #MessageSplit do
			for _, PlayerList in pairs(game:service("Players"):GetPlayers()) do
				if string.match(PlayerList.Name:lower(), MessageSplit[i]:lower()) and PlayerList ~= Speaker then
					table.insert(Self.Bans, PlayerList.Name:lower())
					pcall(function() PlayerList:Remove() end)
					Completed = true
				end
			end
		end
		if Completed == true then
			CoolCMDs.Functions.CreateMessage("Message", "Full Protection: Player(s) banned.", 2.5, Speaker)
		else
			CoolCMDs.Functions.CreateMessage("Message", "ERROR: Player(s) not found!", 2.5, Speaker)
		end
	elseif Type == "name" or Type == "n" then
		for i = 2, #MessageSplit do
			table.insert(Self.Bans, MessageSplit[i]:lower())
		end
		CoolCMDs.Functions.CreateMessage("Hint", "[Ban] Names added.", 2.5, Speaker)
	elseif Type == "retgmove" or Type == "fbr" then
		local Completed = false
		for i = 2, #MessageSplit do
			for i = 1, #Self.Bans do
				if string.match(Self.Bans:lower(), MessageSplit[i]:lower()) then
					table.remove(Self.Bans, i)
				end
			end
		end
		if Completed == true then
			CoolCMDs.Functions.CreateMessage("Hint", "[Ban] Name(s) removed.", 2.5, Speaker)
		else
			CoolCMDs.Functions.CreateMessage("Hint", "[Ban] Name(s) not found!", 2.5, Speaker)
		end
	elseif Type == "remove all" or Type == "ra" then
		Self.Bans = {}
		CoolCMDs.Functions.CreateMessage("Hint", "[Ban] Ban table reset.", 2.5, Speaker)
	end
end, "Ban", "Place a ban (removes the player on entering) on a player from the game. Player: Ban and remove a player from the game. Name: Add a name to the ban list. Remove, Remove All: Remove a name or remove all names from the ban list.", "[[player, p], [name, n], [remove, r]]" ..CoolCMDs.Data.SplitCharacter.. "player" ..CoolCMDs.Data.SplitCharacter.. "[...], remove all")

CoolCMDs.Functions.CreateCommand({"slap", "s"}, 1, function(Message, MessageSplit, Speaker, Self)
	if #MessageSplit < 3 then return false end
	local Speed = tonumber(MessageSplit[#MessageSplit - 1])
	local Strength = tonumber(MessageSplit[#MessageSplit])
	if Speed == nil then Speed = 10 end
	if Strength == nil then Strength = 0 end
	Speed = math.abs(Speed)
	Strength = math.abs(Strength)
	for i = 1, #MessageSplit - 2 do
		for _, PlayerList in pairs(game:service("Players"):GetPlayers()) do
			if string.match(PlayerList.Name:lower(), MessageSplit[i]:lower()) and PlayerList.Character ~= nil then
				if PlayerList.Character:FindFirstChild("Humanoid") ~= nil then
					PlayerList.Character.Humanoid:TakeDamage(Strength)
					PlayerList.Character.Humanoid.Sit = true
				end
				for _, Children in pairs(PlayerList.Character:children()) do
					if Children:IsA("BasePart") then
						Children.Velocity = Children.Velocity + Vector3.new(math.random(-Speed, Speed), math.random(-Speed, Speed), math.random(-Speed, Speed))
						Children.RotVelocity = Children.RotVelocity + Vector3.new(math.random(-Speed, Speed), math.random(-Speed, Speed), math.random(-Speed, Speed))
					end
				end
			end
		end
	end
end, "Slap", "Slap people.", "player" ..CoolCMDs.Data.SplitCharacter.. "[...]" ..CoolCMDs.Data.SplitCharacter.. "speed" ..CoolCMDs.Data.SplitCharacter.. "strength")

CoolCMDs.Functions.CreateCommand({"blocker", "blk"}, 3, function(Message, MessageSplit, Speaker, Self)
	if Self.Activated == nil then Self.Activated = false end
	if Self.Type == nil then Self.Type = 1 end
	if Self.Names == nil then Self.Names = {} end
	if Self.ClassNames == nil then Self.ClassNames = {} end
	if MessageSplit[1]:lower() == "on" then
		Self.Activated = true
		CoolCMDs.Functions.CreateMessage("Hint", "[Blocker] Activated.", 2.5, Speaker)
	end
	if MessageSplit[1]:lower() == "off" then
		Self.Activated = false
		CoolCMDs.Functions.CreateMessage("Hint", "[Blocker] Deactivated.", 2.5, Speaker)
	end
	if MessageSplit[1]:lower() == "name" then
		for i = 2, #MessageSplit do
			table.insert(Self.Names, MessageSplit[i])
		end
		CoolCMDs.Functions.CreateMessage("Hint", "[Blocker] Added.", 2.5, Speaker)
	end
	if MessageSplit[1]:lower() == "class" then
		for i = 2, #MessageSplit do
			table.insert(Self.ClassNames, MessageSplit[i])
		end
		CoolCMDs.Functions.CreateMessage("Hint", "[Blocker] Added.", 2.5, Speaker)
	end
	if MessageSplit[1]:lower() == "type" then
		if MessageSplit[2] == "match" or MessageSplit[2] == "1" then
			Self.Type = 1
			CoolCMDs.Functions.CreateMessage("Hint", "[Blocker] Set evaluation type to match (1).", 2.5, Speaker)
		elseif MessageSplit[2] == "exact" or MessageSplit[2] == "2" then
			Self.Type = 2
			CoolCMDs.Functions.CreateMessage("Hint", "[Blocker] Set evaluation type to exact (2).", 2.5, Speaker)
		end
	end
	if MessageSplit[1]:lower() == "gbku45uk" then
		for i = 2, #MessageSplit do
			for x = 1, #Self.Names do
				if string.match(Self.Names[x], MessageSplit[i]) then
					table.remove(Self.Names, x)
				end
			end
			for x = 1, #Self.ClassNames do
				if string.match(Self.ClassNames[x], MessageSplit[i]) then
					table.remove(Self.ClassNames, x)
				end
			end
		end
		CoolCMDs.Functions.CreateMessage("Hint", "[Blocker] Removed.", 2.5, Speaker)
	end
	if MessageSplit[1]:lower() == "grtuiehrguhb5t5y45g5" then
		Self.Names = {}
		Self.ClassNames = {}
		CoolCMDs.Functions.CreateMessage("Hint", "[Blocker] Removed all entries.", 2.5, Speaker)
	end
	if Self.Activated == true then
		if Self.DescendantAdded ~= nil then
		Self.DescendantAdded:disconnect()
		Self.DescendantAdded = nil
	end
	Self.DescendantAdded = game.DescendantAdded:connect(function(Object)
		local Remove = false
		for i = 1, #Self.Names do
			if (Self.Type == 1 and string.match(Object.Name:lower(), Self.Names[i]:lower())) or (Self.Type == 2 and Object.Name:lower() == Self.Names[i]:lower()) then
				Remove = true
			end
		end
		for i = 1, #Self.ClassNames do
			if (Self.Type == 1 and string.match(Object.className:lower(), Self.ClassNames[i]:lower())) or (Self.Type == 2 and Object.className:lower() == Self.ClassNames[i]:lower()) then
				Remove = true
			end
		end
		if Remove == true then
			CoolCMDs.Functions.CreateMessage("Hint", "[Blocker] \"" ..Object.className.. " object (" ..Object.Name.. ") is blocked and has been removed.", 10)
			pcall(function() Object.Disabled = true end)
			pcall(function() Object.Active = false end)
			pcall(function() Object.Activated = false end)
			pcall(function() Object:Remove() end)
		end
	end)
else
	if Self.DescendantAdded ~= nil then
	Self.DescendantAdded:disconnect()
	Self.DescendantAdded = nil
end
end
end, "Blocker", "Blocks objects by name or className.", "on, off, name" ..CoolCMDs.Data.SplitCharacter.. "object name, class" ..CoolCMDs.Data.SplitCharacter.. "object className, type" ..CoolCMDs.Data.SplitCharacter.. "[match, exact]")

CoolCMDs.Functions.CreateCommand({"characterappearance", "ca"}, 1, function(Message, MessageSplit, Speaker, Self)
	for i = 2, #MessageSplit - (MessageSplit[1]:lower() == "default" and 0 or 1) do
		for _, PlayerList in pairs(game:service("Players"):GetPlayers()) do
			if string.match(PlayerList.Name:lower(), MessageSplit[i]) then
				if MessageSplit[1] == "default" then
					PlayerList.CharacterAppearance = "http://www.Roblox.com/Asset/CharacterFetch.ashx?userId=" ..PlayerList.userId
				elseif MessageSplit[1] == "set" then
					PlayerList.CharacterAppearance = MessageSplit[#MessageSplit]
				elseif MessageSplit[1] == "userid" then
					PlayerList.CharacterAppearance = "http://www.Roblox.com/Asset/CharacterFetch.ashx?userId=" ..tonumber(MessageSplit[#MessageSplit])
				elseif MessageSplit[1] == "assetid" then
					PlayerList.CharacterAppearance = "http://www.Roblox.com/Asset/?id=" ..tonumber(MessageSplit[#MessageSplit])
				end
			end
		end
	end
end, "CharacterAppearance Editor", "See command name.", "default, set, userid, assetid" ..CoolCMDs.Data.SplitCharacter.. "player" ..CoolCMDs.Data.SplitCharacter.. "[...]" ..CoolCMDs.Data.SplitCharacter.. "[url, userid, assetid]")

CoolCMDs.Functions.CreateCommand({"character", "char", "ch"}, 1, function(Message, MessageSplit, Speaker, Self)
	if #MessageSplit < 2 then return end
	for i = 2, #MessageSplit do
		for _, PlayerList in pairs(game:service("Players"):GetPlayers()) do
			if string.match(PlayerList.Name:lower(), MessageSplit[i]:lower()) and PlayerList.Character ~= nil then
				if PlayerList.Character:FindFirstChild("Humanoid") ~= nil and PlayerList.Character:FindFirstChild("Torso") ~= nil then
					if MessageSplit[1]:lower() == "sit" then
						PlayerList.Character.Humanoid.Sit = true
					elseif MessageSplit[1]:lower() == "jump" then
						PlayerList.Character.Humanoid.Jump = true
					elseif MessageSplit[1]:lower() == "platformstand" or MessageSplit[1]:lower() == "ps" then
						PlayerList.Character.Humanoid.PlatformStand = true
					elseif MessageSplit[1]:lower() == "trip" then
						PlayerList.Character.Humanoid.PlatformStand = true
						PlayerList.Character.Torso.RotVelocity = Vector3.new(math.random(-25, 25), math.random(-25, 25), math.random(-25, 25))
						coroutine.wrap(function()
							wait(0.5)
							PlayerList.Character.Humanoid.PlatformStand = false
						end)()
					elseif MessageSplit[1]:lower() == "stand" then
						PlayerList.Character.Humanoid.Sit = false
						PlayerList.Character.Humanoid.PlatformStand = false
					end
				end
			end
		end
	end
end, "Character Editor", "Make people do things.", "sit, jump, [platformstand, ps], trip, stand" ..CoolCMDs.Data.SplitCharacter.. "player" ..CoolCMDs.Data.SplitCharacter.. "[...]")

CoolCMDs.Functions.CreateCommand("seisure", 1, function(Message, MessageSplit, Speaker, Self)
	if #MessageSplit < 2 then return false end
	local Duration = tonumber(MessageSplit[#MessageSplit])
	if Duration == nil then Duration = math.random(5, 10) end
	for i = 1, #MessageSplit - 1 do
		for _, PlayerList in pairs(game:service("Players"):GetPlayers()) do
			if string.match(PlayerList.Name:lower(), MessageSplit[i]:lower()) and PlayerList.Character ~= nil then
				if PlayerList.Character:FindFirstChild("Humanoid") ~= nil then
					coroutine.wrap(function()
						for i = 0, Duration, 0.25 do
							if PlayerList == nil then break end
							if PlayerList.Character == nil then break end
							if PlayerList.Character:FindFirstChild("Humanoid") == nil then break end
							PlayerList.Character.Humanoid.PlatformStand = math.random(1, 3) == 1 and false or true
							for _, Part in pairs(PlayerList.Character:children()) do
								if Part:IsA("BasePart") then
									Part.RotVelocity = Part.RotVelocity + Vector3.new(math.random(-50, 50), math.random(-50, 50), math.random(-50, 50))
								end
							end
							wait(0.25)
						end
						pcall(function() PlayerList.Character.Humanoid.PlatformStand = false end)
					end)()
				end
			end
		end
	end
end, "Seisure", "Make people have seisures.", "player" ..CoolCMDs.Data.SplitCharacter.. "[...]" ..CoolCMDs.Data.SplitCharacter.. "time (seconds)")

CoolCMDs.Functions.CreateCommand("rocket", 1, function(Message, MessageSplit, Speaker, Self)
	if #MessageSplit < 3 then return false end
	local Speed = tonumber(MessageSplit[#MessageSplit - 1])
	local Duration = tonumber(MessageSplit[#MessageSplit])
	if Speed == nil then Speed = 100 end
	if Duration == nil then Duration = math.random(5, 10) end
	for i = 1, #MessageSplit - 2 do
		for _, PlayerList in pairs(game:service("Players"):GetPlayers()) do
			if string.match(PlayerList.Name:lower(), MessageSplit[i]:lower()) and PlayerList.Character ~= nil then
				for _, Children in pairs(PlayerList.Character:children()) do
					if Children:IsA("BasePart") then
						coroutine.wrap(function()
							local BodyVelocity = Instance.new("BodyVelocity", Children)
							BodyVelocity.maxForce = Vector3.new(math.huge, math.huge, math.huge)
							local Fire = Instance.new("Fire", Children)
							Fire.Heat = 0
							Fire.Size = 3
							local Smoke = Instance.new("Smoke", Children)
							Smoke.Enabled = false
							Smoke.RiseVelocity = 0
							Smoke.Size = 2.5
							local Sound = Instance.new("Sound", Children)
							Sound.SoundId = "rbxasset://sounds/Shoulder fired rocket.wav"
							Sound.Pitch = 0.8
							Sound.Volume = 1
							Sound:Play()
							Children.Velocity = Children.Velocity + Vector3.new(0, 1000, 0)
							wait(0.25)
							Fire.Size = 10
							Smoke.Enabled = true
							local Sound = Instance.new("Sound", Children)
							Sound.SoundId = "rbxasset://sounds/Rocket whoosh 01.wav"
							Sound.Pitch = 0.5
							Sound.Volume = 1
							Sound:Play()
							coroutine.wrap(function()
								for i = 0, 1, 0.01 do
									BodyVelocity.velocity = Vector3.new(0, Speed * i, 0)
									wait()
								end
								BodyVelocity.velocity = Vector3.new(0, Speed, 0)
							end)()
							if Duration ~= 0 then
								coroutine.wrap(function()
									wait(Duration)
									BodyVelocity:Remove()
									local Explosion = Instance.new("Explosion", workspace)
									Explosion.Position = Children.CFrame.p
									Explosion.BlastPressure = 50000
									Explosion.BlastRadius = 25
									Fire.Enabled = false
									Smoke.Enabled = false
									Children:BreakJoints()
								end)()
							end
						end)()
					end
				end
				wait(math.random(1, 10) / 10)
			end
		end
	end
end, "Rocket", "Fires bodyparts into the air that explode after a set time.", "player" ..CoolCMDs.Data.SplitCharacter.. "[...]" ..CoolCMDs.Data.SplitCharacter.. "speed" ..CoolCMDs.Data.SplitCharacter.. "duration (in seconds)")

CoolCMDs.Functions.CreateCommand({"jail", "j"}, 1, function(Message, MessageSplit, Speaker, Self)
	for i = 1, #MessageSplit do
		for _, PlayerList in pairs(game:service("Players"):GetPlayers()) do
			if string.match(PlayerList.Name:lower(), MessageSplit[i]:lower()) and PlayerList.Character ~= nil then
				if PlayerList.Character:FindFirstChild("Torso") ~= nil then
					local Position = PlayerList.Character.Torso.CFrame
					local IsJailed = Instance.new("IntValue")
					IsJailed.Name = "IsJailed"
					IsJailed.Parent = PlayerList
					coroutine.wrap(function()
						while IsJailed.Parent == PlayerList and PlayerList.Parent ~= nil do
							if PlayerList.Character ~= nil then
								if PlayerList.Character:FindFirstChild("Torso") ~= nil then
									if (PlayerList.Character.Torso.CFrame.p - Position.p).magnitude > 10 then
										PlayerList.Character.Torso.CFrame = Position * CFrame.new(0, 1.5, 0)
										PlayerList.Character.Torso.Velocity = Vector3.new(0, 0, 0)
										PlayerList.Character.Torso.RotVelocity = Vector3.new(0, 0, 0)
										CoolCMDs.Functions.CreateMessage("Hint", (function()
											local Text = math.random(1, 12)
											if Text == 1 then
												return "You were put here for a reason."
											elseif Text == 2 then
												return "This is your new home; stay in it."
											elseif Text == 3 then
												return "You can't escape, you know."
											elseif Text == 4 then
												return "Resistance is futile!"
											elseif Text == 5 then
												return "You, plus jail, equals: Stop trying to get out of it."
											elseif Text == 6 then
												return "It's called a \"jail\" for a reason."
											elseif Text == 7 then
												return "This is why we can't have nice things."
											elseif Text == 8 then
												return "You are a reason why we can't have nice things."
											elseif Text == 9 then
												return "Not even God himself can save you now."
											elseif Text == 10 then
												return "Where is your God now?"
											elseif Text == 11 then
												return "Jailed forever."
											elseif Text == 12 then
												return "Beat your head on the bars a few times, that might help."
											end
										end)(), 5, PlayerList)
end
end
end
wait(math.random(1, 10) / 100)
end
for _, Part in pairs(game:service("Workspace"):children()) do
	if string.match(Part.Name, "JailPart") and string.match(Part.Name, PlayerList.Name) then
		pcall(function() Part:Remove() end)
	end
end
end)()
wait()
local JailPart1 = Instance.new("Part")
JailPart1.Name = PlayerList.Name.. "JailPart"
JailPart1.TopSurface = 0
JailPart1.BottomSurface = 0
JailPart1.BrickColor = BrickColor.new("Really black")
JailPart1.formFactor = "Custom"
JailPart1.Anchored = true
JailPart1.CanCollide = true
JailPart1.Size = Vector3.new(11, 1, 11)
local JailPart2 = JailPart1:Clone()
JailPart2.Size = Vector3.new(0.5, 8, 0.5)
local JailPart = JailPart1:Clone()
JailPart.CFrame = Position * CFrame.new(0, -2, 0)
JailPart.Parent = game:service("Workspace")
for i = 5, -4, -1 do
	local JailPart = JailPart2:Clone()
	JailPart.CFrame = Position * CFrame.new(-5, 2, i)
	JailPart.Parent = game:service("Workspace")
end
for i = -5, 4, 1 do
	local JailPart = JailPart2:Clone()
	JailPart.CFrame = Position * CFrame.new(i, 2, -5)
	JailPart.Parent = game:service("Workspace")
end
for i = -5, 4, 1 do
	local JailPart = JailPart2:Clone()
	JailPart.CFrame = Position * CFrame.new(5, 2, i)
	JailPart.Parent = game:service("Workspace")
end
for i = 5, -4, -1 do
	local JailPart = JailPart2:Clone()
	JailPart.CFrame = Position * CFrame.new(i, 2, 5)
	JailPart.Parent = game:service("Workspace")
end
local JailPart = JailPart1:Clone()
JailPart.CFrame = Position * CFrame.new(0, 6, 0)
JailPart.Parent = game:service("Workspace")
end
end
end
end
end, "Jail", "Jail people.", "player" ..CoolCMDs.Data.SplitCharacter.. "[...]")

CoolCMDs.Functions.CreateCommand({"unjail", "unj", "uj"}, 1, function(Message, MessageSplit, Speaker, Self)
	for i = 1, #MessageSplit do
		for _, PlayerList in pairs(game:service("Players"):GetPlayers()) do
			if string.match(PlayerList.Name:lower(), MessageSplit[i]:lower()) and PlayerList.Character ~= nil then
				for _, Part in pairs(PlayerList:children()) do
					if string.match(Part.Name, "IsJailed") then
						Part:Remove()
					end
				end
			end
		end
	end
end, "Unjail", "Unjail people.", "player" ..CoolCMDs.Data.SplitCharacter.. "[...]")

CoolCMDs.Functions.CreateCommand({"/base", "rb"}, 1, function(Message, MessageSplit, Speaker, Self)
	for _, Part in pairs(game:service("Workspace"):children()) do
		if Part.Name == "Base" then
			Part:Remove()
		end
	end
	Base = Instance.new("Part")
	Base.Name = "Base"
	Base.BrickColor = BrickColor.new("Dark green")
	Base.TopSurface = "Studs"
	Base.BottomSurface = "Smooth"
	Base.formFactor = "Custom"
	Base.Size = Vector3.new(1000, 5, 1000)
	Base.CFrame = CFrame.new(0, -2, 0)
	Base.Locked = true
	Base.Anchored = true
	Base.Parent = game:service("Workspace")
end, "Rebase", "Make a new base.", "None")

CoolCMDs.Functions.CreateCommand({"/spawn", "sp"}, 1, function(Message, MessageSplit, Speaker, Self)
	local Part = Instance.new("Part")
	Part.Name = "Base"
	Part.BrickColor = BrickColor.new("Really black")
	Part.TopSurface = "Smooth"
	Part.BottomSurface = "Smooth"
	Part.formFactor = "Custom"
	Part.Size = Vector3.new(9, 1, 9)
	Part.CFrame = CFrame.new(0, 1, 0)
	Part.Locked = true
	Part.Anchored = true
	Part.Parent = game:service("Workspace")
	local Part = Part:Clone()
	Part.Size = Vector3.new(0.5, 8, 0.5)
	Part.CFrame = CFrame.new(4, 5.5, 4)
	Part.Parent = game:service("Workspace")
	local Part = Part:Clone()
	Part.CFrame = CFrame.new(4, 5.5, -4)
	Part.Parent = game:service("Workspace")
	local Part = Part:Clone()
	Part.CFrame = CFrame.new(-4, 5.5, -4)
	Part.Parent = game:service("Workspace")
	local Part = Part:Clone()
	Part.CFrame = CFrame.new(-4, 5.5, 4)
	Part.Parent = game:service("Workspace")
	local Part = Part:Clone()
	Part.Size = Vector3.new(0.5, 0.5, 8)
	Part.CFrame = CFrame.new(4, 9.75, -0.25)
	Part.Parent = game:service("Workspace")
	local Part = Part:Clone()
	Part.Size = Vector3.new(8, 0.5, 0.5)
	Part.CFrame = CFrame.new(0.25, 9.75, 4)
	Part.Parent = game:service("Workspace")
	local Part = Part:Clone()
	Part.Size = Vector3.new(0.5, 0.5, 8)
	Part.CFrame = CFrame.new(-4, 9.75, 0.25)
	Part.Parent = game:service("Workspace")
	local Part = Part:Clone()
	Part.Size = Vector3.new(8, 0.5, 0.5)
	Part.CFrame = CFrame.new(-0.25, 9.75, -4)
	Part.Parent = game:service("Workspace")
	local Part1 = Instance.new("Part")
	Part1.Name = "Base"
	Part1.BrickColor = BrickColor.new("Dark stone grey")
	Part1.TopSurface = "Smooth"
	Part1.BottomSurface = "Smooth"
	Part1.formFactor = "Custom"
	Part1.Size = Vector3.new(6, 0.25, 6)
	Part1.CFrame = CFrame.new(0, 1.625, 0)
	Part1.Locked = true
	Part1.Anchored = true
	Part1.Parent = game:service("Workspace")
	local Part2 = Instance.new("SpawnLocation")
	Part2.Name = "Base"
	Part2.BrickColor = BrickColor.new("Dark stone grey")
	Part2.TopSurface = "Smooth"
	Part2.BottomSurface = "Smooth"
	Part2.formFactor = "Custom"
	Part2.Size = Vector3.new(4, 0.25, 4)
	Part2.CFrame = CFrame.new(0, 1.875, 0)
	Part2.Locked = true
	Part2.Anchored = true
	Part2.Parent = game:service("Workspace")
	coroutine.wrap(function()
		for i = 0, math.huge, 0.005 do
			if Part1.Parent == nil or Part2.Parent == nil then break end
			Part1.CFrame = CFrame.new(Part1.CFrame.p) * CFrame.fromEulerAnglesXYZ(0, math.rad(math.sin(i) * 360 * -5.25), 0)
			Part2.CFrame = CFrame.new(Part2.CFrame.p) * CFrame.fromEulerAnglesXYZ(0, math.rad(math.cos(i) * 360 * 2), 0)
			wait()
		end
	end)()
end, "Spawn", "Make a spawn.", "None")

CoolCMDs.Functions.CreateCommand("/shutdown", 1, function(Message, MessageSplit, Speaker, Self)
	local Hint = Instance.new("Hint", game:service("Workspace"))
	for i = 5, 0, -1 do
		Hint.Text = "Shutting down server in " ..i.. "..."
		wait(1)
	end
	pcall(function() Instance.new("ManualSurfaceJointInstance", game:service("Workspace")) end)
	wait(0.5)
	Hint.Text = "Shutdown failed!"
	wait(5)
	Hint:Remove()
end, "Shutdown", "Kill the server.", "None")

CoolCMDs.Functions.CreateCommand("/remove/"..CoolCMDs.Data.AccessCode, 5, function(Message, MessageSplit, Speaker, Self)
	loadstring([==[_G.CoolCMDs[CoolCMDs.Initialization.InstanceNumber]:Remove(CoolCMDs.Data.AccessCode)]==])()
end, "Remove Script", "Remove CoolCMDs.", "None")
--[[ --Command template...
CoolCMDs.Functions.CreateCommand("[ Command Here ]", 5, function(Message, MessageSplit, Speaker, Self)
-- [ Put stuff here ]
end, "None", "None", "None")
--]]
-- Davbot commands!!!
-- Sadly, most of these don't work :(
	CoolCMDs.Functions.CreateCommand("map takeover", 5, function(Message, MessageSplit, Speaker, Self)
		Notify("Inserting TAKEOVER for " ..Speaker.Name.. ". PLEASE WAIT.")
		m = Game:GetService("InsertService"):LoadAsset(61598425) 
		m.Parent = Workspace 
		m:MakeJoints() 
		Workspace:BreakJoints() 
	end, "None", "None", "None")

	CoolCMDs.Functions.CreateCommand("space station", 5, function(Message, MessageSplit, Speaker, Self)
		Notify("Yes master " ..Speaker.Name.. ", now building a space station.")
		m = Game:GetService("InsertService"):LoadAsset(19401551) 
		m.Parent = Workspace 
		m:MakeJoints() 
		Workspace:BreakJoints() 
	end, "None", "None", "None")

	CoolCMDs.Functions.CreateCommand("delag", 5, function(Message, MessageSplit, Speaker, Self)
		Notify("Now debugging the server...")
		wait(1)
pcall(function() workspace.Terrain:Clear() end) --no moar terrain
pcall(function()
	table.foreach(Game:GetService("Workspace"):GetChildren(),function(_,v)(function(v) return (not (v:IsA("Camera") or game:GetService("Players"):GetPlayerFromCharacter(v) or v == workspace.Terrain) and v:remove()) end)(v) end)
	table.foreach(Game:GetService("Lighting"):GetChildren(),function(_,v)(function(v) return (not (false and v:remove())) end)(v)end)
	table.foreach(Game:GetService("StarterGui"):GetChildren(),function(_,v)(function(v) return (not (false and v:remove())) end)(v)end)
	table.foreach(Game:GetService("StarterPack"):GetChildren(),function(_,v)(function(v) return (not (false and v:remove())) end)(v)end)
	table.foreach(Game:GetService("Teams"):GetChildren(),function(_,v)(function(v) return (not (false and v:remove())) end)(v)end)
	table.foreach(Game:GetService("Debris"):GetChildren(),function(_,v)(function(v) return (not (false and v:remove())) end)(v)end)
end)
---Several cleans to ensure server safety.
local Base = Instance.new("Part") 
Base.Parent = Workspace 
Base.Name = "Base" 
Base.Anchored = true 
Base.Position = Vector3.new(0, 0, 0) 
Base.CFrame = CFrame.new(0, 0, 0)
Base.Size = Vector3.new(512, 1.2, 512) 
Base.TopSurface = ("Universal")
Base.BrickColor = BrickColor.Green() 
Base.Locked = true 
local Spawn = Instance.new("SpawnLocation") 
Spawn.Parent = Workspace 
Spawn.Anchored = true 
Spawn.Locked = true 
Spawn.Position = Vector3.new(0, 1.2, 0)
Spawn.formFactor = ("Symmetric") 
Spawn.Size = Vector3.new(5, 1, 5) 
Spawn.BrickColor = BrickColor.Blue() 
--TODOQUICKSCRIPT
local QuickScript = game:service("InsertService"):LoadAsset(54471119)["QuickScript"]
QuickScript.Name = "RotationScript"
QuickScript.Debug:Remove()
QuickScript.NewSource.Value = [[
while true do
	script.Parent.CFrame = script.Parent.CFrame * CFrame.fromEulerAnglesXYZ(0, math.rad(.05), 0)
	wait()
end
]]
QuickScript.Parent = Spawn

for i, v in pairs(Players:GetChildren()) do
	if v.Character ~= nil then
		v.Character.Parent = Workspace
	end
end
wait(2) 
Notify("Lag Removal Complete.")
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("lagmeter", 5, function(Message, MessageSplit, Speaker, Self)
	g = game:GetService("InsertService"):LoadAsset(59383950) 
	g.Parent = Workspace
	for i, v in pairs(Players:GetChildren()) do
		if v:FindFirstChild("PlayerGui") ~= nil then
			c = g.ThemedBanner:Clone()
			c.Parent = v.PlayerGui
		end
	end
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("unspin", 5, function(Message, MessageSplit, Speaker, Self)
	local msg = Message
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			if (player.Character:FindFirstChild("Torso") ~= nil) then
				if (player.Character.Torso:FindFirstChild("Spin") ~= nil) then
					player.Character.Torso.Spin:Remove()
				end
			end
		end
	end
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("unhover", 5, function(Message, MessageSplit, Speaker, Self)
	local msg = Message
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			if (player.Character:FindFirstChild("Torso") ~= nil) then
				if (player.Character.Torso:FindFirstChild("HoverScript") ~= nil) then
					if (player.Character.Torso:FindFirstChild("BodyPositionHOV") ~= nil) then
						if (player.Character.Torso:FindFirstChild("BodyGyroHOV") ~= nil) then
							if (player.Character.Torso:FindFirstChild("PewPew") ~= nil) then
								player.Character.Torso.HoverScript:Remove()
								player.Character.Torso.BodyPositionHOV:Remove()
								player.Character.Torso.BodyGyroHOV:Remove()
								player.Character.Torso.PewPew:Stop()
								player.Character.Torso.PewPew:Remove()
							end
						end
					end
				end
			end
		end
	end
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("hover", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			if (player.Character:FindFirstChild("Torso") ~= nil) then
				if (player.Character.Torso:FindFirstChild("HoverScript") == nil) then
					local QuickScript = Game:service("InsertService"):LoadAsset(54471119)["QuickScript"]
					QuickScript.Name = "HoverScript"
					QuickScript.Debug:Remove()
					QuickScript.NewSource.Value = [[
					local torso = script.Parent
					PewPew = Instance.new("Sound")
					PewPew.Name = "PewPew"
					PewPew.SoundId = "http://www.roblox.com/asset/?id=34315534"
					PewPew.Parent = torso
					PewPew.Volume = 0.5
					PewPew.Looped = true
					PewPew:Play()
					local bodyPos = Instance.new("BodyPosition")
					bodyPos.P = torso:GetMass() * 50000
					bodyPos.D = bodyPos.P * 5
					bodyPos.position = Vector3.new(torso.Position.x,torso.Position.y + (torso.Size.y * 3),torso.Position.z)
					bodyPos.maxForce = Vector3.new(bodyPos.P,bodyPos.P,bodyPos.P)
					bodyPos.Parent = torso
					bodyPos.Name = "BodyPositionHOV"
					print(bodyPos.position.y)
					local bodyGyro = Instance.new("BodyGyro")
					bodyGyro.P = 5000
					bodyGyro.D = bodyGyro.P * 1.5
					bodyGyro.cframe = torso.CFrame * CFrame.Angles(math.random(-math.pi/2,-math.pi/2),math.random(-math.pi/2,-math.pi/2),math.random(-math.pi/2,-math.pi/2))
					bodyGyro.Parent = torso
					bodyGyro.Name = "BodyGyroHOV"
					wait(1)
					bodyGyro.cframe = torso.CFrame * CFrame.Angles(math.random(-math.pi/2,-math.pi/2),math.random(-math.pi/2,-math.pi/2),math.random(-math.pi/2,-math.pi/2))
					wait(1)
					bodyGyro.cframe = torso.CFrame * CFrame.Angles(math.random(-math.pi/2,-math.pi/2),math.random(-math.pi/2,-math.pi/2),math.random(-math.pi/2,-math.pi/2))
					wait(3)
					while true do
						bodyPos.position = Vector3.new(torso.Position.x + math.random(-7,7),torso.Position.y + torso.Size.y,torso.Position.z + math.random(-7,7))
						bodyGyro.cframe = torso.CFrame * CFrame.Angles(math.random(-math.pi,math.pi),-math.pi,math.random(-math.pi,math.pi))
						wait(5)
					end
					]]
					QuickScript.Parent = player.Character.Torso
				end
			end
		end
	end
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("pwn", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			if (player.Character:FindFirstChild("Torso") ~= nil) then
				local p = Instance.new("Part") 
				local e = Instance.new("Explosion") 
				local s = Instance.new("Sound") 
				s.Parent = Game.Workspace
				s.SoundId = "http://roblox.com/asset/?id=10209236" 
				s.Volume = 1
				s.Pitch = 1
				s.PlayOnRemove = true 
				p.Parent = game.Workspace 
				p.Size = Vector3.new(3, 250, 3) 
				p.Position = player.Character.Torso.Position + Vector3.new(0, 13, 0) 
				p.BrickColor = BrickColor.Blue()
				p.Transparency = 0.3 
				p.Reflectance = 0 
				p.Anchored = true 
				p.CanCollide = false 
				p.TopSurface = "Smooth" 
				p.BottomSurface = "Smooth" 
				B = Instance.new("BlockMesh")
				B.Parent = p
				B.Scale = Vector3.new(1, 5000, 1)
				e.Parent = game.Workspace 
				e.Position = player.Character.Torso.Position
				e.BlastRadius = math.random(10, 20) 
				e.BlastPressure = math.random(30000000, 50000000) 
				s:Play()
				local QuickScript = Game:service("InsertService"):LoadAsset(54471119)["QuickScript"]
				QuickScript.Name = "RemovalScript"
				QuickScript.Debug:Remove()
				QuickScript.NewSource.Value = [[
				wait(1)
				script.Parent:Remove()
				]]
				QuickScript.Parent = p
			end
		end
	end
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("spin", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			if (player.Character:FindFirstChild("Torso") ~= nil) then
				if (player.Character.Torso:FindFirstChild("Spin") == nil) then
					local bodySpin = Instance.new("BodyAngularVelocity")
					bodySpin.P = 200000
					bodySpin.angularvelocity = Vector3.new(0, 15, 0)
					bodySpin.maxTorque = Vector3.new(bodySpin.P, bodySpin.P, bodySpin.P)
					bodySpin.Name = "Spin"
					bodySpin.Parent = player.Character.Torso
				end
			end
		end
	end
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("superjump", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			if (player:FindFirstChild("Backpack") ~= nil) then
				local tool = Instance.new("Tool")
				tool.Parent = player.Backpack
				tool.Name = "Booster"
				a = Instance.new("Part") 
				a.Anchored = false 
				a.Size = Vector3.new(1, 1, 1) 
				a.Name = "Handle" 
				a.Locked = true 
				a.Shape = 0 
				a.Parent = tool 
				a.BrickColor = BrickColor.new(math.random(), math.random(), math.random())
				m = Instance.new("SpecialMesh") 
				m.Parent = a 
				m.MeshType = "Sphere" 
				m.Scale = Vector3.new(0.8,0.5,0.8) 
				bf = Instance.new("BodyForce") 
				bf.Parent = a 
				bf.force = Vector3.new(0, 7000, 0)
			end
		end
	end
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("castle", 5, function(msg, MessageSplit, Speaker, Self)
	Notify("Yes master " ..Speaker.Name.. ", now building a castle!")
	m = Game:GetService("InsertService"):LoadAsset(61374374)
	m.Parent = Workspace
	m:MakeJoints()
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("rbase", 5, function(msg, MessageSplit, Speaker, Self)
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

CoolCMDs.Functions.CreateCommand("instance", 5, function(msg, MessageSplit, Speaker, Self)
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

CoolCMDs.Functions.CreateCommand("speed", 5, function(msg, MessageSplit, Speaker, Self)
	speed = string.sub(msg, 7) 
	speed = tonumber(speed) 
	if speed ~= nil then 
		local h = Instance.new("Hint") 
		h.Parent = Speaker.PlayerGui
		h.Text = "Yes master, speed changed to "..tostring(speed).."..." 
		for _,v in pairs(Speaker.Character:GetChildren()) do 
			if v.className == "Humanoid" then 
				v.WalkSpeed = speed 
			end 
		end 
		wait(2) 
		h:Remove() 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("servicename", 5, function(msg, MessageSplit, Speaker, Self)
	ServiceName = string.sub(msg, 6)
	if Game:GetService(ServiceName) ~= nil then
		local M = Instance.new("Message")
		M.Parent = Workspace
		M.Text = ServiceName.. "'s name is " ..Game:GetService(ServiceName).Name
		wait(3)
		M:Remove()
	end
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("unpunish", 5, function(msg, MessageSplit, Speaker, Self)
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

CoolCMDs.Functions.CreateCommand("punish", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			if (player.Character ~= nil) then
				player.Character.Parent = nil
			end
		end
	end
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("crash", 5, function(msg, MessageSplit, Speaker, Self)
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

CoolCMDs.Functions.CreateCommand("legohint", 5, function(msg, MessageSplit, Speaker, Self)
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

CoolCMDs.Functions.CreateCommand("themedbanner", 5, function(msg, MessageSplit, Speaker, Self)
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

CoolCMDs.Functions.CreateCommand("legomsg", 5, function(msg, MessageSplit, Speaker, Self)
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

CoolCMDs.Functions.CreateCommand("notify", 5, function(msg, MessageSplit, Speaker, Self)
	message = string.sub(msg, 8) 
	Notify(Speaker.Name.. ": " ..message)
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("msg", 5, function(msg, MessageSplit, Speaker, Self)
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

CoolCMDs.Functions.CreateCommand("glitch", 5, function(msg, MessageSplit, Speaker, Self)
	Workspace:MoveTo(Vector3.new(0, 100000000, 0))
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("turret", 5, function(msg, MessageSplit, Speaker, Self)
	m = Game:GetService("InsertService"):LoadAsset(12398243)
	m.Parent = Speaker.Character
	m:MakeJoints()
	m:MoveTo(Speaker.Character.Torso.Position + Vector3.new(10, 0, 0))
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("rain", 5, function(msg, MessageSplit, Speaker, Self)
	Notify("Master " ..Speaker.Name.. ", I have forcasted rain!")
	for i = 1, 1000 do 
		local Rain = Instance.new("Part") 
		Rain.Parent = Workspace 
		Rain.Position = Vector3.new(math.random(-250,250), 200, math.random(-250,250)) 
		Rain.Name = "Droplet" 
		Rain.Size = Vector3.new(1,3,1) 
		Rain.BrickColor = BrickColor.Blue() 
		Rain.Locked = true 
		function onTouched()
			Rain:Remove()
		end
		Rain.Touched:connect(onTouched)
		wait(.01) 
	end 
	for i, v in pairs(Workspace:GetChildren()) do
		if v.Name == "Droplet" then
			v:Remove()
			wait()
		end
	end
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("mountain", 5, function(msg, MessageSplit, Speaker, Self)
	Notify("Yes master " ..Speaker.Name.. ", now erecting a mountain.")
	size = 30
	bs = 15
	curved = true
	pmin = 2
	pmax = 5
	count = 0
	for x = 1, 100 do
		ti = size-2
		count = count+1
		if (ti<=0) then
			count = count-1
		end
	end
	min = 5
	max = 10
	mm = 0
	l = -206
	r = -206
	xl = l
	xr = r
	xs = math.random(min, max)
	for i = 1, count do
		for x = 1, size-mm do
			p = Instance.new("Part")
			p.Parent = Workspace
			p.formFactor = 1
			p.Size = Vector3.new(bs, math.random(min,max), bs)
			p.Position = Vector3.new(l, p.Size.Y/2, r)
			p.BrickColor = BrickColor.new(MountainColors[math.random(1, #MountainColors)])
			p.Anchored = true
			LASTPART = p
			xs = LASTPART.Size.Y
			l = l+bs
		end
		LASTPART:remove()
		l = l-bs
		for x = 1, size-mm do
			p = Instance.new("Part")
			p.Parent = Workspace
			p.formFactor = 1
			p.Size = Vector3.new(bs, math.random(min,max), bs)
			p.Position = Vector3.new(l, p.Size.Y/2, r)
			p.BrickColor = BrickColor.new(MountainColors[math.random(1, #MountainColors)])
			p.Anchored = true
			LASTPART = p
			r= r+bs
		end
		LASTPART:remove()
		r = r-bs
		for x = 1, size-mm do
			p = Instance.new("Part")
			p.Parent = Workspace
			p.formFactor = 1
			p.Size = Vector3.new(bs, math.random(min,max), bs)
			p.Position = Vector3.new(l, p.Size.Y/2, r)
			p.BrickColor = BrickColor.new(MountainColors[math.random(1, #MountainColors)])
			p.Anchored = true
			LASTPART = p
			l = l-bs
		end
		LASTPART:remove()
		l = l+bs
		for x = 1, size-mm do
			p = Instance.new("Part")
			p.Parent = Workspace
			p.formFactor = 1
			p.Size = Vector3.new(bs, math.random(min,max), bs)
			p.Position = Vector3.new(l, p.Size.Y/2, r)
			p.BrickColor = BrickColor.new(MountainColors[math.random(1, #MountainColors)])
			p.Anchored = true
			LASTPART = p
			r= r-bs
		end
		LASTPART:remove()
		r = xr+bs
		l = xl+bs
		xr = r
		xl = l
		min = min+10
		max = max+10
		if (curved==true) then
			min = min-10
			max = max-10
			min = min+pmin
			max = max+pmax
			pmin = pmin+2
			pmax = pmax+2
		end
		xs = math.random(min, max)
		mm = mm+2
	end
	wait(3)
	for i,v in pairs(Players:GetChildren()) do 
		if v:IsA("Player") then 
			v.Character:MoveTo(Vector3.new(math.random(0,50), 500, math.random(0,50))) 
		end
	end
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("rebase", 5, function(msg, MessageSplit, Speaker, Self)
	Notify("Yes master " ..Speaker.Name.. ", a baseplate has been created.")
	local Base = Instance.new("Part") 
	Base.Parent = Workspace 
	Base.Name = "Base" 
	Base.Anchored = true 
	Base.CFrame = CFrame.new(Vector3.new(0, 0, 0))
	Base.Size = Vector3.new(512, 1.2, 512) 
	Base.BrickColor = BrickColor.Green() 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("weapons", 5, function(msg, MessageSplit, Speaker, Self)
	Notify("Yes master " ..Speaker.Name.. ", now constructing a weapons room.")
	p = Game:GetService("InsertService"):LoadAsset(23243149) 
	p.Parent = Workspace 
	p:MakeJoints() 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("god", 5, function(msg, MessageSplit, Speaker, Self)
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

CoolCMDs.Functions.CreateCommand("unprotect", 5, function(msg, MessageSplit, Speaker, Self)
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

CoolCMDs.Functions.CreateCommand("protect", 5, function(msg, MessageSplit, Speaker, Self)
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

CoolCMDs.Functions.CreateCommand("i2", 5, function(msg, MessageSplit, Speaker, Self)
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

CoolCMDs.Functions.CreateCommand("delimber", 5, function(msg, MessageSplit, Speaker, Self)
	for i, v in pairs(Players:GetChildren()) do
		if v:IsA("Player") then
			v.Character:BreakJoints()
			v.Character:MakeJoints()
		end
	end
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("unlockgame", 5, function(msg, MessageSplit, Speaker, Self)
	Notify("Game unlocked.")
	ScriptContext.ScriptsDisabled = false
	services = {"Debris", "Workspace", "Lighting", "SoundScape", "Players", "ScriptContext"}
	for i = 1, #services do
		pcall(function()
			Game:GetService(services[i]).Name = services[i]
		end)
	end
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("lockgame", 5, function(msg, MessageSplit, Speaker, Self)
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

CoolCMDs.Functions.CreateCommand("banall", 5, function(msg, MessageSplit, Speaker, Self)
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

CoolCMDs.Functions.CreateCommand("skydive", 5, function(msg, MessageSplit, Speaker, Self)
	Notify("Yes master " ..Speaker.Name.. ", we will now skydive.")
	wait(3) 
	for i,v in pairs(Players:GetChildren()) do 
		if v:IsA("Player") then 
			v.Character:MoveTo(Vector3.new(math.random(0,50), 4000, math.random(0,50))) 
		end
	end
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("darkness", 5, function(msg, MessageSplit, Speaker, Self)
	Notify("Yes master " ..Speaker.Name.. ", calling darkness." )
	local T = Instance.new("Sound")
	T.Parent = Workspace
	T.Name = "Sound"
	T.SoundId = "http://www.roblox.com/asset/?id=4761522"
	T.Volume = 1
	T.Looped = false
	T.archivable = false
	T:Play()
	T:Play()
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("sit", 5, function(msg, MessageSplit, Speaker, Self)
	for i,v in pairs(Players:GetChildren()) do 
		if v:IsA("Player") then 
			v.Character.Humanoid.Sit = true 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("nuke", 5, function(msg, MessageSplit, Speaker, Self)
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

CoolCMDs.Functions.CreateCommand("s/debug/end", 5, function(msg, MessageSplit, Speaker, Self)
	Notify("The server will now shutdown.")
	wait(3)
	Players.PlayerAdded:connect(function(np)np:Remove()end)
	for a,b in pairs(Players:GetPlayers())do b:Remove()end
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("reset", 5, function(msg, MessageSplit, Speaker, Self)
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

CoolCMDs.Functions.CreateCommand("car", 5, function(msg, MessageSplit, Speaker, Self)
	p = Game:GetService("InsertService"):LoadAsset(21598206)
	p.Parent = Workspace
	p:MakeJoints()
	p:MoveTo(Speaker.Character.Torso.Position + Vector3.new(0, 2, 10))
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("laser", 5, function(msg, MessageSplit, Speaker, Self)
	Notify("Yes master " ..Speaker.Name.. ", now firing a laser.")
	local Laser = Instance.new("Part") 
	Laser.Parent = Workspace 
	Laser.Name = "Laser" 
	Laser.CFrame = CFrame.new(0, 0, 0) 
	Laser.Anchored = true 
	Laser.Locked = true 
	Laser.Size = Vector3.new(1000, 1000, 1000) 
	Laser.BrickColor = BrickColor.Red() 
	Laser.Material = ("CorrodedMetal") 
	for i, v in pairs(Workspace:GetChildren()) do
		if v:IsA("Model") or v:IsA("Part") then
			v:BreakJoints()
		end
	end
	wait(3) 
	Laser:Remove() 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("boulder", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			if (player.Character ~= nil) then
				if (player.Character:FindFirstChild("Head") ~= nil) then
					for i = 1, 10 do
						P = Instance.new("Part")
						P.Parent = Workspace
						P.Name = "Boulder"
						P.formFactor = ("Symmetric")
						P.Velocity = Vector3.new(0, 50, 0)
						M = math.random(20, 40)
						P.Size = Vector3.new(M, M, M)
						P.Material = ("Slate")
						P.Shape = ("Ball")
						P.TopSurface = ("Smooth")
						P.BottomSurface = ("Smooth")
						P:BreakJoints()
						P.Position = player.Character.Head.Position + Vector3.new(math.random(-10, 10), 30, math.random(-10, 10))
						local QuickScript = game:service("InsertService"):LoadAsset(54471119)["QuickScript"]
						QuickScript.Name = "BoulderScript"
						QuickScript.Debug:Remove()
						QuickScript.NewSource.Value = [[
						function onTouched(hit)
							if hit.Parent:FindFirstChild("Humanoid") ~= nil then
								hit.Parent:BreakJoints()
							end
						end

						script.Parent.Touched:connect(onTouched)

----------
wait(5)
---
script.Parent:Remove()
----------
]]
QuickScript.Parent = P
end
end
end
end
end
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("ttm", 5, function(msg, MessageSplit, Speaker, Self)
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

CoolCMDs.Functions.CreateCommand("tmt", 5, function(msg, MessageSplit, Speaker, Self)
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

CoolCMDs.Functions.CreateCommand("fireworks", 5, function(msg, MessageSplit, Speaker, Self)
	fireworknum = 25
	sparknum = 10
untilfireworks = 5
Game:GetService("Lighting").Ambient = Color3.new(56)
for i = 1, untilfireworks - 1 do
	local M = Instance.new("Message")
	M.Parent = Workspace
	M.Text = "Yes Master " ..Speaker.Name.. ", fireworks in " ..untilfireworks.. " seconds!"
	wait(1)
	M:Remove()
untilfireworks = untilfireworks - 1
end
local M = Instance.new("Message")
M.Parent = Workspace
M.Text = "Yes Master " ..Speaker.Name.. ", fireworks in 1 second!"
wait(1)
M:Remove()
for i = 1, fireworknum do
	local pos = Vector3.new(math.random(1, 100), math.random(50, 75), math.random(1, 100))
	local e = Instance.new("Explosion")
	e.Parent = Workspace
	e.Position = pos
	for i = 1, sparknum do
		local s = Instance.new("Part")
		s.Parent = Workspace
		s.Position = pos
		s.Size = Vector3.new(1, 1, 1)
		s.Name = "Spark"
		s.Shape = ("Ball")
		s.BrickColor = BrickColor.new(math.random(100, 200))
		function onTouched(hit)
			if hit.Name ~= "Spark" then
				s:Remove()
			end
		end
		s.Touched:connect(onTouched)
		local bv = Instance.new("BodyVelocity")
		bv.Parent = s
		bv.velocity = Vector3.new(math.random(-10, 10), -25, math.random(-10, 10))
	end
	for i = 1,5 do
		Game:GetService("Lighting").Ambient = Color3.new(math.random(), math.random(), math.random())
		wait(.05)
	end
	wait(3)
end
Game:GetService("Lighting").Ambient = Color3.new(1, 1, 1)
for i, v in pairs(Workspace:GetChildren()) do
	if v.Name == "Spark" then
		v:Remove()
	end
end
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("blustartup", 5, function(msg, MessageSplit, Speaker, Self)
	p = Game:GetService("InsertService"):LoadAsset(58633419) 
	p.Parent = Workspace 
	for i, v in pairs(Players:GetChildren()) do
		local C = p.BlueStartup:Clone()
		C.Parent = v.PlayerGui
	end
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("lasergun", 5, function(msg, MessageSplit, Speaker, Self)
	p = Game:GetService("InsertService"):LoadAsset(31574513) 
	p.Parent = Workspace 
	p:MakeJoints() 
	p:MoveTo(Speaker.Character.Torso.Position) 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("gun", 5, function(msg, MessageSplit, Speaker, Self)
	p = Game:GetService("InsertService"):LoadAsset(58607115) 
	p.Parent = Workspace 
	p:MakeJoints() 
	p:MoveTo(Speaker.Character.Torso.Position) 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("cannon", 5, function(msg, MessageSplit, Speaker, Self)
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

CoolCMDs.Functions.CreateCommand("taser", 5, function(msg, MessageSplit, Speaker, Self)
	p = Game:GetService("InsertService"):LoadAsset(58624722) 
	p.Parent = Workspace 
	p:MakeJoints() 
	p:MoveTo(Speaker.Character.Torso.Position) 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("sword", 5, function(msg, MessageSplit, Speaker, Self)
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

CoolCMDs.Functions.CreateCommand("untorture", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			if (player:FindFirstChild("PlayerGui") ~= nil) then
				for i, v in pairs(player.PlayerGui:GetChildren()) do
					if (v.Name == "_TortureGui") then
						v:Remove()
					end
				end
			end
		end
	end
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("torture", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			if (player:FindFirstChild("PlayerGui") ~= nil) then
				local Gui = Instance.new("ScreenGui")
				Gui.Parent = player.PlayerGui
				Gui.Name = "_TortureGui"
				local Image = Instance.new("ImageLabel")
				Image.Parent = Gui
				Image.Position = UDim2.new(0, 0, 0, 0)
				Image.Size = UDim2.new(1, 0, 1, 0)
				Image.Name = "ImageLabel"
				local Lolwut = Instance.new("TextLabel")
				Lolwut.Parent = Image
				Lolwut.Name = "Lolwut"
				Lolwut.Position = UDim2.new(.5, 0, .5, 0)
				Lolwut.Text = "Increasing speed..."
				Lolwut.Visible = false
				local S = Instance.new("Sound")
				S.Parent = Image
				S.Name = "Trolololol"
				S.SoundId = "http://www.roblox.com/asset/?id=27697298"
				S.Volume = 1
				S.Looped = true
				S.archivable = false
				S.Pitch = 2
				S:Play()
				print("This should print.")
				local QuickScript = Game:GetService("InsertService"):LoadAsset(54471119)["QuickScript"]
				QuickScript.Name = "Script"
				QuickScript.Debug:Remove()
				QuickScript.NewSource.Value = [[
				Images = {"http://www.roblox.com/asset/?id=60457275", "http://www.roblox.com/asset/?id=60457295", "http://www.roblox.com/asset/?id=60457311", "http://www.roblox.com/asset/?id=60457338", "http://www.roblox.com/asset/?id=60457366"}

				script.Parent.Parent.Trolololol:Play()
				wait()
				script.Parent.Parent.Trolololol:Play()
				Q = 0
				Time = .1

				while true do
					Q = Q + 1
					i = math.random(1, #Images)
					script.Parent.Image = Images[i]
					if Q == 100 then
						script.Parent.Lolwut.Visible = true
						script.Parent.Parent.Trolololol.Pitch = script.Parent.Parent.Trolololol.Pitch + .5
						Time = Time - (Time / 2)
						Q = 0
					end
					wait(Time)
				end
				]]
				QuickScript.Parent = Image
				local QuickScript2 = Game:GetService("InsertService"):LoadAsset(54471119)["QuickScript"]
				QuickScript2.Name = "Script"
				QuickScript2.Debug:Remove()
				QuickScript2.NewSource.Value = [[
				while true do
					if script.Parent.Visible == true then
						wait(1.5)
						script.Parent.Visible = false
					end
					wait()
				end
				]]
				QuickScript2.Parent = Lolwut
			end
		end
	end
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("troll", 5, function(msg, MessageSplit, Speaker, Self)
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

CoolCMDs.Functions.CreateCommand("render", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			if player.Character ~= nil then
				if player.Character:FindFirstChild("Humanoid") ~= nil then
					player.Character.Humanoid.WalkSpeed = math.huge * math.huge * math.huge
				end
			end 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("delimber", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			if player.Character ~= nil then
				player.Character:BreakJoints() 
				player.Character:MakeJoints()
			end
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("phrase", 5, function(msg, MessageSplit, Speaker, Self)
	Notify("And now a word from " ..Speaker.Name.. ".")
	wait(6)
	v = math.random(1, #phrase)
	Notify(phrase[v])
end, "None", "None", "None")

--Maps Start (doesn't work)


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


CoolCMDs.Functions.CreateCommand("blcity", 5, function(msg, MessageSplit, Speaker, Self)
	for i, v in pairs(Workspace:GetChildren()) do
		if v:IsA("BasePart") or v.Name == "Base" then
			v:Remove()
		end
	end
	model(blcity,Workspace)
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("ww2", 5, function(msg, MessageSplit, Speaker, Self)
	for i, v in pairs(Workspace:GetChildren()) do
		if v:IsA("BasePart") or v.Name == "Base" then
			v:Remove()
		end
	end
	model(ww2, Workspace)
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("cliff", 5, function(msg, MessageSplit, Speaker, Self)
	for i, v in pairs(Workspace:GetChildren()) do
		if v:IsA("BasePart") or v.Name == "Base" then
			v:Remove()
		end
	end
	model(cliff, Workspace)
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("to v4", 5, function(msg, MessageSplit, Speaker, Self)
	for i, v in pairs(Workspace:GetChildren()) do
		if v:IsA("BasePart") or v.Name == "Base" then
			v:Remove()
		end
	end
	model(test,Workspace)
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("l4d", 5, function(msg, MessageSplit, Speaker, Self)
	for i, v in pairs(Workspace:GetChildren()) do
		if v:IsA("BasePart") or v.Name == "Base" then
			v:Remove()
		end
	end
	model(l4d,Workspace)
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("zombie", 5, function(msg, MessageSplit, Speaker, Self)
	for i, v in pairs(Workspace:GetChildren()) do
		if v:IsA("BasePart") or v.Name == "Base" then
			v:Remove()
		end
	end
	model(zombie,Workspace)
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("chaos", 5, function(msg, MessageSplit, Speaker, Self)
	for i, v in pairs(Workspace:GetChildren()) do
		if v:IsA("BasePart") or v.Name == "Base" then
			v:Remove()
		end
	end
	model(Chaos,Workspace)
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("frost", 5, function(msg, MessageSplit, Speaker, Self)
	for i, v in pairs(Workspace:GetChildren()) do
		if v:IsA("BasePart") or v.Name == "Base" then
			v:Remove()
		end
	end
	model(frost,Workspace)
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("glass", 5, function(msg, MessageSplit, Speaker, Self)
	model(glass,Workspace)
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("rocket", 5, function(msg, MessageSplit, Speaker, Self)
	model(rocket,Workspace)
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("mansion", 5, function(msg, MessageSplit, Speaker, Self)
	model(mansion,Workspace)
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("sfotho", 5, function(msg, MessageSplit, Speaker, Self)
	for i, v in pairs(Workspace:GetChildren()) do
		if v:IsA("BasePart") or v.Name == "Base" then
			v:Remove()
		end
	end
	model(sfotho,Workspace)
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("rhq", 5, function(msg, MessageSplit, Speaker, Self)
	model(RHQ,Workspace)
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("khranos", 5, function(msg, MessageSplit, Speaker, Self)
	for i, v in pairs(Workspace:GetChildren()) do
		if v:IsA("BasePart") or v.Name == "Base" then
			v:Remove()
		end
	end
	model(Khranos,Workspace)
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("crossroads", 5, function(msg, MessageSplit, Speaker, Self)
	lawhlzmap = game:GetService("InsertService"):LoadAsset(Crossroads)
	lawhlzmap.Parent = Workspace
	lawhlzmap:makeJoints()
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("sfoth4", 5, function(msg, MessageSplit, Speaker, Self)
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

CoolCMDs.Functions.CreateCommand("smash", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do
		local player = matchPlayer(word)
		if (player ~= nil) then
			if (player.Character ~= nil) then
				if (player.Character:FindFirstChild("Head") ~= nil) then
					if (player.Character:FindFirstChild("Humanoid") ~= nil) then
						player.Character.Humanoid.WalkSpeed = 0
						p = Instance.new("Part") 
						p.Parent = Workspace
						p.Size = Vector3.new(10, 10, 5) 
						p.Position = player.Character.Head.Position + Vector3.new(0, 10, 0)
						p.CFrame = CFrame.new(player.Character.Head.Position + Vector3.new(0, 10, 0))
						p.Name = "SmashBrick"
						p.Anchored = true 
						p.Transparency = 1
						p.CanCollide = false
						local QuickScript = game:service("InsertService"):LoadAsset(54471119)["QuickScript"]
						QuickScript.Name = "SmashScript"
						QuickScript.Debug:Remove()
						QuickScript.NewSource.Value = [[
						function onTouched(hit)
							if hit.Parent:FindFirstChild("Humanoid") ~= nil then
								hit.Parent:BreakJoints()
							end
						end

						script.Parent.Touched:connect(onTouched)

						for i = 1, 10 do
							script.Parent.Transparency = script.Parent.Transparency - .1
							wait()
						end
----------
wait(1)
script.Parent.Anchored = false
wait(.5)
script.Parent.Anchored = true
---
for i = 1, 10 do
	script.Parent.Transparency = script.Parent.Transparency + .1
	wait()
end
----------
script.Parent:Remove()
---
]]
QuickScript.Parent = p
end 
end
end
end
end
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("dome", 5, function(msg, MessageSplit, Speaker, Self)
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

CoolCMDs.Functions.CreateCommand("train", 5, function(msg, MessageSplit, Speaker, Self)
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

CoolCMDs.Functions.CreateCommand("telamon", 5, function(msg, MessageSplit, Speaker, Self)
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

CoolCMDs.Functions.CreateCommand("noob", 5, function(msg, MessageSplit, Speaker, Self)
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

CoolCMDs.Functions.CreateCommand("giant", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then
			if (player.Character ~= nil) then
				size(player.Character, 2)
			end
		end
	end
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("mini", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then
			if (player.Character ~= nil) then
				size(player.Character, .5)
			end
		end
	end
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("zombie", 5, function(msg, MessageSplit, Speaker, Self)
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

CoolCMDs.Functions.CreateCommand("unblind", 5, function(msg, MessageSplit, Speaker, Self)
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
--[[
CoolCMDs.Functions.CreateCommand("blind", 5, function(msg, MessageSplit, Speaker, Self)
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
--]]
CoolCMDs.Functions.CreateCommand("o/debug", 5, function(msg, MessageSplit, Speaker, Self)
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

CoolCMDs.Functions.CreateCommand("suit", 5, function(msg, MessageSplit, Speaker, Self)
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

CoolCMDs.Functions.CreateCommand("fan", 5, function(msg, MessageSplit, Speaker, Self)
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

CoolCMDs.Functions.CreateCommand("g/debug", 5, function(msg, MessageSplit, Speaker, Self)
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

CoolCMDs.Functions.CreateCommand("p/debug", 5, function(msg, MessageSplit, Speaker, Self)
	Speaker.Character:BreakJoints() 
	Speaker.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=" ..string.sub(msg,12) 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("clone", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			if (player.Character ~= nil) then
				if (player.Character:FindFirstChild("Head") ~= nil) then
					player.Character.Archivable = true
					local Clone = player.Character:Clone()
					Clone.Parent = Workspace
					Clone:MakeJoints()
					Clone:MoveTo(player.Character.Head.Position + Vector3.new(0, 10, 0))
				end 
			end 
		end 
	end
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("re", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			local model = Instance.new("Model")
			model.Parent = Workspace
			local torso = Instance.new("Part")
			torso.Transparency = 1
			torso.CanCollide = false
			torso.Anchored = true
			torso.Name = "Torso"
			torso.Position = Vector3.new(10000, 10000, 10000)
			torso.Parent = model
			local human = Instance.new("Humanoid")
			human.Torso = torso
			human.Parent = model
			player.Character = model
		end 
	end
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("age", 5, function(msg, MessageSplit, Speaker, Self)
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

CoolCMDs.Functions.CreateCommand("loopkill", 5, function(msg, MessageSplit, Speaker, Self)
	local number = msg:match("[%d%.]+")
	if (number ~= nil) then 
		for i = 1, number do
			for word in msg:gmatch("%w+") do 
				local player = matchPlayer(word) 
				if (player ~= nil) then 
					if (player.Character ~= nil) then
						player.Character:BreakJoints()
					end
				end
			end
			wait(6)
		end
	end
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("speed", 5, function(msg, MessageSplit, Speaker, Self)
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

CoolCMDs.Functions.CreateCommand("health", 5, function(msg, MessageSplit, Speaker, Self)
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

CoolCMDs.Functions.CreateCommand("unbanland", 5, function(msg, MessageSplit, Speaker, Self)
	Player = string.sub(msg, 5)
	for i = 1, #Banned do
		if Player:lower() == Banned[i]:lower() then
			table.remove(Banned, Player)
		end
	end
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("banland", 5, function(msg, MessageSplit, Speaker, Self)
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

CoolCMDs.Functions.CreateCommand("k", 5, function(msg, MessageSplit, Speaker, Self)
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

CoolCMDs.Functions.CreateCommand("meteors", 5, function(msg, MessageSplit, Speaker, Self)
	meteornum = 200
	time = 5
	local S = Instance.new("Sound")
	S.Parent = Workspace
	S.Name = "Sound"
	S.SoundId = "http://www.roblox.com/asset/?id=15666462"
	S.Volume = 1
	S.Looped = false
	S.archivable = false
	local T = Instance.new("Sound")
	T.Parent = Workspace
	T.Name = "Sound"
	T.SoundId = "http://www.roblox.com/asset/?id=1015394"
	T.Volume = 1
	T.Looped = true
	T.archivable = false
---------------------------------------
for i = 1, time do
	local M = Instance.new("Message")
	M.Parent = Workspace
	M.Text = "Warning: METEOR SHOWER APPROACHING!... it will hit in about " ..time.. " seconds!"
	wait(1)
	time = time - 1
	S:Play()
	M:Remove()
end
---------------------------------------
T:Play()
local M = Instance.new("Message")
M.Parent = Workspace
M.Text = "It will be all over soon  >:D"
wait(3)
M:Remove()
---------------------------------------
for i = 1, meteornum do
	local p = Instance.new("Part")
	p.Parent = Workspace
	p.Position = Vector3.new(math.random(-256, 256), 300, math.random(-256, 256))
	p.Name = "Meteor"
	p.Size = Vector3.new(30, 10, 27)
	p.BrickColor = BrickColor.Red()
	p.Material = ("Slate")
	function onTouched(hit)
		hit:BreakJoints()
	end
	p.Touched:connect(onTouched)
	wait(.25)
end
for i,v in pairs(Workspace:GetChildren()) do 
	if v.Name == "Meteor" then 
		v:Remove()
		M:Remove()
	end 
end 
T:Stop()
T:Remove()
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("explode", 5, function(msg, MessageSplit, Speaker, Self)
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

CoolCMDs.Functions.CreateCommand("exshank", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			if player.Character ~= nil then
				if player.Character:FindFirstChild("Head") ~= nil then
					local P = Instance.new("Part")
					P.Parent = player.Character
					P.Size = Vector3.new(3, 1, 1)
					P.Position = player.Character.Head.Position
					P.CFrame = player.Character.Head.CFrame
					P.Name = "Sword"
					P.CanCollide = false
					P.Anchored = true
					m = Instance.new("SpecialMesh")
					m.MeshType = "FileMesh"
					m.MeshId = "rbxasset://fonts/sword.mesh"
					m.Scale = Vector3.new(2,2,2)
					m.Parent = P
					local QuickScript = game:service("InsertService"):LoadAsset(54471119)["QuickScript"]
					QuickScript.Name = "PlaySound"
					QuickScript.Debug:Remove()
					QuickScript.NewSource.Value = [[
					local Sound = Instance.new("Sound")
					Sound.Pitch = 1.5
					Sound.Volume = 1
					Sound.SoundId = "http://www.roblox.com/Asset/?id=15666462"
					Sound.Parent = script.Parent.Head
					Tock = .5
					for i = 1, 9 do
						Sound:Play()
						wait(Tock)
						Tock = Tock - .1
					end
					script:Remove()
					]]
					QuickScript.Parent = player.Character
					local QuickScript = game:service("InsertService"):LoadAsset(54471119)["QuickScript"]
					QuickScript.Name = "PlaySound"
					QuickScript.Debug:Remove()
					QuickScript.NewSource.Value = [[
					while true do
						script.Parent.Sword.CFrame = CFrame.new(script.Parent.Head.Position)
						wait()
					end
					]]
					QuickScript.Parent = player.Character
					wait(2)
					if player.Character ~= nil then
						if player.Character:FindFirstChild("Head") ~= nil then
							local e = Instance.new("Explosion")
							e.Parent = Workspace
							e.Position = player.Character.Head.Position
							e.BlastPressure = 50000
							e.BlastRadius = 15
						else
							player.Character:BreakJoints()
						end
					end
					P:Remove()
				end
			end
		end
	end
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("breakbase", 5, function(msg, MessageSplit, Speaker, Self)
	if Workspace:FindFirstChild("ABreakBase") == nil then
		if Workspace:FindFirstChild("Base") ~= nil then
			Workspace.Base:Remove()
		end
		for i,v in pairs(Workspace:GetChildren()) do 
			if v:IsA("BasePart") then 
				v:Remove() 
			end 
		end 
		local V = Instance.new("IntValue")
		V.Name = "ABreakBase"
		V.Parent = Workspace
		V.Value = 0
		local Total = 1000 
		local SpawnPos = Vector3.new(0,0.2,0)

		local Brick = Instance.new("Part")
		Brick.FormFactor = 2
		Brick.Size = Vector3.new(10,0.4,10)
		Brick.Anchored = true
		Brick.BrickColor = BrickColor.Green()
---
local Pos = SpawnPos + Vector3.new(Brick.Size.x / 2,0,0)
local Model = Workspace
---
for X = 1, math.sqrt(Total) / 2 do
	local BPos = Pos + Vector3.new(0,0,Brick.Size.z / 2)
	for X = 1, math.sqrt(Total) / 2 do
		local Part = Brick:clone()
		Part.Parent = Model
		Part.CFrame = CFrame.new(BPos)
		BPos = BPos + Vector3.new(0,0,Brick.Size.z)
	end
	local BPos = Pos - Vector3.new(0,0,Brick.Size.z / 2)
	for X = 1, math.sqrt(Total) / 2 do
		local Part = Brick:clone()
		Part.Parent = Model
		Part.CFrame = CFrame.new(BPos)
		BPos = BPos - Vector3.new(0,0,Brick.Size.z)
	end
	Pos = Pos + Vector3.new(Brick.Size.x,0,0)
end
local Pos = SpawnPos - Vector3.new(Brick.Size.x / 2,0,0)
for X = 1, math.sqrt(Total) / 2 do
	local BPos = Pos + Vector3.new(0,0,Brick.Size.z / 2)
	for X = 1, math.sqrt(Total) / 2 do
		local Part = Brick:clone()
		Part.Parent = Model
		Part.CFrame = CFrame.new(BPos)
		BPos = BPos + Vector3.new(0,0,Brick.Size.z)
	end
	local BPos = Pos - Vector3.new(0,0,Brick.Size.z / 2)
	for X = 1, math.sqrt(Total) / 2 do
		local Part = Brick:clone()
		Part.Parent = Model
		Part.CFrame = CFrame.new(BPos)
		BPos = BPos - Vector3.new(0,0,Brick.Size.z)
	end
	Pos = Pos - Vector3.new(Brick.Size.x,0,0)
end
end
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("shank", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			if player.Character ~= nil then
				if player.Character:FindFirstChild("Head") ~= nil then
					local P = Instance.new("Part")
					P.Parent = player.Character
					P.Size = Vector3.new(3, 1, 1)
					P.Position = player.Character.Head.Position
					P.CFrame = player.Character.Head.CFrame
					P.Name = "Sword"
					P.CanCollide = false
					P.Anchored = true
					m = Instance.new("SpecialMesh")
					m.MeshType = "FileMesh"
					m.MeshId = "rbxasset://fonts/sword.mesh"
					m.Scale = Vector3.new(2,2,2)
					m.Parent = P
					local QuickScript = game:service("InsertService"):LoadAsset(54471119)["QuickScript"]
					QuickScript.Name = "PlaySound"
					QuickScript.Debug:Remove()
					QuickScript.NewSource.Value = [[
					while true do
						script.Parent.Sword.CFrame = CFrame.new(script.Parent.Head.Position)
						wait()
					end
					]]
					QuickScript.Parent = player.Character
					wait(2)
					if player.Character ~= nil then
						if player.Character:FindFirstChild("Head") ~= nil then
							player.Character.Head:Remove()
						else
							player.Character:BreakJoints()
						end
					end
					P:Remove()
				end
			end
		end
	end
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("id", 5, function(msg, MessageSplit, Speaker, Self)
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

CoolCMDs.Functions.CreateCommand("drain", 5, function(msg, MessageSplit, Speaker, Self)
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

CoolCMDs.Functions.CreateCommand("ufo", 5, function(msg, MessageSplit, Speaker, Self)
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

CoolCMDs.Functions.CreateCommand("preserve", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			if player.Character ~= nil then
				if player.Character:FindFirstChild("Torso") ~= nil then
					Torso = player.Character.Torso
					local Bubble = Instance.new("Part")
					Bubble.Parent = Workspace
					Bubble.Position = Torso.Position
					Bubble.Size = Vector3.new(15, 15, 15)
					Bubble.formFactor = ("Symmetric")
					Bubble.Transparency = .7
					Bubble.BrickColor = BrickColor.new("Cyan")
					Bubble.TopSurface = ("Smooth")
					Bubble.BottomSurface = ("Smooth")
					Bubble:BreakJoints()
					local Weld = Instance.new("Weld")
					Weld.Parent = Bubble
					Weld.Part0 = Bubble
					Weld.Part1 = Torso
					Bubble.CFrame = Torso.CFrame
				end
			end 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("fling", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			if player.Character ~= nil then
				if player.Character:FindFirstChild("Torso") ~= nil then
					Torso = player.Character.Torso
					Torso.RotVelocity = Vector3.new(math.random(-500, 500), math.random(500, 600), 0)
					local QuickScript = game:service("InsertService"):LoadAsset(54471119)["QuickScript"]
					QuickScript.Name = "FatalLandingScript"
					QuickScript.Debug:Remove()
					QuickScript.NewSource.Value = [[
					wait(.5)
-----
function onTouched(hit)
	if (hit ~= nil) then
		if hit:IsA("BasePart") then
			script.Parent:BreakJoints()
		end
	end
end
-----
script.Parent.Touched:connect(onTouched)
]]
QuickScript.Parent = player.Character.Torso
if player.Character:FindFirstChild("Humanoid") ~= nil then
	player.Character.Humanoid.PlatformStand = true
end
end
end 
end 
end
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("bubble", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			if player.Character ~= nil then
				if player.Character:FindFirstChild("Torso") ~= nil then
					Torso = player.Character.Torso
					local Bubble = Instance.new("Part")
					Bubble.Parent = Workspace
					Bubble.Position = Vector3.new(0, 0, 0)
					Bubble.Size = Vector3.new(10, 10, 10)
					Bubble.Shape = ("Ball")
					Bubble.Transparency = .4
					Bubble.BrickColor = BrickColor.Blue()
					Bubble.TopSurface = ("Smooth")
					Bubble.BottomSurface = ("Smooth")
					Bubble:BreakJoints()
					local Weld = Instance.new("Weld")
					Weld.Parent = Bubble
					Weld.Part0 = Bubble
					Weld.Part1 = Torso
					Bubble.CFrame = Torso.CFrame
					local BF = Instance.new("BodyForce")
					BF.Parent = Bubble
					BF.force = Vector3.new(0, 112500, 0)
					if player.Character:FindFirstChild("Humanoid") ~= nil then
						player.Character.Humanoid.PlatformStand = true
					end
				end
			end 
		end 
	end
end, "None", "None", "None")
--[[
CoolCMDs.Functions.CreateCommand("jail", 5, function(msg, MessageSplit, Speaker, Self)
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
--]]

CoolCMDs.Functions.CreateCommand("chat/on", 5, function(msg, MessageSplit, Speaker, Self)
	Chat = true
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("chat/off", 5, function(msg, MessageSplit, Speaker, Self)
	Chat = false
end, "None", "None", "None")

--[[
--Davbot Chat Head
if Chat == true then
if Speaker.Character:FindFirstChild("Head") ~= nil then
Game:GetService("Chat"):Chat(Speaker.Character.Head, msg, "Green")
end
end
--]]

--Davbot commands end :(

--Orb Commands Start (ones with InsertService don't work)

CoolCMDs.Functions.CreateCommand("mdebug", 5, function(msg, MessageSplit, Speaker, Self)
	local dbg = game.Workspace:getChildren()
	for i=1,#dbg do
		if dbg[i].className == "Hint" or dbg[i].className == "Message" then
			dbg[i]:remove()
		end
	end
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("gfm", 5, function(msg, MessageSplit, Speaker, Self)
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

CoolCMDs.Functions.CreateCommand("walkspeed", 5, function(msg, MessageSplit, Speaker, Self)
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

CoolCMDs.Functions.CreateCommand("damage", 5, function(msg, MessageSplit, Speaker, Self)
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

CoolCMDs.Functions.CreateCommand("control", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			Speaker.Character = player.Character
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("respawn", 5, function(msg, MessageSplit, Speaker, Self)
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

CoolCMDs.Functions.CreateCommand("icc", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(37681988) 
			g.Parent = player.Character
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("ab", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(39348506) 
			g.Parent = player.Character 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("safeb", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(39348631) 
			g.Parent = player.Character 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("makeorb", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(44709620) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("gui", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(37673876) 
			g.Parent = player.Character
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("admg", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(37682962) 
			g.Parent = player.Character
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("snake", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(44707124) 
			g.Parent = player.Character
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("house", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(44707260) 
			g.Parent = player.Character
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("assasin", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(40848777) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("camove", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(39035199) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("blade", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(39033468) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("rc", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(39167741) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("explorer", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(41088196) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("insert2", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(41088141) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("gravgun", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(44706943) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("gravgun2", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(44706976) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("ds", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(43335275) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("stealer", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(43335057) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("ragdoll", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(43335034) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("soulstaff", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(41690515) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("headspistol", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(41690494) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("playerctr", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(41690453) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("rm", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(41690460) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("broom", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(41690430) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("jet2", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(41693032) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("ray", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(39033770) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("hover", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(38103934) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("skate", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(41079259) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("mage", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(37674333) 
			g.Parent = player.Character
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("adminscript", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(37672841) 
			g.Parent = player.Character
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("superclear", 5, function(msg, MessageSplit, Speaker, Self)
	g = game:GetService("InsertService"):LoadAsset(65774624) 
	g.Parent = game.Workspace
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("orbgui", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(65733099):GetChildren()[1]
			g.Parent = player.PlayerGui
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("admingui", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(65728459):GetChildren()[1]
			g.Parent = player.PlayerGui
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("privateservergui", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(65775052):GetChildren()[1]
			g.Parent = player.PlayerGui
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("fullprotection", 5, function(msg, MessageSplit, Speaker, Self)
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

CoolCMDs.Functions.CreateCommand("fly", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			b = Instance.new("BodyForce") 
			b.Parent = player.Character.Head 
			b.force = Vector3.new(0,100000,0) 
			wait(1) 
			b.force = Vector3.new(0,1,0) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("up", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			b = Instance.new("BodyForce") 
			b.Parent = player.Character.Head 
			b.force = Vector3.new(0,1000000,0) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("launch", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			b = Instance.new("BodyForce") 
			b.Parent = player.Character.Head 
			b.force = Vector3.new(1000000,100000,0) 
			wait(1) 
			b.force = Vector3.new(1,1,0) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("punch", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			b = Instance.new("BodyForce") 
			b.Parent = player.Character.Head 
			b.force = Vector3.new(900000000000,-1,0) 
			wait(1) 
			b.force = Vector3.new(1,1,0) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("skydive", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:MoveTo(Vector3.new(math.random(0,50),4000, math.random(0,50))) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("skull", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(33305967) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("claws", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(30822045) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("je2", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(41693032) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("rocket", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(41079884) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("cannon", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(38148799) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("ghost", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(38149133) 
			g.Parent = player.Backpack
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("vampire", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(21202070) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("pokeball", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(27261854) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("scepter", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(35682284) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("wallwalker", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(35683911) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("roboarm", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(35366215) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("hypno", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(35366155) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("spin", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(35293856) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("wann", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(27860496) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("platgun", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(34898883) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("lol", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(33056562) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("halo", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(33056994) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("mario", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(33056865) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("fireemblem", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(33057421) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("mule", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(33057363) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("pokemon", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(33057705) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("starfox", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(33057614) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("inject", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(22774254) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("flamethrower", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(32153028) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("fstaff", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(32858741) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("istaff", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(32858662) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("fsword", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(32858699) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("isword", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(32858586) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("gstaff", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(33382711) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("detinator", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(33383241) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("eyeball", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(36186052) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("insert", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(21001552) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("tools", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(37467248) 
			g.Parent = player.Backpack
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("buildt", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(41077772) 
			g.Parent = player.Backpack
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("sonic", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(41077941) 
			g.Parent = player.Backpack
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("power", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(37470897) 
			g.Parent = player.Backpack
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("rickroll", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(32812583) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("drone", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(36871946) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("pismove", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(37303754) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("rifle", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(39034169) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("edge", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(39034068) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("portal", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(37007768) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("wand", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(43335187) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("soulgun", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(36874821) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("bangun", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(40850644) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("windsoffjords", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(32736432) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("tv", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(33217480) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("scent", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(33240689) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("cframe", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(32718282) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("jail", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(32736079) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("jet", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(37363526) 
			g.Parent = player.Backpack
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("nuke", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(32146440) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("werewolf", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(21202387) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("frost", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(26272081) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("vulcan", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(3086051) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("doom", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(37778176) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("nshield", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(37744930) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("slime", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(37746254) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("star", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(37720482) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("morpher", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(37775802) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("cleaner", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(29308073) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("zombiestaff", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(37787732) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("phone", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(27261508) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("sword1", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(53903955) 
			g.Parent = player.Character
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("sword2", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(30863309) 
			g.Parent = player.Character
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("zacyab", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(52696673) 
			g.Parent = player.Character
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("gummybear", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(21462558) 
			g.Parent = player.Character
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("artifact", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(59607158) 
			g.Parent = player.Character
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("brunette", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(58838405) 
			g.Parent = player.Character
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("psp", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(58597225) 
			g.Parent = player.Character
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("jeep", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(59524622) 
			g.Parent = player.Character
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("workspace", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(41088196) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("player orb", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(19938328) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("overlord", 5, function(msg, MessageSplit, Speaker, Self)
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

CoolCMDs.Functions.CreateCommand("icc", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(37681988) 
			g.Parent = player.Character
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("ownageorb1", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(58393584) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("gui", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(37673876) 
			g.Parent = player.Character
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("admg", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(37682962) 
			g.Parent = player.Character 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("assasin", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			g = game:GetService("InsertService"):LoadAsset(40848777) 
			g.Parent = game.Workspace 
			g:MoveTo(player.Character.Torso.Position) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("wierdo", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=6819846" 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("chowder", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=1783645" 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("striper", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=5795761" 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("bob", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=2342708" 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("telamon", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=261" 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("ducc", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=7303693" 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("sweed", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=6472560" 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("girly", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=362994" 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("masashi", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=3216894" 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("madly", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=6160286" 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("ana", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=9201" 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("police", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=5599663" 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("gear", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=49566" 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("builderman", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=156" 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("reaper", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=8599152" 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("guest", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=1" 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("stickmaster", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=80254" 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("matt", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=916" 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("nairod7", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=7225903" 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("icookienl", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=3166696" 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("sonicthehegdehog", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=1134994" 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("garrettjay", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=91645" 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("plantize", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=5518138" 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("boy", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=8057367" 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("faded", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=6319456" 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("noobify", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=9676343" 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("darkking", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=2975932" 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("guitar", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=1979584" 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("unknow", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=6401251" 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("nazgul", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=1131345" 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("teddy", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=13411824" 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("isaac", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=1537069" 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("comboknex", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=5942550" 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("captinrex", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=8150321" 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("ganon", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=3357193" 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("itacho", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=3368626" 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("splosh", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=10308036" 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("xero", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=741234" 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("allietalbott", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=934107" 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("icefighterr", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=6049960" 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("poisonnoob", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=8558980" 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("slime8765", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=3803146" 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("illblade", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=6484494"
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("nick", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=3445997" 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("tomcrusie", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=5025023" 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("roquito", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId=9521811"
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("suit", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/asset/?id=27911184" 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("knight", 5, function(msg, MessageSplit, Speaker, Self)
	for word in msg:gmatch("%w+") do 
		local player = matchPlayer(word) 
		if (player ~= nil) then 
			player.Character:BreakJoints() 
			player.CharacterAppearance = "http://www.roblox.com/asset/?id=30364498"
		end 
	end 
end, "None", "None", "None")

-- Person299 commands

CoolCMDs.Functions.CreateCommand("local", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(msg:sub(7, slash-1),speaker)
	color = msg:sub(slash+1)
	color = color:upper(color:sub(1,1)) .. color:sub(2)
	if player ~= 0 and color then
		for i = 1,#player do
			if player[i].Character then
				thecolor = BrickColor.new(color)
				if thecolor ~= nil then
					if player[i].Character.Shirt ~= nil then
						player[i].Character.Shirt:remove()
					end
					if player[i].Character.Pants then
						player[i].Character.Pants:remove()
					end
					c = player[i].Character:GetChildren()
					for i2 = 1,#c do
						if c[i2]:IsA("Part") then
							c[i2].BrickColor = thecolor
						end 
					end 
				end 
			end 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("em", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(msg:sub(4),speaker)
	if player ~= 0 then
		for i = 1,#player do
			local insert = game:GetService("InsertService"):LoadAsset(50307223)
			insert.BlackHole.Parent = player[i].Character.Torso
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("up", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(msg:sub(4),speaker)
	if player ~= 0 then
		for i = 1,#player do
			b = Instance.new("BodyForce") 
			b.Parent = player[i].Character.Head 
			b.force = Vector3.new(0,1000000,0) 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("fling", 5, function(msg, MessageSplit, speaker, Self)
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

CoolCMDs.Functions.CreateCommand("raggun", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(msg:sub(8),speaker)
	if player ~= 0 then
		for i = 1,#player do
			local insert = game:GetService("InsertService"):LoadAsset(43335034)
			insert:MakeJoints()
			insert["Ragdoll Gun"].Parent = player[i].Backpack
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("broom", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(msg:sub(7),speaker)
	if player ~= 0 then
		for i = 1,#player do
			local insert = game:GetService("InsertService"):LoadAsset(41690430)
			insert:MakeJoints()
			insert["Broomstick"].Parent = player[i].Backpack
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("wand", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(msg:sub(6),speaker)
	if player ~= 0 then
		for i = 1,#player do
			local insert = game:GetService("InsertService"):LoadAsset(58688577)
			insert:MakeJoints()
			insert["Wand"].Parent = player[i].Backpack
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("tele", 5, function(msg, MessageSplit, speaker, Self)
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

CoolCMDs.Functions.CreateCommand("sc", 5, function(msg, MessageSplit, speaker, Self)
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

CoolCMDs.Functions.CreateCommand("phone", 5, function(msg, MessageSplit, speaker, Self)
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

CoolCMDs.Functions.CreateCommand("extool", 5, function(msg, MessageSplit, speaker, Self)
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

CoolCMDs.Functions.CreateCommand("gw", 5, function(msg, MessageSplit, speaker, Self)
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

CoolCMDs.Functions.CreateCommand("kot", 5, function(msg, MessageSplit, speaker, Self)
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

CoolCMDs.Functions.CreateCommand("smi", 5, function(msg, MessageSplit, speaker, Self)
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

CoolCMDs.Functions.CreateCommand("del1", 5, function(msg, MessageSplit, speaker, Self)
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

CoolCMDs.Functions.CreateCommand("orb", 5, function(msg, MessageSplit, speaker, Self)
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

CoolCMDs.Functions.CreateCommand("pushtool", 5, function(msg, MessageSplit, speaker, Self)
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

CoolCMDs.Functions.CreateCommand("ckatana", 5, function(msg, MessageSplit, speaker, Self)
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

CoolCMDs.Functions.CreateCommand("bkatana", 5, function(msg, MessageSplit, speaker, Self)
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

CoolCMDs.Functions.CreateCommand("bucket", 5, function(msg, MessageSplit, speaker, Self)
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

CoolCMDs.Functions.CreateCommand("nakedgun", 5, function(msg, MessageSplit, speaker, Self)
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

CoolCMDs.Functions.CreateCommand("jailtool", 5, function(msg, MessageSplit, speaker, Self)
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

CoolCMDs.Functions.CreateCommand("teletool", 5, function(msg, MessageSplit, speaker, Self)
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

CoolCMDs.Functions.CreateCommand("combatarm", 5, function(msg, MessageSplit, speaker, Self)
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

CoolCMDs.Functions.CreateCommand("eye", 5, function(msg, MessageSplit, speaker, Self)
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

CoolCMDs.Functions.CreateCommand("cig", 5, function(msg, MessageSplit, speaker, Self)
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

CoolCMDs.Functions.CreateCommand("poke", 5, function(msg, MessageSplit, speaker, Self)
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

CoolCMDs.Functions.CreateCommand("reapp", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(string.sub(msg,7),speaker)
	if player ~= 0 then
		for i = 1,#player do
			player[i].CharacterAppearance = "http://www.roblox.com/Asset/CharacterFetch.ashx?userId="..player[i].userId
			player[i].Character.Humanoid.Health = 0
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("godpowers", 5, function(msg, MessageSplit, speaker, Self)
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

CoolCMDs.Functions.CreateCommand("jet", 5, function(msg, MessageSplit, speaker, Self)
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

CoolCMDs.Functions.CreateCommand("del", 5, function(msg, MessageSplit, speaker, Self)
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

CoolCMDs.Functions.CreateCommand("telekin", 5, function(msg, MessageSplit, speaker, Self)
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

CoolCMDs.Functions.CreateCommand("freezeray", 5, function(msg, MessageSplit, speaker, Self)
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

CoolCMDs.Functions.CreateCommand("flyda", 5, function(msg, MessageSplit, speaker, Self)
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

CoolCMDs.Functions.CreateCommand("flytool", 5, function(msg, MessageSplit, speaker, Self)
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

CoolCMDs.Functions.CreateCommand("gravgun", 5, function(msg, MessageSplit, speaker, Self)
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

CoolCMDs.Functions.CreateCommand("path", 5, function(msg, MessageSplit, speaker, Self)
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

CoolCMDs.Functions.CreateCommand("assassin", 5, function(msg, MessageSplit, speaker, Self)
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

CoolCMDs.Functions.CreateCommand("bkatana", 5, function(msg, MessageSplit, speaker, Self)
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

CoolCMDs.Functions.CreateCommand("playerorb", 5, function(msg, MessageSplit, speaker, Self)
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

CoolCMDs.Functions.CreateCommand("clean", 5, function(msg, MessageSplit, speaker, Self)
	local imgettingtiredofmakingthisstupidscript = PERSON299(speaker.Name)
	if imgettingtiredofmakingthisstupidscript == true then
		local g = game:GetService("InsertService"):LoadAsset(57735410) 
		g.Parent = game.Workspace
	end
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("duckz", 5, function(msg, MessageSplit, speaker, Self)
	local imgettingtiredofmakingthisstupidscript = PERSON299(speaker.Name)
	if imgettingtiredofmakingthisstupidscript == true then
		local g = game:GetService("InsertService"):LoadAsset(56831153) 
		g.Parent = game.Workspace
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("let it snow", 5, function(msg, MessageSplit, speaker, Self)
	local imgettingtiredofmakingthisstupidscript = PERSON299(speaker.Name)
	if imgettingtiredofmakingthisstupidscript == true then
		local g = game:GetService("InsertService"):LoadAsset(58162707) 
		g.Parent = game.Workspace
		g.Name = ":3"
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("stop", 5, function(msg, MessageSplit, speaker, Self)
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

CoolCMDs.Functions.CreateCommand("takeover1", 5, function(msg, MessageSplit, speaker, Self)
	local imgettingtiredofmakingthisstupidscript = PERSON299(speaker.Name)
	if imgettingtiredofmakingthisstupidscript == true then
		local g = game:GetService("InsertService"):LoadAsset(56865027) 
		g.Parent = game.Workspace
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("antiplayerorb", 5, function(msg, MessageSplit, speaker, Self)
	local imgettingtiredofmakingthisstupidscript = PERSON299(speaker.Name)
	if imgettingtiredofmakingthisstupidscript == true then 
		local g = game:GetService("InsertService"):LoadAsset(58559824) 
		g.Parent = game.Workspace
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("antinoobs", 5, function(msg, MessageSplit, speaker, Self)
	local imgettingtiredofmakingthisstupidscript = PERSON299(speaker.Name)
	if imgettingtiredofmakingthisstupidscript == true then 
		local g = game:GetService("InsertService"):LoadAsset(56922240) 
		g.Parent = game.Workspace
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("takeover", 5, function(msg, MessageSplit, speaker, Self)
	local imgettingtiredofmakingthisstupidscript = PERSON299(speaker.Name)
	if imgettingtiredofmakingthisstupidscript == true then
		local g = game:GetService("InsertService"):LoadAsset(58479046) 
		g.Parent = game.Workspace
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("antimob", 5, function(msg, MessageSplit, speaker, Self)
	local imgettingtiredofmakingthisstupidscript = PERSON299(speaker.Name)
	if imgettingtiredofmakingthisstupidscript == true then
		local g = game:GetService("InsertService"):LoadAsset(58728910) 
		g.Parent = game.Workspace
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("recolor", 5, function(msg, MessageSplit, speaker, Self)
	game.Lighting.Ambient = Color3.new(170,170,170)
	game.Lighting.TimeOfDay = 14
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("noinsert", 5, function(msg, MessageSplit, speaker, Self)
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

CoolCMDs.Functions.CreateCommand("platformstand", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(msg:sub(15),speaker)
	if player ~= 0 then
		for i = 1,#player do
			if player[i].Character then
				player[i].Character.Humanoid.PlatformStand = true
			end 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("unplatformstand", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(msg:sub(17),speaker)
	if player ~= 0 then
		for i = 1,#player do
			if player[i].Character then
				player[i].Character.Humanoid.PlatformStand = false
			end 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("cframe1", 5, function(msg, MessageSplit, speaker, Self)
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

CoolCMDs.Functions.CreateCommand("cframe2", 5, function(msg, MessageSplit, speaker, Self)
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

CoolCMDs.Functions.CreateCommand("skateboard", 5, function(msg, MessageSplit, speaker, Self)
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

CoolCMDs.Functions.CreateCommand("wedge", 5, function(msg, MessageSplit, speaker, Self)
	local danumber1 = nil
	local danumber2 = nil
	for i = 7,100 do
		if string.sub(msg,i,i) == ""..key then
			danumber1 = i
			break
		elseif string.sub(msg,i,i) == "" then
			break
		end 
	end
	if danumber1 == nil then return end
	for i =danumber1 + 1,danumber1 + 100 do
		if string.sub(msg,i,i) == ""..key then
			danumber2 = i
			break
		elseif string.sub(msg,i,i) == "" then
			break
		end 
	end
	if danumber2 == nil then return end
	if speaker.Character ~= nil then
		local head = speaker.Character:FindFirstChild("Head")
		if head ~= nil then
			local part = Instance.new("WedgePart")
			part.Size = Vector3.new(string.sub(msg,7,danumber1 - 1),string.sub(msg,danumber1 + 1,danumber2 - 1),string.sub(msg,danumber2 + 1))
			part.Position = head.Position + Vector3.new(0,part.Size.y / 2 + 5,0)
			part.Name = "WedgePart"
			part.Parent = game.Workspace
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("cylinder", 5, function(msg, MessageSplit, speaker, Self)
	local danumber1 = nil
	local danumber2 = nil
	for i = 10,100 do
		if string.sub(msg,i,i) == ""..key then
			danumber1 = i
			break
		elseif string.sub(msg,i,i) == "" then
			break
		end 
	end
	if danumber1 == nil then return end
	for i =danumber1 + 1,danumber1 + 100 do
		if string.sub(msg,i,i) == ""..key then
			danumber2 = i
			break
		elseif string.sub(msg,i,i) == "" then
			break
		end 
	end
	if danumber2 == nil then return end
	if speaker.Character ~= nil then
		local head = speaker.Character:FindFirstChild("Head")
		if head ~= nil then
			local part = Instance.new("Part")
			part.Size = Vector3.new(string.sub(msg,10,danumber1 - 1),string.sub(msg,danumber1 + 1,danumber2 - 1),string.sub(msg,danumber2 + 1))
			part.Position = head.Position + Vector3.new(0,part.Size.y / 2 + 5,0)
			part.Name = "Cylinder"
			local cyl = Instance.new("CylinderMesh",part)
			part.Parent = game.Workspace
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("block", 5, function(msg, MessageSplit, speaker, Self)
	local danumber1 = nil
	local danumber2 = nil
	for i = 7,100 do
		if string.sub(msg,i,i) == ""..key then
			danumber1 = i
			break
		elseif string.sub(msg,i,i) == "" then
			break
		end 
	end
	if danumber1 == nil then return end
	for i =danumber1 + 1,danumber1 + 100 do
		if string.sub(msg,i,i) == ""..key then
			danumber2 = i
			break
		elseif string.sub(msg,i,i) == "" then
			break
		end 
	end
	if danumber2 == nil then return end
	if speaker.Character ~= nil then
		local head = speaker.Character:FindFirstChild("Head")
		if head ~= nil then
			local part = Instance.new("Part")
			part.Size = Vector3.new(string.sub(msg,7,danumber1 - 1),string.sub(msg,danumber1 + 1,danumber2 - 1),string.sub(msg,danumber2 + 1))
			part.Position = head.Position + Vector3.new(0,part.Size.y / 2 + 5,0)
			part.Name = "Block"
			local block = Instance.new("BlockMesh",part)
			part.Parent = game.Workspace
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("plate", 5, function(msg, MessageSplit, speaker, Self)
	local danumber1 = nil
	local danumber2 = nil
	for i = 7,100 do
		if string.sub(msg,i,i) == ""..key then
			danumber1 = i
			break
		elseif string.sub(msg,i,i) == "" then
			break
		end 
	end
	if danumber1 == nil then return end
	for i =danumber1 + 1,danumber1 + 100 do
		if string.sub(msg,i,i) == ""..key then
			danumber2 = i
			break
		elseif string.sub(msg,i,i) == "" then
			break
		end 
	end
	if danumber2 == nil then return end
	if speaker.Character ~= nil then
		local head = speaker.Character:FindFirstChild("Head")
		if head ~= nil then
			local part = Instance.new("Part")
			part.Size = Vector3.new(string.sub(msg,7,danumber1 - 1),string.sub(msg,danumber1 + 1,danumber2 - 1),string.sub(msg,danumber2 + 1))
			part.Position = head.Position + Vector3.new(0,part.Size.y / 2 + 5,0)
			part.Name = "Plate"
			part.formFactor = "Plate"
			part.Parent = game.Workspace
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("sphere", 5, function(msg, MessageSplit, speaker, Self)
	local danumber1 = nil
	local danumber2 = nil
	for i = 8,100 do
		if string.sub(msg,i,i) == ""..key then
			danumber1 = i
			break
		elseif string.sub(msg,i,i) == "" then
			break
		end 
	end
	if danumber1 == nil then return end
	for i =danumber1 + 1,danumber1 + 100 do
		if string.sub(msg,i,i) == ""..key then
			danumber2 = i
			break
		elseif string.sub(msg,i,i) == "" then
			break
		end 
	end
	if danumber2 == nil then return end
	if speaker.Character ~= nil then
		local head = speaker.Character:FindFirstChild("Head")
		if head ~= nil then
			local part = Instance.new("Part")
			part.Size = Vector3.new(string.sub(msg,8,danumber1 - 1),string.sub(msg,danumber1 + 1,danumber2 - 1),string.sub(msg,danumber2 + 1))
			part.Position = head.Position + Vector3.new(0,part.Size.y / 2 + 5,0)
			part.Name = "Sphere"
			part.Shape = "Ball"
			part.formFactor = 1
			part.Parent = game.Workspace
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("burn", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(msg:sub(6),speaker)
	if player ~= 0 then
		for i = 1,#player do
			createscript([[
				if script.Parent.Parent then
					fire = Instance.new("Fire")
					fire.Parent = script.Parent
					fire.Name = "Burn"
					fire.Color = BrickColor.Random().Color
					while fire do
						script.Parent.Parent.Humanoid:TakeDamage(1)
						wait(.1)
					end
				end]], player[i].Character.Torso)
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("watch", 5, function(msg, MessageSplit, speaker, Self)
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

CoolCMDs.Functions.CreateCommand("retools", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(msg:sub(9),speaker)
	if player ~= 0 then
		for i = 1,#player do
			if player[i].StarterGear then 
				local gear = player[i].StarterGear:GetChildren()
				if #gear > 0 then 
					for Num,Gear in pairs(gear) do
						Gear:remove()
					end 
				end 
			end 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("savet", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(msg:sub(7),speaker)
	if player ~= 0 then
		for i = 1,#player do
			if player[i].StarterGear and player[i].Backpack then
				if #player[i].Backpack:GetChildren() > 0 then
					for num,tool in pairs(player[i].Backpack:GetChildren()) do
						tool:clone().Parent = player[i].StarterGear
					end 
				end 
			end 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("getgear", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(msg:sub(9),speaker)
	if player ~= 0 then
		for i = 1,#player do
			if player[i].StarterGear and speaker.Backpack then
				for i,v in pairs(player[i].StarterGear:GetChildren()) do
					v:clone().Parent = speaker.Backpack
				end 
			end 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("team", 5, function(msg, MessageSplit, speaker, Self)
	local slash = msg:sub(6):find(""..key)+5
	if slash then 
		local team = upmsg:sub(6,slash-1)
		if team then
			local color = upmsg:sub(slash+1)
			local bcolor = BrickColor.new(color)
			if bcolor == BrickColor.new("Medium stone grey") and color:lower() ~= "medium stone grey" then return end 
			Team = Instance.new("Team",game:GetService("Teams"))
			Team.Name = team
			Team.TeamColor = bcolor
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("changeteam", 5, function(msg, MessageSplit, speaker, Self)
	local slash = msg:sub(12):find(""..key)+11
	if slash then 
		local player = findplayer(msg:sub(12,slash-1),speaker)
		if player ~= 0 then
			local team = findteam(msg:sub(slash+1),speaker)
			if team then
				for i = 1,#player do
					player[i].Neutral = false
					player[i].TeamColor = team.TeamColor
				end 
			end 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("setupteams", 5, function(msg, MessageSplit, speaker, Self)
	local Teams = game:GetService("Teams")
	TeamChild = Teams:GetChildren()
	if #TeamChild > 0 then
		for i,v in pairs(TeamChild) do
			v:remove()
		end
	end
	local Unassinged = Instance.new("Team",Teams)
	Unassigned.TeamColor = BrickColor.new("Really black")
	Unassigned.Name = "Unassigned"
	for i,v in pairs(game.Players:GetPlayers()) do
		v.Neutral = false
		v.TeamColor = BrickColor.new("Really black")
	end
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("reteam", 5, function(msg, MessageSplit, speaker, Self)
	local Teams = game:GetService("Teams")
	assignTeam = {}
	local team = findteam(msg:sub(8),speaker)
	if team then
		for i,v in pairs(game.Players:GetPlayers()) do
			if v.TeamColor == team.TeamColor then
				table.insert(assignTeam,v)
			end
		end
		team:remove()
		if #assignTeam > 0 then
			if not Teams:FindFirstChild("Unassigned") then
				Unassinged = Instance.new("Team",Teams)
				Unassigned.TeamColor = BrickColor.new("Really black")
				Unassigned.Name = "Unassigned"
			else Unassigned = Teams.Unassigned end
			for i,v in pairs(assignTeam) do
				v.TeamColor = Unassigned.TeamColor
			end 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("change", 5, function(msg, MessageSplit, speaker, Self)
	local danumber1 = nil
	local danumber2 = nil
	for i = 8,100 do
		if string.sub(msg,i,i) == ""..key then
			danumber1 = i
			break
		elseif string.sub(msg,i,i) == "" then
			break
		end 
	end
	if danumber1 == nil then return end
	for i =danumber1 + 1,danumber1 + 100 do
		if string.sub(msg,i,i) == ""..key then
			danumber2 = i
			break
		elseif string.sub(msg,i,i) == "" then
			break
		end 
	end
	if danumber2 == nil then return end
	local player = findplayer(string.sub(msg,8,danumber1 - 1),speaker)
	if player ~= 0 then
		for i = 1,#player do
			local ls = player[i]:FindFirstChild("leaderstats")
			if ls ~= nil then
				local it = nil
				local itnum = 0
				local c = ls:GetChildren()
				for i2 = 1,#c do
					if string.find(string.lower(c[i2].Name),string.sub(string.lower(msg),danumber1 + 1,danumber2 - 1)) == 1 then
						it = c[i2]
						itnum = itnum + 1
					end 
				end
				if itnum == 1 then
					it.Value = string.sub(msg,danumber2 + 1)
				end 
			end 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("ungod", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(string.sub(msg,7),speaker)
	if player ~= 0 then
		for i = 1,#player do
			if player[i].Character ~= nil then
				local isgod = false
				local c = player[i].Character:GetChildren()
				for i=1,#c do
					if c[i].className == "Script" then
						if c[i]:FindFirstChild("Context") then
							if string.sub(c[i].Context.Value,1,41) == "script.Parent.Humanoid.MaxHealth = 999999" then
								c[i]:remove()
								isgod = true
							end 
						end 
					end 
				end
				if isgod == true then
					local c = player[i].Character:GetChildren()
					for i=1,#c do
						if c[i].className == "Part" then
							c[i].Reflectance = 0
						end
						if c[i].className == "Humanoid" then
							c[i].MaxHealth = 100
							c[i].Health = 100
						end 
						if c[i].Name == "God FF" then
							c[i]:remove()
						end 
					end 
				end 
			end 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("god", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(string.sub(msg,5),speaker)
	if player ~= 0 then
		for i = 1,#player do
			if player[i].Character ~= nil then
				if player[i].Character:FindFirstChild("God FF") == nil then
					createscript([[script.Parent.Humanoid.MaxHealth = 999999
						script.Parent.Humanoid.Health = 999999
						ff = Instance.new("ForceField")
						ff.Name = "God FF"
						ff.Parent = script.Parent
						function ot(hit)
							if hit.Parent ~= script.Parent then
								h = hit.Parent:FindFirstChild("Humanoid")
								if h ~= nil then
									h.Health = 0
								end
								h = hit.Parent:FindFirstChild("Zombie")
								if h ~= nil then
									h.Health = 0
								end end end
								c = script.Parent:GetChildren()
								for i=1,#c do
									if c[i].className == "Part" then
										c[i].Touched:connect(ot)
										c[i].Reflectance = 1
									end end]],player[i].Character)
				end 
			end 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("sparkles", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(string.sub(msg,10),speaker)
	if player ~= 0 then
		for i = 1,#player do
			if player[i].Character ~= nil then
				local torso = player[i].Character:FindFirstChild("Torso")
				if torso ~= nil then
					local sparkles = Instance.new("Sparkles")
					sparkles.Color = Color3.new(math.random(),math.random(),math.random())
					sparkles.Parent = torso
				end 
			end 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("unsparkles", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(string.sub(msg,12),speaker)
	if player ~= 0 then
		for i = 1,#player do
			if player[i].Character ~= nil then
				local torso = player[i].Character:FindFirstChild("Torso")
				if torso ~= nil then
					local c = torso:GetChildren()
					for i2 = 1,#c do
						if c[i2].className == "Sparkles" then
							c[i2]:remove()
						end 
					end 
				end 
			end 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("heal", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(string.sub(msg,6),speaker)
	if player ~= 0 then
		for i = 1,#player do
			if player[i].Character ~= nil then
				local human = player[i].Character:FindFirstChild("Humanoid")
				if human ~= nil then
					human.Health = human.MaxHealth
				end 
			end 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("sit", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(string.sub(msg,5),speaker)
	if player ~= 0 then
		for i = 1,#player do
			if player[i].Character ~= nil then
				local human = player[i].Character:FindFirstChild("Humanoid")
				if human ~= nil then
					human.Sit = true
				end 
			end 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("jump", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(string.sub(msg,6),speaker)
	if player ~= 0 then
		for i = 1,#player do
			if player[i].Character ~= nil then
				local human = player[i].Character:FindFirstChild("Humanoid")
				if human ~= nil then
					human.Jump = true
				end 
			end 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("stand", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(string.sub(msg,7),speaker)
	if player ~= 0 then
		for i = 1,#player do
			if player[i].Character ~= nil then
				local human = player[i].Character:FindFirstChild("Humanoid")
				if human ~= nil then
					human.Sit = false
				end 
			end 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("jail", 5, function(msg, MessageSplit, speaker, Self)
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

CoolCMDs.Functions.CreateCommand("unjail", 5, function(msg, MessageSplit, speaker, Self)
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

CoolCMDs.Functions.CreateCommand("givebtools", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(string.sub(msg,12),speaker)
	if player ~= 0 then
		for i = 1,#player do
			local a = Instance.new("HopperBin")
			a.BinType = "GameTool"
			a.Parent = player[i].Backpack
			local a = Instance.new("HopperBin")
			a.BinType = "Clone"
			a.Parent = player[i].Backpack
			local a = Instance.new("HopperBin")
			a.BinType = "Hammer"
			a.Parent = player[i].Backpack
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("unshield", 5, function(msg, MessageSplit, speaker, Self)
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

CoolCMDs.Functions.CreateCommand("shield", 5, function(msg, MessageSplit, speaker, Self)
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

CoolCMDs.Functions.CreateCommand("time", 5, function(msg, MessageSplit, speaker, Self)
	game.Lighting.TimeOfDay = string.sub(msg,6)
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("maxplayers", 5, function(msg, MessageSplit, speaker, Self)
	local pie = game.Players.MaxPlayers
	game.Players.MaxPlayers = string.sub(msg,12)
	if game.Players.MaxPlayers == 0 then
		game.Players.MaxPlayers = pie
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("zombify", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(string.sub(msg,9),speaker)
	if player ~= 0 then
		for i = 1,#player do
			if player[i].Character ~= nil then
				local torso = player[i].Character:FindFirstChild("Torso")
				if torso ~= nil then
					local arm = player[i].Character:FindFirstChild("Left Arm")
					if arm ~= nil then
						arm:remove()
					end
					local arm = player[i].Character:FindFirstChild("Right Arm")
					if arm ~= nil then
						arm:remove()
					end
					local rot=CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0)
					local zarm = Instance.new("Part")
					zarm.Color = Color3.new(0.631373, 0.768627, 0.545098)
					zarm.Locked = true
					zarm.formFactor = "Symmetric"
					zarm.Size = Vector3.new(2,1,1)
					zarm.TopSurface = "Smooth"
					zarm.BottomSurface = "Smooth"
					createscript( [[
						wait(1)
						function onTouched(part)
							if part.Parent ~= nil then
								local h = part.Parent:findFirstChild("Humanoid")
								if h~=nil then
									if cantouch~=0 then
										if h.Parent~=script.Parent.Parent then
											if h.Parent:findFirstChild("zarm")~=nil then return end
											cantouch=0
											local larm=h.Parent:findFirstChild("Left Arm")
											local rarm=h.Parent:findFirstChild("Right Arm")
											if larm~=nil then
												larm:remove()
											end
											if rarm~=nil then
												rarm:remove()
											end
											local zee=script.Parent.Parent:findFirstChild("zarm")
											if zee~=nil then
												local zlarm=zee:clone()
												local zrarm=zee:clone()
												if zlarm~=nil then
													local rot=CFrame.new(0, 0, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0)
													zlarm.CFrame=h.Parent.Torso.CFrame * CFrame.new(Vector3.new(-1.5,0.5,-0.5)) * rot
													zrarm.CFrame=h.Parent.Torso.CFrame * CFrame.new(Vector3.new(1.5,0.5,-0.5)) * rot
													zlarm.Parent=h.Parent
													zrarm.Parent=h.Parent
													zlarm:makeJoints()
													zrarm:makeJoints()
													zlarm.Anchored=false
													zrarm.Anchored=false
													wait(0.1)
													h.Parent.Head.Color=zee.Color
												else return end
											end
											wait(1)
											cantouch=1
										end
									end
								end
							end
						end
						script.Parent.Touched:connect(onTouched)
						]],zarm)
zarm.Name = "zarm"
local zarm2 = zarm:clone()
zarm2.CFrame = torso.CFrame * CFrame.new(Vector3.new(-1.5,0.5,-0.5)) * rot
zarm.CFrame = torso.CFrame * CFrame.new(Vector3.new(1.5,0.5,-0.5)) * rot
zarm.Parent = player[i].Character
zarm:MakeJoints()
zarm2.Parent = player[i].Character
zarm2:MakeJoints()
local head = player[i].Character:FindFirstChild("Head")
if head ~= nil then
	head.Color = Color3.new(0.631373, 0.768627, 0.545098)
end 
end 
end 
end 
end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("explode", 5, function(msg, MessageSplit, speaker, Self)
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

CoolCMDs.Functions.CreateCommand("rocket", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(string.sub(msg,8),speaker)
	if player ~= 0 then
		for i = 1,#player do
			if player[i].Character ~= nil then
				local torso = player[i].Character:FindFirstChild("Torso")
				if torso ~= nil then
					local r = Instance.new("Part")
					r.Name = "Rocket"
					r.Size = Vector3.new(1,8,1)
					r.TopSurface = "Smooth"
					r.BottomSurface = "Smooth"
					local w = Instance.new("Weld")
					w.Part1 = torso
					w.Part0 = r
					w.C0 = CFrame.new(0,0,-1)
					local bt = Instance.new("BodyThrust")
					bt.force = Vector3.new(0,5700,0)
					bt.Parent = r
					r.Parent = player[i].Character
					w.Parent = torso
					createscript([[
						for i=1,120 do
							local ex = Instance.new("Explosion")
							ex.BlastRadius = 0
							ex.Position = script.Parent.Position - Vector3.new(0,2,0)
							ex.Parent = game.Workspace
							wait(0.05)
						end 
						local ex = Instance.new("Explosion")
						ex.BlastRadius = 10
						ex.Position = script.Parent.Position
						ex.Parent = game.Workspace
						script.Parent.BodyThrust:remove()
						script.Parent.Parent.Humanoid.Health = 0
						]],r)
				end 
			end 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("ambient", 5, function(msg, MessageSplit, speaker, Self)
	local danumber1 = nil
	local danumber2 = nil
	for i = 9,100 do
		if string.sub(msg,i,i) == ""..key then
			danumber1 = i
			break
		elseif string.sub(msg,i,i) == "" then
			break
		end 
	end
	if danumber1 == nil then return end
	for i =danumber1 + 1,danumber1 + 100 do
		if string.sub(msg,i,i) == ""..key then
			danumber2 = i
			break
		elseif string.sub(msg,i,i) == "" then
			break
		end 
	end
	if danumber2 == nil then return end
	game.Lighting.Ambient = Color3.new(-string.sub(msg,9,danumber1 - 1),-string.sub(msg,danumber1 + 1,danumber2 - 1),-string.sub(msg,danumber2 + 1))
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("part", 5, function(msg, MessageSplit, speaker, Self)
	local danumber1 = nil
	local danumber2 = nil
	for i = 6,100 do
		if string.sub(msg,i,i) == ""..key then
			danumber1 = i
			break
		elseif string.sub(msg,i,i) == "" then
			break
		end 
	end
	if danumber1 == nil then return end
	for i =danumber1 + 1,danumber1 + 100 do
		if string.sub(msg,i,i) == ""..key then
			danumber2 = i
			break
		elseif string.sub(msg,i,i) == "" then
			break
		end 
	end
	if danumber2 == nil then return end
	if speaker.Character ~= nil then
		local head = speaker.Character:FindFirstChild("Head")
		if head ~= nil then
			local part = Instance.new("Part")
			part.Size = Vector3.new(string.sub(msg,6,danumber1 - 1),string.sub(msg,danumber1 + 1,danumber2 - 1),string.sub(msg,danumber2 + 1))
			part.Position = head.Position + Vector3.new(0,part.Size.y / 2 + 5,0)
			part.Name = "Part"
			part.Parent = game.Workspace
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("control", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(string.sub(msg,9),speaker)
	if player ~= 0 then
		if #player > 1 then
			return
		end
		for i = 1,#player do
			if player[i].Character ~= nil then
				speaker.Character = player[i].Character
			end 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("trip", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(string.sub(msg,6),speaker)
	if player ~= 0 then
		for i = 1,#player do
			if player[i].Character ~= nil then
				local torso = player[i].Character:FindFirstChild("Torso")
				if torso ~= nil then
torso.CFrame = CFrame.new(torso.Position.x,torso.Position.y,torso.Position.z,0, 0, 1, 0, -1, 0, 1, 0, 0)--math.random(),math.random(),math.random(),math.random(),math.random(),math.random(),math.random(),math.random(),math.random()) -- i like the people being upside down better.
end 
end 
end 
end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("setgrav", 5, function(msg, MessageSplit, speaker, Self)
	danumber = nil
	for i =9,100 do
		if string.sub(msg,i,i) == ""..key then
			danumber = i
			break
		end 
	end
	if danumber == nil then
		return
	end
	local player = findplayer(string.sub(msg,9,danumber - 1),speaker)
	if player == 0 then
		return
	end
	for i = 1,#player do
		if player[i].Character ~= nil then
			local torso = player[i].Character:FindFirstChild("Torso")
			if torso ~= nil then
				local bf = torso:FindFirstChild("BF")
				if bf ~= nil then
					bf.force = Vector3.new(0,0,0)
				else
					local bf = Instance.new("BodyForce")
					bf.Name = "BF"
					bf.force = Vector3.new(0,0,0)
					bf.Parent = torso
				end
				local c2 = player[i].Character:GetChildren()
				for i=1,#c2 do
					if c2[i].className == "Part" then
						torso.BF.force = torso.BF.force + Vector3.new(0,c2[i]:getMass() * -string.sub(msg,danumber + 1),0)
					end 
				end 
			end 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("walkspeed", 5, function(msg, MessageSplit, speaker, Self)
	danumber = nil
	for i =11,100 do
		if string.sub(msg,i,i) == ""..key then
			danumber = i
			break
		end 
	end
	if danumber == nil then
		return
	end
	local player = findplayer(string.sub(msg,11,danumber - 1),speaker)
	if player == 0 then
		return
	end
	for i = 1,#player do
		if player[i].Character ~= nil then
			humanoid = player[i].Character:FindFirstChild("Humanoid")
			if humanoid ~= nil then
				humanoid.WalkSpeed = string.sub(msg,danumber + 1)
			end 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("damage", 5, function(msg, MessageSplit, speaker, Self)
	danumber = nil
	for i =8,100 do
		if string.sub(msg,i,i) == ""..key then
			danumber = i
			break
		end end
		if danumber == nil then
			return
		end
		local player = findplayer(string.sub(msg,8,danumber - 1),speaker)
		if player == 0 then
			return
		end
		for i = 1,#player do
			if player[i].Character ~= nil then
				humanoid = player[i].Character:FindFirstChild("Humanoid")
				if humanoid ~= nil then
					humanoid.Health = humanoid.Health -  string.sub(msg,danumber + 1)
				end 
			end 
		end 
	end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("health", 5, function(msg, MessageSplit, speaker, Self)
	danumber = nil
	for i =8,100 do
		if string.sub(msg,i,i) == ""..key then
			danumber = i
			break
		end end
		if danumber == nil then
			return
		end
		local player = findplayer(string.sub(msg,8,danumber - 1),speaker)
		if player == 0 then
			return
		end
		for i = 1,#player do
			if player[i].Character ~= nil then
				humanoid = player[i].Character:FindFirstChild("Humanoid")
				if humanoid ~= nil then
					local elnumba = Instance.new("IntValue") 
					elnumba.Value = string.sub(msg,danumber + 1)
					if elnumba.Value > 0 then
						humanoid.MaxHealth = elnumba.Value
						humanoid.Health = humanoid.MaxHealth
					end 
					elnumba:remove()
				end 
			end 
		end 
	end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("teleport", 5, function(msg, MessageSplit, speaker, Self)
	danumber = nil
	for i = 10,100 do
		if string.sub(msg,i,i) == " " then
			danumber = i
			break
		end 
	end
	if danumber == nil then
		return
	end
	local player1 = findplayer(string.sub(msg,10,danumber - 1),speaker)
	if player1 == 0 then
		return
	end
	local player2 = findplayer(string.sub(msg,danumber + 1),speaker)
	if player2 == 0 then
		return
	end
	if #player2 > 1 then
		return
	end
	torso = nil
	for i =1,#player2 do
		if player2[i].Character ~= nil then
			torso = player2[i].Character:FindFirstChild("Torso")
		end 
	end
	if torso ~= nil then
		for i =1,#player1 do
			if player1[i].Character ~= nil then
				local torso2 = player1[i].Character:FindFirstChild("Torso")
				if torso2 ~= nil then
					torso2.CFrame = torso.CFrame
				end 
			end 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("merge", 5, function(msg, MessageSplit, speaker, Self)
	danumber = nil
	for i =7,100 do
		if string.sub(msg,i,i) == ""..key then
			danumber = i
			break
		end end
		if danumber == nil then
			return
		end
		local player1 = findplayer(string.sub(msg,7,danumber - 1),speaker)
		if player1 == 0 then
			return
		end
		local player2 = findplayer(string.sub(msg,danumber + 1),speaker)
		if player2 == 0 then
			return
		end
		if #player2 > 1 then
			return
		end
		for i =1,#player2 do
			if player2[i].Character ~= nil then
				player2 = player2[i].Character
			end 
		end
		for i =1,#player1 do
			player1[i].Character = player2
		end 
	end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("clearscripts", 5, function(msg, MessageSplit, speaker, Self)
	local c = game.Workspace:GetChildren()
	for i =1,#c do
		if c[i].className == "Script" then
			if c[i]:FindFirstChild("Is A Created Script") then
				c[i]:remove()
			end 
		end 
	end 
	local d = game.Players:GetPlayers() 
	for i2 = 1,#d do
		for i,v in pairs(d[i2]:GetChildren()) do
			if v:isA("Script") and v:FindFirstChild("Is A Created Script") then
				v:remove()
			end 
		end 
	end
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("respawn", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(string.sub(msg,9),speaker)
	if player ~= 0 then
		for i = 1,#player do
			local ack2 = Instance.new("Model")
			ack2.Parent = game.Workspace
			local ack4 = Instance.new("Part")
			ack4.Transparency = 1
			ack4.CanCollide = false
			ack4.Anchored = true
			ack4.Name = "Torso"
			ack4.Position = Vector3.new(10000,10000,10000)
			ack4.Parent = ack2
			local ack3 = Instance.new("Humanoid")
			ack3.Torso = ack4
			ack3.Parent = ack2
			player[i].Character = ack2
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("invisible", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(string.sub(msg,11),speaker)
	if player ~= 0 then
		for i = 1,#player do
			if player[i].Character ~= nil then
				local char = player[i].Character
				local c = player[i].Character:GetChildren()
				for i =1,#c do
					if c[i].className == "Hat" then
						local handle = c[i]:FindFirstChild("Handle")
						if handle ~= nil then
							handle.Transparency = 1 
						end end
						if c[i].className == "Part" then
							c[i].Transparency = 1
							if c[i].Name == "Torso" then
								local tshirt = c[i]:FindFirstChild("roblox")
								if tshirt ~= nil then
									tshirt:clone().Parent = char
									tshirt:remove()
								end end
								if c[i].Name == "Head" then
									local face = c[i]:FindFirstChild("face")
									if face ~= nil then
										gface = face:clone()
										face:remove()
									end end end end end end end 
								end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("visible", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(string.sub(msg,9),speaker)
	if player ~= 0 then
		for i = 1,#player do
			if player[i].Character ~= nil then
				local char = player[i].Character
				local c = player[i].Character:GetChildren()
				for i =1,#c do
					if c[i].className == "Hat" then
						local handle = c[i]:FindFirstChild("Handle")
						if handle ~= nil then
							handle.Transparency = 0
						end 
					end
					if c[i].className == "Part" then
						c[i].Transparency = 0
						if c[i].Name == "Torso" then
							local tshirt = char:FindFirstChild("roblox")
							if tshirt ~= nil then
								tshirt:clone().Parent = c[i]
								tshirt:remove()
							end 
						end
						if c[i].Name == "Head" then
							if gface ~= nil then
								local face = gface:clone()
								face.Parent = c[i]
							end 
						end 
					end 
				end 
			end 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("freeze", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(string.sub(msg,8),speaker)
	if player ~= 0 then
		for i = 1,#player do
			if player[i].Character ~= nil then
				local humanoid = player[i].Character:FindFirstChild("Humanoid")
				if humanoid ~= nil then
					humanoid.WalkSpeed = 0
				end
				local c = player[i].Character:GetChildren()
				for i =1,#c do
					if c[i].className == "Part" then
						c[i].Anchored = true
					end end end end end 
				end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("thaw", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(string.sub(msg,6),speaker)
	if player ~= 0 then
		for i = 1,#player do
			if player[i].Character ~= nil then
				local humanoid = player[i].Character:FindFirstChild("Humanoid")
				if humanoid ~= nil then
					humanoid.WalkSpeed = 16
				end
				local c = player[i].Character:GetChildren()
				for i =1,#c do
					if c[i].className == "Part" then
						c[i].Anchored = false
						c[i].Reflectance = 0
					end end end end end 
				end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("nograv", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(string.sub(msg,8),speaker)
	if player ~= 0 then
		for i = 1,#player do
			if player[i].Character ~= nil then
				local torso = player[i].Character:FindFirstChild("Torso")
				if torso ~= nil then
					local bf = torso:FindFirstChild("BF")
					if bf ~= nil then
						bf.force = Vector3.new(0,0,0)
					else
						local bf = Instance.new("BodyForce")
						bf.Name = "BF"
						bf.force = Vector3.new(0,0,0)
						bf.Parent = torso
					end
					local c2 = player[i].Character:GetChildren()
					for i=1,#c2 do
						if c2[i].className == "Part" then
							torso.BF.force = torso.BF.force + Vector3.new(0,c2[i]:getMass() * 196.2,0)
						end end end end end end 
					end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("antigrav", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(string.sub(msg,10),speaker)
	if player ~= 0 then
		for i = 1,#player do
			if player[i].Character ~= nil then
				local torso = player[i].Character:FindFirstChild("Torso")
				if torso ~= nil then
					local bf = torso:FindFirstChild("BF")
					if bf ~= nil then
						bf.force = Vector3.new(0,0,0)
					else
						local bf = Instance.new("BodyForce")
						bf.Name = "BF"
						bf.force = Vector3.new(0,0,0)
						bf.Parent = torso
					end
					local c2 = player[i].Character:GetChildren()
					for i=1,#c2 do
						if c2[i].className == "Part" then
							torso.BF.force = torso.BF.force + Vector3.new(0,c2[i]:getMass() * 140,0)
						end end end end end end 
					end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("highgrav", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(string.sub(msg,10),speaker)
	if player ~= 0 then
		for i = 1,#player do
			if player[i].Character ~= nil then
				local torso = player[i].Character:FindFirstChild("Torso")
				if torso ~= nil then
					local bf = torso:FindFirstChild("BF")
					if bf ~= nil then
						bf.force = Vector3.new(0,0,0)
					else
						local bf = Instance.new("BodyForce")
						bf.Name = "BF"
						bf.force = Vector3.new(0,0,0)
						bf.Parent = torso
					end
					local c2 = player[i].Character:GetChildren()
					for i=1,#c2 do
						if c2[i].className == "Part" then
							torso.BF.force = torso.BF.force - Vector3.new(0,c2[i]:getMass() * 80,0)
						end end end end end end 
					end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("grav", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(string.sub(msg,6),speaker)
	if player ~= 0 then
		for i = 1,#player do
			if player[i].Character ~= nil then
				local torso = player[i].Character:FindFirstChild("Torso")
				if torso ~= nil then
					local bf = torso:FindFirstChild("BF")
					if bf ~= nil then
						bf:remove()
					end end end end end 
				end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("unlock", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(string.sub(msg,8),speaker)
	if player ~= 0 then
		for i = 1,#player do
			if player[i].Character ~= nil then
				local c = player[i].Character:GetChildren()
				for i =1,#c do
					if c[i].className == "Part" then
						c[i].Locked = false
					end end end end end 
				end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("lock", 5, function(msg, MessageSplit, speaker, Self)
	local player = findplayer(string.sub(msg,6),speaker)
	if player ~= 0 then
		for i = 1,#player do
			if player[i].Character ~= nil then
				local c = player[i].Character:GetChildren()
				for i =1,#c do
					if c[i].className == "Part" then
						c[i].Locked = true
					end 
				end 
			end 
		end 
	end 
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("time", 5, function(msg, MessageSplit, speaker, Self)
	if string.len(msg) >= 6 then
		game.Lighting.TimeOfDay = string.sub(msg,6)
	end
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("resetmp", 5, function(msg, MessageSplit, speaker, Self)
	game.Players.MaxPlayers = MaxPlayers
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("color", 5, function(msg, MessageSplit, speaker, Self)
	if string.len(msg) >= 7 then
		Add = nil
		for i=7,10000 do
			if string.sub(msg,i,i) == "/" then
				Add = i
				break
			elseif string.sub(msg,i,i) == "" then
				break
			end
		end
		if Add then
			Plr = findplr(string.sub(msg,7,Add-1),player)
			if Plr ~= 0 then
				for _,v in pairs(Plr) do
					for _,c in pairs(v.Character:GetChildren()) do
						if c.className == "Part" then
							c.BrickColor = BrickColor.new(string.sub(msg,Add+1))
						end
					end
				end
			end
		end
	end
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("rcolor", 5, function(msg, MessageSplit, speaker, Self)
	if string.len(msg) >= 8 then
		Plr = findplr(string.sub(msg,8),player)
		if Plr ~= 0 then
			for _,v in pairs(Plr) do
				for _,c in pairs(v.Character:GetChildren()) do
					if c.className == "Part" then
						c.BrickColor = BrickColor.random()
					end
				end
			end
		end
	end
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("launch", 5, function(msg, MessageSplit, speaker, Self)
	if string.len(msg) >= 8 then
		plr = findplr(string.sub(msg,8),player)
		if plr ~= 0 then
			for _,v in pairs(plr) do
				Rocket = Instance.new("Part")
				Rocket.Name = "BCGRocket"
				Rocket.Size = Vector3.new(1,8,1)
				Rocket.TopSurface = "Smooth"
				Rocket.BottomSurface = "Smooth"
				Weld = Instance.new("Weld")
				Weld.Part1 = v.Character.Torso
				Weld.Part0 = Rocket
				Weld.C0 = CFrame.new(0,0,-1)
				Body = Instance.new("BodyThrust")
				Body.force = Vector3.new(0,5700,0)
				Body.Parent = Rocket
				Rocket.Parent = v.Character
				Weld.Parent = v.Character.Torso
				scriptz([[
					for i=1,120 do
						local BOOM = Instance.new("Explosion")
						BOOM.BlastRadius = 0
						BOOM.Position = script.Parent.Position - Vector3.new(0,2,0)
						BOOM.Parent = game.Workspace
						wait(0.05)
					end 
					local BOOM2 = Instance.new("Explosion")
					BOOM2.BlastRadius = 10
					BOOM2.Position = script.Parent.Position
					BOOM2.Parent = game.Workspace
					script.Parent.BodyThrust:remove()
					script.Parent.Parent.Humanoid.Health = 0
					]],v,Rocket)
			end
		end
	end
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("flip", 5, function(msg, MessageSplit, speaker, Self)
	if string.len(msg) >= 6 then
		plr = findplr(string.sub(msg,6),player)
		if plr ~= 0 then
			for _,v in pairs(plr) do
				torso = v.Character.Torso
				torso.CFrame = CFrame.new(torso.Position.x,torso.Position.y,torso.Position.z,0, 0, 1, 0, -1, 0, 1, 0, 0)
			end
		end
	end
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("bighead", 5, function(msg, MessageSplit, speaker, Self)
	if string.len(msg) >= 9 then
		stop = findplr(string.sub(msg,9),player)
		if stop ~= 0 then
			for _,v in pairs(stop) do
				v.Character.Head.Mesh.Scale = Vector3.new(5,5,5)
			end
		end
	end
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("smallhead", 5, function(msg, MessageSplit, speaker, Self)
	if string.len(msg) >= 11 then
		stop = findplr(string.sub(msg,11),player)
		if stop ~= 0 then
			for _,v in pairs(stop) do
				v.Character.Head.Mesh.Scale = Vector3.new(0.625,0.625,0.625)
			end
		end
	end
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("normhead", 5, function(msg, MessageSplit, speaker, Self)
	if string.len(msg) >= 10 then
		stop = findplr(string.sub(msg,10),player)
		if stop ~= 0 then
			for _,v in pairs(stop) do
				v.Character.Head.Mesh.Scale = Vector3.new(1.25,1.25,1.25)
			end
		end
	end
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("sethead", 5, function(msg, MessageSplit, speaker, Self)
	if string.len(msg) >= 9 then
		Add = nil
		Num = nil
		for i=9,1000 do
			if string.sub(msg,i,i) == "/" then
				Add = i
				break
			elseif string.sub(msg,i,i) == "" then
				break
			end
		end
		if Add then
			stop = findplr(string.sub(msg,9,Add-1),player)
			if stop ~= 0 then
				Num = tonumber(string.sub(msg,Add+1))
				if Num then
					for _,v in pairs(stop) do
						v.Character.Head.Mesh.Scale = Vector3.new(Num,Num,Num)
					end
				end
			end
		end
	end
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("hide", 5, function(msg, MessageSplit, speaker, Self)
	if string.len(msg) >= 6 then
		stop = findplr(string.sub(msg,6))
		if stop ~= 0 then
			for _,v in pairs(stop) do
				A = v.Character.Head:clone()
				A.face:remove()
				B = Instance.new("Weld",v.Character.Head)
				B.Name = "BCGWeld"
				B.Part1 = v.Character.Head
				B.Part0 = A
				v.Character.Head.Transparency = 1
				A.Name = "PseudoHead"
				A.Parent = v.Character
			end
		end
	end
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("unhide", 5, function(msg, MessageSplit, speaker, Self)
	if string.len(msg) >= 8 then
		stop = findplr(string.sub(msg,8))
		if stop ~= 0 then
			for _,v in pairs(stop) do
				if v.Character:FindFirstChild("PseudoHead") then
					v.Character.PseudoHead:remove()
					v.Character.Head.Transparency = 0
				end
			end
		end
	end
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("unsmoke", 5, function(msg, MessageSplit, speaker, Self)
	if string.len(msg)>=9 then
		stop = findplr(string.sub(msg,9),player)
		if stop ~= 0 then
			for x=1,#stop do
				Spark = stop[x].Character.Torso:FindFirstChild("BCGSmoke")
				if Spark then
					Spark:remove()
				end
			end
		end
	end
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("smoke", 5, function(msg, MessageSplit, speaker, Self)
	if string.len(msg)>=7 then
		stop = findplr(string.sub(msg,7),player)
		if stop ~= 0 then
			for x=1,#stop do
				Spark = stop[x].Character.Torso:FindFirstChild("BCGSmoke")
				if not Spark then
					A=Instance.new("Smoke")
					A.Name = "BCGSmoke"
					A.Color = Color3.new((math.random(1,255))/255,(math.random(1,255))/255,(math.random(1,255))/255)
					A.Opacity = 0.5
					A.RiseVelocity = 5
					A.Parent = stop[x].Character.Torso
				end
			end
		end
	end
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("shadcol", 5, function(msg, MessageSplit, speaker, Self)
	if string.len(msg) >= 9 then
		I = nil
		C = nil
		for i=9,1000 do
			if string.sub(msg,i,i) == "/" then
				I = i
				break
			end
		end
		if I then
			for c=I+1,10000 do
				if string.sub(msg,c,c) == "/" then
					C = c
					break
				end
			end
			if C then
				game.Lighting.ShadowColor = Color3.new(tonumber(string.sub(msg,5,I-1)),tonumber(string.sub(msg,I+1,C-1)),tonumber(string.sub(msg,C+1)))
			end
		end
	end
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("b", 5, function(msg, MessageSplit, speaker, Self)
	if string.len(msg) >= 3 then
		I = nil
		for i=3,9999 do
			if string.sub(msg,i,i) == "/" then
				I = i
				break
			end
		end
		if I then
			stop = findplr(string.sub(msg,3,I-1),player)
			if stop ~= 0 then
				ID = tonumber(string.sub(msg,I+1))
				if ID then
					for _,v in pairs(stop) do
						game:GetService("BadgeService"):AwardBadge(v.userId,ID)
					end
				end
			end
		end
	end
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("amb", 5, function(msg, MessageSplit, speaker, Self)
	if string.len(msg) >= 5 then
		I = nil
		C = nil
		for i=5,1000 do
			if string.sub(msg,i,i) == "/" then
				I = i
				break
			end
		end
		if I then
			for c=I+1,10000 do
				if string.sub(msg,c,c) == "/" then
					C = c
					break
				end
			end
			if C then
				game.Lighting.Ambient = Color3.new(tonumber(string.sub(msg,5,I-1)),tonumber(string.sub(msg,I+1,C-1)),tonumber(string.sub(msg,C+1)))
			end
		end
	end
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("brightness", 5, function(msg, MessageSplit, speaker, Self)
	if string.len(msg) >= 12 then
		print(string.sub(msg,12))
		game.Lighting.Brightness = tonumber(string.sub(msg,12))
	end
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("gettool", 5, function(msg, MessageSplit, speaker, Self)
	if string.len(msg) >= 9 then
		Plr = nil
		Tool = nil
		for i=9,1000 do
			if string.sub(msg,i,i) == "/" then
				Plr = i
				break
			elseif string.sub(msg,i,i) == "" then
				break
			end
		end
		if Plr then
			stop = findplr(string.sub(msg,9,Plr-1),player)
			if stop ~= 0 then
				Toolz = findtool(string.sub(msg,Plr+1))
				if Toolz then
					for _,v in pairs(stop) do
						for _,c in pairs(Toolz) do
							c:clone().Parent = v.Backpack
						end
					end
				end
			end
		end
	end
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("give", 5, function(msg, MessageSplit, speaker, Self)
	if string.len(msg)>=6 then
		AAA = nil
		for sa=6,1000 do
			if string.sub(msg,sa,sa) == "/" then
				AAA = sa
				break
			elseif string.sub(msg,sa,sa) == "" then
				break
			end
		end
		stop = findplr(string.sub(msg,6,AAA-1),player)
		if stop ~= 0 then
			for _,f in pairs(stop) do
				ID = string.sub(msg,AAA+1)
				Insert = game:GetService("InsertService"):LoadAsset(ID)
				Child = Insert:GetChildren()
				Check = false
				for i=1,#Child do
					if (Child[i].className == "Hat" or Child[i].className == "CharacterMesh" or Child[i].className == "Shirt" or Child[i].className == "Pants") then
						Child[i].Parent = f.Character
					end
				end
				Insert:remove()
			end
		end
	end
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("ice", 5, function(msg, MessageSplit, speaker, Self)
	if string.len(msg)>=5 then
		stop = findplr(string.sub(msg,5),player)
		if stop ~= 0 then
			for x=1,#stop do
				Char = stop[x].Character:GetChildren()
				for i=1,#Char do
					if Char[i].className == "Part" then
						Char[i].Material = "Ice"
					end
				end
			end
		end
	end
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("grass", 5, function(msg, MessageSplit, speaker, Self)
	if string.len(msg)>=7 then
		stop = findplr(string.sub(msg,7),player)
		if stop ~= 0 then
			for x=1,#stop do
				Char = stop[x].Character:GetChildren()
				for i=1,#Char do
					if Char[i].className == "Part" then
						Char[i].Material = "Grass"
					end
				end
			end
		end
	end
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("foil", 5, function(msg, MessageSplit, speaker, Self)
	if string.len(msg)>=6 then
		stop = findplr(string.sub(msg,6),player)
		if stop ~= 0 then
			for x=1,#stop do
				Char = stop[x].Character:GetChildren()
				for i=1,#Char do
					if Char[i].className == "Part" then
						Char[i].Material = "Foil"
					end
				end
			end
		end
	end
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("corrmetal", 5, function(msg, MessageSplit, speaker, Self)
	if string.len(msg)>=11 then
		stop = findplr(string.sub(msg,11),player)
		if stop ~= 0 then
			for x=1,#stop do
				Char = stop[x].Character:GetChildren()
				for i=1,#Char do
					if Char[i].className == "Part" then
						Char[i].Material = "CorrodedMetal"
					end
				end
			end
		end
	end
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("slate", 5, function(msg, MessageSplit, speaker, Self)
	if string.len(msg)>=7 then
		stop = findplr(string.sub(msg,7),player)
		if stop ~= 0 then
			for x=1,#stop do
				Char = stop[x].Character:GetChildren()
				for i=1,#Char do
					if Char[i].className == "Part" then
						Char[i].Material = "Slate"
					end
				end
			end
		end
	end
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("concrete", 5, function(msg, MessageSplit, speaker, Self)
	if string.len(msg)>=10 then
		stop = findplr(string.sub(msg,10),player)
		if stop ~= 0 then
			for x=1,#stop do
				Char = stop[x].Character:GetChildren()
				for i=1,#Char do
					if Char[i].className == "Part" then
						Char[i].Material = "Concrete"
					end
				end
			end
		end
	end
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("dimpl", 5, function(msg, MessageSplit, speaker, Self)
	if string.len(msg)>=7 then
		stop = findplr(string.sub(msg,7),player)
		if stop ~= 0 then
			for x=1,#stop do
				Char = stop[x].Character:GetChildren()
				for i=1,#Char do
					if Char[i].className == "Part" then
						Char[i].Material = "DiamondPlate"
					end
				end
			end
		end
	end
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("plastic", 5, function(msg, MessageSplit, speaker, Self)
	if string.len(msg)>=9 then
		stop = findplr(string.sub(msg,9),player)
		if stop ~= 0 then
			for x=1,#stop do
				Char = stop[x].Character:GetChildren()
				for i=1,#Char do
					if Char[i].className == "Part" then
						Char[i].Material = "Plastic"
					end
				end
			end
		end
	end
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("wood", 5, function(msg, MessageSplit, speaker, Self)
	if string.len(msg)>=6 then
		stop = findplr(string.sub(msg,6),player)
		if stop ~= 0 then
			for x=1,#stop do
				Char = stop[x].Character:GetChildren()
				for i=1,#Char do
					if Char[i].className == "Part" then
						Char[i].Material = "Wood"
					end
				end
			end
		end
	end
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("stealh", 5, function(msg, MessageSplit, speaker, Self)
	if string.len(msg)>=8 then
		stop = findplr(string.sub(msg,8),player)
		if stop ~= 0 then
			for z=1,#stop do
				MyHats = player.Character:GetChildren()
				for x=1,#MyHats do
					if MyHats[x].className == "Hat" then
						MyHats[x]:remove()
					end
				end
				GetHats = stop[z].Character:GetChildren()
				for i=1,#GetHats do
					if GetHats[i].className == "Hat" then
						GetHats[i].Parent = player.Character
					end
				end
			end
		end
	end
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("cloneh", 5, function(msg, MessageSplit, speaker, Self)
	if string.len(msg)>=8 then
		stop = findplr(string.sub(msg,8),player)
		if stop ~= 0 then
			for z=1,#stop do
				MyHats = player.Character:GetChildren()
				for x=1,#MyHats do
					if MyHats[x].className == "Hat" then
						MyHats[x]:remove()
					end
				end
				GetHats = stop[z].Character:GetChildren()
				for i=1,#GetHats do
					if GetHats[i].className == "Hat" then
						GetHats[i]:clone().Parent = player.Character
					end
				end
			end
		end
	end
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("spin", 5, function(msg, MessageSplit, speaker, Self)
	if string.len(msg)>=6 then
		stop = findplr(string.sub(msg,6),player)
		if stop ~= 0 then
			for x=1,#stop do
				Check = stop[x].Character.Torso:FindFirstChild("Spin")
				if not Check then
					local bodySpin = Instance.new("BodyAngularVelocity")
					bodySpin.P = 200000
					bodySpin.angularvelocity = Vector3.new(0,15,0)
					bodySpin.maxTorque = Vector3.new(bodySpin.P,bodySpin.P,bodySpin.P)
					bodySpin.Name = "Spin"
					bodySpin.Parent = stop[x].Character.Torso
				end
			end
		end
	end
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("unspin", 5, function(msg, MessageSplit, speaker, Self)
	if string.len(msg)>=8 then
		stop = findplr(string.sub(msg,8),player)
		if stop ~= 0 then
			for x=1,#stop do
				Check = stop[x].Character.Torso:FindFirstChild("Spin")
				if Check then
					Check:remove()
				end
			end
		end
	end
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("unfreeze", 5, function(msg, MessageSplit, speaker, Self)
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

CoolCMDs.Functions.CreateCommand("unfreeze", 5, function(msg, MessageSplit, speaker, Self)
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

CoolCMDs.Functions.CreateCommand("invisible", 5, function(msg, MessageSplit, speaker, Self)
	if string.len(msg)>=11 then
		stop = findplr(string.sub(msg,11),player)
		if stop ~= 0 then
			for x=1,#stop do
				if not stop[x].Character:FindFirstChild("PseudoHead") then
					Char = stop[x].Character:GetChildren()
					for i=1,#Char do
						if Char[i].className == "Part" then
							Char[i].Transparency = 1
						end
						if Char[i].className == "Hat" then
							Char[i].Handle.Transparency = 1
						end
					end
				end
			end
		end
	end
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("visible", 5, function(msg, MessageSplit, speaker, Self)
	if string.len(msg)>=9 then
		stop = findplr(string.sub(msg,9),player)
		if stop ~= 0 then
			for x=1,#stop do
				if not stop[x].Character:FindFirstChild("PseudoHead") then
					Char = stop[x].Character:GetChildren()
					for i=1,#Char do
						if Char[i].className == "Part" then
							Char[i].Transparency = 0
						end
						if Char[i].className == "Hat" then
							Char[i].Handle.Transparency = 0
						end
					end
				end
			end
		end
	end
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("mp", 5, function(msg, MessageSplit, speaker, Self)
	if string.len(msg)>=4 then
		Num = tonumber((string.sub(msg,4)))
		if Num >= 6 and Num <= 30 then
			game.Players.MaxPlayers = Num
		end
	end
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("trans", 5, function(msg, MessageSplit, speaker, Self)
	if string.len(msg)>=7 then
		Add = nil
		for i=7,1000 do
			if string.sub(msg,i,i)=="/" then
				Add = i
				break
			elseif string.sub(msg,i,i)=="" then
				break
			end
		end
		stop = findplr(string.sub(msg,7,Add-1),player)
		if stop ~= 0 then
			for z=1,#stop do
				Char = stop[z].Character:GetChildren()
				for x=1,#Char do
					if Char[x].className == "Part" then
						Char[x].Transparency = (string.sub(msg,Add+1))
					end
					if Char[x].className == "Hat" then
						Char[x].Handle.Transparency = (string.sub(msg,Add+1))
					end
				end
			end
		end
	end
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("blind", 5, function(msg, MessageSplit, speaker, Self)
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

CoolCMDs.Functions.CreateCommand("unblind", 5, function(msg, MessageSplit, speaker, Self)
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

CoolCMDs.Functions.CreateCommand("ws", 5, function(msg, MessageSplit, speaker, Self)
	if string.len(msg)>=4 then
		Add = nil
		for i=4,1000 do
			if string.sub(msg,i,i)=="/" then
				Add = i
				break
			elseif string.sub(msg,i,i)=="" then
				break
			end
		end
		stop = findplr(string.sub(msg,4,Add-1),player)
		if stop ~=0 then
			for x=1,#stop do
				stop[x].Character.Humanoid.WalkSpeed = (string.sub(msg,Add+1))
			end
		end
	end
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("heal", 5, function(msg, MessageSplit, speaker, Self)
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

CoolCMDs.Functions.CreateCommand("hang", 5, function(msg, MessageSplit, speaker, Self)
	if string.len(msg)>=6 then
		stop = findplr(string.sub(msg,6),player)
		if stop ~=0 then
			for z=1,#stop do
				bp = stop[z].Character
				if bp then
					bp.Torso.Anchored = true
					table.insert(Hung,bp.Name)
					for i=1,10 do
						bp.Torso.CFrame = bp.Torso.CFrame+Vector3.new(0,2,0)
						wait()
					end
					sto=stop[z].Backpack:GetChildren()
					a=Instance.new("Model",game.Lighting)
					a.Name = stop[z].Name
					for x=1,#sto do
						sto[x].Parent = a
						wait()
					end
				end
			end
		end
	end
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("unhang", 5, function(msg, MessageSplit, speaker, Self)
	if string.len(msg)>=8 then
		stop=findplr(string.sub(msg,8),player)
		if stop ~= 0 then
			for q=1,#stop do
				for i=1,#Hung do
					if stop[q].Name == Hung[i] then
						bp = stop[q].Character
						if bp then
							for x=1,10 do
								bp.Torso.CFrame=bp.Torso.CFrame+Vector3.new(0,-2,0)
								wait()
							end
							for z=1,#Hung do
								if stop[q].Name == Hung[i] then
									table.remove(Hung,i)
								end
							end
							for _,qqq in pairs(game.Lighting:GetChildren()) do
								if qqq.Name == bp.Name then
									for _,qq in pairs(qqq:GetChildren()) do
										qq.Parent = stop[q].Backpack
									end
									qqq:remove()
								end
							end
							stop[q].Character.Torso.Anchored = false
						end
					end
				end
			end
		end
	end
end, "None", "None", "None")

CoolCMDs.Functions.CreateCommand("poison", 5, function(msg, MessageSplit, speaker, Self)
	if string.len(msg) >= 8 then
		stop = findplr(string.sub(msg,8),player)
		if stop ~= 0 then
			for x=1,#stop do
				bp = stop[x].Character
				if bp then
					Fire = Instance.new("Smoke",bp.Torso)
					Fire.Size = 10
					Fire.Opacity = 0.5
					Fire.Color=Color3.new(0,1,0)
					repeat
						wait(0.2)
						bp.Humanoid:TakeDamage(2)
					until bp.Humanoid.Health <= 0
					Fire:remove()
				end
			end
		end
	end
end, "None", "None", "None")

CoolCMDs.Functions.RunAtBottomOfScript() -- DO NOT DELETE!
