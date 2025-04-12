if istable(pkscript) and isfunction(pkscript.Unload) then
	pkscript.Unload()
else
	pkscript = pkscript or {}
end

include("globals.lua")
include("util.lua")
include("hooks.lua")

include("movement.lua")

include("menu.lua")
include("menu/build.lua")

function pkscript.Unload()
	pkscript.Menu.Destroy()
	pkscript.Hooks.UnRegisterAll()
end

function pkscript.FullUnload()
	pkscript.Unload()

	local CommandTable = concommand.GetTable()

	for Command, _ in next, CommandTable do
		if string.StartsWith(Command, "pkscript_") then
			concommand.Remove(Command)
		end
	end

	pkscript = nil
end

concommand.Add("pkscript_unload", pkscript.Unload)
concommand.Add("pkscript_fullunload", pkscript.FullUnload)
