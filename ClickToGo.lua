---@diagnostic disable: undefined-global
local Tinkr = ...
local ObjectManager = Tinkr.Util.ObjectManager
local Exports = Tinkr:require('Routine.Modules.Exports')
local Common = Tinkr.Common
local Routine = Tinkr.Routine
Tinkr:require('Routine.Modules.Exports')
Tinkr:require('scripts.cromulon.libs.HereBeDragons.HereBeDragons-20' , wowex)
Tinkr:require('scripts.cromulon.libs.HereBeDragons.HereBeDragons-pins-20' , wowex)

local frame = CreateFrame("Frame", nil, UIParent)
local timer = 1

frame:SetScript("OnUpdate", function(self, elapsed))
    timer = timer + elapsed
    if timer < 0.1 then return end
    timer = 0

hooksecurefunc(WorldMapFrame, "OnKeyDown", function()
    local mapID = WoldMapFame.mapID()
)