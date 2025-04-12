-- Another file so menu.lua isn't huge

local Menu = pkscript.Menu

function Menu.Build()
	local Instance = Menu.Instance -- Assume valid

	local Movement = Instance:AddOption("Movement")
	Movement:AddSubOption("Bunny Hop")
	Movement:AddSubOption("Auto Strafe")
end
