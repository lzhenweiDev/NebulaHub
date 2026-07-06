-- =====================================================================
-- 🌟 NEBULA HUB v3 - Fixed UI + Better Text
-- =====================================================================

if not game:IsLoaded() then game.Loaded:Wait() end

local _HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local _LocalPlayer = Players.LocalPlayer

-- =====================================================================
-- SCRIPT DATABASE
-- =====================================================================
local ScriptDatabase = {
    [142823291] = {
        Name = "Murder Mystery 2",
        Script = "https://github.com/lzhenweiDev/NebulaHub/raw/refs/heads/main/Scripts/MM2.lua",
        Description = "ESP Roles, Aimbot, noClip"
    },
    ["UNIVERSAL"] = {
        Name = "Universal Admin",
        Script = "https://github.com/lzhenweiDev/NebulaHub/raw/refs/heads/main/Scripts/admin.lua",
        Description = "Fly, Noclip, ESP, Godmode"
    },
    ["17664219670"] = {
        Name = "Airstrikes NPCs",
        Script = "https://github.com/lzhenweiDev/NebulaHub/raw/refs/heads/main/Scripts/admin.lua",
        Description = "Fly, Noclip, ESP, Godmode"
    },
}

-- =====================================================================
-- NEBULA UI LIBRARY (MINI VERSION)
-- =====================================================================
local _Nebula = {}
local CurrentTheme = {
    Background = Color3.fromRGB(15, 10, 25),
    Background2 = Color3.fromRGB(10, 6, 18),
    Surface = Color3.fromRGB(25, 18, 40),
    Surface2 = Color3.fromRGB(20, 14, 32),
    Text = Color3.fromRGB(230, 220, 255),
    TextDim = Color3.fromRGB(150, 140, 180),
    Accent = Color3.fromRGB(140, 80, 255),
    AccentGlow = Color3.fromRGB(180, 130, 255),
    Danger = Color3.fromRGB(255, 70, 70),
    Success = Color3.fromRGB(80, 220, 120),
    Warning = Color3.fromRGB(255, 180, 50),
    Border = Color3.fromRGB(60, 45, 90),
}

-- =====================================================================
-- LOADING SCREEN
-- =====================================================================
local function ShowLoadingUI()
    local SG = Instance.new("ScreenGui")
    SG.Name = "NebulaHub"
    SG.Parent = CoreGui
    SG.ResetOnSpawn = false
    SG.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- Background
    local bg = Instance.new("Frame")
    bg.Parent = SG
    bg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    bg.BackgroundTransparency = 1
    bg.Size = UDim2.new(1, 0, 1, 0)
    bg.ZIndex = 999
    
    -- Center Frame
    local center = Instance.new("Frame")
    center.Parent = bg
    center.BackgroundColor3 = CurrentTheme.Background
    center.BorderColor3 = CurrentTheme.Border
    center.BorderSizePixel = 1
    center.Position = UDim2.new(0.5, -175, 0.5, -120)
    center.Size = UDim2.new(0, 350, 0, 240)
    center.BackgroundTransparency = 1
    center.ClipsDescendants = true
    center.ZIndex = 1000
    Instance.new("UICorner", center).CornerRadius = UDim.new(0, 14)
    
    -- Gloss effect
    local gloss = Instance.new("Frame")
    gloss.Parent = center
    gloss.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    gloss.BackgroundTransparency = 0.97
    gloss.BorderSizePixel = 0
    gloss.Size = UDim2.new(1, 0, 0.3, 0)
    gloss.ZIndex = 1001
    Instance.new("UICorner", gloss).CornerRadius = UDim.new(0, 14)
    
    -- Title
    local title = Instance.new("TextLabel")
    title.Parent = center
    title.BackgroundTransparency = 1
    title.Position = UDim2.new(0, 0, 0, 20)
    title.Size = UDim2.new(1, 0, 0, 28)
    title.Font = Enum.Font.GothamBold
    title.Text = "🌟 NEBULA HUB"
    title.TextColor3 = CurrentTheme.AccentGlow
    title.TextSize = 22
    title.ZIndex = 1001
    
    -- Subtitle
    local subtitle = Instance.new("TextLabel")
    subtitle.Parent = center
    subtitle.BackgroundTransparency = 1
    subtitle.Position = UDim2.new(0, 0, 0, 50)
    subtitle.Size = UDim2.new(1, 0, 0, 16)
    subtitle.Font = Enum.Font.Gotham
    subtitle.Text = "Connecting..."
    subtitle.TextColor3 = CurrentTheme.TextDim
    subtitle.TextSize = 10
    subtitle.ZIndex = 1001
    
    -- Status label
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Parent = center
    statusLabel.BackgroundTransparency = 1
    statusLabel.Position = UDim2.new(0, 0, 0, 85)
    statusLabel.Size = UDim2.new(1, 0, 0, 20)
    statusLabel.Font = Enum.Font.GothamBold
    statusLabel.Text = "🔍 Scanning Game ID..."
    statusLabel.TextColor3 = CurrentTheme.Text
    statusLabel.TextSize = 12
    statusLabel.ZIndex = 1001
    
    -- Game info label
    local gameInfoLabel = Instance.new("TextLabel")
    gameInfoLabel.Parent = center
    gameInfoLabel.BackgroundTransparency = 1
    gameInfoLabel.Position = UDim2.new(0, 0, 0, 108)
    gameInfoLabel.Size = UDim2.new(1, 0, 0, 14)
    gameInfoLabel.Font = Enum.Font.Gotham
    gameInfoLabel.Text = ""
    gameInfoLabel.TextColor3 = CurrentTheme.TextDim
    gameInfoLabel.TextSize = 9
    gameInfoLabel.ZIndex = 1001
    
    -- =====================================================================
    -- ANIMATED PROGRESS BAR (THE COOL PART)
    -- =====================================================================
    
    -- Glow effect behind bar
    local barGlow = Instance.new("Frame")
    barGlow.Parent = center
    barGlow.BackgroundColor3 = CurrentTheme.Accent
    barGlow.BackgroundTransparency = 0.85
    barGlow.BorderSizePixel = 0
    barGlow.Position = UDim2.new(0.08, 0, 0, 145)
    barGlow.Size = UDim2.new(0.84, 0, 0, 12)
    barGlow.ZIndex = 1001
    Instance.new("UICorner", barGlow).CornerRadius = UDim.new(0, 6)
    
    -- Progress bar background
    local barBg = Instance.new("Frame")
    barBg.Parent = center
    barBg.BackgroundColor3 = CurrentTheme.Background2
    barBg.BorderColor3 = CurrentTheme.Border
    barBg.BorderSizePixel = 1
    barBg.Position = UDim2.new(0.1, 0, 0, 147)
    barBg.Size = UDim2.new(0.8, 0, 0, 8)
    barBg.ZIndex = 1002
    Instance.new("UICorner", barBg).CornerRadius = UDim.new(0, 4)
    
    -- Progress bar fill
    local barFill = Instance.new("Frame")
    barFill.Parent = barBg
    barFill.BackgroundColor3 = CurrentTheme.AccentGlow
    barFill.BorderSizePixel = 0
    barFill.Size = UDim2.new(0, 0, 1, 0)
    barFill.ZIndex = 1003
    Instance.new("UICorner", barFill).CornerRadius = UDim.new(0, 4)
    
    -- Moving shine on the bar
    local barShine = Instance.new("Frame")
    barShine.Parent = barFill
    barShine.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    barShine.BackgroundTransparency = 0.7
    barShine.BorderSizePixel = 0
    barShine.Size = UDim2.new(0, 30, 1, 0)
    barShine.Position = UDim2.new(0, -40, 0, 0)
    barShine.ZIndex = 1004
    Instance.new("UICorner", barShine).CornerRadius = UDim.new(0, 4)
    
    -- Animate shine
    task.spawn(function()
        while barShine and barShine.Parent do
            barShine.Position = UDim2.new(0, -40, 0, 0)
            TweenService:Create(barShine, TweenInfo.new(1.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
                Position = UDim2.new(1, 10, 0, 0)
            }):Play()
            task.wait(1.5)
        end
    end)
    
    -- =====================================================================
    -- PERCENTAGE
    -- =====================================================================
    local pctLabel = Instance.new("TextLabel")
    pctLabel.Parent = center
    pctLabel.BackgroundTransparency = 1
    pctLabel.Position = UDim2.new(0, 0, 0, 165)
    pctLabel.Size = UDim2.new(1, 0, 0, 20)
    pctLabel.Font = Enum.Font.GothamBold
    pctLabel.Text = "0%"
    pctLabel.TextColor3 = CurrentTheme.AccentGlow
    pctLabel.TextSize = 14
    pctLabel.ZIndex = 1001
    
    -- =====================================================================
    -- VERSION
    -- =====================================================================
    local versionLabel = Instance.new("TextLabel")
    versionLabel.Parent = center
    versionLabel.BackgroundTransparency = 1
    versionLabel.Position = UDim2.new(0, 0, 0, 200)
    versionLabel.Size = UDim2.new(1, 0, 0, 14)
    versionLabel.Font = Enum.Font.Gotham
    versionLabel.Text = "Hub v3.0 | Nebula"
    versionLabel.TextColor3 = Color3.fromRGB(100, 90, 130)
    versionLabel.TextSize = 9
    versionLabel.ZIndex = 1001
    
    -- Animate in
    TweenService:Create(bg, TweenInfo.new(0.3), {BackgroundTransparency = 0.5}):Play()
    TweenService:Create(center, TweenInfo.new(0.3, Enum.EasingStyle.Back), {BackgroundTransparency = 0}):Play()
    
    return {
        SG = SG,
        StatusLabel = statusLabel,
        GameInfoLabel = gameInfoLabel,
        BarFill = barFill,
        PctLabel = pctLabel,
        Center = center,
        Bg = bg,
        Subtitle = subtitle,
    }
end

-- =====================================================================
-- POPUP: ERROR
-- =====================================================================
local function ShowErrorPopup(parent, title, message, callback)
    local overlay = Instance.new("Frame")
    overlay.Parent = parent
    overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    overlay.BackgroundTransparency = 1
    overlay.Size = UDim2.new(1, 0, 1, 0)
    overlay.ZIndex = 2000
    
    local popup = Instance.new("Frame")
    popup.Parent = overlay
    popup.BackgroundColor3 = CurrentTheme.Background
    popup.BorderColor3 = CurrentTheme.Danger
    popup.BorderSizePixel = 1
    popup.Position = UDim2.new(0.5, -150, 0.5, -60)
    popup.Size = UDim2.new(0, 0, 0, 0)
    popup.AnchorPoint = Vector2.new(0.5, 0.5)
    popup.ClipsDescendants = true
    popup.ZIndex = 2001
    Instance.new("UICorner", popup).CornerRadius = UDim.new(0, 12)
    
    local icon = Instance.new("TextLabel")
    icon.Parent = popup
    icon.BackgroundTransparency = 1
    icon.Position = UDim2.new(0, 15, 0, 12)
    icon.Size = UDim2.new(0, 28, 0, 28)
    icon.Font = Enum.Font.GothamBold
    icon.Text = "❌"
    icon.TextColor3 = CurrentTheme.Danger
    icon.TextSize = 22
    icon.ZIndex = 2002
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Parent = popup
    titleLabel.BackgroundTransparency = 1
    titleLabel.Position = UDim2.new(0, 48, 0, 14)
    titleLabel.Size = UDim2.new(1, -65, 0, 22)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Text = title
    titleLabel.TextColor3 = CurrentTheme.Danger
    titleLabel.TextSize = 14
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.ZIndex = 2002
    
    local msgLabel = Instance.new("TextLabel")
    msgLabel.Parent = popup
    msgLabel.BackgroundTransparency = 1
    msgLabel.Position = UDim2.new(0, 15, 0, 42)
    msgLabel.Size = UDim2.new(1, -30, 0, 30)
    msgLabel.Font = Enum.Font.Gotham
    msgLabel.Text = message
    msgLabel.TextColor3 = CurrentTheme.Text
    msgLabel.TextSize = 11
    msgLabel.TextWrapped = true
    msgLabel.TextXAlignment = Enum.TextXAlignment.Left
    msgLabel.ZIndex = 2002
    
    local btn = Instance.new("TextButton")
    btn.Parent = popup
    btn.BackgroundColor3 = CurrentTheme.Accent
    btn.BorderSizePixel = 0
    btn.Position = UDim2.new(0.25, 0, 0, 78)
    btn.Size = UDim2.new(0.5, 0, 0, 30)
    btn.Font = Enum.Font.GothamBold
    btn.Text = "OK"
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 12
    btn.AutoButtonColor = false
    btn.ZIndex = 2002
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    
    TweenService:Create(overlay, TweenInfo.new(0.2), {BackgroundTransparency = 0.4}):Play()
    TweenService:Create(popup, TweenInfo.new(0.3, Enum.EasingStyle.Back), {Size = UDim2.new(0, 300, 0, 118)}):Play()
    
    btn.MouseButton1Click:Connect(function()
        TweenService:Create(overlay, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
        TweenService:Create(popup, TweenInfo.new(0.2), {Size = UDim2.new(0, 0, 0, 0)}):Play()
        task.wait(0.2)
        overlay:Destroy()
        if callback then callback() end
    end)
end

-- =====================================================================
-- POPUP: CHOICE (YES / NEVERMIND)
-- =====================================================================
local function ShowChoicePopup(parent, gameName, yesCallback, noCallback)
    local overlay = Instance.new("Frame")
    overlay.Parent = parent
    overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    overlay.BackgroundTransparency = 1
    overlay.Size = UDim2.new(1, 0, 1, 0)
    overlay.ZIndex = 2000
    
    local popup = Instance.new("Frame")
    popup.Parent = overlay
    popup.BackgroundColor3 = CurrentTheme.Background
    popup.BorderColor3 = CurrentTheme.Warning
    popup.BorderSizePixel = 1
    popup.Position = UDim2.new(0.5, -160, 0.5, -75)
    popup.Size = UDim2.new(0, 0, 0, 0)
    popup.AnchorPoint = Vector2.new(0.5, 0.5)
    popup.ClipsDescendants = true
    popup.ZIndex = 2001
    Instance.new("UICorner", popup).CornerRadius = UDim.new(0, 12)
    
    local gloss = Instance.new("Frame")
    gloss.Parent = popup
    gloss.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    gloss.BackgroundTransparency = 0.97
    gloss.BorderSizePixel = 0
    gloss.Size = UDim2.new(1, 0, 0.3, 0)
    gloss.ZIndex = 2002
    Instance.new("UICorner", gloss).CornerRadius = UDim.new(0, 12)
    
    local icon = Instance.new("TextLabel")
    icon.Parent = popup
    icon.BackgroundTransparency = 1
    icon.Position = UDim2.new(0, 15, 0, 12)
    icon.Size = UDim2.new(0, 28, 0, 28)
    icon.Font = Enum.Font.GothamBold
    icon.Text = "🎮"
    icon.TextColor3 = CurrentTheme.Warning
    icon.TextSize = 22
    icon.ZIndex = 2002
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Parent = popup
    titleLabel.BackgroundTransparency = 1
    titleLabel.Position = UDim2.new(0, 48, 0, 14)
    titleLabel.Size = UDim2.new(1, -65, 0, 22)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Text = "Game Not Supported"
    titleLabel.TextColor3 = CurrentTheme.Warning
    titleLabel.TextSize = 14
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.ZIndex = 2002
    
    local msgLabel = Instance.new("TextLabel")
    msgLabel.Parent = popup
    msgLabel.BackgroundTransparency = 1
    msgLabel.Position = UDim2.new(0, 15, 0, 42)
    msgLabel.Size = UDim2.new(1, -30, 0, 55)
    msgLabel.Font = Enum.Font.Gotham
    msgLabel.Text = "No specific script was found for:\n🎮 " .. gameName .. "\n\nWould you like to load the Universal Admin instead?"
    msgLabel.TextColor3 = CurrentTheme.Text
    msgLabel.TextSize = 11
    msgLabel.TextWrapped = true
    msgLabel.TextXAlignment = Enum.TextXAlignment.Left
    msgLabel.ZIndex = 2002
    
    local yesBtn = Instance.new("TextButton")
    yesBtn.Parent = popup
    yesBtn.BackgroundColor3 = CurrentTheme.Success
    yesBtn.BorderSizePixel = 0
    yesBtn.Position = UDim2.new(0.08, 0, 0, 92)
    yesBtn.Size = UDim2.new(0.38, 0, 0, 30)
    yesBtn.Font = Enum.Font.GothamBold
    yesBtn.Text = "✅ Yes, load it"
    yesBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
    yesBtn.TextSize = 12
    yesBtn.AutoButtonColor = false
    yesBtn.ZIndex = 2002
    Instance.new("UICorner", yesBtn).CornerRadius = UDim.new(0, 8)
    
    local noBtn = Instance.new("TextButton")
    noBtn.Parent = popup
    noBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    noBtn.BorderSizePixel = 0
    noBtn.Position = UDim2.new(0.54, 0, 0, 92)
    noBtn.Size = UDim2.new(0.38, 0, 0, 30)
    noBtn.Font = Enum.Font.GothamBold
    noBtn.Text = "❌ Nevermind"
    noBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    noBtn.TextSize = 12
    noBtn.AutoButtonColor = false
    noBtn.ZIndex = 2002
    Instance.new("UICorner", noBtn).CornerRadius = UDim.new(0, 8)
    
    TweenService:Create(overlay, TweenInfo.new(0.2), {BackgroundTransparency = 0.4}):Play()
    TweenService:Create(popup, TweenInfo.new(0.3, Enum.EasingStyle.Back), {Size = UDim2.new(0, 320, 0, 132)}):Play()
    
    local function close()
        TweenService:Create(overlay, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
        TweenService:Create(popup, TweenInfo.new(0.2), {Size = UDim2.new(0, 0, 0, 0)}):Play()
        task.wait(0.2)
        overlay:Destroy()
    end
    
    yesBtn.MouseButton1Click:Connect(function()
        close()
        if yesCallback then yesCallback() end
    end)
    
    noBtn.MouseButton1Click:Connect(function()
        close()
        if noCallback then noCallback() end
    end)
end

-- =====================================================================
-- ANIMATE PROGRESS
-- =====================================================================
local function AnimateProgress(UI, target, duration, text)
    local startWidth = UI.BarFill.Size.X.Scale
    local startTime = tick()
    
    task.spawn(function()
        while tick() - startTime < duration do
            local alpha = math.min((tick() - startTime) / duration, 1)
            local eased = 1 - (1 - alpha) * (1 - alpha) -- ease out
            local current = startWidth + (target - startWidth) * eased
            UI.BarFill.Size = UDim2.new(current, 0, 1, 0)
            UI.PctLabel.Text = math.floor(current * 100) .. "%"
            RunService.RenderStepped:Wait()
        end
        UI.BarFill.Size = UDim2.new(target, 0, 1, 0)
        UI.PctLabel.Text = math.floor(target * 100) .. "%"
    end)
    
    if text then
        UI.StatusLabel.Text = text
    end
end

-- =====================================================================
-- MAIN HUB
-- =====================================================================
local function StartHub()
    local UI = ShowLoadingUI()
    
    task.wait(0.5)
    UI.Subtitle.Text = "Nebula Hub v3.0"
    AnimateProgress(UI, 0.2, 0.4, "🔍 Scanning for game...")
    
    task.wait(0.5)
    local gameId = game.PlaceId
    local gameName = "Unknown Game"
    pcall(function()
        gameName = game:GetService("MarketplaceService"):GetProductInfo(gameId).Name
    end)
    
    UI.GameInfoLabel.Text = "🎮 " .. gameName .. "  |  🆔 " .. gameId
    UI.Subtitle.Text = gameName
    AnimateProgress(UI, 0.5, 0.4, "📋 Checking database...")
    
    local gameScript = ScriptDatabase[gameId]
    
    task.wait(0.5)
    
    if gameScript then
        -- Script found!
        UI.StatusLabel.TextColor3 = CurrentTheme.Success
        AnimateProgress(UI, 0.75, 0.4, "✅ Found: " .. gameScript.Name)
        
        task.wait(0.3)
        AnimateProgress(UI, 0.9, 0.3, "📥 " .. gameScript.Description)
        
        local success, result = pcall(function()
            return loadstring(game:HttpGet(gameScript.Script))()
        end)
        
        task.wait(0.3)
        
        if success then
            AnimateProgress(UI, 1.0, 0.3, "✅ Script loaded successfully!")
            UI.StatusLabel.TextColor3 = CurrentTheme.Success
            
            task.wait(0.8)
            TweenService:Create(UI.Bg, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
            TweenService:Create(UI.Center, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
            task.wait(0.4)
            UI.SG:Destroy()
        else
            ShowErrorPopup(UI.SG, "Script Error", "Failed to load the script.\n\nError: " .. tostring(result), function()
                TweenService:Create(UI.Bg, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
                TweenService:Create(UI.Center, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
                task.wait(0.3)
                UI.SG:Destroy()
            end)
        end
    else
        -- Game not supported
        UI.StatusLabel.TextColor3 = CurrentTheme.Warning
        AnimateProgress(UI, 0.7, 0.4, "❌ No specific script found")
        
        task.wait(0.5)
        
        ShowChoicePopup(UI.SG, gameName,
            function()
                -- Yes - Load Universal
                AnimateProgress(UI, 0.9, 0.4, "📥 Loading Universal Admin...")
                
                local universal = ScriptDatabase["UNIVERSAL"]
                if universal then
                    local success, result = pcall(function()
                        return loadstring(game:HttpGet(universal.Script))()
                    end)
                    
                    if success then
                        AnimateProgress(UI, 1.0, 0.3, "✅ Universal Admin loaded!")
                        UI.StatusLabel.TextColor3 = CurrentTheme.Success
                        
                        task.wait(0.8)
                        TweenService:Create(UI.Bg, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
                        TweenService:Create(UI.Center, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
                        task.wait(0.4)
                        UI.SG:Destroy()
                    else
                        ShowErrorPopup(UI.SG, "Error", "Failed to load Universal Admin.\n\nError: " .. tostring(result), function()
                            UI.SG:Destroy()
                        end)
                    end
                end
            end,
            function()
                -- Nevermind
                TweenService:Create(UI.Bg, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
                TweenService:Create(UI.Center, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
                task.wait(0.3)
                UI.SG:Destroy()
            end
        )
    end
end

-- Start!
StartHub()
