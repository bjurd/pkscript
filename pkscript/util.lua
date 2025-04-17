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
