pkscript.Util = pkscript.Util or {}

pkscript.Util.TraceResult = pkscript.Util.TraceResult or {}
pkscript.Util.TraceData = pkscript.Util.TraceData or {}
pkscript.Util.TraceData.output = pkscript.Util.TraceResult

-- Same as _G.Either but checks nil instead of falsy
function pkscript.Util.Either(C, A, B)
	if C == nil then return B else return A end
end

function pkscript.Util.ConfigDefault(C, A)
	return pkscript.Util.Either(C, C, A)
end

function pkscript.Util.ResetTrace() -- Ugly >:/
	local TraceData = pkscript.Util.TraceData

	TraceData.start = nil
	TraceData.endpos = nil
	TraceData.mins = nil
	TraceData.maxs = nil
	TraceData.filter = nil
	TraceData.mask = nil
	TraceData.collisiongroup = nil
	TraceData.ignoreworld = nil
	TraceData.whitelist = nil
	TraceData.hitclientonly = nil

	return TraceData
end

function pkscript.Util.RunTrace()
	if isvector(pkscript.Util.TraceData.mins) then
		util.TraceHull(pkscript.Util.TraceData)
	else
		util.TraceLine(pkscript.Util.TraceData)
	end

	return pkscript.Util.TraceResult
end

function pkscript.Util.AddressOf(Object)
	local Address = string.sub(Format("%p", Object), 3)

	if isentity(Object) and Object ~= game.GetWorld() and not Object:IsValid() then
		Address = string.gsub(Address, "%x", "0")
	end

	return Format("0x%s", string.upper(Address))
end

function pkscript.Util.CallOnValid(Default, Object, FunctionName, ...)
	if Object ~= game.GetWorld() and not IsValid(Object) then
		return Default
	end

	local Function = Object[FunctionName]

	if not isfunction(Function) then
		return Default
	end

	local Result = Function(Object, ...)

	if Result == nil then
		return Default
	else
		return Result
	end
end

function pkscript.Util.BoolToString(Bool)
	return Bool and "Yes" or "No"
end

function pkscript.Util.MarkupBool(Bool)
	local Color = Bool and pkscript.Colors.Green or pkscript.Colors.Red

	return Format(
		"<color=%s>%s</color>",
		markup.Color(Color),
		pkscript.Util.BoolToString(Bool)
	)
end

function pkscript.Util.ASCIIFilter(String)
	return string.gsub(String, "[^\32-\126]", "?")
end

function pkscript.Util.TicksToTime(Ticks)
	return Ticks * pkscript.TickInterval
end

function pkscript.Util.GetServerTime()
	return pkscript.Util.TicksToTime(pkscript.LocalPlayer:GetInternalVariable("m_nTickBase"))
end

function pkscript.Util.PositionInView(Position, ViewOrigin, ViewAngles, ViewFOV)
	if ViewFOV <= 0 then
		ViewFOV = 360
	end

	local ViewForward = ViewAngles:Forward()
	local ViewRight = ViewAngles:Right()
	local ViewUp = ViewAngles:Up()

	local Direction = Position - ViewOrigin
	Direction:Normalize()

	local Dot = ViewForward:Dot(Direction)
	local Adjusted = math.cos(math.rad(ViewFOV) * 0.5)

	local OffsetX = ViewRight:Dot(Direction)
	local OffsetY = ViewUp:Dot(Direction)

	local ScreenDir = Vector(OffsetX, -OffsetY, 0)
	ScreenDir:Normalize()

	return Dot >= Adjusted, ScreenDir
end
