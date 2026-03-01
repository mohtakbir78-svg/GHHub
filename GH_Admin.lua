-- Garden Horizons Admin Script
-- By: Your Hub

local player = game.Players.LocalPlayer
local rs = game:GetService("RunService")
local uis = game:GetService("UserInputService")

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

local function corner(p, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r or 10)
    c.Parent = p
end

-- ================================
-- TOMBOL BUKA ⚡ (bisa digeser)
-- ================================
local openBtn = Instance.new("TextButton")
openBtn.Size = UDim2.new(0,65,0,65)
openBtn.Position = UDim2.new(0,20,0.4,0)
openBtn.BackgroundColor3 = DARK
openBtn.Text = "⚡"
openBtn.TextScaled = true
openBtn.ZIndex = 9999
openBtn.Parent = sg
corner(openBtn, 32)
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
-- MAIN FRAME (langsung terbuka)
-- ================================
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0,320,0,460)
Frame.Position = UDim2.new(0.5,-160,0.5,-230)
Frame.BackgroundColor3 = DARK
Frame.BorderSizePixel = 0
Frame.Visible = true
Frame.ZIndex = 100
Frame.ClipsDescendants = true
Frame.Parent = sg
corner(Frame, 14)
local fStroke = Instance.new("UIStroke")
fStroke.Color = Color3.fromRGB(60,60,20)
fStroke.Thickness = 1.5
fStroke.Parent = Frame

-- TITLE BAR
local TBar = Instance.new("Frame")
TBar.Size = UDim2.new(1,0,0,48)
TBar.BackgroundColor3 = Color3.fromRGB(30,28,10)
TBar.BorderSizePixel = 0
TBar.ZIndex = 101
TBar.Parent = Frame
corner(TBar, 14)

local TFix = Instance.new("Frame")
TFix.Size = UDim2.new(1,0,0,10)
TFix.Position = UDim2.new(0,0,1,-10)
TFix.BackgroundColor3 = Color3.fromRGB(30,28,10)
TFix.BorderSizePixel = 0
TFix.ZIndex = 101
TFix.Parent = TBar

local TLbl = Instance.new("TextLabel")
TLbl.Size = UDim2.new(1,-50,1,0)
TLbl.Position = UDim2.new(0,12,0,0)
TLbl.BackgroundTransparency = 1
TLbl.Text = "⚡ GH Admin Hub"
TLbl.TextColor3 = GOLD
TLbl.Font = Enum.Font.GothamBold
TLbl.TextSize = 16
TLbl.TextXAlignment = Enum.TextXAlignment.Left
TLbl.ZIndex = 102
TLbl.Parent = TBar

local THint = Instance.new("TextLabel")
THint.Size = UDim2.new(1,-50,0,12)
THint.Position = UDim2.new(0,12,1,-14)
THint.BackgroundTransparency = 1
THint.Text = "☰ tahan & geser"
THint.TextColor3 = GRAY
THint.Font = Enum.Font.Gotham
THint.TextSize = 10
THint.TextXAlignment = Enum.TextXAlignment.Left
THint.ZIndex = 102
THint.Parent = TBar

local drag, dragStart, startPos = false, nil, nil
TBar.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
        drag = true; dragStart = i.Position; startPos = Frame.Position
    end
end)
TBar.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
        drag = false
    end
end)
uis.InputChanged:Connect(function(i)
    if drag and (i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseMove) then
        local d = i.Position - dragStart
        Frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset+d.X, startPos.Y.Scale, startPos.Y.Offset+d.Y)
    end
end)

-- CLOSE X
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0,34,0,34)
CloseBtn.Position = UDim2.new(1,-38,0,7)
CloseBtn.BackgroundColor3 = RED
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = WHITE
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 16
CloseBtn.ZIndex = 103
CloseBtn.Parent = TBar
corner(CloseBtn, 8)

-- ================================
-- SCROLL
-- ================================
local Scroll = Instance.new("ScrollingFrame")
Scroll.Size = UDim2.new(1,-14,1,-58)
Scroll.Position = UDim2.new(0,7,0,54)
Scroll.BackgroundTransparency = 1
Scroll.ScrollBarThickness = 4
Scroll.ScrollBarImageColor3 = GOLD
Scroll.ZIndex = 101
Scroll.Parent = Frame

local SLayout = Instance.new("UIListLayout")
SLayout.SortOrder = Enum.SortOrder.LayoutOrder
SLayout.Padding = UDim.new(0,8)
SLayout.Parent = Scroll

SLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    Scroll.CanvasSize = UDim2.new(0,0,0,SLayout.AbsoluteContentSize.Y+10)
end)

local function mkCard(h)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1,0,0,h or 50)
    f.BackgroundColor3 = CARD
    f.BorderSizePixel = 0
    f.ZIndex = 102
    f.Parent = Scroll
    corner(f, 10)
    return f
end

local function mkTitle(parent, txt)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1,-12,0,26)
    l.Position = UDim2.new(0,10,0,4)
    l.BackgroundTransparency = 1
    l.Text = txt
    l.TextColor3 = WHITE
    l.Font = Enum.Font.GothamBold
    l.TextSize = 13
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.ZIndex = 103
    l.Parent = parent
    return l
end

local function mkValLabel(parent, val, posY)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(0,46,0,22)
    l.Position = UDim2.new(0.5,-23,0,posY)
    l.BackgroundTransparency = 1
    l.Text = tostring(val)
    l.TextColor3 = GOLD
    l.Font = Enum.Font.GothamBold
    l.TextSize = 16
    l.ZIndex = 103
    l.Parent = parent
    return l
end

local function mkSmlBtn(parent, txt, sz, pos, col)
    local b = Instance.new("TextButton")
    b.Size = sz
    b.Position = pos
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

local function mkToggleBtn(parent, posY)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0,65,0,28)
    b.Position = UDim2.new(1,-73,0,posY)
    b.BackgroundColor3 = Color3.fromRGB(50,50,70)
    b.Text = "OFF"
    b.TextColor3 = GRAY
    b.Font = Enum.Font.GothamBold
    b.TextSize = 12
    b.ZIndex = 103
    b.Parent = parent
    corner(b, 7)
    return b
end

-- ================================
-- TERBANG
-- ================================
local flyCard = mkCard(130)
mkTitle(flyCard, "✈️ Terbang")

local FlyStatLbl = Instance.new("TextLabel")
FlyStatLbl.Size = UDim2.new(1,-12,0,18)
FlyStatLbl.Position = UDim2.new(0,10,0,30)
FlyStatLbl.BackgroundTransparency = 1
FlyStatLbl.Text = "Status: ❌ OFF"
FlyStatLbl.TextColor3 = RED
FlyStatLbl.Font = Enum.Font.GothamBold
FlyStatLbl.TextSize = 12
FlyStatLbl.TextXAlignment = Enum.TextXAlignment.Left
FlyStatLbl.ZIndex = 103
FlyStatLbl.Parent = flyCard

local FlySpeedLbl = mkValLabel(flyCard, "60", 52)
local FlyDecBtn = mkSmlBtn(flyCard, "-10", UDim2.new(0,55,0,22), UDim2.new(0,6,0,56),   Color3.fromRGB(140,50,20))
local FlyIncBtn = mkSmlBtn(flyCard, "+10", UDim2.new(0,55,0,22), UDim2.new(1,-61,0,56), Color3.fromRGB(30,90,160))

local FlyTogBtn = Instance.new("TextButton")
FlyTogBtn.Size = UDim2.new(1,-12,0,30)
FlyTogBtn.Position = UDim2.new(0,6,0,84)
FlyTogBtn.BackgroundColor3 = GREEN
FlyTogBtn.Text = "✈️ Aktifkan Terbang"
FlyTogBtn.TextColor3 = WHITE
FlyTogBtn.Font = Enum.Font.GothamBold
FlyTogBtn.TextSize = 13
FlyTogBtn.ZIndex = 103
FlyTogBtn.Parent = flyCard
corner(FlyTogBtn, 8)

local NaikBtn = Instance.new("TextButton")
NaikBtn.Size = UDim2.new(0.5,-9,0,26)
NaikBtn.Position = UDim2.new(0,6,1,-32)
NaikBtn.BackgroundColor3 = Color3.fromRGB(30,120,50)
NaikBtn.Text = "⬆️ Naik"
NaikBtn.TextColor3 = WHITE
NaikBtn.Font = Enum.Font.GothamBold
NaikBtn.TextSize = 12
NaikBtn.ZIndex = 103
NaikBtn.Parent = flyCard
corner(NaikBtn, 7)

local TurunBtn = Instance.new("TextButton")
TurunBtn.Size = UDim2.new(0.5,-9,0,26)
TurunBtn.Position = UDim2.new(0.5,3,1,-32)
TurunBtn.BackgroundColor3 = Color3.fromRGB(160,40,40)
TurunBtn.Text = "⬇️ Turun"
TurunBtn.TextColor3 = WHITE
TurunBtn.Font = Enum.Font.GothamBold
TurunBtn.TextSize = 12
TurunBtn.ZIndex = 103
TurunBtn.Parent = flyCard
corner(TurunBtn, 7)

-- ================================
-- SPEED BOOST
-- ================================
local sbCard = mkCard(80)
mkTitle(sbCard, "🏃 Speed Boost")
local sbVal = 16
local sbLbl = mkValLabel(sbCard, sbVal, 34)
local sbDec = mkSmlBtn(sbCard, "-5",          UDim2.new(0,50,0,22), UDim2.new(0,6,0,48),     Color3.fromRGB(140,50,20))
local sbInc = mkSmlBtn(sbCard, "+5",          UDim2.new(0,50,0,22), UDim2.new(1,-56,0,48),   Color3.fromRGB(30,90,160))
local sbSet = mkSmlBtn(sbCard, "✅ Set Speed", UDim2.new(0,110,0,22), UDim2.new(0.5,-55,0,48), BLUE)

-- ================================
-- JUMP POWER
-- ================================
local jpCard = mkCard(80)
mkTitle(jpCard, "🦘 Jump Power")
local jpVal = 50
local jpLbl = mkValLabel(jpCard, jpVal, 34)
local jpDec = mkSmlBtn(jpCard, "-10",         UDim2.new(0,50,0,22), UDim2.new(0,6,0,48),     Color3.fromRGB(140,50,20))
local jpInc = mkSmlBtn(jpCard, "+10",         UDim2.new(0,50,0,22), UDim2.new(1,-56,0,48),   Color3.fromRGB(30,90,160))
local jpSet = mkSmlBtn(jpCard, "✅ Set Jump",  UDim2.new(0,110,0,22), UDim2.new(0.5,-55,0,48), Color3.fromRGB(120,60,200))

-- ================================
-- INVISIBLE
-- ================================
local invCard = mkCard(52)
mkTitle(invCard, "👻 Invisible")
local invBtn = mkToggleBtn(invCard, 12)

-- ================================
-- CHAT DI LAYAR
-- ================================
local chatCard = mkCard(88)
mkTitle(chatCard, "💬 Chat di Layar")

local chatBox = Instance.new("TextBox")
chatBox.Size = UDim2.new(1,-82,0,30)
chatBox.Position = UDim2.new(0,8,0,34)
chatBox.BackgroundColor3 = Color3.fromRGB(18,18,28)
chatBox.Text = ""
chatBox.PlaceholderText = "Tulis pesan..."
chatBox.PlaceholderColor3 = GRAY
chatBox.TextColor3 = WHITE
chatBox.Font = Enum.Font.Gotham
chatBox.TextSize = 12
chatBox.ZIndex = 103
chatBox.ClearTextOnFocus = false
chatBox.Parent = chatCard
corner(chatBox, 7)

local sendBtn = mkSmlBtn(chatCard, "📢 Send", UDim2.new(0,64,0,30), UDim2.new(1,-72,0,34), GREEN)

local chatFrame = Instance.new("Frame")
chatFrame.Size = UDim2.new(0,300,0,56)
chatFrame.Position = UDim2.new(0.5,-150,0,70)
chatFrame.BackgroundColor3 = Color3.fromRGB(0,0,0)
chatFrame.BackgroundTransparency = 0.35
chatFrame.BorderSizePixel = 0
chatFrame.ZIndex = 9998
chatFrame.Visible = false
chatFrame.Parent = sg
corner(chatFrame, 10)

local chatLbl = Instance.new("TextLabel")
chatLbl.Size = UDim2.new(1,-16,1,0)
chatLbl.Position = UDim2.new(0,8,0,0)
chatLbl.BackgroundTransparency = 1
chatLbl.Text = ""
chatLbl.TextColor3 = WHITE
chatLbl.Font = Enum.Font.GothamBold
chatLbl.TextSize = 18
chatLbl.TextWrapped = true
chatLbl.ZIndex = 9999
chatLbl.Parent = chatFrame

-- Reset
local resetCard = Instance.new("Frame")
resetCard.Size = UDim2.new(1,0,0,44)
resetCard.BackgroundTransparency = 1
resetCard.ZIndex = 101
resetCard.Parent = Scroll

local resetBtn = Instance.new("TextButton")
resetBtn.Size = UDim2.new(1,0,1,0)
resetBtn.BackgroundColor3 = Color3.fromRGB(55,60,80)
resetBtn.Text = "↺ Reset Semua Default"
resetBtn.TextColor3 = WHITE
resetBtn.Font = Enum.Font.GothamBold
resetBtn.TextSize = 14
resetBtn.ZIndex = 103
resetBtn.Parent = resetCard
corner(resetBtn, 10)

-- ================================
-- LOGIKA TERBANG
-- ================================
local flying = false
local flySpeed = 60
local goUp, goDown = false, false
local bv, bg

local function startFly()
    flying = true
    local char = player.Character
    if not char then return end
    local hum  = char:FindFirstChildOfClass("Humanoid")
    local root = char:FindFirstChild("HumanoidRootPart")
    if not hum or not root then return end
    hum.PlatformStand = true
    bv = Instance.new("BodyVelocity")
    bv.MaxForce = Vector3.new(1e5,1e5,1e5)
    bv.Velocity = Vector3.zero
    bv.Parent = root
    bg = Instance.new("BodyGyro")
    bg.MaxTorque = Vector3.new(1e5,1e5,1e5)
    bg.D = 50
    bg.Parent = root
    FlyTogBtn.Text = "🛑 Matikan Terbang"
    FlyTogBtn.BackgroundColor3 = RED
    FlyStatLbl.Text = "Status: ✅ ON"
    FlyStatLbl.TextColor3 = GREEN
end

local function stopFly()
    flying = false
    local char = player.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then hum.PlatformStand = false end
    if bv then bv:Destroy(); bv = nil end
    if bg then bg:Destroy(); bg = nil end
    FlyTogBtn.Text = "✈️ Aktifkan Terbang"
    FlyTogBtn.BackgroundColor3 = GREEN
    FlyStatLbl.Text = "Status: ❌ OFF"
    FlyStatLbl.TextColor3 = RED
end

rs.RenderStepped:Connect(function()
    if not flying then return end
    local char = player.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    local hum  = char:FindFirstChildOfClass("Humanoid")
    if not root or not bv then return end
    local dir = Vector3.zero
    if hum and hum.MoveDirection.Magnitude > 0 then
        dir = Vector3.new(hum.MoveDirection.X,0,hum.MoveDirection.Z)
    end
    if goUp   then dir = dir + Vector3.new(0,1,0) end
    if goDown then dir = dir - Vector3.new(0,1,0) end
    if dir.Magnitude > 0 then dir = dir.Unit end
    bv.Velocity = dir * flySpeed
    bg.CFrame = workspace.CurrentCamera.CFrame
end)

FlyTogBtn.MouseButton1Click:Connect(function()
    if flying then stopFly() else startFly() end
end)
FlyDecBtn.MouseButton1Click:Connect(function() flySpeed = math.max(10,flySpeed-10); FlySpeedLbl.Text = tostring(flySpeed) end)
FlyIncBtn.MouseButton1Click:Connect(function() flySpeed = math.min(300,flySpeed+10); FlySpeedLbl.Text = tostring(flySpeed) end)

NaikBtn.MouseButton1Down:Connect(function() goUp = true end)
NaikBtn.MouseButton1Up:Connect(function()   goUp = false end)
NaikBtn.TouchStarted:Connect(function() goUp = true end)
NaikBtn.TouchEnded:Connect(function()   goUp = false end)

TurunBtn.MouseButton1Down:Connect(function() goDown = true end)
TurunBtn.MouseButton1Up:Connect(function()   goDown = false end)
TurunBtn.TouchStarted:Connect(function() goDown = true end)
TurunBtn.TouchEnded:Connect(function()   goDown = false end)

-- ================================
-- LOGIKA ADMIN
-- ================================
local isInvis = false

local function applySpeed(v)
    local char = player.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then hum.WalkSpeed = v end
end

local function applyJump(v)
    local char = player.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then hum.JumpPower = v end
end

local function applyInvis(state)
    local char = player.Character
    if not char then return end
    for _, p in ipairs(char:GetDescendants()) do
        if p:IsA("BasePart") and p.Name ~= "HumanoidRootPart" then
            p.Transparency = state and 1 or 0
        end
        if p:IsA("Decal") then p.Transparency = state and 1 or 0 end
    end
end

sbDec.MouseButton1Click:Connect(function() sbVal = math.max(1,sbVal-5);   sbLbl.Text = tostring(sbVal) end)
sbInc.MouseButton1Click:Connect(function() sbVal = math.min(500,sbVal+5); sbLbl.Text = tostring(sbVal) end)
sbSet.MouseButton1Click:Connect(function() applySpeed(sbVal) end)

jpDec.MouseButton1Click:Connect(function() jpVal = math.max(1,jpVal-10);   jpLbl.Text = tostring(jpVal) end)
jpInc.MouseButton1Click:Connect(function() jpVal = math.min(500,jpVal+10); jpLbl.Text = tostring(jpVal) end)
jpSet.MouseButton1Click:Connect(function() applyJump(jpVal) end)

invBtn.MouseButton1Click:Connect(function()
    isInvis = not isInvis
    applyInvis(isInvis)
    invBtn.BackgroundColor3 = isInvis and GREEN or Color3.fromRGB(50,50,70)
    invBtn.TextColor3       = isInvis and WHITE or GRAY
    invBtn.Text = isInvis and "ON" or "OFF"
end)

local chatTimer
sendBtn.MouseButton1Click:Connect(function()
    local msg = chatBox.Text
    if msg ~= "" then
        chatLbl.Text = "💬 " .. msg
        chatFrame.Visible = true
        chatBox.Text = ""
        if chatTimer then task.cancel(chatTimer) end
        chatTimer = task.delay(5, function()
            chatFrame.Visible = false
        end)
    end
end)

resetBtn.MouseButton1Click:Connect(function()
    sbVal = 16; sbLbl.Text = "16"; applySpeed(16)
    jpVal = 50; jpLbl.Text = "50"; applyJump(50)
    isInvis = false; applyInvis(false)
    invBtn.BackgroundColor3 = Color3.fromRGB(50,50,70)
    invBtn.TextColor3 = GRAY; invBtn.Text = "OFF"
    stopFly()
end)

player.CharacterAdded:Connect(function()
    task.wait(0.5)
    applySpeed(sbVal); applyJump(jpVal)
    if isInvis then applyInvis(true) end
    flying = false; bv = nil; bg = nil
    FlyTogBtn.Text = "✈️ Aktifkan Terbang"
    FlyTogBtn.BackgroundColor3 = GREEN
    FlyStatLbl.Text = "Status: ❌ OFF"
    FlyStatLbl.TextColor3 = RED
end)

-- OPEN / CLOSE
openBtn.MouseButton1Click:Connect(function() Frame.Visible = true end)
CloseBtn.MouseButton1Click:Connect(function() Frame.Visible = false end)
