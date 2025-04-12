pkscript.Movement = pkscript.Movement or {}
local Movement = pkscript.Movement

Movement.Config = Movement.Config or {}
local Config = Movement.Config

Config.AutoStrafe = pkscript.Util.ConfigDefault(Config.AutoStrafe, true) -- TODO: Make this modes instead of on/off
Config.BunnyHop = pkscript.Util.ConfigDefault(Config.BunnyHop, true)
Config.QuickStop = pkscript.Util.ConfigDefault(Config.QuickStop, true)

do -- AutoStrafe
	local LastFacing = pkscript.LocalPlayer:EyeAngles()

	function Movement.RageStrafe(Command)
		if not Command:KeyDown(IN_JUMP) then return end

		local Facing = Command:GetViewAngles()
		local SideSpeed = pkscript.ConVars.cl_sidespeed:GetFloat()

		if Facing.yaw > LastFacing.yaw then
			Command:SetSideMove(-SideSpeed)
		elseif Facing.yaw < LastFacing.yaw then
			Command:SetSideMove(SideSpeed)
		end

		LastFacing = Facing
	end

	function Movement.AutoStrafe(Command)
		if not Config.AutoStrafe then return end

		-- TODO: Other strafe modes
		Movement.RageStrafe(Command)
	end
end

do -- Bunny Hop
	local LastGrounded
	local GroundedTicks = 0

	function Movement.BunnyHop(Command)
		local Grounded = pkscript.LocalPlayer:IsOnGround()

		if Config.BunnyHop then
			if Command:KeyDown(IN_JUMP) and not Grounded then
				GroundedTicks = 0

				Command:RemoveKey(IN_JUMP)
			elseif LastGrounded and Grounded then
				GroundedTicks = GroundedTicks + 1

				if GroundedTicks > 2 then -- Prevent getting stuck (sv_sticktoground & slopes)
					GroundedTicks = 0

					Command:RemoveKey(IN_JUMP)
				end
			end
		else
			GroundedTicks = 0
		end

		LastGrounded = Grounded
	end
end

function Movement.QuickStop(Command)
	if not Config.QuickStop then return end

	if pkscript.LocalPlayer:IsOnGround() and Command:GetForwardMove() == 0 and Command:GetSideMove() == 0 then
		local Velocity = pkscript.LocalPlayer:GetVelocity()

		local Angles = Velocity:Angle()
		Angles.yaw = Command:GetViewAngles().yaw - Angles.yaw

		local NewMove = Angles:Forward()
		NewMove:Mul(Velocity:Length2D())

		Command:SetForwardMove(-NewMove.x)
		Command:SetSideMove(-NewMove.y)
	end
end

function Movement.CreateMove(Command)
	Movement.AutoStrafe(Command)
	Movement.BunnyHop(Command)
	Movement.QuickStop(Command)
end

pkscript.Hooks.Register("CreateMove", Movement.CreateMove)
