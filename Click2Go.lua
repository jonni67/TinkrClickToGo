---@diagnostic disable: undefined-global

--Thanks Becca/Anonymouse for any help with this =P

--Click on the map and move to the position

local Tinkr = ...
local Detour = Tinkr.Util.Detour


local function FOR(index, target, callback, path)
    if index > target then 
      return
    end 
    callback(index,target, path)
end
  
local function moving(index, target, path)
    MoveTo(path[index].x, path[index].y, path[index].z)
    FOR(index + 1, target, moving, path)
end
  
local function tablelength(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end

local function travel(x1, y1, z1, x2, y2, z2) 
    local path = Detour:Raw(x1, y1, z1, x2, y2, z2, GetMapID())
    FOR(1,tablelength(path),moving,path)   
end


if WorldMapFrame ~= nil and not MapListenerRegistered then
    MapListenerRegistered = true
    WorldMapFrame.ScrollContainer:HookScript(
    "OnMouseUp",
    
    function(self, button)
        if button == "LeftButton" then
            local cx, cy = WorldMapFrame.ScrollContainer:GetNormalizedCursorPosition()
            local cont, wPos = C_Map.GetWorldPosFromMapPos(WorldMapFrame:GetMapID(), CreateVector2D(cx, cy))
            local wx, wy = wPos:GetXY()
            local hitFlags = bit.bor(0x1, 0x10, 0x100, 0x100000)
            local x1, y1, z1 = ObjectPosition("player")
            local x2, y2, z2 = TraceLine(wx, wy, -1000, wx, wy, 1000, hitFlags)
            travel(x1,y1,z1,x2,y2,z2)
        end
        
    end)
end
