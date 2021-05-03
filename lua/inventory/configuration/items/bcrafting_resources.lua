local ITEM = XeninInventory:CreateItem()
ITEM.Hover = "XeninInventory.Hover.V2"
ITEM.NWData = {}

ITEM:AddAction("Drop", 2, function(self, ply, ent, tbl)
  local trace = {}
  trace.start = ply:EyePos()
  trace.endpos = trace.start + ply:GetAimVector() * 85
  trace.filter = ply

  local tr = util.TraceLine(trace)
  local weapon = ents.Create(ent)
  local model = self:GetModel(ent)
  weapon:SetModel(model)
  weapon:SetPos(tr.HitPos)
  weapon:Spawn()

  for i, v in pairs(tbl.data or {}) do
    if (i == "dt") then
      for k, dt in pairs(v) do
        weapon.dt[k] = v
      end
    elseif (i == "nw") then
      for k, nw in pairs(v) do
        if (weapon["Set" .. k]) then

          weapon["Set" .. k](weapon, nw)
        end
      end
    end
  end
end)

function ITEM:GetData(ent)
  local dt = {}
  for i, v in pairs(ent.dt or {}) do
    dt[i] = v
  end

  local tbl = {}
  if (ent.GetNetworkedVars) then
    for i, v in pairs(ent:GetNetworkVars()) do
      tbl[i] = v
    end
  end

  return {
    model = ent:GetModel(),
    dt = dt,
    nw = tbl
  }
end

ITEM:Register("bcrafting_resource_metal")
ITEM:Register("bcrafting_resource_wood")
ITEM:Register("bcrafting_resource_plastic")
