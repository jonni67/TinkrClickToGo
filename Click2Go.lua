---@diagnostic disable: undefined-global

--Thanks Becca/Anonymouse/Fusspawn

--Click on the map and move to the position

local Tinkr = ...
local Detour = Tinkr.Util.Detour
local wp_index = 1
local path = nil

local main_frame = CreateFrame("Frame")
main_frame:SetScript("OnUpdate", function() 

    if path ~= nil then
        print(wp_index)
        local px,py,pz = ObjectPosition("player")
        if FastDistance(path[wp_index].x, path[wp_index].y, path[wp_index].z,px,py,pz) > 2.5 then
            MoveTo(path[wp_index].x, path[wp_index].y, path[wp_index].z)
        else
            wp_index = wp_index + 1
        end
        if wp_index > #path then
            wp_index = 1
            path = nil
        end
    end

end)

if WorldMapFrame ~= nil and not MapListenerRegistered then
    MapListenerRegistered = true
    WorldMapFrame.ScrollContainer:HookScript(
    "OnMouseUp",function(self, button)
    
    if button == "LeftButton" then
        local cx, cy = WorldMapFrame.ScrollContainer:GetNormalizedCursorPosition()
        local cont, wPos = C_Map.GetWorldPosFromMapPos(WorldMapFrame:GetMapID(), CreateVector2D(cx, cy))
        local wx, wy = wPos:GetXY()
        local hitFlags = bit.bor(0x1, 0x10, 0x100, 0x100000)
        local x1, y1, z1 = ObjectPosition("player")
        local x2, y2, z2 = TraceLine(wx, wy, -1000, wx, wy, 1000, hitFlags)
        path = Detour:Raw(x1, y1, z1, x2, y2, z2, GetMapID())
    end   
    end)

end
