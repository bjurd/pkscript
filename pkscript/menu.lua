pkscript.Menu = pkscript.Menu or {}
local Menu = pkscript.Menu

Menu.Font = "DebugOverlay" -- Default

include("pkscript/menu/base.lua")
include("pkscript/menu/frame.lua")
include("pkscript/menu/option.lua")

function Menu.Destroy()
	Menu.Close()

	if IsValid(Menu.Instance) then
		Menu.Instance:Remove()
		Menu.Instance = nil
	end
end

function Menu.Setup()
	Menu.Destroy()

	local Instance = vgui.Create("pkscript_Frame")

	if not IsValid(Instance) then
		return false
	end

	Instance:SetWidth(ScreenScale(100))
	Instance:SetHeight(ScreenScaleH(250))

	Menu.Instance = Instance

	Menu.Build()
	Menu.Close() -- Start hidden

	return true
end

function Menu.Open()
	if not IsValid(Menu.Instance) and not Menu.Setup() then
		error("Failed to create menu!")
		return
	end

	Menu.Instance:Show()
	Menu.Instance:MakePopup()
end

function Menu.Close()
	if not IsValid(Menu.Instance) then return end

	Menu.Instance:Hide()
end

function Menu.Toggle()
	if not IsValid(Menu.Instance) and not Menu.Setup() then
		error("Failed to create menu!")
		return
	end

	if Menu.Instance:IsVisible() then
		Menu.Close()
	else
		Menu.Open()
	end
end

concommand.Add("pkscript_menu", Menu.Toggle)
