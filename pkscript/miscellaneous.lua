pkscript.Miscellaneous = pkscript.Miscellaneous or {}
local Misc = pkscript.Miscellaneous

Misc.Config = Misc.Config or {}
local Config = Misc.Config

Config.AutoCleanup = Config.AutoCleanup or {}
Config.AutoCleanup.Enabled = pkscript.Util.ConfigDefault(Config.AutoCleanup.Enabled, true)
Config.AutoCleanup.OnDeath = pkscript.Util.ConfigDefault(Config.AutoCleanup.OnDeath, false)
Config.AutoCleanup.OnRelease = pkscript.Util.ConfigDefault(Config.AutoCleanup.OnRelease, true)

Config.AutoSuicide = pkscript.Util.ConfigDefault(Config.AutoSuicide, true)

function Misc.PropHeadingTowards(Prop, Entity)
	local ToEntity = Entity:GetPos()
	ToEntity:Sub(Prop:GetPos())
	ToEntity:Normalize()

	local Direction = Prop:GetVelocity()
	Direction:Normalize()

	return Direction:Dot(ToEntity) > math.cos(30) -- 30 fov seems good enough /shrug
end

function Misc.PropWillCollide(Prop, Entity)
	local PropVel = Prop:GetVelocity()
	PropVel:Mul(0.1)

	local PropPos = Prop:GetPos()
	PropPos:Add(PropVel)

	local Distance = PropPos:DistToSqr(Entity:GetPos())
	local Radius = Prop:BoundingRadius() + Entity:BoundingRadius()

	return Distance <= Radius * Radius
end

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
			if not Misc.PropHeadingTowards(Entity, pkscript.LocalPlayer) then
				return
			end

			pkscript.LocalPlayer:ConCommand("gmod_cleanup")

			Entity.pkscript_AutoCleanup = true -- TODO: This is kind of hacky I feel, passing information like this is not ideal but it's the easiest right now
		end
	end
end

function Misc.AutoSuicide(Command)
	if not Config.AutoSuicide then return end
	if not pkscript.LocalPlayer:Alive() then return end

	if Command:CommandNumber() == 0 then -- TODO: May cause reliability issues?
		return
	end

	local Weapon = pkscript.LocalPlayer:GetActiveWeapon()
	local Holding = NULL

	if IsValid(Weapon) and Weapon:GetClass() == "weapon_physgun" then
		Holding = Weapon:GetInternalVariable("m_hGrabbedEntity")
	end

	local EntityCache = pkscript.Visuals.EntityCache -- Leverage visuals cache
	local CacheSize = #EntityCache

	for i = 1, CacheSize do
		local Entity = EntityCache[i]
		if Entity == Holding then continue end -- Don't suicide while propflying

		if Entity:GetClass() == "prop_physics" then
			if Misc.PropHeadingTowards(Entity, pkscript.LocalPlayer) and Misc.PropWillCollide(Entity, pkscript.LocalPlayer) then
				if not Entity.pkscript_AutoCleanup then -- Don't suicide if we just let it go
					pkscript.LocalPlayer:ConCommand("kill")
				end
			end
		end
	end
end

pkscript.Hooks.Register("CreateMove", Misc.AutoCleanupOnDeath)
pkscript.Hooks.Register("PhysgunDrop", Misc.AutoCleanupOnRelease)
pkscript.Hooks.Register("CreateMove", Misc.AutoSuicide)
