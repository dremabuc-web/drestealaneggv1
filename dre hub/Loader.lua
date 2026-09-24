-- ==================================================
-- DRE HUB | STEAL AN EGG | Loader
-- ==================================================

local BASE_URL = "https://raw.githubusercontent.com/betdoyvaka/stealanegg/main/"

_G.DRE_EnablePrint = false

local oldPrint = print

print = function(...)
    if _G.DRE_EnablePrint then
        oldPrint(...)
    end
end

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

repeat
    task.wait()
until game:IsLoaded() and game.Players.LocalPlayer

local Player = game.Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

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

    return {
        Gui = LoadingGui,

        Update = function(_)
        end,

        Destroy = function()
            if LoadingGui then
                LoadingGui:Destroy()
            end
        end
    }
end

local Loading = CreateLoadingScreen()

Loading.Update(5)

Loading.Update(10)
loadstring(GetScript("Config.lua"))()

Loading.Update(15)
loadstring(GetScript("UI.lua"))()

Loading.Update(20)
loadstring(GetScript("Components.lua"))()

Loading.Update(25)
loadstring(GetScript("Tabs/Init.lua"))()

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

Loading.Update(50)
loadstring(GetScript("Features/VIPTP.lua"))()

Loading.Update(51)
loadstring(GetScript("Features/AttackDrone.lua"))()

Loading.Update(54)
loadstring(GetScript("Features/ManagerDrone.lua"))()

Loading.Update(57)
loadstring(GetScript("Features/ManualFastClick.lua"))()

Loading.Update(59)
loadstring(GetScript("Features/FarmingManager.lua"))()

Loading.Update(60)
loadstring(GetScript("Features/ConfigSystem.lua"))()

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

Loading.Update(92)

if _G.DRE_TabsManager then
    _G.DRE_TabsManager:SelectTabByName("Info")
end

Loading.Update(95)

Loading.Update(98)
loadstring(GetScript("Features/BypassAntiCheat.lua"))()

task.wait(2)

if _G.DRE_ConfigSystem then
    _G.DRE_ConfigSystem.Load()
end

Loading.Update(100)

task.wait(0.3)

Loading.Destroy()
