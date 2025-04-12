-- Another file so menu.lua isn't huge
-- TODO: Each feature file should be responsible for setting up its own menu code

local Menu = pkscript.Menu

function Menu.Build()
	local Instance = Menu.Instance -- Assume valid

	local Movement = Instance:AddOption("Movement")
	Movement:AddSubOption("Bunny Hop", pkscript.Movement.Config, "BunnyHop", TYPE_BOOL)
	Movement:AddSubOption("Auto Strafe", pkscript.Movement.Config, "AutoStrafe", TYPE_BOOL)
	Movement:AddSubOption("Quick Stop", pkscript.Movement.Config, "QuickStop", TYPE_BOOL)

	local Visuals = Instance:AddOption("Visuals")

	local PlayerESP = Visuals:AddSubOption("Player ESP")
	PlayerESP:AddSubOption("Enabled", pkscript.Visuals.Config.PlayerESP, "Enabled", TYPE_BOOL)
	PlayerESP:AddSubOption("Name Tags", pkscript.Visuals.Config.PlayerESP, "NameTags", TYPE_BOOL)
	PlayerESP:AddSubOption("Weapons", pkscript.Visuals.Config.PlayerESP, "Weapons", TYPE_BOOL)
	PlayerESP:AddSubOption("Health", pkscript.Visuals.Config.PlayerESP, "Health", TYPE_BOOL)
	PlayerESP:AddSubOption("Bounding Boxes", pkscript.Visuals.Config.PlayerESP, "Bounds", TYPE_BOOL)

	local PropESP = Visuals:AddSubOption("Prop ESP")
	PropESP:AddSubOption("Enabled", pkscript.Visuals.Config.PropESP, "Enabled", TYPE_BOOL)
	PropESP:AddSubOption("Bounding Boxes", pkscript.Visuals.Config.PropESP, "Bounds", TYPE_BOOL)
end
