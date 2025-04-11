pkscript.Movement = pkscript.Movement or {}
local Movement = pkscript.Movement

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
		-- TODO: Other strafe modes
		Movement.RageStrafe(Command)
	end
end

do -- Bunny Hop
	local LastGrounded
	local GroundedTicks = 0

	function Movement.BunnyHop(Command)
		local Grounded = pkscript.LocalPlayer:IsOnGround()

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

		LastGrounded = Grounded
	end
end

function Movement.CreateMove(Command)
	Movement.AutoStrafe(Command)
	Movement.BunnyHop(Command)
end

pkscript.Hooks.Register("CreateMove", Movement.CreateMove)
