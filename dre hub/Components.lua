-- ==================================================
-- DRE HUB | STEAL AN EGG | COMPONENTS
-- ==================================================

local TweenService = game:GetService("TweenService")
local Theme = (_G.DRE and _G.DRE.UI and _G.DRE.UI.Theme) or {
    Background = Color3.fromRGB(10,11,15),
    Sidebar = Color3.fromRGB(13,14,19),
    Panel = Color3.fromRGB(17,19,26),
    PanelHover = Color3.fromRGB(21,23,31),
    Input = Color3.fromRGB(11,12,17),
    Accent = Color3.fromRGB(126,92,255),
    Accent2 = Color3.fromRGB(89,180,255),
    Text = Color3.fromRGB(245,247,255),
    SubText = Color3.fromRGB(139,145,160),
    Muted = Color3.fromRGB(86,91,105),
    Border = Color3.fromRGB(39,42,53),
    Success = Color3.fromRGB(82,210,145),
}

local Fast = TweenInfo.new(0.13, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
local Medium = TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

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
    s.Parent = parent
    return s
end

local function GetTabTextSize(name)
    local n = #name
    if n >= 16 then return 9
    elseif n >= 13 then return 10
    elseif n >= 9 then return 11
    elseif n >= 6 then return 12
    else return 13 end
end

function CreateTab(Name, Order)
    local TabScroll = _G.DRE_TabScroll
    local Tab = Instance.new("TextButton")
    Tab.Name = Name:gsub("%s+", "_") .. "_Tab"
    Tab.Size = UDim2.new(1, 0, 0, 38)
    Tab.BackgroundColor3 = Theme.PanelHover
    Tab.BackgroundTransparency = 1
    Tab.BorderSizePixel = 0
    Tab.Text = ""
    Tab.AutoButtonColor = false
    Tab.LayoutOrder = Order or 1
    Tab.ZIndex = 16
    Tab.Parent = TabScroll
    Corner(Tab, 10)

    local Indicator = Instance.new("Frame")
    Indicator.Name = "Indicator"
    Indicator.Size = UDim2.new(0, 3, 0, 22)
    Indicator.Position = UDim2.new(0, 0, 0.5, -11)
    Indicator.BackgroundColor3 = Theme.Accent
    Indicator.BackgroundTransparency = 1
    Indicator.BorderSizePixel = 0
    Indicator.ZIndex = 18
    Indicator.Parent = Tab
    Corner(Indicator, 99)

    local Icon = Instance.new("Frame")
    Icon.Name = "Icon"
    Icon.Size = UDim2.fromOffset(26, 26)
    Icon.Position = UDim2.new(0, 10, 0.5, -13)
    Icon.BackgroundColor3 = Theme.Input
    Icon.BackgroundTransparency = 0.15
    Icon.BorderSizePixel = 0
    Icon.ZIndex = 17
    Icon.Parent = Tab
    Corner(Icon, 8)

    local IconText = Instance.new("TextLabel")
    IconText.Size = UDim2.new(1,0,1,0)
    IconText.BackgroundTransparency = 1
    IconText.Text = string.sub(Name,1,1):upper()
    IconText.TextColor3 = Theme.SubText
    IconText.TextSize = 10
    IconText.Font = Enum.Font.GothamBold
    IconText.ZIndex = 18
    IconText.Parent = Icon

    local Text = Instance.new("TextLabel")
    Text.Name = "TabText"
    Text.Size = UDim2.new(1, -49, 1, 0)
    Text.Position = UDim2.fromOffset(43, 0)
    Text.BackgroundTransparency = 1
    Text.Text = Name
    Text.TextColor3 = Theme.SubText
    Text.TextSize = GetTabTextSize(Name)
    Text.TextXAlignment = Enum.TextXAlignment.Left
    Text.TextYAlignment = Enum.TextYAlignment.Center
    Text.Font = Enum.Font.GothamMedium
    Text.TextTruncate = Enum.TextTruncate.AtEnd
    Text.ZIndex = 18
    Text.Parent = Tab

    Tab.MouseEnter:Connect(function()
        if _G.DRE_TabsManager and _G.DRE_TabsManager.ActiveTab ~= Tab then
            TweenService:Create(Tab, Fast, {BackgroundTransparency = 0.72}):Play()
            TweenService:Create(Icon, Fast, {BackgroundColor3 = Theme.PanelHover}):Play()
        end
    end)
    Tab.MouseLeave:Connect(function()
        if _G.DRE_TabsManager and _G.DRE_TabsManager.ActiveTab ~= Tab then
            TweenService:Create(Tab, Fast, {BackgroundTransparency = 1}):Play()
        end
    end)

    return Tab
end

function CreatePage(Name)
    local Content = _G.DRE_Content
    local Page = Instance.new("ScrollingFrame")
    Page.Name = Name .. "_Page"
    Page.Size = UDim2.new(1,0,1,0)
    Page.BackgroundTransparency = 1
    Page.BorderSizePixel = 0
    Page.Visible = false
    Page.CanvasSize = UDim2.new()
    Page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Page.ScrollingDirection = Enum.ScrollingDirection.Y
    Page.ScrollBarThickness = 3
    Page.ScrollBarImageColor3 = Theme.Accent
    Page.ScrollBarImageTransparency = 0.35
    Page.VerticalScrollBarInset = Enum.ScrollBarInset.Always
    Page.Active = true
    Page.Selectable = true
    Page.ZIndex = 14
    Page.Parent = Content

    local Padding = Instance.new("UIPadding")
    Padding.PaddingTop = UDim.new(0, 17)
    Padding.PaddingBottom = UDim.new(0, 18)
    Padding.PaddingLeft = UDim.new(0, 20)
    Padding.PaddingRight = UDim.new(0, 18)
    Padding.Parent = Page

    local List = Instance.new("UIListLayout")
    List.Padding = UDim.new(0, 9)
    List.SortOrder = Enum.SortOrder.LayoutOrder
    List.Parent = Page
    return Page
end

function CreateSectionTitle(Parent, TextValue, Order)
    local Holder = Instance.new("Frame")
    Holder.Name = "Section_" .. TextValue:gsub("%s+","_")
    Holder.Size = UDim2.new(1,0,0,31)
    Holder.BackgroundTransparency = 1
    Holder.LayoutOrder = Order or 1
    Holder.Parent = Parent

    local Accent = Instance.new("Frame")
    Accent.Size = UDim2.fromOffset(3, 16)
    Accent.Position = UDim2.new(0,0,0.5,-8)
    Accent.BackgroundColor3 = Theme.Accent
    Accent.BorderSizePixel = 0
    Accent.Parent = Holder
    Corner(Accent, 99)

    local Label = Instance.new("TextLabel")
    Label.Name = "SectionTitle"
    Label.Size = UDim2.new(1,-16,1,0)
    Label.Position = UDim2.fromOffset(12,0)
    Label.BackgroundTransparency = 1
    Label.Text = TextValue:upper()
    Label.TextColor3 = Theme.Text
    Label.TextSize = 11
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.TextYAlignment = Enum.TextYAlignment.Center
    Label.Font = Enum.Font.GothamBold
    Label.Parent = Holder
    return Label
end

local function MakeRow(parent, name, order, height)
    local holder = Instance.new("Frame")
    holder.Name = name:gsub("%s+","_")
    holder.Size = UDim2.new(1,0,0,height or 42)
    holder.BackgroundColor3 = Theme.Panel
    holder.BorderSizePixel = 0
    holder.LayoutOrder = order or 1
    holder.ZIndex = 20
    holder.Parent = parent
    Corner(holder, 10)
    Stroke(holder, Theme.Border, 0.15, 1)

    holder.MouseEnter:Connect(function()
        TweenService:Create(holder, Fast, {BackgroundColor3 = Theme.PanelHover}):Play()
    end)
    holder.MouseLeave:Connect(function()
        TweenService:Create(holder, Fast, {BackgroundColor3 = Theme.Panel}):Play()
    end)
    return holder
end

local function AddLabel(parent, text, width)
    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.Size = UDim2.new(1, -(width or 58), 1, 0)
    label.Position = UDim2.fromOffset(13,0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Theme.Text
    label.TextSize = 11
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextYAlignment = Enum.TextYAlignment.Center
    label.Font = Enum.Font.GothamMedium
    label.ZIndex = 22
    label.Parent = parent
    return label
end

local function StyleToggle(button, stroke, check, state)
    check.Visible = state
    TweenService:Create(button, Fast, {
        BackgroundColor3 = state and Theme.Accent or Theme.Input
    }):Play()
    TweenService:Create(stroke, Fast, {
        Color = state and Theme.Accent2 or Theme.Border,
        Transparency = state and 0.1 or 0.1
    }):Play()
    if state then
        check.TextTransparency = 0
    else
        check.TextTransparency = 1
    end
end

function CreateCheckbox(Parent, TextValue, Order)
    local Holder = MakeRow(Parent, TextValue, Order, 42)
    local Label = AddLabel(Holder, TextValue, 58)

    local CheckButton = Instance.new("TextButton")
    CheckButton.Name = "CheckBox"
    CheckButton.Size = UDim2.fromOffset(26,26)
    CheckButton.Position = UDim2.new(1,-39,0.5,-13)
    CheckButton.BackgroundColor3 = Theme.Input
    CheckButton.BorderSizePixel = 0
    CheckButton.Text = ""
    CheckButton.AutoButtonColor = false
    CheckButton.ZIndex = 25
    CheckButton.Parent = Holder
    Corner(CheckButton, 8)
    local boxStroke = Stroke(CheckButton, Theme.Border, 0, 1)

    local Check = Instance.new("TextLabel")
    Check.Name = "Check"
    Check.Size = UDim2.new(1,0,1,0)
    Check.BackgroundTransparency = 1
    Check.Text = "✓"
    Check.TextColor3 = Color3.new(1,1,1)
    Check.TextSize = 15
    Check.Font = Enum.Font.GothamBold
    Check.Visible = false
    Check.TextTransparency = 1
    Check.ZIndex = 26
    Check.Parent = CheckButton

    local Enabled = false
    local function Toggle()
        Enabled = not Enabled
        StyleToggle(CheckButton, boxStroke, Check, Enabled)
    end
    CheckButton.MouseButton1Click:Connect(Toggle)
    return Holder, CheckButton, function() return Enabled end
end

function CreateTextBoxWithCheckbox(Parent, TextValue, Order, DefaultValue, MinValue, MaxValue)
    DefaultValue = DefaultValue or 50
    MinValue = MinValue or 0
    MaxValue = MaxValue or 1000

    local Holder = MakeRow(Parent, TextValue, Order, 46)
    local Label = AddLabel(Holder, TextValue, 178)

    local TextBox = Instance.new("TextBox")
    TextBox.Name = "TextBox"
    TextBox.Size = UDim2.fromOffset(76,30)
    TextBox.Position = UDim2.new(1,-119,0.5,-15)
    TextBox.BackgroundColor3 = Theme.Input
    TextBox.BorderSizePixel = 0
    TextBox.Text = tostring(DefaultValue)
    TextBox.TextColor3 = Theme.Text
    TextBox.PlaceholderColor3 = Theme.Muted
    TextBox.TextSize = 11
    TextBox.TextXAlignment = Enum.TextXAlignment.Center
    TextBox.Font = Enum.Font.GothamMedium
    TextBox.ClearTextOnFocus = false
    TextBox.ZIndex = 25
    TextBox.Parent = Holder
    Corner(TextBox, 8)
    Stroke(TextBox, Theme.Border, 0.1, 1)

    local CheckButton = Instance.new("TextButton")
    CheckButton.Name = "CheckBox"
    CheckButton.Size = UDim2.fromOffset(26,26)
    CheckButton.Position = UDim2.new(1,-39,0.5,-13)
    CheckButton.BackgroundColor3 = Theme.Input
    CheckButton.BorderSizePixel = 0
    CheckButton.Text = ""
    CheckButton.AutoButtonColor = false
    CheckButton.ZIndex = 25
    CheckButton.Parent = Holder
    Corner(CheckButton, 8)
    local boxStroke = Stroke(CheckButton, Theme.Border, 0, 1)

    local Check = Instance.new("TextLabel")
    Check.Name = "Check"
    Check.Size = UDim2.new(1,0,1,0)
    Check.BackgroundTransparency = 1
    Check.Text = "✓"
    Check.TextColor3 = Color3.new(1,1,1)
    Check.TextSize = 15
    Check.Font = Enum.Font.GothamBold
    Check.Visible = false
    Check.TextTransparency = 1
    Check.ZIndex = 26
    Check.Parent = CheckButton

    local Enabled = false
    local CurrentValue = DefaultValue

    local function UpdateValue()
        local val = tonumber(TextBox.Text)
        if val then
            CurrentValue = math.clamp(val, MinValue, MaxValue)
            TextBox.Text = tostring(CurrentValue)
        else
            TextBox.Text = tostring(CurrentValue)
        end
    end

    local function Toggle()
        Enabled = not Enabled
        StyleToggle(CheckButton, boxStroke, Check, Enabled)
    end

    TextBox.FocusGained:Connect(function()
        Stroke(TextBox, Theme.Accent, 0.05, 1)
    end)
    TextBox.FocusLost:Connect(function()
        UpdateValue()
    end)
    CheckButton.MouseButton1Click:Connect(Toggle)
    return Holder, CheckButton, function() return Enabled end, TextBox, function() return CurrentValue end
end

function CreateSmartCheckbox(Parent, LabelText, Order, ToggleFunction, GetStateFunction)
    local Holder = MakeRow(Parent, LabelText, Order, 42)
    AddLabel(Holder, LabelText, 58)

    local Button = Instance.new("TextButton")
    Button.Name = "CheckBox"
    Button.Size = UDim2.fromOffset(26,26)
    Button.Position = UDim2.new(1,-39,0.5,-13)
    Button.BackgroundColor3 = Theme.Input
    Button.BorderSizePixel = 0
    Button.Text = ""
    Button.AutoButtonColor = false
    Button.ZIndex = 25
    Button.Parent = Holder
    Corner(Button, 8)
    local BoxStroke = Stroke(Button, Theme.Border, 0, 1)

    local Check = Instance.new("TextLabel")
    Check.Name = "Check"
    Check.Size = UDim2.new(1,0,1,0)
    Check.BackgroundTransparency = 1
    Check.Text = "✓"
    Check.TextColor3 = Color3.new(1,1,1)
    Check.TextSize = 15
    Check.Font = Enum.Font.GothamBold
    Check.Visible = false
    Check.TextTransparency = 1
    Check.ZIndex = 26
    Check.Parent = Button

    local Enabled = false
    if GetStateFunction then
        local ok, state = pcall(GetStateFunction)
        Enabled = ok and state == true
    end

    local function UpdateUI(state)
        Enabled = state == true
        StyleToggle(Button, BoxStroke, Check, Enabled)
    end
    UpdateUI(Enabled)

    Button.MouseButton1Click:Connect(function()
        local current = GetStateFunction and GetStateFunction() or Enabled
        UpdateUI(not current)
        if ToggleFunction then
            task.spawn(function()
                pcall(ToggleFunction)
            end)
        end
    end)

    return {
        Holder = Holder,
        Button = Button,
        GetState = function() return Enabled end,
        SetState = UpdateUI,
        Update = UpdateUI,
    }
end

print("DRE Components Loaded")
