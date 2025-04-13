pkscript.Hooks = pkscript.Hooks or {}
local Hooks = pkscript.Hooks

Hooks.List = Hooks.List or {}
Hooks.CallbackList = Hooks.CallbackList or {}

function Hooks.Run(Type, ...)
	local List = Hooks.List[Type]

	if not List then -- Don't istable for performance sake
		return
	end

	local a, b, c, d, e, f

	for i = 1, #List do
		a, b, c, d, e, f = List[i](...)

		if a ~= nil then
			return a, b, c, d, e, f
		end
	end

	return nil
end

function Hooks.Register(Type, Callback)
	local List = Hooks.List[Type]
	local CallbackList = Hooks.CallbackList[Type]

	if not istable(List) then
		List = {}
		Hooks.List[Type] = List

		hook.Add(Type, "pkscript", function(...)
			return Hooks.Run(Type, ...)
		end)
	end

	if not istable(CallbackList) then
		CallbackList = {}
		Hooks.CallbackList[Type] = CallbackList
	end

	CallbackList[Callback] = table.insert(List, Callback)
end

function Hooks.UnRegister(Type, Callback)
	local List = Hooks.List[Type]
	local CallbackList = Hooks.CallbackList[Type]

	if not istable(List) or not istable(CallbackList) then
		return
	end

	local Index = CallbackList[Callback]

	table.remove(List, Index)
	CallbackList[Callback] = nil

	if #List < 1 then
		hook.Remove(Type, "pkscript")

		Hooks.List[Type] = nil
		Hooks.CallbackList[Type] = nil
	end
end

function Hooks.UnRegisterAll()
	for Type, List in next, Hooks.List do
		for i = #List, 1, -1 do
			Hooks.UnRegister(Type, List[i])
		end
	end
end
