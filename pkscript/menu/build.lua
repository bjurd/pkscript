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

	local Materials = table.GetKeys(pkscript.Visuals.Config.Materials) -- TODO: These tables are pretty unorganized :(
	table.sort(Materials)

	local Colors = table.GetKeys(pkscript.Colors)
	table.sort(Colors)

	local PlayerESP = Visuals:AddSubOption("Player ESP")
	PlayerESP:AddSubOption("Enabled", pkscript.Visuals.Config.PlayerESP, "Enabled", TYPE_BOOL)
	PlayerESP:AddSubOption("Name Tags", pkscript.Visuals.Config.PlayerESP, "NameTags", TYPE_BOOL)
	PlayerESP:AddSubOption("Weapons", pkscript.Visuals.Config.PlayerESP, "Weapons", TYPE_BOOL)
	PlayerESP:AddSubOption("Health", pkscript.Visuals.Config.PlayerESP, "Health", TYPE_BOOL)
	PlayerESP:AddSubOption("Bounding Boxes", pkscript.Visuals.Config.PlayerESP, "Bounds", TYPE_BOOL)

	local ColoredModels = PlayerESP:AddSubOption("Colored Models")
	ColoredModels:AddSubOption("Enabled", pkscript.Visuals.Config.PlayerESP.ColoredModels, "Enabled", TYPE_BOOL)
	ColoredModels:AddSubOption("Ignore Z", pkscript.Visuals.Config.PlayerESP.ColoredModels, "IgnoreZ", TYPE_BOOL)
	ColoredModels:AddSubOption("Fullbright", pkscript.Visuals.Config.PlayerESP.ColoredModels, "Fullbright", TYPE_BOOL)
	ColoredModels:AddDropdown("Material", pkscript.Visuals.Config.PlayerESP.ColoredModels, "Material", Materials)
	ColoredModels:AddDropdown("Color", pkscript.Visuals.Config.PlayerESP.ColoredModels, "Color", Colors)

	local PropESP = Visuals:AddSubOption("Prop ESP")
	PropESP:AddSubOption("Enabled", pkscript.Visuals.Config.PropESP, "Enabled", TYPE_BOOL)
	PropESP:AddSubOption("Bounding Boxes", pkscript.Visuals.Config.PropESP, "Bounds", TYPE_BOOL)

	ColoredModels = PropESP:AddSubOption("Colored Models")
	ColoredModels:AddSubOption("Enabled", pkscript.Visuals.Config.PropESP.ColoredModels, "Enabled", TYPE_BOOL)
	ColoredModels:AddSubOption("Ignore Z", pkscript.Visuals.Config.PropESP.ColoredModels, "IgnoreZ", TYPE_BOOL)
	ColoredModels:AddSubOption("Fullbright", pkscript.Visuals.Config.PropESP.ColoredModels, "Fullbright", TYPE_BOOL)
	ColoredModels:AddDropdown("Material", pkscript.Visuals.Config.PropESP.ColoredModels, "Material", Materials)
	ColoredModels:AddDropdown("Color", pkscript.Visuals.Config.PropESP.ColoredModels, "Color", Colors)

	local ColoredViewmodel = Visuals:AddSubOption("Colored Viewmodel")
	ColoredViewmodel:AddSubOption("Enabled", pkscript.Visuals.Config.Viewmodel, "Enabled", TYPE_BOOL)

	local Hands = ColoredViewmodel:AddSubOption("Hands")
	Hands:AddSubOption("Enabled", pkscript.Visuals.Config.Viewmodel.Hands, "Enabled", TYPE_BOOL)
	Hands:AddSubOption("Fullbright", pkscript.Visuals.Config.Viewmodel.Hands, "Fullbright", TYPE_BOOL)
	Hands:AddDropdown("Material", pkscript.Visuals.Config.Viewmodel.Hands, "Material", Materials)
	Hands:AddDropdown("Color", pkscript.Visuals.Config.Viewmodel.Hands, "Color", Colors)

	local Weapon = ColoredViewmodel:AddSubOption("Weapon")
	Weapon:AddSubOption("Enabled", pkscript.Visuals.Config.Viewmodel.Weapon, "Enabled", TYPE_BOOL)
	Weapon:AddSubOption("Fullbright", pkscript.Visuals.Config.Viewmodel.Weapon, "Fullbright", TYPE_BOOL)
	Weapon:AddDropdown("Material", pkscript.Visuals.Config.Viewmodel.Weapon, "Material", Materials)
	Weapon:AddDropdown("Color", pkscript.Visuals.Config.Viewmodel.Weapon, "Color", Colors)

	local HUD = Visuals:AddSubOption("HUD")
	HUD:AddSubOption("Debug Info", pkscript.Visuals.Config.HUD.DebugInfo, "Enabled", TYPE_BOOL)

	local World = Visuals:AddSubOption("World")
	World:AddSubOption("Night Mode", pkscript.Visuals.Config.World, "Nightmode", TYPE_BOOL)

	local FOVChanger = World:AddSubOption("FOV Changer")

	local FOVSizes = table.GetKeys(pkscript.Visuals.Config.World.FOVChanger.Sizes)
	table.sort(FOVSizes)

	FOVChanger:AddSubOption("Static", pkscript.Visuals.Config.World.FOVChanger, "Static", TYPE_BOOL)
	FOVChanger:AddDropdown("Size", pkscript.Visuals.Config.World.FOVChanger, "Size", FOVSizes)

	local Misc = Instance:AddOption("Miscellaneous")

	local AutoCleanup = Misc:AddSubOption("Auto Cleanup")
	AutoCleanup:AddSubOption("Enabled", pkscript.Miscellaneous.Config.AutoCleanup, "Enabled", TYPE_BOOL)
	AutoCleanup:AddSubOption("On Death", pkscript.Miscellaneous.Config.AutoCleanup, "OnDeath", TYPE_BOOL)
	AutoCleanup:AddSubOption("On Release", pkscript.Miscellaneous.Config.AutoCleanup, "OnRelease", TYPE_BOOL)

	Misc:AddSubOption("Auto Suicide", pkscript.Miscellaneous.Config, "AutoSuicide", TYPE_BOOL)
end
