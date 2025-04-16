local BaseClass = baseclass.Get("pkscript_Option")

local PANEL = {}

AccessorFunc(PANEL, "m_pOptionsTable", "OptionsTable")

function PANEL:Init()
	self:SetOptionsTable({})
end

function PANEL:ChildOpenedCallback(OldValue, NewValue)
	local TopOption = self:GetTopOption()

	if not IsValid(TopOption) then
		error("Something has gone horribly wrong")
		return
	end

	TopOption:OnOptionChanged(self:GetVarKey(), NewValue)
end

function PANEL:OnOptionChanged(Key, Value)
	if not istable(self.m_pTempTable) then
		error("Something has gone horribly wrong")
		return
	end

	for k, _ in next, self.m_pTempTable do
		self.m_pTempTable[k] = false -- Reset everything
	end

	self.m_pTempTable[Key] = true -- Update to the new one (for the visual)

	-- Actually change the variable
	local VarTable = self:GetVarTable()

	if istable(VarTable) then
		VarTable[self:GetVarKey()] = Key
	end
end

function PANEL:OpenConfiguration()
	local OptionsTable = self:GetOptionsTable()

	if #OptionsTable < 1 then
		self:Close()
		return
	end

	self.m_pTempTable = {}

	local VarTable = self:GetVarTable()
	local CurrentValue = nil

	if istable(VarTable) then
		CurrentValue = VarTable[self:GetVarKey()]
	end

	for i = 1, #OptionsTable do
		local OptionLabel = OptionsTable[i] -- TODO: This means there can't be options with the same name, which would be bad design anyways /shrug
		self.m_pTempTable[OptionLabel] = CurrentValue == OptionLabel

		local Option = self:AddSubOption(OptionLabel, self.m_pTempTable, OptionLabel, TYPE_BOOL)
		Option.OnValueChanged = self.ChildOpenedCallback
	end

	self:Open()
end

function PANEL:CloseConfiguration()
	self.m_pTempTable = nil

	self:DestroyOptions()
end

function PANEL:PaintForeground(Width, Height)
	surface.SetFont(self:GetFont())
	surface.SetTextColor(self:GetTextColor())

	local Text = self:GetText()
	local TextWidth, TextHeight = surface.GetTextSize(Text)

	surface.SetTextPos((Width * 0.5) - (TextWidth * 0.5), (Height * 0.5) - (TextHeight * 0.5))
	surface.DrawText(Text)

	if self:GetOpen() then
		Text = "<-"
	else
		Text = "->"
	end

	TextWidth, TextHeight = surface.GetTextSize(Text)

	surface.SetTextPos(Width - (TextWidth * 2), (Height * 0.5) - (TextHeight * 0.5))
	surface.DrawText(Text)
end

function PANEL:AddDropdown(Label, Table, Key, Options)
	error("Don't call AddDropdown on Dropdowns!")
	return nil
end

vgui.Register("pkscript_Dropdown", PANEL, "pkscript_Option")
