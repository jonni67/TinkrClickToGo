---@diagnostic disable: undefined-global

--Click on the map and move to the position
--Thanks Becca/Anonymouse/Fusspawn

local Tinkr = ...
local Detour = Tinkr.Util.Detour
local wp_index = 1
local path = nil
local main_frame = CreateFrame("Frame")

local function GetRad(X1, Y1, Z1, X2, Y2, Z2) 
    return math.atan2(Y2 - Y1, X2 - X1) % (math.pi * 2), math.atan((Z1 - Z2) / math.sqrt(math.pow(X1 - X2, 2) + math.pow(Y1 - Y2, 2))) % math.pi 
end

main_frame:SetScript("OnUpdate", function() 

    if path ~= nil then
        local px,py,pz = ObjectPosition("player")
        if wp_index <= 5 then
            local a1,a2 = GetRad(px,py,pz,path[wp_index].x, path[wp_index].y, path[wp_index].z)
            FaceDirection(a1,false)
        end
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

    WorldMapFrame.ScrollContainer:HookScript(
        "OnMouseUp",function(self, button)
        if button=="RightButton" then 
            path = nil
            wp_index = 1
        end
    end)
end
