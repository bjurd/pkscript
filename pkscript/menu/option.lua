local PANEL = {}

AccessorFunc(PANEL, "m_strFont", "Font", FORCE_STRING)
AccessorFunc(PANEL, "m_colText", "TextColor", FORCE_COLOR)
AccessorFunc(PANEL, "m_strText", "Text", FORCE_STRING)
AccessorFunc(PANEL, "m_pVarTable", "VarTable")
AccessorFunc(PANEL, "m_strVarKey", "VarKey", FORCE_STRING)
AccessorFunc(PANEL, "m_iVarType", "VarType", FORCE_NUMBER)
AccessorFunc(PANEL, "m_pTopOption", "TopOption")
AccessorFunc(PANEL, "m_bOpen", "Open", FORCE_BOOL)

function PANEL:Init()
	self:SetTall(ScreenScaleH(16))
	self:DockMargin(-1, -1, -1, -1) -- Stop funky double borders

	self:SetFont(pkscript.Menu.Font)
	self:SetTextColor(color_white)
	self:SetText("Option")

	self:SetVarKey("")
	self:SetVarType(TYPE_NIL)

	self:SetOpen(false)

	self.m_pSubOptions = {}
	self.m_pSubOptionKeys = {}
end

function PANEL:GetSubOptions()
	return self.m_pSubOptions
end

function PANEL:GetSubOptionKeys()
	return self.m_pSubOptionKeys
end

function PANEL:GetSubOptionIndex(SubOption)
	return self:GetSubOptionKeys()[SubOption] or -1
end

function PANEL:OnRemove()
	local SubOptions = self:GetSubOptions()
	local SubOptionKeys = self:GetSubOptionKeys()

	for i = #SubOptions, 1, -1 do -- Not actual children
		local SubOption = SubOptions[i]
		SubOption:Remove()

		table.remove(SubOptions, i) -- This makes SubOptionKeys out of sync, but it's okay since everything is being trashed
		SubOptionKeys[SubOption] = nil
	end
end

function PANEL:PaintBackground(Width, Height)
	surface.SetDrawColor(0, 0, 0, 255)
	surface.DrawOutlinedRect(0, 0, Width, Height)

	if self:HasFocus() or self:GetOpen() then
		surface.SetDrawColor(self:GetAccentColor())
	else
		surface.SetDrawColor(24, 24, 24, 255)
	end

	surface.DrawRect(1, 1, Width - 2, Height - 2)
end

function PANEL:PaintForeground(Width, Height)
	local HasSubOptions = #self.m_pSubOptions > 0

	surface.SetFont(self:GetFont())
	surface.SetTextColor(self:GetTextColor())

	if not HasSubOptions and self:GetVarType() == TYPE_BOOL then
		local VarTable = self:GetVarTable()

		if VarTable then
			if VarTable[self:GetVarKey()] then
				surface.SetTextColor(pkscript.Colors.Green)
			else
				surface.SetTextColor(pkscript.Colors.Red)
			end
		end
	end

	local Text = self:GetText()
	local TextWidth, TextHeight = surface.GetTextSize(Text)

	surface.SetTextPos((Width * 0.5) - (TextWidth * 0.5), (Height * 0.5) - (TextHeight * 0.5))
	surface.DrawText(Text)

	-- Use reference for performance sake
	if HasSubOptions then
		if self:GetOpen() then
			Text = "<-"
		else
			Text = "->"
		end

		TextWidth, TextHeight = surface.GetTextSize(Text)

		surface.SetTextPos(Width - (TextWidth * 2), (Height * 0.5) - (TextHeight * 0.5))
		surface.DrawText(Text)
	end
end

function PANEL:AddSubOption(Label, Table, Key, Type)
	local Option = vgui.Create("pkscript_Option")

	if not IsValid(Option) then
		error("Failed to create option!")
		return nil
	end

	Option:SetZPos(#self:GetSubOptions() + 1)

	Option:SetFont(self:GetFont())
	Option:SetText(Label)

	Option:SetVarTable(Table)
	Option:SetVarKey(Key)
	Option:SetVarType(Type)
	Option:SetTopOption(self)

	Option:Hide()

	self:GetSubOptionKeys()[Option] = table.insert(self:GetSubOptions(), Option)

	return Option
end

function PANEL:FocusTop()
	local Top = self:GetTopOption()

	if IsValid(Top) then
		Top:RequestFocus()

		return Top
	else
		Top = self:GetParent()

		if IsValid(Top) then
			Top:RequestFocus()
		end
	end

	return nil
end

function PANEL:OpenConfiguration()
	-- TODO: Support things other than booleans and give them their own menu

	if self:GetVarType() == TYPE_BOOL then
		local VarTable = self:GetVarTable()

		if istable(VarTable) then
			local VarKey = self:GetVarKey()

			VarTable[VarKey] = not VarTable[VarKey]
		end
	end

	self:SetOpen(false) -- TODO: Side-effect of the temporary boolean-only thing
end

function PANEL:CloseConfiguration()
	-- TODO:
end

function PANEL:Open()
	self:SetOpen(true)

	local SubOptions = self:GetSubOptions()

	if #SubOptions < 1 then
		self:OpenConfiguration()

		return
	end

	-- Show sub-options

	local Width, Height = self:GetSize()
	local ScreenX, ScreenY = self:LocalToScreen(Width, 0)

	ScreenX = ScreenX - 1 -- Prevent double border

	for i = 1, #SubOptions do
		local SubOption = SubOptions[i]

		SubOption:SetSize(Width, Height)
		SubOption:SetPos(ScreenX, ScreenY)
		SubOption:MakePopup() -- Because MoveToFront doesn't work for some reason
		SubOption:Show()

		ScreenY = ScreenY + (Height - 1) -- Prevent double borders
	end

	SubOptions[1]:MakePopup()
end

function PANEL:Close()
	self:SetOpen(false)

	local SubOptions = self:GetSubOptions()

	if #SubOptions < 1 then
		self:CloseConfiguration()
		self:FocusTop()

		return
	end

	for i = 1, #SubOptions do
		SubOptions[i]:Close()
		SubOptions[i]:Hide()
	end

	self:FocusTop()
end

function PANEL:OnKeyCodePressed(Key)
	if pkscript.Menu.IsMenuKey(Key) then
		pkscript.Menu.Close()
		return
	end

	if Key == KEY_UP or Key == KEY_DOWN then
		local LastFocus = vgui.GetKeyboardFocus()

		local SubOptions = self:GetSubOptions()
		local SubOptionKeys = self:GetSubOptionKeys()

		if IsValid(LastFocus) and SubOptionKeys[LastFocus] then
			local Index = SubOptionKeys[LastFocus]

			if Key == KEY_UP then Index = Index - 1 end
			if Key == KEY_DOWN then Index = Index + 1 end

			if Index < 1 then Index = #SubOptions end -- Rollover clamp
			if Index > #SubOptions then Index = 1 end

			local FocusOption = SubOptions[Index]

			if IsValid(FocusOption) then
				FocusOption:MakePopup()
			end
		else
			local Top = self:FocusTop()

			if IsValid(Top) then -- Pass through to non-parent
				Top:OnKeyCodePressed(Key)
			end
		end
	elseif Key == KEY_RIGHT then
		self:Open()
	elseif Key == KEY_LEFT then
		if self:GetOpen() then
			self:Close()
		else
			local Top = self:FocusTop()

			if IsValid(Top) then
				Top:OnKeyCodePressed(Key)
			end
		end
	end
end

vgui.Register("pkscript_Option", PANEL, "pkscript_Base")
