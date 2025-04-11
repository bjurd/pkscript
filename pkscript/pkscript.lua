if istable(pkscript) and isfunction(pkscript.Unload) then
	pkscript.Unload()
else
	pkscript = {}
end

include("globals.lua")
include("hooks.lua")

function pkscript.Unload()
	pkscript.Hooks.UnRegisterAll()
end
