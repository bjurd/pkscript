pkscript.Visuals = pkscript.Visuals or {}
local Visuals = pkscript.Visuals
local Cache = pkscript.Cache

Visuals.EntityCache = {} -- Force empty these
Visuals.EntityCacheKeys = {}

Visuals.EntityClasses = Visuals.EntityClasses or {
	["player"] = true,
	["prop_physics"] = true,
	["prop_dynamic"] = true
}

Visuals.Config = Visuals.Config or {}
local Config = Visuals.Config

Config.Fonts = Config.Fonts or {} -- TODO: No idea how to do this in a menu controlled by arrow keys
Config.Fonts.NameTags = pkscript.Util.ConfigDefault(Config.Fonts.NameTags, "TargetIDSmall")
Config.Fonts.Weapons = pkscript.Util.ConfigDefault(Config.Fonts.Weapons, "DebugOverlay")
Config.Fonts.DebugInfo = pkscript.Util.ConfigDefault(Config.Fonts.DebugInfo, "DebugOverlay")

Config.Materials = Config.Materials or {}
Config.Materials.Flat = Material("models/debug/debugwhite")
Config.Materials.Shiny = Material("models/shiny")

Config.Materials.Glow = CreateMaterial("pkscript_Glow", "VertexLitGeneric", {
	["$basetexture"] = "vgui/white_additive",
	["$bumpmap"] = "vgui/white_additive",

	["$ignorez"] = 0,

	["$selfillum"] = 1,
	["$selfillumFresnel"] = 1,
	["$selfillumFresnelMinMaxExp"] = "[0 1 1]",
	["$selfillumtint"] = "[0 0 0]"
})

Config.Materials.Jellyfish = CreateMaterial("pkscript_Jellyfish", "jellyfish", {
	["$basetexture"] = "models/effects/vol_light001",
	["$gradienttexture"] = "effects/bluelaser1",
	["$pulserate"] = 0.5
})

Config.Materials["Jellyfish (Static)"] = CreateMaterial("pkscript_StaticJellyfish", "jellyfish", {
	["$basetexture"] = "models/effects/vol_light001",
	["$gradienttexture"] = "effects/bluelaser1"
})

-- Players
Config.PlayerESP = Config.PlayerESP or {}
Config.PlayerESP.Enabled = pkscript.Util.ConfigDefault(Config.PlayerESP.Enabled, true)
Config.PlayerESP.IgnoreDormant = pkscript.Util.ConfigDefault(Config.PlayerESP.IgnoreDormant, false)
Config.PlayerESP.NameTags = pkscript.Util.ConfigDefault(Config.PlayerESP.NameTags, true)
Config.PlayerESP.FilterNameTags = pkscript.Util.ConfigDefault(Config.PlayerESP.FilterNameTags, true)
Config.PlayerESP.Weapons = pkscript.Util.ConfigDefault(Config.PlayerESP.Weapons, false)
Config.PlayerESP.Health = pkscript.Util.ConfigDefault(Config.PlayerESP.Health, false)
Config.PlayerESP.Bounds = pkscript.Util.ConfigDefault(Config.PlayerESP.Bounds, false)

Config.PlayerESP.OOF = Config.PlayerESP.OOF or {}
Config.PlayerESP.OOF.Enabled = pkscript.Util.ConfigDefault(Config.PlayerESP.OOF.Enabled, false)
Config.PlayerESP.OOF.Color = pkscript.Util.ConfigDefault(Config.PlayerESP.OOF.Color, "Red")
Config.PlayerESP.OOF.NameTags = pkscript.Util.ConfigDefault(Config.PlayerESP.OOF.NameTags, true)

Config.PlayerESP.ColoredModels = Config.PlayerESP.ColoredModels or {}
Config.PlayerESP.ColoredModels.Material = pkscript.Util.ConfigDefault(Config.PlayerESP.ColoredModels.Material, "Flat")
Config.PlayerESP.ColoredModels.Color = pkscript.Util.ConfigDefault(Config.PlayerESP.ColoredModels.Color, "White")
Config.PlayerESP.ColoredModels.Enabled = pkscript.Util.ConfigDefault(Config.PlayerESP.ColoredModels.Enabled, false)
Config.PlayerESP.ColoredModels.IgnoreZ = pkscript.Util.ConfigDefault(Config.PlayerESP.ColoredModels.IgnoreZ, false)
Config.PlayerESP.ColoredModels.Fullbright = pkscript.Util.ConfigDefault(Config.PlayerESP.ColoredModels.Fullbright, false)

-- Props
Config.PropESP = Config.PropESP or {}
Config.PropESP.Enabled = pkscript.Util.ConfigDefault(Config.PropESP.Enabled, true)
Config.PropESP.Bounds = pkscript.Util.ConfigDefault(Config.PropESP.Bounds, true) -- Actually hitboxes because props are dumb

Config.PropESP.ColoredModels = Config.PropESP.ColoredModels or {}
Config.PropESP.ColoredModels.Material = pkscript.Util.ConfigDefault(Config.PropESP.ColoredModels.Material, "Flat")
Config.PropESP.ColoredModels.Color = pkscript.Util.ConfigDefault(Config.PropESP.ColoredModels.Color, "Blue")
Config.PropESP.ColoredModels.Enabled = pkscript.Util.ConfigDefault(Config.PropESP.ColoredModels.Enabled, true)
Config.PropESP.ColoredModels.IgnoreZ = pkscript.Util.ConfigDefault(Config.PropESP.ColoredModels.IgnoreZ, false)
Config.PropESP.ColoredModels.Fullbright = pkscript.Util.ConfigDefault(Config.PropESP.ColoredModels.Fullbright, false)

-- Viewmodel
Config.Viewmodel = Config.Viewmodel or {}
Config.Viewmodel.Enabled = pkscript.Util.ConfigDefault(Config.Viewmodel.Enabled, true)

Config.Viewmodel.Hands = Config.Viewmodel.Hands or {}
Config.Viewmodel.Hands.Material = pkscript.Util.ConfigDefault(Config.Viewmodel.Hands.Material, "Shiny")
Config.Viewmodel.Hands.Color = pkscript.Util.ConfigDefault(Config.Viewmodel.Hands.Color, "Purple")
Config.Viewmodel.Hands.Enabled = pkscript.Util.ConfigDefault(Config.Viewmodel.Hands.Enabled, true)
Config.Viewmodel.Hands.Fullbright = pkscript.Util.ConfigDefault(Config.Viewmodel.Hands.Fullbright, true)

Config.Viewmodel.Weapon = Config.Viewmodel.Weapon or {}
Config.Viewmodel.Weapon.Material = pkscript.Util.ConfigDefault(Config.Viewmodel.Weapon.Material, "Jellyfish")
Config.Viewmodel.Weapon.Color = pkscript.Util.ConfigDefault(Config.Viewmodel.Weapon.Color, "White")
Config.Viewmodel.Weapon.Enabled = pkscript.Util.ConfigDefault(Config.Viewmodel.Weapon.Enabled, true)
Config.Viewmodel.Weapon.Fullbright = pkscript.Util.ConfigDefault(Config.Viewmodel.Weapon.Fullbright, false)

-- HUD
Config.HUD = Config.HUD or {}

Config.HUD.DebugInfo = Config.HUD.DebugInfo or {}
Config.HUD.DebugInfo.Enabled = pkscript.Util.ConfigDefault(Config.HUD.DebugInfo.Enabled, false)

Config.HUD.DebugInfo.Markup = [[
<font=%s>
Frame Rate:   %.0f (%.0f)
Frame Time:   %.4f
Lua Memory:   %s
Entity Cache: %u

LocalPlayer:  <color=255,255,0,255>%s</color>
Health:       %d
Armor:        %d
Velocity:     %.2f
Tick Base:    %d
Move Type:    <color=0,255,200,255>%s</color>

Weapon:       <color=255,255,0,255>%s</color>
Display Name: <color=0,255,200,255>%s</color>
Is Lua:       %s
Primary:      %s
Secondary:    %s

Vehicle:      <color=255,255,0,255>%s</color>
Class Name:   <color=0,255,200,255>%s</color>

Server:       <color=0,150,255,255>%s</color>
Name:         <color=0,255,200,255>%s</color>
Ping:         %u ms (%u ms)
Tick Rate:    %.1f / %.1f
CurTime:      %.6f
Network Time: %.6f
Time Delta:   %.6f
Time Scale:   %.2f
Timing Out:   %s (%s)
Time Delay:   %.6f

Look Entity:  <color=255,255,0,255>%s</color>
Class Name:   <color=0,255,200,255>%s</color>
Index:        %d
Hitbox:       %d
Hitgroup:     %d
Texture:      <color=0,255,200,255>%s</color>
Model:        <color=0,255,200,255>%s</color>
Material:     %d
</font>
]]

Config.HUD.Removals = Config.HUD.Removals or {}
Config.HUD.Removals.Enabled = pkscript.Util.ConfigDefault(Config.HUD.Removals.Enabled, true)

Config.HUD.Removals.Health = Config.HUD.Removals.Health or {}
Config.HUD.Removals.Health.Enabled = pkscript.Util.ConfigDefault(Config.HUD.Removals.Health.Enabled, false)

Config.HUD.Removals.Health.List = {
	["CHudHealth"] = true,
	["CHudBattery"] = true,
	["CHudGeiger"] = true
}

Config.HUD.Removals.Ammo = Config.HUD.Removals.Ammo or {}
Config.HUD.Removals.Ammo.Enabled = pkscript.Util.ConfigDefault(Config.HUD.Removals.Ammo.Enabled, false)

Config.HUD.Removals.Ammo.List = {
	["CHudAmmo"] = true,
	["CHudSecondaryAmmo"] = true
}

Config.HUD.Removals.DamageIndicator = Config.HUD.Removals.DamageIndicator or {}
Config.HUD.Removals.DamageIndicator.Enabled = pkscript.Util.ConfigDefault(Config.HUD.Removals.DamageIndicator.Enabled, true)

Config.HUD.Removals.DamageIndicator.List = {
	["CHudDamageIndicator"] = true,
	["CHudPoisonDamageIndicator"] = true
}

Config.HUD.Removals.Custom = Config.HUD.Removals.Custom or {}
Config.HUD.Removals.Custom.Enabled = pkscript.Util.ConfigDefault(Config.HUD.Removals.Custom.Enabled, false)

Config.HUD.Removals.Custom.List = {
	["CHudGMod"] = true
}

-- World
Config.World = Config.World or {}
Config.World.Nightmode = pkscript.Util.ConfigDefault(Config.World.Nightmode, true)

Config.World.FOVChanger = Config.World.FOVChanger or {}
Config.World.FOVChanger.Size = pkscript.Util.ConfigDefault(Config.World.FOVChanger.Size, "Normal")
Config.World.FOVChanger.Static = pkscript.Util.ConfigDefault(Config.World.FOVChanger.Static, false)
Config.World.FOVChanger.ScaleCalculations = pkscript.Util.ConfigDefault(Config.World.FOVChanger.ScaleCalculations, true)

Config.World.FOVChanger.Sizes = Config.World.FOVChanger.Sizes or {}
Config.World.FOVChanger.Sizes.Small = 54
Config.World.FOVChanger.Sizes.Normal = -1
Config.World.FOVChanger.Sizes.Big = 120
Config.World.FOVChanger.Sizes.Bigger = 160

function Visuals.SortEntities(A, B)
	return A:GetPos():DistToSqr(Visuals.LocalPlayerPos) > B:GetPos():DistToSqr(Visuals.LocalPlayerPos)
end

do
	local floor = math.floor
	local inf = math.huge
	local nan = 0 / 0
	local Vector = Vector

	function Visuals.GetCorners(Entity)
		local Mins, Maxs = Entity:GetCollisionBounds()
		Mins:Add(Entity:GetPos())
		Maxs:Add(Entity:GetPos())

		local Coords = {
			Mins,
			Vector(Mins.x, Maxs.y, Mins.z),
			Vector(Maxs.x, Maxs.y, Mins.z),
			Vector(Maxs.x, Mins.y, Mins.z),
			Maxs,
			Vector(Mins.x, Maxs.y, Maxs.z),
			Vector(Mins.x, Mins.y, Maxs.z),
			Vector(Maxs.x, Mins.y, Maxs.z)
		}

		local Left, Right, Top, Bottom = inf, -inf, inf, -inf

		for i = 1, #Coords do
			local Screen = Coords[i]:ToScreen()

			if not Screen.visible then
				return nan, nan, nan, nan
			end

			if Left > Screen.x then Left = Screen.x end
			if Right < Screen.x then Right = Screen.x end
			if Top > Screen.y then Top = Screen.y end
			if Bottom < Screen.y then Bottom = Screen.y end
		end

		return floor(Left), floor(Right), floor(Top), floor(Bottom)
	end
end

-- TODO: Localize stuff for ESP drawing

do
	-- TODO: This math is slightly wrong since it kind of uses 2D positioning meaning that if you're not on the same Z level it'll point up or down incorrectly
	-- I think that's probably more of an issue with PositionInView, idk
	local function DrawOOFArrow(Direction, X, Y, BaseWidth, BaseHeight, Color)
		-- https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/entities/widget_arrow.lua
		Cache.Materials.Arrow = Cache.Materials.Arrow or Material("widgets/arrow.png")

		local ArrowAngle = math.deg(math.atan2(-Direction.y, Direction.x))
		ArrowAngle = (ArrowAngle + 360) % 360 -- math.NormalizeAngle is -180 to 180 and makes it squish sometimes

		local FlipArrow = (ArrowAngle > 315 or ArrowAngle <= 45) or (ArrowAngle > 135 and ArrowAngle <= 225) -- Terrible manual checks yay
		local ArrowWidth, ArrowHeight

		if math.abs(Direction.x) > math.abs(Direction.y) then
			ArrowWidth = FlipArrow and BaseWidth or BaseHeight
			ArrowHeight = FlipArrow and BaseHeight or BaseWidth
		else
			ArrowWidth = FlipArrow and BaseHeight or BaseWidth
			ArrowHeight = FlipArrow and BaseWidth or BaseHeight
		end

		surface.SetMaterial(Cache.Materials.Arrow)
		surface.SetDrawColor(Color)
		surface.DrawTexturedRectRotated(X, Y, ArrowWidth, ArrowHeight, ArrowAngle - 90) -- -90 because the sprite faces up
	end

	function Visuals.PlayerESP2D(Player)
		if not Config.PlayerESP.Enabled then return end
		if Player == pkscript.LocalPlayer then return end -- TODO: LocalPlayer options ?

		if Config.PlayerESP.IgnoreDormant and Player:IsDormant() then return end
		if not Player:Alive() then return end

		local Text, TextWidth, TextHeight

		if not Player:IsDormant() then
			if Config.PlayerESP.OOF.Enabled then
				local Visible, Direction = pkscript.Util.PositionInView(Player:WorldSpaceCenter(), Cache.ViewSetup.ViewOrigin, Cache.ViewSetup.ViewAngles, Cache.ViewSetup.ViewFOV)

				if not Visible then
					local Radius = math.max(Cache.ScreenSetup.Width, Cache.ScreenSetup.Height) * 0.25 -- TODO: Better way of doing this

					local ArrowX = Cache.ScreenSetup.Center.x + (Direction.x * Radius)
					local ArrowY = Cache.ScreenSetup.Center.y + (Direction.y * Radius)

					DrawOOFArrow(Direction, ArrowX + 1, ArrowY + 1, 32, 100, pkscript.Colors.Black) -- Unoptimized outline
					DrawOOFArrow(Direction, ArrowX + 1, ArrowY - 1, 32, 100, pkscript.Colors.Black)
					DrawOOFArrow(Direction, ArrowX - 1, ArrowY + 1, 32, 100, pkscript.Colors.Black)
					DrawOOFArrow(Direction, ArrowX - 1, ArrowY - 1, 32, 100, pkscript.Colors.Black)
					DrawOOFArrow(Direction, ArrowX, ArrowY, 32, 100, ColorAlpha(pkscript.Colors[Config.PlayerESP.OOF.Color], 100)) -- EWWW ColorAlpha EWWWW

					if Config.PlayerESP.OOF.NameTags then
						Text = Player:GetName()

						if Config.PlayerESP.FilterNameTags then -- TODO: Might be a touch misleading that this acts based on a different section's config
							Text = pkscript.Util.ASCIIFilter(Text)
						end

						draw.SimpleTextOutlined(Text, Config.Fonts.NameTags, ArrowX, ArrowY, surface.GetTextColor(), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, pkscript.Colors.Black)
					end
				end
			end
		end

		local Left, Right, Top, Bottom = Visuals.GetCorners(Player)
		if Left ~= Left then return end

		if Config.PlayerESP.NameTags then
			surface.SetFont(Config.Fonts.NameTags)

			Text = Player:GetName()

			if Config.PlayerESP.FilterNameTags then
				Text = pkscript.Util.ASCIIFilter(Text)
			end

			TextWidth, TextHeight = surface.GetTextSize(Text)

			local CenterX = ((Left + Right) * 0.5) - (TextWidth * 0.5)

			draw.SimpleTextOutlined(Text, Config.Fonts.NameTags, CenterX, Top - TextHeight, surface.GetTextColor(), nil, nil, 1, pkscript.Colors.Black)
		end

		if Config.PlayerESP.Weapons then
			local Weapon = Player:GetActiveWeapon()

			if IsValid(Weapon) and Weapon:IsWeapon() then -- Some addons are retarded :/
				surface.SetFont(Config.Fonts.Weapons)

				Text = language.GetPhrase(Weapon:GetPrintName())
				TextWidth, TextHeight = surface.GetTextSize(Text)

				local CenterX = ((Left + Right) * 0.5) - (TextWidth * 0.5)

				draw.SimpleTextOutlined(Text, Config.Fonts.Weapons, CenterX, Bottom + TextHeight, surface.GetTextColor(), nil, nil, 1, pkscript.Colors.Black)

				--surface.SetTextPos(CenterX, Bottom + TextHeight)
				--surface.DrawText(Text)
			end
		end

		if Config.PlayerESP.Health then
			local MinHealth = Player:Health()
			local MaxHealth = Player:GetMaxHealth()

			local Percent = math.Clamp(MinHealth / MaxHealth, 0, 1)

			local HealthColor = pkscript.Colors.Red:Lerp(pkscript.Colors.Green, Percent)
			local HealthHeight = (Bottom - Top) * Percent

			surface.SetDrawColor(24, 24, 24, 255)
			surface.DrawRect(Left - 8, Top, 4, Bottom - Top)

			surface.SetDrawColor(HealthColor)
			surface.DrawRect(Left - 8, Bottom - HealthHeight, 4, HealthHeight)

			surface.SetDrawColor(0, 0, 0, 255)
			surface.DrawOutlinedRect(Left - 8, Top, 4, Bottom - Top)
		end
	end
end

function Visuals.PropESP2D(Prop)
	-- TODO: ?
end

do
	local StdFrameRate = 0
	local FrameRateTime = 0
	local FrameRateAmount = 0
	local FrameRateCounter = 0

	function Visuals.DebugInfo()
		if not Config.HUD.DebugInfo.Enabled then return end

		local Weapon = pkscript.LocalPlayer:GetActiveWeapon()

		local WeaponName = pkscript.Util.CallOnValid("N/A", Weapon, "GetPrintName")
		WeaponName = language.GetPhrase(WeaponName)

		local Vehicle = pkscript.LocalPlayer:GetVehicle()

		-- Some weapons (toolgun) make empty sound when checking CanPrimary/SecondaryAttack :/
		local NextPrimaryFire = pkscript.Util.CallOnValid(math.huge, Weapon, "GetNextPrimaryFire")
		local NextSecondaryFire = pkscript.Util.CallOnValid(math.huge, Weapon, "GetNextSecondaryFire")

		local ServerTime = pkscript.Util.GetServerTime()
		local FrameTime = RealFrameTime()
		local FrameRate = 1 / FrameTime
		local CurrentTime = CurTime()
		local TimeDelta = math.abs(ServerTime - CurrentTime)

		FrameRateAmount = FrameRateAmount + 1

		-- FrameRate that doesn't jump all over the place constantly so it's actually readable
		if CurrentTime - FrameRateTime >= 1 then
			StdFrameRate = FrameRateCounter / FrameRateAmount

			FrameRateTime = CurrentTime
			FrameRateAmount = 0
			FrameRateCounter = 0
		end

		FrameRateCounter = FrameRateCounter + FrameRate

		local Ping = pkscript.LocalPlayer:Ping()
		local TimingOut, TimeoutPing = GetTimeoutInfo()
		local ProbablyTimingOut = TimeoutPing > Ping / 1000

		local EyeTrace = pkscript.LocalPlayer:GetEyeTrace()

		local Markup = Format(
			Config.HUD.DebugInfo.Markup,

			Config.Fonts.DebugInfo,

			FrameRate,
			StdFrameRate,
			FrameTime,
			string.NiceSize(collectgarbage("count")),
			#Visuals.EntityCache,

			pkscript.Util.AddressOf(pkscript.LocalPlayer),
			pkscript.LocalPlayer:Health(),
			pkscript.LocalPlayer:Armor(),
			pkscript.LocalPlayer:GetVelocity():Length(),
			pkscript.LocalPlayer:GetInternalVariable("m_nTickBase"),
			pkscript.MoveTypes[pkscript.LocalPlayer:GetMoveType()] or "Unknown",

			pkscript.Util.AddressOf(Weapon),
			WeaponName,
			pkscript.Util.MarkupBool(pkscript.Util.CallOnValid(false, Weapon, "IsScripted")),
			pkscript.Util.MarkupBool(NextPrimaryFire < ServerTime),
			pkscript.Util.MarkupBool(NextSecondaryFire < ServerTime),

			pkscript.Util.AddressOf(Vehicle),
			pkscript.Util.CallOnValid("N/A", Vehicle, "GetClass"),

			game.GetIPAddress(),
			GetHostName(),
			Ping,
			TimeDelta * 1000,
			math.Clamp(1 / engine.ServerFrameTime(), 0, pkscript.InverseTickInterval),
			pkscript.InverseTickInterval,
			CurrentTime,
			ServerTime,
			TimeDelta,
			game.GetTimeScale() * pkscript.ConVars.host_timescale:GetFloat(),
			pkscript.Util.MarkupBool(TimingOut),
			pkscript.Util.MarkupBool(ProbablyTimingOut),
			TimeoutPing,

			pkscript.Util.AddressOf(EyeTrace.Entity),
			pkscript.Util.CallOnValid("N/A", EyeTrace.Entity, "GetClass"),
			pkscript.Util.CallOnValid(0, EyeTrace.Entity, "EntIndex"),
			EyeTrace.HitBox or -1,
			EyeTrace.HitGroup or -1,
			EyeTrace.HitTexture or "N/A",
			pkscript.Util.CallOnValid("N/A", EyeTrace.Entity, "GetModel"),
			EyeTrace.MatType or 0 -- The wiki says this defaults to 0, it's wrong
		)

		markup.Parse(Markup):Draw(10, 175)
	end
end

function Visuals.ESP2D()
	if #Visuals.CurrentEntities < 1 then return end -- Nothing!

	cam.Start2D() -- Fix PostDrawHUD sucking
	do
		for i = 1, #Visuals.CurrentEntities do
			local Entity = Visuals.CurrentEntities[i]

			if Entity:IsDormant() then
				surface.SetTextColor(150, 150, 150, 255)
			else
				surface.SetTextColor(255, 255, 255, 255)
			end

			if Entity:IsPlayer() then -- TODO: This will need expanded if/when entity classes are expanded
				Visuals.PlayerESP2D(Entity)
			else
				Visuals.PropESP2D(Entity)
			end
		end

		Visuals.DebugInfo()
	end
	cam.End2D()
end

function Visuals.PlayerRenderOverride(Player, Flags) -- Always runs if Colored Models are enabled, no need to check it here
	if bit.band(Flags, STUDIO_RENDER) ~= STUDIO_RENDER then return end
	if Player:IsDormant() then return end

	if not Config.PlayerESP.Enabled then -- In case ESP was disabled but Colored Models werent
		Player:DrawModel()
		return
	end

	if Config.PlayerESP.ColoredModels.IgnoreZ then
		cam.IgnoreZ(true)
	end

	local Material = Config.Materials[Config.PlayerESP.ColoredModels.Material]

	if Config.PlayerESP.ColoredModels.Fullbright then
		render.SuppressEngineLighting(true)
	end

	render.MaterialOverride(Config.Materials[Config.PlayerESP.ColoredModels.Material])

	local Color = pkscript.Colors[Config.PlayerESP.ColoredModels.Color]
	render.SetColorModulation(Color.r / 255, Color.g / 255, Color.b / 255)

	Player:DrawModel()

	render.SetColorModulation(1, 1, 1)
	render.MaterialOverride(nil)
	render.SuppressEngineLighting(false)

	cam.IgnoreZ(false)
end

function Visuals.PlayerESP3D(Player)
	if not Config.PlayerESP.Enabled then return end
	if Player == pkscript.LocalPlayer then return end -- TODO: LocalPlayer options ?

	if not Player:Alive() then return end
	if Player:IsDormant() then return end

	if Config.PlayerESP.Bounds then
		local Mins, Maxs = Player:GetCollisionBounds()

		render.DrawWireframeBox(Player:GetPos(), angle_zero, Mins, Maxs, color_white, false)
	end

	if Config.PlayerESP.ColoredModels.Enabled then
		Player.RenderOverride = Visuals.PlayerRenderOverride
	else
		-- TODO: This has the possibility to break some things
		Player.RenderOverride = nil
	end
end

function Visuals.PropRenderOverride(Prop, Flags)
	if bit.band(Flags, STUDIO_RENDER) ~= STUDIO_RENDER then return end
	if Prop:IsDormant() then return end

	if not Config.PropESP.Enabled then
		Prop:DrawModel()
		return
	end

	if Config.PropESP.ColoredModels.IgnoreZ then
		cam.IgnoreZ(true)
	end

	if Config.PropESP.ColoredModels.Fullbright then
		render.SuppressEngineLighting(true)
	end

	render.MaterialOverride(Config.Materials[Config.PropESP.ColoredModels.Material])

	local Color = pkscript.Colors[Config.PropESP.ColoredModels.Color]
	render.SetColorModulation(Color.r / 255, Color.g / 255, Color.b / 255)

	Prop:DrawModel()

	render.SetColorModulation(1, 1, 1)
	render.MaterialOverride(nil)
	render.SuppressEngineLighting(false)

	cam.IgnoreZ(false)
end

function Visuals.PropESP3D(Prop)
	if not Config.PropESP.Enabled then return end

	if Prop:IsDormant() then return end

	if Config.PropESP.Bounds then
		local DrewHitboxes = false
		local HitboxSets = Prop:GetHitboxSetCount()

		for Set = 0, HitboxSets - 1 do
			local Hitboxes = Prop:GetHitBoxCount(Set)

			for Hitbox = 0, Hitboxes - 1 do
				local Bone = Prop:GetHitBoxBone(Hitbox, Set)

				if Bone then
					local Origin, Angles
					local Matrix = Prop:GetBoneMatrix(Bone)

					if Matrix then
						Origin = Matrix:GetTranslation()
						Angles = Matrix:GetAngles()
					else
						Origin, Angles = Prop:GetBonePosition(Bone)
					end

					local Mins, Maxs = Prop:GetHitBoxBounds(Hitbox, Set)

					if Mins and Maxs then
						DrewHitboxes = true

						render.DrawWireframeBox(Origin, Angles, Mins, Maxs, color_white, false)
					end
				end
			end
		end

		if not DrewHitboxes then -- Fallback to regular bounds if it has no hitboxes
			local Mins, Maxs = Prop:GetCollisionBounds()

			render.DrawWireframeBox(Prop:GetPos(), Prop:GetAngles(), Mins, Maxs, color_white, false)
		end
	end

	if Config.PropESP.ColoredModels.Enabled then
		Prop.RenderOverride = Visuals.PropRenderOverride
	else
		-- TODO: This has the possibility to break some things
		Prop.RenderOverride = nil
	end
end

function Visuals.ESP3D()
	for i = 1, #Visuals.CurrentEntities do
		local Entity = Visuals.CurrentEntities[i]

		if Entity:IsPlayer() then
			Visuals.PlayerESP3D(Entity)
		else
			Visuals.PropESP3D(Entity)
		end
	end
end

function Visuals.PreDrawViewModel()
	if not Config.Viewmodel.Enabled then return end

	if not Config.Viewmodel.Weapon.Enabled then
		render.MaterialOverride(nil)
		render.SetColorModulation(1, 1, 1)

		return
	end

	if Config.Viewmodel.Weapon.Fullbright then
		render.SuppressEngineLighting(true)
	end

	render.MaterialOverride(Config.Materials[Config.Viewmodel.Weapon.Material])

	local Color = pkscript.Colors[Config.Viewmodel.Weapon.Color]
	render.SetColorModulation(Color.r / 255, Color.g / 255, Color.b / 255)
end

function Visuals.PostDrawViewModel()
	if not Config.Viewmodel.Enabled then return end

	if not Config.Viewmodel.Weapon.Enabled then
		return
	end

	render.SetColorModulation(1, 1, 1)
	render.MaterialOverride(nil)
	render.SuppressEngineLighting(false)
end

function Visuals.PreDrawPlayerHands()
	if not Config.Viewmodel.Enabled then return end

	if not Config.Viewmodel.Hands.Enabled then
		render.MaterialOverride(nil)
		render.SetColorModulation(1, 1, 1)

		return
	end

	if Config.Viewmodel.Hands.Fullbright then
		render.SuppressEngineLighting(true)
	end

	render.MaterialOverride(Config.Materials[Config.Viewmodel.Hands.Material])

	local Color = pkscript.Colors[Config.Viewmodel.Hands.Color]
	render.SetColorModulation(Color.r / 255, Color.g / 255, Color.b / 255)
end

function Visuals.PostDrawPlayerHands()
	if not Config.Viewmodel.Enabled then return end

	if not Config.Viewmodel.Hands.Enabled then
		return
	end

	render.SetColorModulation(1, 1, 1)
	render.MaterialOverride(nil)
	render.SuppressEngineLighting(false)
end

do -- Nightmode
	local LastState = false
	Cache.Materials.World = Cache.Materials.World or {}

	local function CacheWorld()
		if not table.IsEmpty(Cache.Materials.World) then
			return
		end

		local MaterialCache = Cache.Materials.World
		local Materials = game.GetWorld():GetMaterials()

		for i = 1, #Materials do
			local Name = Materials[i]

			if not MaterialCache[Name] then
				MaterialCache[Name] = {}

				local Material = Material(Name)

				MaterialCache[Name].Material = Material
				MaterialCache[Name].Color = Material:GetVector("$color")
			end
		end
	end

	local function Reset()
		CacheWorld()

		for _, Data in next, Cache.Materials.World do
			Data.Material:SetVector("$color", Data.Color)
		end
	end

	local function Setup()
		CacheWorld()

		local Dark = Color(50, 50, 50, 255):ToVector()

		for _, Data in next, Cache.Materials.World do
			Data.Material:SetVector("$color", Dark)
		end
	end

	function Visuals.Nightmode()
		if not Config.World.Nightmode then
			if LastState then
				Reset()
			end

			LastState = false

			return
		end

		if not LastState then
			Setup()
		end

		LastState = true
	end
end

do
	local View = {}

	function Visuals.FOVChanger(Player, Origin, Angles, FOV, ZNear, ZFar)
		local Size = Config.World.FOVChanger.Sizes[Config.World.FOVChanger.Size]
		if Size == -1 then return end

		local Weapon = Player:GetActiveWeapon()

		if isfunction(Weapon.CalcView) then
			Origin, Angles, FOV = Weapon:CalcView(Player, Origin, Angles, FOV)
		end

		if Config.World.FOVChanger.Static then
			FOV = Size
		else
			local Offset = pkscript.ConVars.fov_desired:GetInt() - Size
			FOV = FOV - Offset
		end

		View.origin = Origin
		View.angles = Angles
		View.fov = FOV
		View.znear = ZNear
		View.zfar = ZFar

		if Config.World.FOVChanger.ScaleCalculations then
			Player:SetFOV(FOV) -- Set the FOV for clientside calculations (Like sensitivity)
		end

		return View
	end
end

function Visuals.HandleRemovals(Name)
	if not Config.HUD.Removals.Enabled then return end

	if Config.HUD.Removals.Health.Enabled and Config.HUD.Removals.Health.List[Name] then return false end
	if Config.HUD.Removals.Ammo.Enabled and Config.HUD.Removals.Ammo.List[Name] then return false end
	if Config.HUD.Removals.DamageIndicator.Enabled and Config.HUD.Removals.DamageIndicator.List[Name] then return false end
	if Config.HUD.Removals.Custom.Enabled and Config.HUD.Removals.Custom.List[Name] then return false end
end

function Visuals.PrepareEntityCache()
	Visuals.CurrentEntities = {}

	for i = 1, #Visuals.EntityCache do -- Copy that can be sorted
		Visuals.CurrentEntities[#Visuals.CurrentEntities + 1] = Visuals.EntityCache[i]
	end

	Visuals.LocalPlayerPos = pkscript.LocalPlayer:GetPos()
	table.sort(Visuals.CurrentEntities, Visuals.SortEntities)
end

function Visuals.UpdateCacheIndices()
	for i = 1, #Visuals.EntityCache do
		Visuals.EntityCacheKeys[Visuals.EntityCache[i]] = i
	end
end

function Visuals.CacheEntity(Entity)
	if Visuals.EntityCacheKeys[Entity] then return end

	if Visuals.EntityClasses[Entity:GetClass()] then
		Visuals.EntityCacheKeys[Entity] = table.insert(Visuals.EntityCache, Entity)
	end
end

function Visuals.UnCacheEntity(Entity)
	if not Visuals.EntityCacheKeys[Entity] then return end

	Entity.RenderOverride = nil -- TODO: This has the possibility to break some things

	table.remove(Visuals.EntityCache, Visuals.EntityCacheKeys[Entity])
	Visuals.EntityCacheKeys[Entity] = nil

	-- table.remove shifts the indices
	Visuals.UpdateCacheIndices()
end

function Visuals.WipeEntityCache()
	for Entity, _ in next, Visuals.EntityCacheKeys do
		Visuals.UnCacheEntity(Entity)
	end
end

pkscript.Hooks.Register("PreRender", Visuals.PrepareEntityCache)
pkscript.Hooks.Register("PostDrawHUD", Visuals.ESP2D)
pkscript.Hooks.Register("PreDrawEffects", Visuals.ESP3D)
pkscript.Hooks.Register("PreDrawViewModel", Visuals.PreDrawViewModel)
pkscript.Hooks.Register("PostDrawViewModel", Visuals.PostDrawViewModel)
pkscript.Hooks.Register("PreDrawPlayerHands", Visuals.PreDrawPlayerHands)
pkscript.Hooks.Register("PostDrawPlayerHands", Visuals.PostDrawPlayerHands)
pkscript.Hooks.Register("RenderScene", Visuals.Nightmode)
pkscript.Hooks.Register("CalcView", Visuals.FOVChanger)
pkscript.Hooks.Register("HUDShouldDraw", Visuals.HandleRemovals)
pkscript.Hooks.Register("OnEntityCreated", Visuals.CacheEntity)
pkscript.Hooks.Register("NetworkEntityCreated", Visuals.CacheEntity) -- Should be unnecessary, but doesn't hurt
pkscript.Hooks.Register("EntityRemoved", Visuals.UnCacheEntity)
pkscript.Hooks.Register("PKScript:Unload", Visuals.WipeEntityCache)

-- Initial cache
do
	for _, Entity in ents.Iterator() do
		Visuals.CacheEntity(Entity)
	end
end
