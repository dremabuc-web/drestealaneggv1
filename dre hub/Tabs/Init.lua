-- ==================================================
-- DRE HUB | TABS MANAGER
-- ==================================================

local TweenService = game:GetService("TweenService")

local TabsManager = {}
TabsManager.Tabs = {}
TabsManager.Pages = {}
TabsManager.ActiveTab = nil
TabsManager.ActivePage = nil

-- ==================================================
-- REGISTER TAB
-- ==================================================
function TabsManager:RegisterTab(Name, Order, PageName)
    local Tab = CreateTab(Name, Order)
    local Page = CreatePage(PageName or Name:upper())
    
    table.insert(self.Tabs, { Tab = Tab, Page = Page, Name = Name })
    
    Tab.MouseButton1Click:Connect(function()
        self:SelectTab(Tab, Page)
    end)
    
    return Tab, Page
end

-- ==================================================
-- SELECT TAB
-- ==================================================
function TabsManager:SelectTab(SelectedTab, SelectedPage)
    if not SelectedTab or not SelectedPage then return end

    for _, data in ipairs(self.Tabs) do
        data.Page.Visible = false
        local indicator = data.Tab:FindFirstChild("Indicator")
        local tabText = data.Tab:FindFirstChild("TabText")
        local icon = data.Tab:FindFirstChild("Icon")

        TweenService:Create(data.Tab, TweenInfo.new(0.16, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            BackgroundTransparency = 1
        }):Play()
        if indicator then
            TweenService:Create(indicator, TweenInfo.new(0.16), {BackgroundTransparency = 1}):Play()
        end
        if tabText then
            TweenService:Create(tabText, TweenInfo.new(0.16), {
                TextColor3 = Color3.fromRGB(139,145,160)
            }):Play()
        end
        if icon then
            TweenService:Create(icon, TweenInfo.new(0.16), {
                BackgroundColor3 = Color3.fromRGB(11,12,17)
            }):Play()
        end
    end

    SelectedPage.Visible = true
    SelectedPage.CanvasPosition = Vector2.new(0, 0)

    TweenService:Create(SelectedTab, TweenInfo.new(0.18, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        BackgroundTransparency = 0.82
    }):Play()

    local indicator = SelectedTab:FindFirstChild("Indicator")
    local tabText = SelectedTab:FindFirstChild("TabText")
    local icon = SelectedTab:FindFirstChild("Icon")

    if indicator then
        TweenService:Create(indicator, TweenInfo.new(0.2), {
            BackgroundTransparency = 0
        }):Play()
    end
    if tabText then
        TweenService:Create(tabText, TweenInfo.new(0.2), {
            TextColor3 = Color3.fromRGB(245,247,255)
        }):Play()
    end
    if icon then
        TweenService:Create(icon, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(28,23,49)
        }):Play()
    end

    self.ActiveTab = SelectedTab
    self.ActivePage = SelectedPage
end

-- ==================================================
-- GET TAB BY NAME
-- ==================================================
function TabsManager:GetTab(Name)
    for _, data in ipairs(self.Tabs) do
        if data.Name == Name then
            return data.Tab, data.Page
        end
    end
    return nil, nil
end

-- ==================================================
-- SELECT TAB BY NAME
-- ==================================================
function TabsManager:SelectTabByName(Name)
    local Tab, Page = self:GetTab(Name)
    if Tab and Page then
        self:SelectTab(Tab, Page)
    end
end

-- ==================================================
-- EXPORT
-- ==================================================
_G.DRE_TabsManager = TabsManager

print("✅ Tabs Manager Loaded")
