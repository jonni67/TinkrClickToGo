---@diagnostic disable: undefined-global

--Click on the map and move to the position

local Tinkr = ...
local ObjectManager = Tinkr.Util.ObjectManager
local Exports = Tinkr:require('Routine.Modules.Exports')
local Common = Tinkr.Common
local Routine = Tinkr.Routine
Tinkr:require('Routine.Modules.Exports')

local function travel(x1, y1, z1, x2, y2, z2, mapId) 
    local path, pathType = GeneratePath(x1, y1, z1, x2, y2, z2, mapId)
    print(pathType)
    return  
end


--Thanks Becca for this function
if WorldMapFrame ~= nil and not MapListenerRegistered then
    MapListenerRegistered = true
    WorldMapFrame.ScrollContainer:HookScript(
    "OnMouseUp",
    function(self, button)
        if button == "LeftButton" then
            local cx, cy = WorldMapFrame.ScrollContainer:GetNormalizedCursorPosition()
            local cont, wPos = C_Map.GetWorldPosFromMapPos(WorldMapFrame:GetMapID(), CreateVector2D(cx, cy))
            local wx, wy = wPos:GetXY()
            local hitFlags = bit.bor(0x10, 0x100)
            local x1, y1, z1 = ObjectPosition("player")
            local x2, y2, z2 = TraceLine(wx, wy, -1000, wx, wy, 1000, hitFlags)
            --print("Traceline:",x,y,z)
            --print("Clicked Pos:",wx,wy)
            --print("Char pos:",p1,p2,p3)
            travel(x1,y1,z1,x2,y2,z2, WorldMapFrame:GetMapID())
        end
        
    end)
end
