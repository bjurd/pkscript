if istable(pkscript) and isfunction(pkscript.Unload) then
	pkscript.Unload()
else
	pkscript = {}
end

include("globals.lua")
include("hooks.lua")

include("movement.lua")

function pkscript.Unload()
	pkscript.Hooks.UnRegisterAll()
end

concommand.Add("pkscript_unload", pkscript.Unload)
