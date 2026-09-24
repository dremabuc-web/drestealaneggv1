-- ==================================================
-- DRE HUB | STEAL AN EGG | Loader
-- ✅ Load CharacterSystem មុន Features
-- ✅ VIPTP ជំនួស EggCheckPremium
-- ==================================================

local BASE_URL = "https://raw.githubusercontent.com/betdoyvaka/stealanegg/main/"

_G.DRE_EnablePrint = false

local oldPrint = print
print = function(...)
    if _G.DRE_EnablePrint then
        oldPrint(...)
    end
end

print("🔵 Loading DRE HUB...")

-- ==================================================
-- CACHE SYSTEM
-- ==================================================
_G.DRE_Cache = _G.DRE_Cache or {}

local function GetScript(path)
    local fullPath = BASE_URL .. path
    if _G.DRE_Cache[fullPath] then
        return _G.DRE_Cache[fullPath]
    end
    local script = game:HttpGet(fullPath)
    _G.DRE_Cache[fullPath] = script
    return script
end

-- ==================================================
-- WAIT UNTIL GAME IS LOADED
-- ==================================================
repeat task.wait() until game:IsLoaded() and game.Players.LocalPlayer

local Player = game.Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

print("✅ Game loaded, Player: " .. Player.Name)

-- ==================================================
-- CREATE LOADING SCREEN
-- ==================================================
local function CreateLoadingScreen()
    local LoadingGui = Instance.new("ScreenGui")
    LoadingGui.Name = "LoadingScreen"
    LoadingGui.ResetOnSpawn = false
    LoadingGui.IgnoreGuiInset = true
    LoadingGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    LoadingGui.DisplayOrder = 9999
    LoadingGui.Parent = CoreGui

    local Text = Instance.new("TextLabel")
    Text.Name = "DRE"
    Text.Size = UDim2.new(1, 0, 1, 0)
    Text.Position = UDim2.new(0, 0, 0, 0)
    Text.BackgroundTransparency = 1
    Text.BorderSizePixel = 0
    Text.Text = "/dre"
    Text.TextColor3 = Color3.fromRGB(255, 255, 255)
    Text.TextSize = 28
    Text.TextXAlignment = Enum.TextXAlignment.Center
    Text.TextYAlignment = Enum.TextYAlignment.Center
    Text.Font = Enum.Font.Code
    Text.Parent = LoadingGui

    local function UpdateProgress(_)
    end

    return {
        Gui = LoadingGui,
        Update = UpdateProgress,
        Destroy = function()
            LoadingGui:Destroy()
        end
    }
end

-- ==================================================
-- CREATE LOADING SCREEN
-- ==================================================
local Loading = CreateLoadingScreen()
Loading.Update(5)

-- ==================================================
-- LOAD CORE FILES
-- ==================================================
Loading.Update(10)
loadstring(GetScript("Config.lua"))()

Loading.Update(15)
loadstring(GetScript("UI.lua"))()

Loading.Update(20)
loadstring(GetScript("Components.lua"))()

-- ==================================================
-- LOAD TABS MANAGER
-- ==================================================
Loading.Update(25)
loadstring(GetScript("Tabs/Init.lua"))()

-- ==================================================
-- ✅ LOAD CHARACTER SYSTEM (មុន Features)
-- ==================================================

-- ==================================================
-- LOAD FEATURES
-- ==================================================
Loading.Update(28)
loadstring(GetScript("Features/AntiAFK.lua"))()

Loading.Update(30)
loadstring(GetScript("Features/WalkSpeed.lua"))()

Loading.Update(33)
loadstring(GetScript("Features/AntiTrap.lua"))()

Loading.Update(36)
loadstring(GetScript("Features/GodMode.lua"))()

Loading.Update(39)
loadstring(GetScript("Features/TeleportSystem.lua"))()

Loading.Update(42)
loadstring(GetScript("Features/AutoFarm.lua"))()

Loading.Update(45)
loadstring(GetScript("Features/AutoAttack.lua"))()

Loading.Update(48)
loadstring(GetScript("Features/AFKSystem.lua"))()

-- ✅ VIPTP (AFK Farm Only) — ជំនួស EggCheckPremium
Loading.Update(50)
loadstring(GetScript("Features/VIPTP.lua"))()

Loading.Update(51)
loadstring(GetScript("Features/AttackDrone.lua"))()

Loading.Update(54)
loadstring(GetScript("Features/ManagerDrone.lua"))()

Loading.Update(57)
loadstring(GetScript("Features/ManualFastClick.lua"))()

-- ✅ FarmingManager (ប្រើ VIPTP + EggCheck Logic ខាងក្នុង)
Loading.Update(59)
loadstring(GetScript("Features/FarmingManager.lua"))()

-- ✅ ConfigSystem
Loading.Update(60)
loadstring(GetScript("Features/ConfigSystem.lua"))()

-- ==================================================
-- LOAD TABS
-- ==================================================
Loading.Update(62)
loadstring(GetScript("Tabs/Info.lua"))()

Loading.Update(65)
loadstring(GetScript("Tabs/Farming.lua"))()

Loading.Update(70)
loadstring(GetScript("Tabs/Combat.lua"))()

Loading.Update(75)
loadstring(GetScript("Tabs/AutoFarming.lua"))()

Loading.Update(80)
loadstring(GetScript("Tabs/Event.lua"))()

Loading.Update(85)
loadstring(GetScript("Tabs/HopServer.lua"))()

Loading.Update(90)
loadstring(GetScript("Tabs/Setting.lua"))()

-- ==================================================
-- SELECT DEFAULT TAB
-- ==================================================
Loading.Update(92)
if _G.DRE_TabsManager then
    _G.DRE_TabsManager:SelectTabByName("Info")
end

Loading.Update(95)

-- ==================================================
-- LOAD ANTI CHEAT
-- ==================================================
Loading.Update(98)
loadstring(GetScript("Features/BypassAntiCheat.lua"))()

-- ==================================================
-- ✅ WAIT 2 SECONDS THEN APPLY CONFIG
-- ==================================================
print("⏳ Waiting 2s before applying config...")
task.wait(2)

if _G.DRE_ConfigSystem then
    print("🔧 Applying Config...")
    _G.DRE_ConfigSystem.Load()
end

Loading.Update(100)

task.wait(0.3)
Loading.Destroy()
print("✅ Loading Screen Closed!")
print("🚀 DRE HUB | Ready!")
