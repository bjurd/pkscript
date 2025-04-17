pkscript.Miscellaneous = pkscript.Miscellaneous or {}
local Misc = pkscript.Miscellaneous

Misc.Config = Misc.Config or {}
local Config = Misc.Config

Config.AutoCleanup = Config.AutoCleanup or {}
Config.AutoCleanup.Enabled = pkscript.Util.ConfigDefault(Config.AutoCleanup.Enabled, false)
Config.AutoCleanup.OnDeath = pkscript.Util.ConfigDefault(Config.AutoCleanup.OnDeath, false)
Config.AutoCleanup.OnRelease = pkscript.Util.ConfigDefault(Config.AutoCleanup.OnRelease, false)

do -- Auto Cleanup
	local AliveLast

	function Misc.AutoCleanupOnDeath(Command)
		local Alive = pkscript.LocalPlayer:Alive()

		if Config.AutoCleanup.Enabled and Config.AutoCleanup.OnDeath then
			if not Alive and AliveLast then
				pkscript.LocalPlayer:ConCommand("gmod_cleanup")
			end
		end

		AliveLast = Alive
	end

	function Misc.AutoCleanupOnRelease(Player, Entity)
		if not Config.AutoCleanup.Enabled or not Config.AutoCleanup.OnRelease then
			return
		end

		if Player == pkscript.LocalPlayer then -- TODO: Only remove the prop released? I don't this is possible :(
			local ToPlayer = pkscript.LocalPlayer:GetPos()
			ToPlayer:Sub(Entity:GetPos())
			ToPlayer:Normalize()

			local Direction = Entity:GetVelocity()
			Direction:Normalize()

			local Dot = Direction:Dot(ToPlayer)

			if Dot <= math.cos(30) then -- 30 fov seems good enough /shrug
				return -- Only remove if it's heading towards us
			end

			pkscript.LocalPlayer:ConCommand("gmod_cleanup")
		end
	end
end

pkscript.Hooks.Register("CreateMove", Misc.AutoCleanupOnDeath)
pkscript.Hooks.Register("PhysgunDrop", Misc.AutoCleanupOnRelease)
