-- Garden Horizons Admin Script
-- Horizontal Layout + Real Chat (terlihat semua orang)

local player = game.Players.LocalPlayer
local rs = game:GetService("RunService")
local uis = game:GetService("UserInputService")
local chat = game:GetService("Chat")

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

local function corner(p, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r or 10)
    c.Parent = p
end

-- ================================
-- MAIN FRAME (horizontal)
-- ================================
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 590, 0, 262)
Frame.Position = UDim2.new(0.5, -295, 0.5, -131)
Frame.BackgroundColor3 = DARK
Frame.BorderSizePixel = 0
Frame.Visible = true
Frame.ZIndex = 100
Frame.ClipsDescendants = true
Frame.Parent = sg
corner(Frame, 14)
local fStroke = Instance.new("UIStroke")
fStroke.Color = Color3.fromRGB(60,55,10)
fStroke.Thickness = 1.5
fStroke.Parent = Frame

-- TITLE BAR
local TBar = Instance.new("Frame")
TBar.Size = UDim2.new(1, 0, 0, 42)
TBar.BackgroundColor3 = Color3.fromRGB(30,28,10)
TBar.BorderSizePixel = 0
TBar.ZIndex = 101
TBar.Parent = Frame
corner(TBar, 14)

local TFix = Instance.new("Frame")
TFix.Size = UDim2.new(1, 0, 0, 12)
TFix.Position = UDim2.new(0, 0, 1, -12)
TFix.BackgroundColor3 = Color3.fromRGB(30,28,10)
TFix.BorderSizePixel = 0
TFix.ZIndex = 101
TFix.Parent = TBar

local TLbl = Instance.new("TextLabel")
TLbl.Size = UDim2.new(1, -60, 1, 0)
TLbl.Position = UDim2.new(0, 14, 0, 0)
TLbl.BackgroundTransparency = 1
TLbl.Text = "⚡ GH Admin Hub  •  ☰ tahan & geser"
TLbl.TextColor3 = GOLD
TLbl.Font = Enum.Font.GothamBold
TLbl.TextSize = 14
TLbl.TextXAlignment = Enum.TextXAlignment.Left
TLbl.ZIndex = 102
TLbl.Parent = TBar

-- TOMBOL X (parent ke sg, biar tidak terpotong)
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 36, 0, 36)
CloseBtn.BackgroundColor3 = RED
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = WHITE
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 18
CloseBtn.ZIndex = 99999
CloseBtn.Parent = sg
corner(CloseBtn, 8)

local function updateClosePos()
    local fp = Frame.AbsolutePosition
    local fs = Frame.AbsoluteSize
    CloseBtn.Position = UDim2.new(0, fp.X + fs.X - 42, 0, fp.Y + 4)
end
Frame:GetPropertyChangedSignal("AbsolutePosition"):Connect(updateClosePos)
Frame:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateClosePos)
updateClosePos()

-- DRAG
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
        updateClosePos()
    end
end)

-- ================================
-- CONTENT (horizontal columns)
-- ================================
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -10, 1, -48)
Content.Position = UDim2.new(0, 5, 0, 44)
Content.BackgroundTransparency = 1
Content.ZIndex = 101
Content.Parent = Frame

local HLayout = Instance.new("UIListLayout")
HLayout.FillDirection = Enum.FillDirection.Horizontal
HLayout.SortOrder = Enum.SortOrder.LayoutOrder
HLayout.Padding = UDim.new(0, 6)
HLayout.VerticalAlignment = Enum.VerticalAlignment.Center
HLayout.Parent = Content

local function mkCol(order, w)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(0, w or 128, 1, -8)
    f.BackgroundColor3 = CARD
    f.BorderSizePixel = 0
    f.LayoutOrder = order
    f.ZIndex = 102
    f.Parent = Content
    corner(f, 10)
    return f
end

local function mkColTitle(parent, txt)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1,-8,0,24)
    l.Position = UDim2.new(0,4,0,5)
    l.BackgroundTransparency = 1
    l.Text = txt
    l.TextColor3 = WHITE
    l.Font = Enum.Font.GothamBold
    l.TextSize = 13
    l.TextXAlignment = Enum.TextXAlignment.Center
    l.ZIndex = 103
    l.Parent = parent
end

local function mkValLbl(parent, val, posY)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1,0,0,22)
    l.Position = UDim2.new(0,0,0,posY)
    l.BackgroundTransparency = 1
    l.Text = tostring(val)
    l.TextColor3 = GOLD
    l.Font = Enum.Font.GothamBold
    l.TextSize = 18
    l.TextXAlignment = Enum.TextXAlignment.Center
    l.ZIndex = 103
    l.Parent = parent
    return l
end

local function mkBtn(parent, txt, posY, h, col)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1,-10,0,h or 26)
    b.Position = UDim2.new(0,5,0,posY)
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

local function mkTogBtn(parent, posY)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1,-10,0,34)
    b.Position = UDim2.new(0,5,0,posY)
    b.BackgroundColor3 = Color3.fromRGB(50,50,70)
    b.Text = "OFF"
    b.TextColor3 = GRAY
    b.Font = Enum.Font.GothamBold
    b.TextSize = 14
    b.ZIndex = 103
    b.Parent = parent
    corner(b, 8)
    return b
end

-- COL 1: TERBANG
local flyCol = mkCol(1)
mkColTitle(flyCol, "✈️ Terbang")
local FlyStatLbl = Instance.new("TextLabel")
FlyStatLbl.Size = UDim2.new(1,-6,0,18)
FlyStatLbl.Position = UDim2.new(0,3,0,32)
FlyStatLbl.BackgroundTransparency = 1
FlyStatLbl.Text = "❌ OFF"
FlyStatLbl.TextColor3 = RED
FlyStatLbl.Font = Enum.Font.GothamBold
FlyStatLbl.TextSize = 11
FlyStatLbl.TextXAlignment = Enum.TextXAlignment.Center
FlyStatLbl.ZIndex = 103
FlyStatLbl.Parent = flyCol

local FlySpeedLbl = mkValLbl(flyCol, "60", 52)
local FlyDecBtn   = mkBtn(flyCol, "- 10",       76,  24, Color3.fromRGB(140,50,20))
local FlyIncBtn   = mkBtn(flyCol, "+ 10",       106, 24, Color3.fromRGB(30,90,160))
local FlyTogBtn   = mkBtn(flyCol, "✈️ Aktifkan", 136, 28, GREEN)
local NaikBtn     = mkBtn(flyCol, "⬆️ Naik",    170, 24, Color3.fromRGB(30,120,50))
local TurunBtn    = mkBtn(flyCol, "⬇️ Turun",   200, 24, Color3.fromRGB(160,40,40))

-- COL 2: SPEED
local sbCol = mkCol(2)
mkColTitle(sbCol, "🏃 Speed")
local sbVal = 16
local sbLbl = mkValLbl(sbCol, sbVal, 32)
local sbDec = mkBtn(sbCol, "- 5",    58,  24, Color3.fromRGB(140,50,20))
local sbInc = mkBtn(sbCol, "+ 5",    88,  24, Color3.fromRGB(30,90,160))
local sbSet = mkBtn(sbCol, "✅ Set", 120, 30, BLUE)

-- COL 3: JUMP
local jpCol = mkCol(3)
mkColTitle(jpCol, "🦘 Jump")
local jpVal = 50
local jpLbl = mkValLbl(jpCol, jpVal, 32)
local jpDec = mkBtn(jpCol, "- 10",   58,  24, Color3.fromRGB(140,50,20))
local jpInc = mkBtn(jpCol, "+ 10",   88,  24, Color3.fromRGB(30,90,160))
local jpSet = mkBtn(jpCol, "✅ Set", 120, 30, PURP)

-- COL 4: INVISIBLE
local invCol = mkCol(4)
mkColTitle(invCol, "👻 Invis")
local invBtn = mkTogBtn(invCol, 38)

-- COL 5: CHAT (kirim ke chat Roblox, terlihat semua orang)
local chatCol = mkCol(5, 152)
mkColTitle(chatCol, "💬 Chat (Semua Lihat)")

-- Info label
local chatInfoLbl = Instance.new("TextLabel")
chatInfoLbl.Size = UDim2.new(1,-8,0,16)
chatInfoLbl.Position = UDim2.new(0,4,0,30)
chatInfoLbl.BackgroundTransparency = 1
chatInfoLbl.Text = "📢 Terlihat semua orang!"
chatInfoLbl.TextColor3 = GREEN
chatInfoLbl.Font = Enum.Font.Gotham
chatInfoLbl.TextSize = 10
chatInfoLbl.TextXAlignment = Enum.TextXAlignment.Center
chatInfoLbl.ZIndex = 103
chatInfoLbl.Parent = chatCol

local chatBox = Instance.new("TextBox")
chatBox.Size = UDim2.new(1,-10,0,36)
chatBox.Position = UDim2.new(0,5,0,50)
chatBox.BackgroundColor3 = Color3.fromRGB(18,18,28)
chatBox.Text = ""
chatBox.PlaceholderText = "Tulis pesan..."
chatBox.PlaceholderColor3 = GRAY
chatBox.TextColor3 = WHITE
chatBox.Font = Enum.Font.Gotham
chatBox.TextSize = 11
chatBox.ZIndex = 103
chatBox.ClearTextOnFocus = false
chatBox.TextWrapped = true
chatBox.Parent = chatCol
corner(chatBox, 7)
local cStroke = Instance.new("UIStroke")
cStroke.Color = Color3.fromRGB(50,60,80)
cStroke.Thickness = 1
cStroke.Parent = chatBox

local sendBtn  = mkBtn(chatCol, "📢 Kirim Chat", 92,  32, GREEN)
local resetBtn = mkBtn(chatCol, "↺ Reset",       130, 26, Color3.fromRGB(55,60,80))

-- Status kirim
local chatStatusLbl = Instance.new("TextLabel")
chatStatusLbl.Size = UDim2.new(1,-8,0,16)
chatStatusLbl.Position = UDim2.new(0,4,0,160)
chatStatusLbl.BackgroundTransparency = 1
chatStatusLbl.Text = ""
chatStatusLbl.TextColor3 = GREEN
chatStatusLbl.Font = Enum.Font.GothamBold
chatStatusLbl.TextSize = 10
chatStatusLbl.TextXAlignment = Enum.TextXAlignment.Center
chatStatusLbl.ZIndex = 103
chatStatusLbl.Parent = chatCol

-- ================================
-- TOMBOL BUKA ⚡
-- ================================
local openBtn = Instance.new("TextButton")
openBtn.Size = UDim2.new(0,60,0,60)
openBtn.Position = UDim2.new(0,16,0.45,0)
openBtn.BackgroundColor3 = DARK
openBtn.Text = "⚡"
openBtn.TextScaled = true
openBtn.ZIndex = 9999
openBtn.Visible = false
openBtn.Parent = sg
corner(openBtn, 30)
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
    FlyTogBtn.Text = "🛑 Matikan"
    FlyTogBtn.BackgroundColor3 = RED
    FlyStatLbl.Text = "✅ ON"
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
    FlyTogBtn.Text = "✈️ Aktifkan"
    FlyTogBtn.BackgroundColor3 = GREEN
    FlyStatLbl.Text = "❌ OFF"
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

-- ================================
-- KIRIM CHAT (terlihat semua orang)
-- ================================
sendBtn.MouseButton1Click:Connect(function()
    local msg = chatBox.Text
    if msg == "" then return end

    -- Cara 1: via Chat service (paling kompatibel di exploit)
    local ok = false
    pcall(function()
        chat:Chat(player.Character, msg, Enum.ChatColor.White)
        ok = true
    end)

    -- Cara 2: via ReplicatedStorage SayMessageRequest
    if not ok then
        pcall(function()
            local remote = game:GetService("ReplicatedStorage"):FindFirstChild("DefaultChatSystemChatEvents")
            if remote then
                local sayMsg = remote:FindFirstChild("SayMessageRequest")
                if sayMsg then
                    sayMsg:FireServer(msg, "All")
                    ok = true
                end
            end
        end)
    end

    -- Cara 3: simulate keyboard input chat
    if not ok then
        pcall(function()
            game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(msg, "All")
            ok = true
        end)
    end

    chatBox.Text = ""
    chatStatusLbl.Text = ok and "✅ Terkirim!" or "⚠️ Coba lagi"
    chatStatusLbl.TextColor3 = ok and GREEN or GOLD
    task.delay(2, function() chatStatusLbl.Text = "" end)
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
    FlyTogBtn.Text = "✈️ Aktifkan"
    FlyTogBtn.BackgroundColor3 = GREEN
    FlyStatLbl.Text = "❌ OFF"
    FlyStatLbl.TextColor3 = RED
end)

-- OPEN / CLOSE
CloseBtn.MouseButton1Click:Connect(function()
    Frame.Visible = false
    CloseBtn.Visible = false
    openBtn.Visible = true
end)
openBtn.MouseButton1Click:Connect(function()
    Frame.Visible = true
    CloseBtn.Visible = true
    openBtn.Visible = false
    updateClosePos()
end)
