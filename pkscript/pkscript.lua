if istable(pkscript) and isfunction(pkscript.Unload) then
	pkscript.Unload()
else
	pkscript = pkscript or {}
end

include("globals.lua")
include("hooks.lua")

include("movement.lua")

include("menu.lua")

function pkscript.Unload()
	pkscript.Menu.Destroy()
	pkscript.Hooks.UnRegisterAll()
end

concommand.Add("pkscript_unload", pkscript.Unload)
