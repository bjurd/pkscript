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
	if isentity(Object) and not Object:IsValid() then
		return "0x00000000"
	end

	return Format("0x%X", tonumber(string.match(Format("%p", Object), "0x(%x+)"), 16))
end

function pkscript.Util.CallOnValid(Default, Object, FunctionName, ...)
	if not IsValid(Object) then
		return Default
	end

	local Function = Object[FunctionName]

	if not isfunction(Function) then
		return Default
	end

	return Function(Object, ...)
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
