if istable(pkscript) and isfunction(pkscript.Unload) then
	pkscript.Unload()
else
	pkscript = pkscript or {}
end

include("pkscript/globals.lua")
include("pkscript/util.lua")
include("pkscript/hooks.lua")

include("pkscript/movement.lua")
include("pkscript/visuals.lua")
include("pkscript/miscellaneous.lua")

include("pkscript/menu.lua")
include("pkscript/menu/build.lua")

function pkscript.Unload()
	pkscript.Hooks.Run("PKScript:Unload")

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

function pkscript.Reload()
	-- A file can't include itself >:/
	local Source = debug.getinfo(1).short_src
	local Code = file.Read(Source, "GAME")

	RunString(Code, Source)
end

concommand.Add("pkscript_unload", pkscript.Unload)
concommand.Add("pkscript_fullunload", pkscript.FullUnload)
concommand.Add("pkscript_reload", pkscript.Reload)
