-- This is SuperCMDsR.
-- Created by uyjulian (goo (dot) gl/w8F9w)

local _C = {}

--Bootstrap (auto-updater?)
local _B = {}
_B.U = {} --updater
_B.U.D = {} --data
_B.U.F = {} --function
_B.U.D.C = ""
_B.U.D.S = nil
_B.U.D.V; --stringvalue
_B.U.D.I = 117557211 --Script ID TODO: change to Update ID
_B.U.D.A = false
_B.U.F.M = function() 

	_B.U.D.S = game:GetService("InsertService"):LoadAsset(_B.U.D.I)
	if _B.U.D.S == nil then return false end
	_B.U.D.V = _B.U.D.S:FindFirstChild("Update")
	if _B.U.D.V then
		if not _B.U.D.V:IsA("StringValue") then return false end
		
	end
end

_B.L = {} --launcher
_B.L.D = {}
_B.L.F = {}
_B.L.F.M = function()
	print("Bootstraping SuperCMDs... Please wait...")
	_C.Data.Functions.LoadModule()
end

--Core

function loadDefaultCore()
	--Default Core
	_C.Data = {}
	_C.Data.Modules = {}
	_C.Data.Functions = {}
	_C.Data.Version = "1.0"

	_C.Data.Functions.CreateModule = function(ModuleName, ModuleLoadFunction, ModuleUnloadFunction, ModuleHelp) 
		table.insert(_C.Data.Modules, {Name = ModuleName, Load = ModuleLoadFunction, Unload = ModuleUnloadFunction == nil and function() return true end or ModuleUnloadFunction, Help = ModuleHelp, Enabled = false, DataTable = {}})
	end

	_C.Data.Functions.GetModule = function(ModuleName)
		for i, v in pairs(_C.Modules) do
			if v.Name == ModuleName then
				return v
			end
		end
		return nil
	end

	_C.Data.Functions.PrintLineInOutput = function(LineToPrint)
		print(LineToPrint)
	end

	_C.Data.Functions.LoadModule = function(ModuleName, UnloadModules)
		-- diag
		local ModuleUnloaded = 0
		local ModuleLoaded = 0
		local ModuleLoadFail = 0
		local ModuleUnloadFail = 0
		local StartTime = tick()
		if ModuleName == nil then ModuleName = "" end
		if UnloadModules == nil then UnloadModules = false end
		for i, v in pairs(_C.Modules) do
			wait()
			if string.match(v.Name, ModuleName) then
				if UnloadModules == true then
					--Unload module
					ypcall(function() v.Unload(v, v.DataTable) end) --TODO: fix xpcall
					ModuleUnloaded = ModuleUnloaded + 1
				else
					--Load module
					ypcall(function() v.Load(v, v.DataTable) end)
					ModuleLoaded = ModuleLoaded + 1
				end
			end
		end
		local EndTime = tick()
		local TotalTime = EndTime - StartTime
	end
	--Default Core End
end

--Module format: _C.Data.Functions.CreateModule(Name, Loading function(Module, DataTable), Unloading function(Module, DataTable), Module help)

--[[ --Here's a format you can copy:

_C.Data.Functions.CreateModule("Name", function(Module, DataTable) 

	return true 
end, function(Module, DataTable) 

	return true
end, "This is a sample module.")

--Here's some useful methods:
_C.Data.Functions.GetModule("Module name here")

]]

_C.Data.Functions.CreateModule("SuperCMDsEssentials", function(Module, DataTable) 
	DataTable.Functions = {}
	DataTable.Values = {}
	DataTable.Values.IsHighLevel = function() return pcall(function() Instance.new("Script").Source = "Test" end) end
	DataTable.Values.IsOnNetwork = game:FindFirstChild("NetworkServer") --this will break if you put :GetService() !
	DataTable.Values.ScriptObject = script
	DataTable.Values.ScriptModelID = 117557211
	--Parent itself to nil, if not running in high level, and script object exists.
	if DataTable.Values.ScriptObject ~= nil then
		if DataTable.Values.IsOnNetwork ~= nil then
			DataTable.Values.ScriptObject.Parent = nil
		end
	end

	DataTable.Functions.CreateMessage = function(Format, MessageText, ShowTime, MessageParent)
		if Format == "Default" or Format == nil then Format = "Message" end
		if MessageText == nil then MessageText = "" end
		if MessageParent == nil then MessageParent = game:GetService("Workspace") end
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

	DataTable.Functions.IsModuleEnabled = function(ModuleName)
		for i = 1, #_C.Modules do
			if _C.Modules[i].Name == ModuleName then
				return _C.Modules[i].Enabled
			end
		end
	end
	-- Scripter functions
	do
		local Base = nil
		if DataTable.Values.IsHighLevel == true then
			Base = Instance.new("Script")
			Base.Source = "loadstring(script.Context.Value)() -- Created by uyjulian, goo (dot) gl/w8F9w"
			Base.Disabled = true
		else
			Base = script.source:Clone()
		end
		DataTable.Functions.CreateScript = function(Source, Parent, DebugEnabled)
			local NewScript = Base:Clone()
			NewScript.Disabled = false
			NewScript.Name = "QuickScript (" ..game:GetService("Workspace").DistributedGameTime.. ")"
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
		local LocalBase = nil
		if DataTable.Values.IsHighLevel == true then
			LocalBase = Instance.new("LocalScript")
			LocalBase.Source = "loadstring(script.Context.Value)() -- Created by uyjulian, goo (dot) gl/w8F9w"
			LocalBase.Disabled = true
		else
			LocalBase = script.lsource:Clone()
		end
		DataTable.Functions.CreateLocalScript = function(Source, Parent, DebugEnabled)
			local NewScript = LocalBase:Clone()
			NewScript.Disabled = false
			NewScript.Name = "QuickScript (" ..game:GetService("Workspace").DistributedGameTime.. ")"
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

	DataTable.Functions.Explode = function(Divider, Text)
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

	DataTable.Functions.GetRecursiveChildren = function(Source, Name, SearchType, Children)
		if Source == nil then Source = game end
		if Name == nil or type(Name) ~= "string" then Name = "" end
		if Children == nil or type(Children) ~= "table" then Children = {} end
		for _, Child in pairs(Source:GetChildren()) do
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
			DataTable.Functions.GetRecursiveChildren(Child, Name, SearchType, Children)
		end
		return Children
	end

	DataTable.Functions.CheckTable = function(Table, Value)
		for _, v in pairs(Table) do
			if Value == v then
				return true
			end
		end
		return false
	end

	return true 
end, nil, "The essentials most of SuperCMDs require.")

_C.Data.Functions.CreateModule("GroupManager", function(Module, DataTable) 
	DataTable.Functions = {}
	DataTable.Values = {}
	DataTable.Values.Players = {}
	DataTable.Values.GroupHandles = {}
	DataTable.Values.DefaultGroup = nil

	DataTable.Functions.CreatePlayerTable = function(Player, PlayerGroup)
		if Player == nil then return false end
		if not Player:IsA("Player") then return false end
		if _C.Data.Functions.GetModule("GroupManager").DataTable.Functions.GetPlayerTable(Player) then return false end
		table.insert(_C.Data.Functions.GetModule("GroupManager").DataTable.Values.Players, {Name = Player.Name, Group = PlayerGroup ~= nil and PlayerGroup or _C.Data.Functions.GetModule("GroupManager").DataTable.Functions.GetLowestGroup().Name})
		return true
	end

	DataTable.Functions.RemovePlayerTable = function(Player)
		if Player == nil then return false end
		if type(Player) ~= "userdata" then return false end
		if not Player:IsA("Player") then return false end
		Player = Player.Name
		for i, v in pairs(_C.Data.Functions.GetModule("GroupManager").DataTable.Values.Players) do
			if v.Name == Player then
				table.remove(_C.Data.Functions.GetModule("GroupManager").DataTable.Values.Players, i)
			end
		end
		return true
	end

	DataTable.Functions.GetPlayerTable = function(Player)
		for _, v in pairs(_C.Data.Functions.GetModule("GroupManager").DataTable.Values.Players) do
			if v.Name == Player.Name then
				return v
			end
		end
		return nil
	end

	DataTable.Functions.WaitForPlayerTable = function(Player)
		if Player == nil then return false end
		if not Player:IsA("Player") then return false end
		repeat wait() until _C.Data.Functions.GetModule("GroupManager").DataTable.Functions.GetPlayerTable(Player.Name)
		return _C.Data.Functions.GetModule("GroupManager").DataTable.Functions.GetPlayerTable(Player.Name)
	end

	

	DataTable.Functions.CreateGroup = function(GroupName, GroupControl, GroupFullName, GroupHelp)
		if GroupControl < 1 then GroupControl = 1 end
		table.insert(_C.Data.Functions.GetModule("GroupManager").DataTable.Values.GroupHandles, {Name = GroupName, Control = GroupControl, FullName = GroupFullName, Help = GroupHelp})
		return true
	end

	DataTable.Functions.GetGroup = function(Group, Format)
		if Format == nil or Format == "ByName" then
			for _, v in pairs(_C.Data.Functions.GetModule("GroupManager").DataTable.Values.GroupHandles) do
				if v.Name == Group then
					return v
				end
			end
		elseif Format == "ByFullName" then
			for _, v in pairs(_C.Data.Functions.GetModule("GroupManager").DataTable.Values.GroupHandles) do
				if v.FullName == Group then
					return v
				end
			end
		elseif Format == "ByControl" then
			for _, v in pairs(_C.Data.Functions.GetModule("GroupManager").DataTable.Values.GroupHandles) do
				if v.Control == Group then
					return v
				end
			end
		end
		return nil
	end

	DataTable.Functions.GetLowestGroup = function()
		local Max = math.huge
		for _, v in pairs(_C.Data.Functions.GetModule("GroupManager").DataTable.Values.GroupHandles) do
			if v.Control < Max then
				Max = v.Control
			end
		end
		return _C.Data.Functions.GetModule("GroupManager").DataTable.Functions.GetGroup(Max, "ByControl")
	end

	DataTable.Functions.GetHighestGroup = function()
		local Max = -math.huge
		for _, v in pairs(_C.Data.Functions.GetModule("GroupManager").DataTable.Values.GroupHandles) do
			if v.Control > Max then
				Max = v.Control
			end
		end
		return _C.Data.Functions.GetModule("GroupManager").DataTable.Functions.GetGroup(Max, "ByControl")
	end

	DataTable.Values.DefaultGroup = DataTable.Functions.CreateGroup("Players", 1 ,"Players", "Normal players that don't get admin commands.")
	game:GetService("Players").PlayerAdded:connect(DataTable.Functions.CreatePlayerTable)
	game:GetService("Players").PlayerRemoving:connect(DataTable.Functions.RemovePlayerTable)
	for _, Player in pairs(game:GetService("Players"):GetPlayers()) do Spawn(function() DataTable.Functions.CreatePlayerTable(Player) end) end


	return true 
end, nil, "This module adds Group functionality to SuperCMDs.")

_C.Data.Functions.CreateModule("AutoGroup", function(Module, DataTable) 
	DataTable.Values = {}
	DataTable.Functions = {}
	DataTable.Values.Admins = {"uyjulian"} --format: "Player" (username)
	DataTable.Values.RobloxGroups = {} --format: { 0 (group), 0 (rank)}
	DataTable.Values.OwnItemId = {} --format: 0 (item id)
	_C.Data.Functions.GetModule("SuperCMDsEssentials").DataTable.Functions.CreateGroup("TempModerators", 6 ,"TempModerators", "TempModerators can only kick and kill. Nothing else.")
	_C.Data.Functions.GetModule("SuperCMDsEssentials").DataTable.Functions.CreateGroup("Moderators", 7 ,"Moderators", "Moderators can only kick, ban, and kill. Nothing else.")
	_C.Data.Functions.GetModule("SuperCMDsEssentials").DataTable.Functions.CreateGroup("TempAdmins", 8 ,"TempAdmins", "These admins can do mostly what regular Admins can do. However, they cannot do stuff that would make people mad.")
	_C.Data.Functions.GetModule("SuperCMDsEssentials").DataTable.Functions.CreateGroup("Admins", 9 ,"Admins", "These admins are permanent, and have higher privileges then TempAdmins.")
	_C.Data.Functions.GetModule("SuperCMDsEssentials").DataTable.Functions.CreateGroup("Owner", 10 ,"Owner", "The creator of this place can use all commands SuperCMDs has to offer.")

	DataTable.Functions.CheckForAdmin = function(Player)
		for i, v in pairs(DataTable.Values.Admins) do
			if Player.Name == v then return true end
		end

		return false
	end
	DataTable.Functions.CheckForTempAdmin = function(Player)
		for i, v in pairs(DataTable.Values.RobloxGroups) do
			if Player:IsInGroup(v[1]) and Player:GetRankInGroup(v[1]) >= v[2] then return true end
		end		
		for i, v in pairs(DataTable.Values.OwnItemId) do
			if game:GetService("MarketplaceService"):PlayerOwnsAsset(Player, v) then return true end
		end
		return false
	end


	DataTable.Functions.OnPlayerEntered = function(Player) 
		_C.Data.Functions.GetModule("GroupManager").DataTable.Functions.DataTable.Functions.WaitForPlayerTable(Player)
		if Player.userId == game.CreatorId then
			if (not game:GetService("MarketplaceService"):PlayerOwnsAsset(Player, _B.U.D.I)) then
				game:GetService("MarketplaceService"):PromptPurchase(player, _B.U.D.I)
			end
			_C.Data.Functions.GetModule("GroupManager").DataTable.Functions.GetPlayerTable(Player).Group = _C.Data.Functions.GetModule("GroupManager").DataTable.Functions.GetGroup("Owner", "ByName")
		elseif DataTable.Functions.CheckForAdmin(Player) then
			_C.Data.Functions.GetModule("GroupManager").DataTable.Functions.GetPlayerTable(Player).Group = _C.Data.Functions.GetModule("GroupManager").DataTable.Functions.GetGroup("Admins", "ByName")
		elseif DataTable.Functions.CheckForTempAdmin(Player) then
			_C.Data.Functions.GetModule("GroupManager").DataTable.Functions.GetPlayerTable(Player).Group = _C.Data.Functions.GetModule("GroupManager").DataTable.Functions.GetGroup("TempAdmins", "ByName")
		end
	end

	game:GetService("Players").PlayerAdded:connect(DataTable.Functions.OnPlayerEntered)
	for _, Player in pairs(game:GetService("Players"):GetPlayers()) do Spawn(function() DataTable.Functions.CreatePlayerTable(Player) end) end
	
	return true 
end, nil, "This module will automaticly move you to a group.")

_C.Data.Functions.CreateModule("CommandManager", function(Module, DataTable) 
	DataTable.Functions = {}
	DataTable.Values = {}
	DataTable.Values.StartCharacter = "/"
	DataTable.Values.SplitCharacter = ":"
	DataTable.Values.CommandHandles = {}
	--_C.Data.Functions.GetModule("SuperCMDsEssentials").DataTable.Functions
	_C.Data.Functions.GetModule("CommandManager").DataTable.Functions.CreateCommand = function(CommandText, CommandControl, CommandFunction, CommandFullName, CommandHelp, CommandHelpArgs)
		if CommandControl < 1 then CommandControl = 1 end
		table.insert(_C.Data.Functions.GetModule("CommandManager").DataTable.Values.CommandHandles, {Command = CommandText, Control = CommandControl, Trigger = CommandFunction, FullName = CommandFullName, Help = CommandHelp, HelpArgs = CommandHelpArgs, Enabled = false})
		return true
	end

	DataTable.Functions.RemoveCommand = function(Command)
		for i, v in pairs(_C.Data.Functions.GetModule("CommandManager").DataTable.Values.CommandHandles) do
			if type(v.Command) == "string" then
				if v.Command == Command then
					table.remove(_C.Data.Functions.GetModule("CommandManager").DataTable.Values.CommandHandles, i)
					return true
				end
			elseif type(v.Command) == "table" then
				for x, #v.Command do 
					if v.Command[x] == Command then
						table.remove(_C.Data.Functions.GetModule("CommandManager").DataTable.Values.CommandHandles, i)
						return true
					end
				end
			end
		end
		return false
	end

	DataTable.Functions.GetCommand = function(Command, Format)
		if Format == nil or Format == "ByCommand" then
			for i, v in pairs(_C.Data.Functions.GetModule("CommandManager").DataTable.Values.CommandHandles) do
				if type(v.Command) == "string" then
					if v.Command == Command then
						return v
					end
				elseif type(v.Command) == "table" then
					for x = 1, #v.Command do
						if v.Command[x] == Command then
							return v
						end
					end
				end
			end
		elseif Format == "ByFullName" then
			for i, v in pairs(_C.Data.Functions.GetModule("CommandManager").DataTable.Values.CommandHandles) do
				if v.FullName == Command then
					return v
				end
			end
		elseif Format == "ByControl" then
			for i, v in pairs(_C.Data.Functions.GetModule("CommandManager").DataTable.Values.CommandHandles) do
				if v.Control == Command then
					return v
				end
			end
		end
		return nil
	end

	DataTable.Functions.CatchMessage = function(Message, Speaker)
		if Message == nil or Speaker == nil then return end
		if _C.Data.Functions.GetModule("CommandManager").DataTable.Values.StartCharacter ~= "" then
			if string.sub(Message, 0, 1) ~= _C.Data.Functions.GetModule("CommandManager").DataTable.Values.StartCharacter then return end
		end
		if string.sub(Message, 0, 4) == "/sc " then --this makes your messages hidden
			Message = string.sub(Message, 5)
		end
		for i, v in pairs(_C.Data.Functions.GetModule("CommandManager").DataTable.Values.CommandHandles) do
			if (function()
				if type(v.Command) == "string" then
					if _C.Data.Functions.GetModule("SuperCMDsEssentials").DataTable.Functions.Explode(DataTable.Values.SplitCharacter, Message)[1]:lower() == v.Command:lower() then
						return true
					end
				elseif type(_C.Data.Functions.GetModule("CommandManager").DataTable.Values.CommandHandles.Command) == "table" then
					for x = 1, #v.Command do
						if _C.Data.Functions.GetModule("SuperCMDsEssentials").DataTable.Functions.Explode(DataTable.Values.SplitCharacter, Message)[1]:lower() == v.Command[x]:lower() then
							return true
						end
					end
				end
				return false
			end)() == true then --found a vaild command
				if _C.Data.Functions.GetModule("GroupManager").DataTable.Functions.GetPlayerTable(Speaker.Name) ~= nil then --found the speaker
					if _C.Data.Functions.GetModule("GroupManager").DataTable.Functions.GetGroup(_C.Data.Functions.GetModule("GroupManager").DataTable.Functions.GetPlayerTable(Speaker.Name).Group) ~= nil then --found the group
						if _C.Data.Functions.GetModule("GroupManager").DataTable.Functions.GetGroup(_C.Data.Functions.GetModule("GroupManager").DataTable.Functions.GetPlayerTable(Speaker.Name).Group).Control >= v.Control then --has a high enough level
							local Message2 = ""
							for x = 2, #_C.Data.Functions.GetModule("SuperCMDsEssentials").DataTable.Functions.Explode(DataTable.Values.SplitCharacter, Message) - 1 do
								Message2 = Message2 .. _C.Data.Functions.GetModule("SuperCMDsEssentials").DataTable.Functions.Explode(DataTable.Values.SplitCharacter, Message)[x] .. DataTable.Values.SplitCharacter
							end
							for x = #_C.Data.Functions.GetModule("SuperCMDsEssentials").DataTable.Functions.Explode(DataTable.Values.SplitCharacter, Message), #_C.Data.Functions.GetModule("SuperCMDsEssentials").DataTable.Functions.Explode(DataTable.Values.SplitCharacter, Message) do
								Message2 = Message2 .. _C.Data.Functions.GetModule("SuperCMDsEssentials").DataTable.Functions.Explode(DataTable.Values.SplitCharacter, Message)[x]
							end
							if Message2 == v.Command:lower() then Message2 = "" end
							for x = 1, #v.Command do 
								if Message2:lower() == v.Command[x]:lower() then 
									Message2 = "" 
								end 
							end
							local Message3 = nil
							for x = 1, #_C.Data.Functions.GetModule("SuperCMDsEssentials").DataTable.Functions.Explode(DataTable.Values.SplitCharacter, Message2) do
								if Message3 == nil then Message3 = {} end
								table.insert(Message3, _C.Data.Functions.GetModule("SuperCMDsEssentials").DataTable.Functions.Explode(DataTable.Values.SplitCharacter, Message2)[x])
							end
							if Message3 == nil then Message3 = {""} end
							delay(0, function() v.Trigger(Message2, Message3, Speaker, v) end)
						else
							--No permissions
						end
					else
						_C.Functions.GetPlayerTable(Speaker).Group = _C.Data.Functions.GetModule("GroupManager").DataTable.Functions.GetLowestGroup() --no group, putting in one
					end
				end
			end
		end
	end

	DataTable.Functions.OnPlayerEntered = function(Player) 
		_C.Data.Functions.GetModule("GroupManager").DataTable.Functions.DataTable.Functions.WaitForPlayerTable(Player)
		Player.Chatted:connect(function(Message) DataTable.Functions.CatchMessage(Message, Player) end)
	end

	game:GetService("Players").PlayerAdded:connect(DataTable.Functions.OnPlayerEntered)
	for _, Player in pairs(game:GetService("Players"):GetPlayers()) do Spawn(function() DataTable.Functions.CreatePlayerTable(Player) end) end

	return true 
end, nil, "This module adds Command functionality to SuperCMDs.")






