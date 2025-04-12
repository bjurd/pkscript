pkscript.Util = pkscript.Util or {}

-- Same as _G.Either but checks nil instead of falsy
function pkscript.Util.Either(C, A, B)
	if C == nil then return B else return A end
end

function pkscript.Util.ConfigDefault(C, A)
	return pkscript.Util.Either(C, C, A)
end
