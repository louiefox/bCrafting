--[[
	Created by Patrick Ratzow (sleeppyy).

	Credits goes to Metamist for his previously closed source library Wyvern,
		CupCakeR for various improvements, the animated texture VGUI panel, and misc.
]]
 
-- Based off https://github.com/Threebow/better-derma-grid/blob/master/threegrid.lua
local PANEL = {}

AccessorFunc(PANEL, "horizontalMargin", "HorizontalMargin", FORCE_NUMBER)
AccessorFunc(PANEL, "verticalMargin", "VerticalMargin", FORCE_NUMBER)
AccessorFunc(PANEL, "columns", "Columns", FORCE_NUMBER)

function PANEL:Init()
	self:SetHorizontalMargin(0)
	self:SetVerticalMargin(0)

	self.rows = {}
	self.cells = {}
end

function PANEL:AddCell(pnl)
	local columns = self:GetColumns()

	local rowId = math.floor(#self.cells / columns) + 1
	self.rows[rowId] = self.rows[rowId] or self:CreateRow()
	local row = self.rows[rowId]

	pnl:SetParent(row)
	pnl:Dock(LEFT)

	table.insert(row.items, pnl)
	table.insert(self.cells, pnl)

	self:CalculateRowHeight(row)
end

function PANEL:CreateRow()
	local row = self:Add("Panel")
	row:Dock(TOP)
	row:DockMargin(0, 0, 0, self:GetVerticalMargin())
	row.items = {}

	return row
end

function PANEL:CalculateRowHeight(row)
	local height = 0

	for k, v in pairs(row.items) do
		height = math.max(height, v:GetTall())
	end

	row:SetTall(height)
end

function PANEL:Skip()
	local cell = vgui.Create("Panel")
	self:AddCell(cell)
end

function PANEL:Clear()
	for _, row in pairs(self.rows) do
		for _, cell in pairs(row.items) do
			cell:Remove()
		end
		row:Remove()
	end

	self.rells, self.rows = {}, {}
end

function PANEL:PerformLayout(w, h)
	if (!w) then return end -- No idea???

	self.BaseClass.PerformLayout(self, w, h)

	local columns = self:GetColumns()
	local margin = self:GetHorizontalMargin()

	for k, row in pairs(self.rows) do
		self:CalculateRowHeight(row)
		for i, cell in pairs(row.items) do
			local cellMargin = #row.items + 1 < columns and self:GetHorizontalMargin() or 0
			local cellWidth = (cell:GetWide() - margin * (columns - 1) / columns)
			cell:DockMargin(0, 0, cellMargin, 0)
			cell:SetWide(cellWidth)
		end
	end
end

PANEL.OnRemove = PANEL.Clear

vgui.Register("XeninUI.Grid", PANEL, "DScrollPanel")