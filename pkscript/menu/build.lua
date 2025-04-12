-- Another file so menu.lua isn't huge
-- TODO: Each feature file should be responsible for setting up its own menu code

local Menu = pkscript.Menu

function Menu.Build()
	local Instance = Menu.Instance -- Assume valid

	local Movement = Instance:AddOption("Movement")
	Movement:AddSubOption("Bunny Hop", pkscript.Movement.Config, "BunnyHop", TYPE_BOOL)
	Movement:AddSubOption("Auto Strafe", pkscript.Movement.Config, "AutoStrafe", TYPE_BOOL)
	Movement:AddSubOption("Quick Stop", pkscript.Movement.Config, "QuickStop", TYPE_BOOL)
end
