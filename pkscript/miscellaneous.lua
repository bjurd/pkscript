pkscript.Miscellaneous = pkscript.Miscellaneous or {}
local Misc = pkscript.Miscellaneous

Misc.Config = Misc.Config or {}
local Config = Misc.Config

Config.Cleanup = pkscript.Util.ConfigDefault(Config.Cleanup, false)

do
	local AliveLast

	function Misc.Cleanup(Command)
		local Alive = pkscript.LocalPlayer:Alive()

		if Config.Cleanup then
			if not Alive and AliveLast then
				pkscript.LocalPlayer:ConCommand("gmod_cleanup")
			end
		end

		AliveLast = Alive
	end
end

function Misc.CreateMove(Command)
	Misc.Cleanup(Command)
end

pkscript.Hooks.Register("CreateMove", Misc.CreateMove)
