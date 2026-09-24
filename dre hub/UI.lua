-- ==================================================
-- DRE HUB | STEAL AN EGG | PREMIUM UI
-- ==================================================

local Services = {
    Players = game:GetService("Players"),
    TweenService = game:GetService("TweenService"),
    UserInputService = game:GetService("UserInputService"),
    RunService = game:GetService("RunService"),
    CoreGui = game:GetService("CoreGui"),
    ContentProvider = game:GetService("ContentProvider"),
}

local Settings = _G.DRE
local Theme = Settings.UI.Theme
local TweenFast = TweenInfo.new(0.14, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
local TweenMed = TweenInfo.new(0.22, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

local GuiParent = Services.CoreGui
pcall(function()
    if type(gethui) == "function" then
        local h = gethui()
        if h then GuiParent = h end
    end
end)

pcall(function()
    local old = GuiParent:FindFirstChild("DRE_HUB")
    if old then old:Destroy() end
    local oldToggle = GuiParent:FindFirstChild("DRE_Toggle")
    if oldToggle then oldToggle:Destroy() end
end)

local function Corner(parent, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius)
    c.Parent = parent
    return c
end

local function Stroke(parent, color, transparency, thickness)
    local s = Instance.new("UIStroke")
    s.Color = color
    s.Transparency = transparency or 0
    s.Thickness = thickness or 1
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    s.Parent = parent
    return s
end

local function Shadow(parent)
    local sh = Instance.new("ImageLabel")
    sh.Name = "Shadow"
    sh.AnchorPoint = Vector2.new(0.5, 0.5)
    sh.Position = UDim2.new(0.5, 0, 0.5, 7)
    sh.Size = UDim2.new(1, 34, 1, 34)
    sh.BackgroundTransparency = 1
    sh.Image = "rbxassetid://1316045217"
    sh.ImageColor3 = Color3.new(0, 0, 0)
    sh.ImageTransparency = 0.42
    sh.ScaleType = Enum.ScaleType.Slice
    sh.SliceCenter = Rect.new(10, 10, 118, 118)
    sh.ZIndex = math.max(parent.ZIndex - 1, 1)
    sh.Parent = parent
    return sh
end

local ASSET_ID = Settings.AssetID
pcall(function() Services.ContentProvider:PreloadAsync({ASSET_ID}) end)

local ToggleScreenGui = Instance.new("ScreenGui")
ToggleScreenGui.Name = "DRE_Toggle"
ToggleScreenGui.ResetOnSpawn = false
ToggleScreenGui.IgnoreGuiInset = true
ToggleScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ToggleScreenGui.DisplayOrder = 1001
ToggleScreenGui.Parent = GuiParent

local Toggle = Instance.new("ImageButton")
Toggle.Name = "DRE"
Toggle.Size = UDim2.fromOffset(52, 52)
Toggle.Position = UDim2.new(0, 18, 0.5, -26)
Toggle.BackgroundColor3 = Theme.Panel
Toggle.BorderSizePixel = 0
Toggle.Image = ASSET_ID
Toggle.ScaleType = Enum.ScaleType.Fit
Toggle.AutoButtonColor = false
Toggle.ZIndex = 999
Toggle.Parent = ToggleScreenGui
Corner(Toggle, 16)
local toggleStroke = Stroke(Toggle, Theme.Border, 0.05, 1)
local toggleGradient = Instance.new("UIGradient")
toggleGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Theme.PanelHover),
    ColorSequenceKeypoint.new(1, Theme.Input),
})
toggleGradient.Rotation = 45
toggleGradient.Parent = Toggle

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DRE_HUB"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.DisplayOrder = 1000
ScreenGui.Parent = GuiParent

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.fromOffset(Settings.UI.Width, Settings.UI.Height)
Main.Position = UDim2.new(0.5, -Settings.UI.Width/2, 0.5, -Settings.UI.Height/2)
Main.BackgroundColor3 = Theme.Background
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.Active = true
Main.ZIndex = 10
Main.Parent = ScreenGui
Corner(Main, 18)
Stroke(Main, Theme.Border, 0, 1)

local MainGradient = Instance.new("UIGradient")
MainGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(14, 15, 21)),
    ColorSequenceKeypoint.new(0.55, Theme.Background),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(8, 9, 13)),
})
MainGradient.Rotation = 20
MainGradient.Parent = Main

Shadow(Main)

local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 76)
TopBar.BackgroundColor3 = Theme.TopBar
TopBar.BackgroundTransparency = 0.05
TopBar.BorderSizePixel = 0
TopBar.Active = true
TopBar.ZIndex = 20
TopBar.Parent = Main

local topGradient = Instance.new("UIGradient")
topGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 27, 37)),
    ColorSequenceKeypoint.new(0.65, Theme.TopBar),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(13, 14, 19)),
})
topGradient.Rotation = 90
topGradient.Parent = TopBar

local AccentLine = Instance.new("Frame")
AccentLine.Size = UDim2.new(1, 0, 0, 2)
AccentLine.Position = UDim2.new(0, 0, 1, -2)
AccentLine.BackgroundColor3 = Theme.Accent
AccentLine.BorderSizePixel = 0
AccentLine.ZIndex = 24
AccentLine.Parent = TopBar

local BrandMark = Instance.new("Frame")
BrandMark.Size = UDim2.fromOffset(42, 42)
BrandMark.Position = UDim2.new(0, 17, 0, 17)
BrandMark.BackgroundColor3 = Theme.Input
BrandMark.BorderSizePixel = 0
BrandMark.ZIndex = 22
BrandMark.Parent = TopBar
Corner(BrandMark, 13)
Stroke(BrandMark, Theme.Border, 0.15, 1)

local BrandIcon = Instance.new("ImageLabel")
BrandIcon.Size = UDim2.new(1, -8, 1, -8)
BrandIcon.Position = UDim2.fromOffset(4, 4)
BrandIcon.BackgroundTransparency = 1
BrandIcon.Image = ASSET_ID
BrandIcon.ScaleType = Enum.ScaleType.Fit
BrandIcon.ZIndex = 23
BrandIcon.Parent = BrandMark

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, -220, 0, 27)
Title.Position = UDim2.new(0, 70, 0, 14)
Title.BackgroundTransparency = 1
Title.Text = Settings.Name
Title.TextColor3 = Theme.Text
Title.TextSize = 20
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Font = Enum.Font.GothamBold
Title.ZIndex = 21
Title.Parent = TopBar

local Subtitle = Instance.new("TextLabel")
Subtitle.Name = "Subtitle"
Subtitle.Size = UDim2.new(1, -220, 0, 17)
Subtitle.Position = UDim2.new(0, 71, 0, 41)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = Settings.Version
Subtitle.TextColor3 = Theme.SubText
Subtitle.TextSize = 10
Subtitle.TextXAlignment = Enum.TextXAlignment.Left
Subtitle.Font = Enum.Font.GothamMedium
Subtitle.ZIndex = 21
Subtitle.Parent = TopBar

local Status = Instance.new("Frame")
Status.Size = UDim2.fromOffset(96, 28)
Status.Position = UDim2.new(1, -112, 0, 24)
Status.BackgroundColor3 = Color3.fromRGB(14, 28, 23)
Status.BorderSizePixel = 0
Status.ZIndex = 23
Status.Parent = TopBar
Corner(Status, 9)
Stroke(Status, Theme.Success, 0.55, 1)

local StatusDot = Instance.new("Frame")
StatusDot.Size = UDim2.fromOffset(7, 7)
StatusDot.Position = UDim2.new(0, 11, 0.5, -3)
StatusDot.BackgroundColor3 = Theme.Success
StatusDot.BorderSizePixel = 0
StatusDot.ZIndex = 24
StatusDot.Parent = Status
Corner(StatusDot, 99)

local StatusText = Instance.new("TextLabel")
StatusText.Size = UDim2.new(1, -28, 1, 0)
StatusText.Position = UDim2.fromOffset(25, 0)
StatusText.BackgroundTransparency = 1
StatusText.Text = "READY"
StatusText.TextColor3 = Theme.Success
StatusText.TextSize = 9
StatusText.Font = Enum.Font.GothamBold
StatusText.TextXAlignment = Enum.TextXAlignment.Left
StatusText.ZIndex = 24
StatusText.Parent = Status

local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(0, Settings.UI.SidebarWidth, 1, -76)
Sidebar.Position = UDim2.new(0, 0, 0, 76)
Sidebar.BackgroundColor3 = Theme.Sidebar
Sidebar.BorderSizePixel = 0
Sidebar.ZIndex = 12
Sidebar.Parent = Main

local sidebarGradient = Instance.new("UIGradient")
sidebarGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Theme.Sidebar),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 11, 15)),
})
sidebarGradient.Rotation = 90
sidebarGradient.Parent = Sidebar

local SideLabel = Instance.new("TextLabel")
SideLabel.Size = UDim2.new(1, -24, 0, 17)
SideLabel.Position = UDim2.fromOffset(12, 12)
SideLabel.BackgroundTransparency = 1
SideLabel.Text = "NAVIGATION"
SideLabel.TextColor3 = Theme.Muted
SideLabel.TextSize = 8
SideLabel.Font = Enum.Font.GothamBold
SideLabel.TextXAlignment = Enum.TextXAlignment.Left
SideLabel.ZIndex = 15
SideLabel.Parent = Sidebar

local TabScroll = Instance.new("ScrollingFrame")
TabScroll.Name = "TabScroll"
TabScroll.Size = UDim2.new(1, 0, 1, -39)
TabScroll.Position = UDim2.fromOffset(0, 34)
TabScroll.BackgroundTransparency = 1
TabScroll.BorderSizePixel = 0
TabScroll.CanvasSize = UDim2.new()
TabScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
TabScroll.ScrollingDirection = Enum.ScrollingDirection.Y
TabScroll.ScrollBarThickness = 0
TabScroll.Active = true
TabScroll.ZIndex = 14
TabScroll.Parent = Sidebar

local TabPadding = Instance.new("UIPadding")
TabPadding.PaddingTop = UDim.new(0, 5)
TabPadding.PaddingBottom = UDim.new(0, 10)
TabPadding.PaddingLeft = UDim.new(0, 9)
TabPadding.PaddingRight = UDim.new(0, 9)
TabPadding.Parent = TabScroll

local TabList = Instance.new("UIListLayout")
TabList.Padding = UDim.new(0, 5)
TabList.SortOrder = Enum.SortOrder.LayoutOrder
TabList.Parent = TabScroll

local SidebarLine = Instance.new("Frame")
SidebarLine.Size = UDim2.new(0, 1, 1, 0)
SidebarLine.Position = UDim2.new(1, -1, 0, 0)
SidebarLine.BackgroundColor3 = Theme.Border
SidebarLine.BorderSizePixel = 0
SidebarLine.ZIndex = 15
SidebarLine.Parent = Sidebar

local Content = Instance.new("Frame")
Content.Name = "Content"
Content.Size = UDim2.new(1, -Settings.UI.SidebarWidth, 1, -76)
Content.Position = UDim2.new(0, Settings.UI.SidebarWidth, 0, 76)
Content.BackgroundTransparency = 1
Content.BorderSizePixel = 0
Content.ZIndex = 12
Content.Parent = Main

local function MakeDrag(input, target)
    local start = input.Position
    local startPos = target.Position
    local active = input.UserInputType == Enum.UserInputType.Touch and input or nil
    local moving = true
    local changed, ended
    changed = Services.UserInputService.InputChanged:Connect(function(i)
        if not moving then return end
        if active and i ~= active then return end
        if i.UserInputType ~= Enum.UserInputType.MouseMovement and i.UserInputType ~= Enum.UserInputType.Touch then return end
        local d = i.Position - start
        target.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset+d.X, startPos.Y.Scale, startPos.Y.Offset+d.Y)
    end)
    ended = Services.UserInputService.InputEnded:Connect(function(i)
        if active then
            if i == active then moving = false end
        elseif i.UserInputType == Enum.UserInputType.MouseButton1 then
            moving = false
        end
        if not moving then
            changed:Disconnect()
            ended:Disconnect()
        end
    end)
end

TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        MakeDrag(input, Main)
    end
end)

local isUIVisible = true
Toggle.MouseButton1Click:Connect(function()
    isUIVisible = not isUIVisible
    if isUIVisible then
        ScreenGui.Enabled = true
        Main.Size = UDim2.fromOffset(Settings.UI.Width - 18, Settings.UI.Height - 18)
        Services.TweenService:Create(Main, TweenMed, {
            Size = UDim2.fromOffset(Settings.UI.Width, Settings.UI.Height)
        }):Play()
    else
        ScreenGui.Enabled = false
    end
    Services.TweenService:Create(Toggle, TweenFast, {
        Size = UDim2.fromOffset(46, 46)
    }):Play()
    task.delay(0.14, function()
        Services.TweenService:Create(Toggle, TweenFast, {
            Size = UDim2.fromOffset(52, 52)
        }):Play()
    end)
end)

_G.DRE_Main = Main
_G.DRE_TopBar = TopBar
_G.DRE_Sidebar = Sidebar
_G.DRE_TabScroll = TabScroll
_G.DRE_Content = Content
_G.DRE_ScreenGui = ScreenGui
_G.DRE_Toggle = Toggle
_G.DRE_GuiParent = GuiParent

-- Backward compatibility for any component loaded before an external update.
_G.DRE_Theme = Theme

print("DRE UI Loaded")
