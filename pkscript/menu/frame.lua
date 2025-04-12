local PANEL = {}

AccessorFunc(PANEL, "m_iBarHeight", "BarHeight", FORCE_NUMBER)

PANEL.GradientUp = Material("gui/gradient_up")

function PANEL:Init()
	self:SetBarHeight(24)
end

function PANEL:PaintBackground(Width, Height)
	local BarHeight = self:GetBarHeight()

	surface.SetDrawColor(0, 0, 0, 255)
	surface.DrawOutlinedRect(0, 0, Width, Height)
	surface.DrawLine(0, BarHeight, Width, BarHeight)

	surface.SetDrawColor(24, 24, 24, 255)
	surface.DrawRect(1, 1, Width - 2, BarHeight - 1)

	surface.SetMaterial(self.GradientUp)
	surface.SetDrawColor(self:GetAccentColor())
	surface.DrawTexturedRect(1, BarHeight * 0.25, Width - 2, BarHeight * 0.75)
end

vgui.Register("pkscript_Frame", PANEL, "pkscript_Base")
