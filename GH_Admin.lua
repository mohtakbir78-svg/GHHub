-- The Forge Hub
-- Auto Mine + Auto Forge + Kill Aura + Auto Sell + ESP + Auto Potion
-- Delta Compatible

local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local rs = game:GetService("RunService")
local uis = game:GetService("UserInputService")
local ts = game:GetService("TweenService")

local sg = Instance.new("ScreenGui")
sg.ResetOnSpawn = false
sg.DisplayOrder = 9999
sg.Parent = gethui and gethui() or player.PlayerGui

local WHITE = Color3.fromRGB(255,255,255)
local GREEN = Color3.fromRGB(40,160,60)
local RED   = Color3.fromRGB(200,50,50)
local BLUE  = Color3.fromRGB(40,120,200)
local DARK  = Color3.fromRGB(14,14,22)
local CARD  = Color3.fromRGB(24,24,36)
local GRAY  = Color3.fromRGB(120,120,140)
local GOLD  = Color3.fromRGB(240,190,50)
local PURP  = Color3.fromRGB(120,60,200)
local ORANGE= Color3.fromRGB(220,120,30)

local function corner(p, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r or 10)
    c.Parent = p
end

-- ================================
-- MAIN FRAME
-- ================================
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 380, 0, 310)
Frame.Position = UDim2.new(0.5, -190, 0.5, -155)
Frame.BackgroundColor3 = DARK
Frame.BorderSizePixel = 0
Frame.Visible = true
Frame.ZIndex = 100
Frame.ClipsDescendants = true
Frame.Parent = sg
corner(Frame, 14)
local fStroke = Instance.new("UIStroke")
fStroke.Color = Color3.fromRGB(80,50,20)
fStroke.Thickness = 1.5
fStroke.Parent = Frame

-- TITLE BAR
local TBar = Instance.new("Frame")
TBar.Size = UDim2.new(1,0,0,40)
TBar.BackgroundColor3 = Color3.fromRGB(36,22,10)
TBar.BorderSizePixel = 0
TBar.ZIndex = 101
TBar.Parent = Frame
corner(TBar, 14)

local TFix = Instance.new("Frame")
TFix.Size = UDim2.new(1,0,0,10)
TFix.Position = UDim2.new(0,0,1,-10)
TFix.BackgroundColor3 = Color3.fromRGB(36,22,10)
TFix.BorderSizePixel = 0
TFix.ZIndex = 101
TFix.Parent = TBar

local TLbl = Instance.new("TextLabel")
TLbl.Size = UDim2.new(1,-50,1,0)
TLbl.Position = UDim2.new(0,12,0,0)
TLbl.BackgroundTransparency = 1
TLbl.Text = "⚒️ The Forge Hub  •  ☰ geser"
TLbl.TextColor3 = GOLD
TLbl.Font = Enum.Font.GothamBold
TLbl.TextSize = 14
TLbl.TextXAlignment = Enum.TextXAlignment.Left
TLbl.ZIndex = 102
TLbl.Parent = TBar

-- CLOSE BTN
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0,34,0,34)
CloseBtn.BackgroundColor3 = RED
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = WHITE
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 16
CloseBtn.ZIndex = 99999
CloseBtn.Parent = sg
corner(CloseBtn, 8)

local function updateClose()
    local fp = Frame.AbsolutePosition
    local fs = Frame.AbsoluteSize
    CloseBtn.Position = UDim2.new(0, fp.X+fs.X-38, 0, fp.Y+4)
end
Frame:GetPropertyChangedSignal("AbsolutePosition"):Connect(updateClose)
Frame:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateClose)
updateClose()

-- DRAG
local drag, dragStart, startPos = false, nil, nil
TBar.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
        drag = true; dragStart = i.Position; startPos = Frame.Position
    end
end)
TBar.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then drag = false end
end)
uis.InputChanged:Connect(function(i)
    if drag and (i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseMove) then
        local d = i.Position - dragStart
        Frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset+d.X, startPos.Y.Scale, startPos.Y.Offset+d.Y)
        updateClose()
    end
end)

-- ================================
-- HORIZONTAL SCROLL
-- ================================
local HScroll = Instance.new("ScrollingFrame")
HScroll.Size = UDim2.new(1,-10,1,-48)
HScroll.Position = UDim2.new(0,5,0,44)
HScroll.BackgroundTransparency = 1
HScroll.ScrollBarThickness = 4
HScroll.ScrollBarImageColor3 = GOLD
HScroll.ScrollingDirection = Enum.ScrollingDirection.X
HScroll.ZIndex = 101
HScroll.Parent = Frame

local HLayout = Instance.new("UIListLayout")
HLayout.FillDirection = Enum.FillDirection.Horizontal
HLayout.SortOrder = Enum.SortOrder.LayoutOrder
HLayout.Padding = UDim.new(0,8)
HLayout.VerticalAlignment = Enum.VerticalAlignment.Center
HLayout.Parent = HScroll

local UIPad = Instance.new("UIPadding")
UIPad.PaddingLeft = UDim.new(0,4)
UIPad.PaddingRight = UDim.new(0,4)
UIPad.Parent = HScroll

HLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    HScroll.CanvasSize = UDim2.new(0, HLayout.AbsoluteContentSize.X+10, 0, 0)
end)

-- Helper
local function mkSection(order, w)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(0, w or 160, 1, -10)
    f.BackgroundColor3 = CARD
    f.BorderSizePixel = 0
    f.LayoutOrder = order
    f.ZIndex = 102
    f.Parent = HScroll
    corner(f, 10)
    return f
end

local function secTitle(parent, txt, col)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1,-10,0,24)
    l.Position = UDim2.new(0,6,0,5)
    l.BackgroundTransparency = 1
    l.Text = txt
    l.TextColor3 = col or WHITE
    l.Font = Enum.Font.GothamBold
    l.TextSize = 13
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.ZIndex = 103
    l.Parent = parent
end

local function secStat(parent, txt, posY, col)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1,-10,0,18)
    l.Position = UDim2.new(0,6,0,posY)
    l.BackgroundTransparency = 1
    l.Text = txt
    l.TextColor3 = col or RED
    l.Font = Enum.Font.GothamBold
    l.TextSize = 11
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.ZIndex = 103
    l.Parent = parent
    return l
end

local function secBtn(parent, txt, posX, posY, w, h, col)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0, w or 70, 0, h or 28)
    b.Position = UDim2.new(0, posX, 0, posY)
    b.BackgroundColor3 = col or BLUE
    b.Text = txt
    b.TextColor3 = WHITE
    b.Font = Enum.Font.GothamBold
    b.TextSize = 12
    b.ZIndex = 103
    b.Parent = parent
    corner(b, 7)
    return b
end

local function secTog(parent, posX, posY, w)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0, w or 148, 0, 30)
    b.Position = UDim2.new(0, posX, 0, posY)
    b.BackgroundColor3 = Color3.fromRGB(50,50,70)
    b.Text = "OFF"
    b.TextColor3 = GRAY
    b.Font = Enum.Font.GothamBold
    b.TextSize = 13
    b.ZIndex = 103
    b.Parent = parent
    corner(b, 7)
    return b
end

-- ================================
-- SECTION 1: AUTO MINE
-- ================================
local mineS = mkSection(1, 165)
secTitle(mineS, "⛏️ Auto Mine", GOLD)
local mineStatLbl = secStat(mineS, "❌ OFF", 32)
local mineRangeLbl = secStat(mineS, "Range: 15 studs", 50, GRAY)
local mineBtn = secTog(mineS, 8, 72)
local mineDecBtn = secBtn(mineS, "Range -5", 8, 108, 72, 24, Color3.fromRGB(140,50,20))
local mineIncBtn = secBtn(mineS, "Range +5", 85, 108, 72, 24, Color3.fromRGB(30,90,160))

-- ================================
-- SECTION 2: AUTO FORGE
-- ================================
local forgeS = mkSection(2, 165)
secTitle(forgeS, "🔨 Auto Forge", ORANGE)
local forgeStatLbl = secStat(forgeS, "❌ OFF", 32)
local forgeInfoLbl = secStat(forgeS, "Skip minigame otomatis", 50, GRAY)
local forgeBtn = secTog(forgeS, 8, 72)
local forgeQualLbl = secStat(forgeS, "Quality: Max", 108, GOLD)

-- ================================
-- SECTION 3: KILL AURA
-- ================================
local killS = mkSection(3, 165)
secTitle(killS, "⚔️ Kill Aura", RED)
local killStatLbl = secStat(killS, "❌ OFF", 32)
local killRangeLbl = secStat(killS, "Range: 20 studs", 50, GRAY)
local killBtn = secTog(killS, 8, 72)
local killDecBtn = secBtn(killS, "Range -5", 8, 108, 72, 24, Color3.fromRGB(140,50,20))
local killIncBtn = secBtn(killS, "Range +5", 85, 108, 72, 24, Color3.fromRGB(30,90,160))

-- ================================
-- SECTION 4: AUTO SELL
-- ================================
local sellS = mkSection(4, 165)
secTitle(sellS, "🛒 Auto Sell", GREEN)
local sellStatLbl = secStat(sellS, "❌ OFF", 32)
local sellInfoLbl = secStat(sellS, "Jual otomatis ke NPC", 50, GRAY)
local sellBtn = secTog(sellS, 8, 72)
local sellDelayLbl = secStat(sellS, "Delay: 3 detik", 108, GOLD)

-- ================================
-- SECTION 5: ESP
-- ================================
local espS = mkSection(5, 165)
secTitle(espS, "👁️ ESP", BLUE)
local espOreStatLbl = secStat(espS, "Ore ESP: ❌ OFF", 32)
local espPlyStatLbl = secStat(espS, "Player ESP: ❌ OFF", 50)
local espOreBtn = secBtn(espS, "Ore ESP", 8, 72, 72, 28, BLUE)
local espPlyBtn = secBtn(espS, "Player ESP", 85, 72, 72, 28, PURP)

-- ================================
-- SECTION 6: AUTO POTION
-- ================================
local potS = mkSection(6, 165)
secTitle(potS, "🧪 Auto Potion", PURP)
local potStatLbl = secStat(potS, "❌ OFF", 32)
local potInfoLbl = secStat(potS, "Pakai saat HP < 50%", 50, GRAY)
local potBtn = secTog(potS, 8, 72)
local potHpLbl = secStat(potS, "HP Trigger: 50%", 108, GOLD)

-- ================================
-- OPEN BTN
-- ================================
local openBtn = Instance.new("TextButton")
openBtn.Size = UDim2.new(0,56,0,56)
openBtn.Position = UDim2.new(0,14,0.43,0)
openBtn.BackgroundColor3 = DARK
openBtn.Text = "⚒️"
openBtn.TextScaled = true
openBtn.ZIndex = 9999
openBtn.Visible = false
openBtn.Parent = sg
corner(openBtn, 28)
local obStroke = Instance.new("UIStroke")
obStroke.Color = GOLD
obStroke.Thickness = 2
obStroke.Parent = openBtn

local obDrag, obDragStart, obStartPos = false, nil, nil
openBtn.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
        obDrag = true; obDragStart = i.Position; obStartPos = openBtn.Position
    end
end)
openBtn.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
        obDrag = false
    end
end)
uis.InputChanged:Connect(function(i)
    if obDrag and (i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseMove) then
        local d = i.Position - obDragStart
        openBtn.Position = UDim2.new(obStartPos.X.Scale, obStartPos.X.Offset+d.X, obStartPos.Y.Scale, obStartPos.Y.Offset+d.Y)
    end
end)

-- ================================
-- ESP HIGHLIGHTS
-- ================================
local espOreOn = false
local espPlyOn = false
local espConnections = {}

local function clearESP()
    for _, h in ipairs(espConnections) do pcall(function() h:Destroy() end) end
    espConnections = {}
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("SelectionBox") and obj.Name == "ForgeESP" then
            obj:Destroy()
        end
        if obj:IsA("BillboardGui") and obj.Name == "ForgeESPTag" then
            obj:Destroy()
        end
    end
end

local function addESP(part, color, label)
    local box = Instance.new("SelectionBox")
    box.Name = "ForgeESP"
    box.Adornee = part
    box.Color3 = color
    box.LineThickness = 0.04
    box.SurfaceTransparency = 0.7
    box.SurfaceColor3 = color
    box.ZIndex = 1
    box.Parent = workspace

    local bg = Instance.new("BillboardGui")
    bg.Name = "ForgeESPTag"
    bg.Size = UDim2.new(0,80,0,20)
    bg.StudsOffset = Vector3.new(0,2,0)
    bg.AlwaysOnTop = true
    bg.Adornee = part
    bg.Parent = workspace

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1,0,1,0)
    lbl.BackgroundTransparency = 1
    lbl.Text = label
    lbl.TextColor3 = color
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 12
    lbl.Parent = bg

    table.insert(espConnections, box)
    table.insert(espConnections, bg)
end

local function refreshESP()
    clearESP()
    if espOreOn then
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") or obj:IsA("MeshPart") then
                local n = obj.Name:lower()
                if n:find("ore") or n:find("rock") or n:find("crystal") or n:find("mineral") then
                    addESP(obj, GOLD, "⛏️ " .. obj.Name)
                end
            end
        end
    end
    if espPlyOn then
        for _, p in ipairs(game.Players:GetPlayers()) do
            if p ~= player and p.Character then
                local root = p.Character:FindFirstChild("HumanoidRootPart")
                if root then addESP(root, RED, "👤 " .. p.Name) end
            end
        end
    end
end

-- ================================
-- LOGIKA AUTO MINE
-- ================================
local autoMine = false
local mineRange = 15
local mineConn

local function doMine()
    local c = player.Character
    if not c then return end
    local root = c:FindFirstChild("HumanoidRootPart")
    if not root then return end
    local hum = c:FindFirstChildOfClass("Humanoid")

    -- Cari ore/rock terdekat
    local closest, closestDist = nil, mineRange
    for _, obj in ipairs(workspace:GetDescendants()) do
        if (obj:IsA("BasePart") or obj:IsA("MeshPart")) and obj.CanCollide then
            local n = obj.Name:lower()
            if n:find("ore") or n:find("rock") or n:find("crystal") or n:find("mineral") or n:find("stone") then
                local dist = (root.Position - obj.Position).Magnitude
                if dist < closestDist then
                    closest = obj
                    closestDist = dist
                end
            end
        end
    end

    if closest then
        -- Teleport mendekati ore
        if closestDist > 6 then
            local dir = (closest.Position - root.Position).Unit
            root.CFrame = CFrame.new(closest.Position - dir * 4)
        end
        -- Fire RemoteEvent mine
        for _, re in ipairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
            if re:IsA("RemoteEvent") then
                local n = re.Name:lower()
                if n:find("mine") or n:find("hit") or n:find("break") or n:find("pick") then
                    pcall(function() re:FireServer(closest) end)
                    pcall(function() re:FireServer(closest, 1) end)
                end
            end
        end
        -- Simulate click/tool activation
        local tool = c:FindFirstChildOfClass("Tool")
        if tool then
            local handle = tool:FindFirstChild("Handle")
            if handle then
                pcall(function()
                    tool:Activate()
                end)
            end
        end
    end
end

-- ================================
-- LOGIKA AUTO FORGE
-- ================================
local autoForge = false
local forgeConn

local function doForge()
    for _, re in ipairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
        if re:IsA("RemoteEvent") then
            local n = re.Name:lower()
            if n:find("forge") or n:find("craft") or n:find("smelt") then
                pcall(function() re:FireServer() end)
                pcall(function() re:FireServer(true) end)
                pcall(function() re:FireServer("max") end)
            end
        end
    end
    -- Skip minigame dengan fire semua possible remote
    for _, re in ipairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
        if re:IsA("RemoteEvent") then
            local n = re.Name:lower()
            if n:find("hit") or n:find("minigame") or n:find("timing") or n:find("perfect") or n:find("quality") then
                pcall(function() re:FireServer(true) end)
                pcall(function() re:FireServer(100) end)
                pcall(function() re:FireServer("perfect") end)
            end
        end
    end
end

-- ================================
-- LOGIKA KILL AURA
-- ================================
local killAura = false
local killRange = 20
local killConn

local function doKillAura()
    local c = player.Character
    if not c then return end
    local root = c:FindFirstChild("HumanoidRootPart")
    if not root then return end
    local tool = c:FindFirstChildOfClass("Tool")

    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Humanoid") and obj.Health > 0 then
            local parent = obj.Parent
            if parent ~= c and not game.Players:GetPlayerFromCharacter(parent) then
                local enemyRoot = parent:FindFirstChild("HumanoidRootPart") or parent:FindFirstChild("Root") or parent.PrimaryPart
                if enemyRoot then
                    local dist = (root.Position - enemyRoot.Position).Magnitude
                    if dist <= killRange then
                        -- Teleport ke musuh dan serang
                        local dir = (enemyRoot.Position - root.Position).Unit
                        root.CFrame = CFrame.new(enemyRoot.Position - dir * 4) * CFrame.Angles(0, math.atan2(dir.X, dir.Z), 0)
                        -- Fire attack remote
                        for _, re in ipairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
                            if re:IsA("RemoteEvent") then
                                local n = re.Name:lower()
                                if n:find("attack") or n:find("hit") or n:find("damage") or n:find("swing") then
                                    pcall(function() re:FireServer(parent) end)
                                    pcall(function() re:FireServer(enemyRoot.Position) end)
                                end
                            end
                        end
                        -- Activate tool
                        if tool then pcall(function() tool:Activate() end) end
                    end
                end
            end
        end
    end
end

-- ================================
-- LOGIKA AUTO SELL
-- ================================
local autoSell = false
local sellConn

local function doSell()
    for _, re in ipairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
        if re:IsA("RemoteEvent") then
            local n = re.Name:lower()
            if n:find("sell") or n:find("trade") or n:find("vendor") or n:find("shop") then
                pcall(function() re:FireServer() end)
                pcall(function() re:FireServer("all") end)
                pcall(function() re:FireServer(true) end)
            end
        end
    end
end

-- ================================
-- LOGIKA AUTO POTION
-- ================================
local autoPotion = false
local potHpTrigger = 50
local potConn

local function doPotion()
    local c = player.Character
    if not c then return end
    local hum = c:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    local hpPct = (hum.Health / hum.MaxHealth) * 100
    if hpPct <= potHpTrigger then
        for _, re in ipairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
            if re:IsA("RemoteEvent") then
                local n = re.Name:lower()
                if n:find("potion") or n:find("heal") or n:find("drink") or n:find("use") then
                    pcall(function() re:FireServer() end)
                    pcall(function() re:FireServer("health") end)
                end
            end
        end
        -- Coba pakai item dari inventory
        local bp = player:FindFirstChild("Backpack") or player:FindFirstChild("Inventory")
        if bp then
            for _, tool in ipairs(bp:GetChildren()) do
                local n = tool.Name:lower()
                if n:find("potion") or n:find("heal") then
                    tool.Parent = c
                    task.wait(0.1)
                    pcall(function() tool:Activate() end)
                    task.wait(0.1)
                    tool.Parent = bp
                end
            end
        end
    end
end

-- ================================
-- LOOP UTAMA
-- ================================
rs.Heartbeat:Connect(function()
    if autoMine then pcall(doMine) end
    if killAura then pcall(doKillAura) end
e
