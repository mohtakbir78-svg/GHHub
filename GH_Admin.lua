-- Garden Horizons Hub
-- Terbang + Admin + Chat Layar

local player = game.Players.LocalPlayer
local rs = game:GetService("RunService")
local uis = game:GetService("UserInputService")
local chatSvc = game:GetService("Chat")

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

local function mkLabel(parent, txt, size, color, posX, posY, w, h, align)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(0, w or 120, 0, h or 20)
    l.Position = UDim2.new(0, posX, 0, posY)
    l.BackgroundTransparency = 1
    l.Text = txt
    l.TextColor3 = color or WHITE
    l.Font = Enum.Font.GothamBold
    l.TextSize = size or 13
    l.TextXAlignment = align or Enum.TextXAlignment.Left
    l.ZIndex = 103
    l.Parent = parent
    return l
end

local function mkBtn(parent, txt, posX, posY, w, h, col)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0, w or 80, 0, h or 28)
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

local function mkToggle(parent, posX, posY, w, h)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0, w or 60, 0, h or 28)
    b.Position = UDim2.new(0, posX, 0, posY)
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

local function mkCard(parent, posY, h, w)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(0, w or 160, 0, h or 80)
    f.Position = UDim2.new(0, 0, 0, posY or 0)
    f.BackgroundColor3 = CARD
    f.BorderSizePixel = 0
    f.ZIndex = 102
    f.Parent = parent
    corner(f, 10)
    return f
end

-- ================================
-- CHAT DISPLAY DI LAYAR
-- ================================
local chatFrame = Instance.new("Frame")
chatFrame.Size = UDim2.new(0, 360, 0, 70)
chatFrame.Position = UDim2.new(0.5, -180, 0.5, -35)
chatFrame.BackgroundColor3 = Color3.fromRGB(10,10,16)
chatFrame.BackgroundTransparency = 0
chatFrame.BorderSizePixel = 0
chatFrame.ZIndex = 99998
chatFrame.Visible = false
chatFrame.Parent = sg
corner(chatFrame, 12)
local cfStroke = Instance.new("UIStroke")
cfStroke.Color = GOLD
cfStroke.Thickness = 2
cfStroke.Parent = chatFrame

local chatNameDisp = Instance.new("TextLabel")
chatNameDisp.Size = UDim2.new(1,-16,0,22)
chatNameDisp.Position = UDim2.new(0,10,0,4)
chatNameDisp.BackgroundTransparency = 1
chatNameDisp.Text = "💬 " .. player.Name
chatNameDisp.TextColor3 = GOLD
chatNameDisp.Font = Enum.Font.GothamBold
chatNameDisp.TextSize = 13
chatNameDisp.TextXAlignment = Enum.TextXAlignment.Left
chatNameDisp.ZIndex = 99999
chatNameDisp.Parent = chatFrame

local chatMsgDisp = Instance.new("TextLabel")
chatMsgDisp.Size = UDim2.new(1,-16,0,36)
chatMsgDisp.Position = UDim2.new(0,10,0,28)
chatMsgDisp.BackgroundTransparency = 1
chatMsgDisp.Text = ""
chatMsgDisp.TextColor3 = WHITE
chatMsgDisp.Font = Enum.Font.GothamBold
chatMsgDisp.TextSize = 20
chatMsgDisp.TextWrapped = true
chatMsgDisp.TextXAlignment = Enum.TextXAlignment.Left
chatMsgDisp.ZIndex = 99999
chatMsgDisp.Parent = chatFrame

-- ================================
-- MAIN FRAME (horizontal scroll)
-- ================================
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 370, 0, 290)
Frame.Position = UDim2.new(0.5, -185, 0.5, -145)
Frame.BackgroundColor3 = DARK
Frame.BorderSizePixel = 0
Frame.Visible = true
Frame.ZIndex = 100
Frame.ClipsDescendants = true
Frame.Parent = sg
corner(Frame, 14)
local fStroke = Instance.new("UIStroke")
fStroke.Color = Color3.fromRGB(40,80,45)
fStroke.Thickness = 1.5
fStroke.Parent = Frame

-- TITLE BAR
local TBar = Instance.new("Frame")
TBar.Size = UDim2.new(1,0,0,40)
TBar.BackgroundColor3 = Color3.fromRGB(18,36,20)
TBar.BorderSizePixel = 0
TBar.ZIndex = 101
TBar.Parent = Frame
corner(TBar, 14)

local TFix = Instance.new("Frame")
TFix.Size = UDim2.new(1,0,0,10)
TFix.Position = UDim2.new(0,0,1,-10)
TFix.BackgroundColor3 = Color3.fromRGB(18,36,20)
TFix.BorderSizePixel = 0
TFix.ZIndex = 101
TFix.Parent = TBar

local TLbl = Instance.new("TextLabel")
TLbl.Size = UDim2.new(1,-50,1,0)
TLbl.Position = UDim2.new(0,12,0,0)
TLbl.BackgroundTransparency = 1
TLbl.Text = "🌱 GH Hub  •  ☰ geser"
TLbl.TextColor3 = GREEN
TLbl.Font = Enum.Font.GothamBold
TLbl.TextSize = 14
TLbl.TextXAlignment = Enum.TextXAlignment.Left
TLbl.ZIndex = 102
TLbl.Parent = TBar

-- TOMBOL X (parent sg)
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
    if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
        drag = false
    end
end)
uis.InputChanged:Connect(function(i)
    if drag and (i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseMove) then
        local d = i.Position - dragStart
        Frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset+d.X, startPos.Y.Scale, startPos.Y.Offset+d.Y)
        updateClose()
    end
end)

-- ================================
-- SCROLL HORIZONTAL (konten)
-- ================================
local HScroll = Instance.new("ScrollingFrame")
HScroll.Size = UDim2.new(1,-10,1,-48)
HScroll.Position = UDim2.new(0,5,0,44)
HScroll.BackgroundTransparency = 1
HScroll.ScrollBarThickness = 4
HScroll.ScrollBarImageColor3 = GREEN
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

local function secValLbl(parent, val, posX, posY, col)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(0,50,0,22)
    l.Position = UDim2.new(0,posX,0,posY)
    l.BackgroundTransparency = 1
    l.Text = tostring(val)
    l.TextColor3 = col or GOLD
    l.Font = Enum.Font.GothamBold
    l.TextSize = 18
    l.TextXAlignment = Enum.TextXAlignment.Center
    l.ZIndex = 103
    l.Parent = parent
    return l
end

local function secStatLbl(parent, txt, posX, posY, col)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1,-10,0,18)
    l.Position = UDim2.new(0,posX,0,posY)
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

local function secTog(parent, posX, posY, w)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0,w or 65,0,30)
    b.Position = UDim2.new(0,posX,0,posY)
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
-- SECTION 1: TERBANG
-- ================================
local flyS = mkSection(1, 170)
secTitle(flyS, "✈️ Terbang", GREEN)

local FlyStatLbl = secStatLbl(flyS, "❌ OFF", 6, 30)

-- Naik / Toggle / Turun berdampingan
local NaikBtn = secBtn(flyS, "⬆️", 6, 52, 44, 36, Color3.fromRGB(30,120,50))
local FlyTogBtn = secBtn(flyS, "ON/OFF", 56, 52, 60, 36, GREEN)
local TurunBtn = secBtn(flyS, "⬇️", 122, 52, 44, 36, Color3.fromRGB(160,40,40))

-- Speed
local flySpeedLbl = secValLbl(flyS, "60", 58, 96)
local FlyDecBtn = secBtn(flyS, "-10", 6, 100, 50, 24, Color3.fromRGB(140,50,20))
local FlyIncBtn = secBtn(flyS, "+10", 114, 100, 50, 24, Color3.fromRGB(30,90,160))

-- ================================
-- SECTION 2: SPEED BOOST
-- ================================
local sbS = mkSection(2, 160)
secTitle(sbS, "🏃 Speed Boost", WHITE)

local sbVal = 16
local sbLbl = secValLbl(sbS, sbVal, 56, 38)
local sbDec = secBtn(sbS, "-5",  6,  42, 48, 24, Color3.fromRGB(140,50,20))
local sbInc = secBtn(sbS, "+5",  108, 42, 48, 24, Color3.fromRGB(30,90,160))
local sbSet = secBtn(sbS, "✅ Set Speed", 6, 72, 148, 28, BLUE)

-- ================================
-- SECTION 3: JUMP POWER
-- ================================
local jpS = mkSection(3, 160)
secTitle(jpS, "🦘 Jump Power", WHITE)

local jpVal = 50
local jpLbl = secValLbl(jpS, jpVal, 56, 38)
local jpDec = secBtn(jpS, "-10", 6,  42, 48, 24, Color3.fromRGB(140,50,20))
local jpInc = secBtn(jpS, "+10", 108, 42, 48, 24, Color3.fromRGB(30,90,160))
local jpSet = secBtn(jpS, "✅ Set Jump", 6, 72, 148, 28, PURP)

-- ================================
-- SECTION 4: INVISIBLE
-- ================================
local invS = mkSection(4, 130)
secTitle(invS, "👻 Invisible", WHITE)
local invStatLbl = secStatLbl(invS, "❌ OFF", 6, 32)
local invBtn = secTog(invS, 32, 52, 68)

-- ================================
-- SECTION 5: CHAT DI LAYAR
-- ================================
local chatS = mkSection(5, 180)
secTitle(chatS, "💬 Chat Layar", WHITE)

local chatInfoL = Instance.new("TextLabel")
chatInfoL.Size = UDim2.new(1,-10,0,14)
chatInfoL.Position = UDim2.new(0,6,0,30)
chatInfoL.BackgroundTransparency = 1
chatInfoL.Text = "📢 Terlihat semua orang!"
chatInfoL.TextColor3 = GREEN
chatInfoL.Font = Enum.Font.Gotham
chatInfoL.TextSize = 10
chatInfoL.TextXAlignment = Enum.TextXAlignment.Left
chatInfoL.ZIndex = 103
chatInfoL.Parent = chatS

local chatBox = Instance.new("TextBox")
chatBox.Size = UDim2.new(1,-12,0,38)
chatBox.Position = UDim2.new(0,6,0,48)
chatBox.BackgroundColor3 = Color3.fromRGB(16,16,26)
chatBox.Text = ""
chatBox.PlaceholderText = "Tulis pesan..."
chatBox.PlaceholderColor3 = GRAY
chatBox.TextColor3 = WHITE
chatBox.Font = Enum.Font.Gotham
chatBox.TextSize = 12
chatBox.ZIndex = 103
chatBox.ClearTextOnFocus = false
chatBox.TextWrapped = true
chatBox.Parent = chatS
corner(chatBox, 7)
local cStroke = Instance.new("UIStroke")
cStroke.Color = Color3.fromRGB(50,60,80)
cStroke.Thickness = 1
cStroke.Parent = chatBox

local sendBtn = secBtn(chatS, "📢 Kirim", 6, 92, 168, 32, GREEN)

local chatStatusL = Instance.new("TextLabel")
chatStatusL.Size = UDim2.new(1,-10,0,16)
chatStatusL.Position = UDim2.new(0,6,0,130)
chatStatusL.BackgroundTransparency = 1
chatStatusL.Text = ""
chatStatusL.TextColor3 = GREEN
chatStatusL.Font = Enum.Font.GothamBold
chatStatusL.TextSize = 11
chatStatusL.TextXAlignment = Enum.TextXAlignment.Center
chatStatusL.ZIndex = 103
chatStatusL.Parent = chatS

-- RESET SEMUA
local resetS = mkSection(6, 140)
secTitle(resetS, "⚙️ Lainnya", WHITE)
local resetBtn = secBtn(resetS, "↺ Reset Default", 6, 36, 128, 32, Color3.fromRGB(55,60,80))

-- ================================
-- TOMBOL BUKA 🌱
-- ================================
local openBtn = Instance.new("TextButton")
openBtn.Size = UDim2.new(0,56,0,56)
openBtn.Position = UDim2.new(0,14,0.43,0)
openBtn.BackgroundColor3 = DARK
openBtn.Text = "🌱"
openBtn.TextScaled = true
openBtn.ZIndex = 9999
openBtn.Visible = false
openBtn.Parent = sg
corner(openBtn, 28)
local obStroke = Instance.new("UIStroke")
obStroke.Color = GREEN
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
    FlyTogBtn.Text = "🛑"
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
    FlyTogBtn.Text = "ON/OFF"
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
FlyDecBtn.MouseButton1Click:Connect(function()
    flySpeed = math.max(10, flySpeed-10)
    flySpeedLbl.Text = tostring(flySpeed)
end)
FlyIncBtn.MouseButton1Click:Connect(function()
    flySpeed = math.min(300, flySpeed+10)
    flySpeedLbl.Text = tostring(flySpeed)
end)

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
    invStatLbl.Text = isInvis and "✅ ON" or "❌ OFF"
    invStatLbl.TextColor3 = isInvis and GREEN or RED
end)

-- ================================
-- LOGIKA CHAT (terlihat semua orang)
-- ================================
local chatTimer
local function sendChat(msg)
    -- Cara 1: Chat service
    local ok = pcall(function()
        chatSvc:Chat(player.Character, msg, Enum.ChatColor.White)
    end)
    -- Cara 2: SayMessageRequest
    if not ok then
        pcall(function()
            game:GetService("ReplicatedStorage")
                .DefaultChatSystemChatEvents
                .SayMessageRequest:FireServer(msg, "All")
          
