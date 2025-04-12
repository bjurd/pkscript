local PANEL = {}

AccessorFunc(PANEL, "m_colAccent", "AccentColor", FORCE_COLOR)

function PANEL:Init()
	self:SetPaintBackgroundEnabled(false)
	self:SetPaintBorderEnabled(false)

	self:SetMouseInputEnabled(true)
	self:SetKeyboardInputEnabled(true)

	self:SetAccentColor(Color(125, 0, 0, 255))
end

function PANEL:SetupChild(Child)

end

function PANEL:Paint(Width, Height)
	self:PaintBackground(Width, Height)
	self:PaintForeground(Width, Height)
end

function PANEL:PaintBackground(Width, Height)

end

function PANEL:PaintForeground(Width, Height)

end

function PANEL:OnChildAdded(Child)
	timer.Simple(0, function() -- Incredible video game
		if IsValid(self) and IsValid(Child) and isfunction(Child.SetAccentColor) then
			Child:SetAccentColor(self:GetAccentColor())

			self:SetupChild(Child)
		end
	end)
end

vgui.Register("pkscript_Base", PANEL, "DPanel")
