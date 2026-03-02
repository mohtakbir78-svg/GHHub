-- Universal Admin Hub
-- Bisa dipakai di semua game Roblox
-- Delta Compatible

local player = game.Players.LocalPlayer
local rs = game:GetService("RunService")
local uis = game:GetService("UserInputService")

local sg = Instance.new("ScreenGui")
sg.ResetOnSpawn = false
sg.DisplayOrder = 9999
sg.Parent = gethui and gethui() or player.PlayerGui

local WHITE  = Color3.fromRGB(255,255,255)
local GREEN  = Color3.fromRGB(40,160,60)
local RED    = Color3.fromRGB(200,50,50)
local BLUE   = Color3.fromRGB(40,120,200)
local DARK   = Color3.fromRGB(14,14,22)
local CARD   = Color3.fromRGB(24,24,36)
local GRAY   = Color3.fromRGB(120,120,140)
local GOLD   = Color3.fromRGB(240,190,50)
local PURP   = Color3.fromRGB(120,60,200)
local CYAN   = Color3.fromRGB(0,200,220)
local ORANGE = Color3.fromRGB(220,120,30)

local function corner(p, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r or 10)
    c.Parent = p
end

-- ================================
-- CHAT ADMIN DI ATAS LAYAR
-- ================================
local chatDisp = Instance.new("Frame")
chatDisp.Size = UDim2.new(0, 440, 0, 76)
chatDisp.Position = UDim2.new(0.5, -220, 0, 10)
chatDisp.BackgroundColor3 = Color3.fromRGB(8, 8, 18)
chatDisp.BackgroundTransparency = 0
chatDisp.BorderSizePixel = 0
chatDisp.ZIndex = 99998
chatDisp.Visible = false
chatDisp.Parent = sg
corner(chatDisp, 12)
local cdStroke = Instance.new("UIStroke")
cdStroke.Color = CYAN
cdStroke.Thickness = 2.5
cdStroke.Parent = chatDisp

local cdBadge = Instance.new("Frame")
cdBadge.Size = UDim2.new(0, 72, 0, 22)
cdBadge.Position = UDim2.new(0, 10, 0, 7)
cdBadge.BackgroundColor3 = CYAN
cdBadge.BorderSizePixel = 0
cdBadge.ZIndex = 99999
cdBadge.Parent = chatDisp
corner(cdBadge, 5)
local cdBadgeLbl = Instance.new("TextLabel")
cdBadgeLbl.Size = UDim2.new(1,0,1,0)
cdBadgeLbl.BackgroundTransparency = 1
cdBadgeLbl.Text = "⚡ ADMIN"
cdBadgeLbl.TextColor3 = DARK
cdBadgeLbl.Font = Enum.Font.GothamBold
cdBadgeLbl.TextSize = 11
cdBadgeLbl.ZIndex = 99999
cdBadgeLbl.Parent = cdBadge

local cdName = Instance.new("TextLabel")
cdName.Size = UDim2.new(1,-100,0,22)
cdName.Position = UDim2.new(0,88,0,7)
cdName.BackgroundTransparency = 1
cdName.Text = player.Name
cdName.TextColor3 = CYAN
cdName.Font = Enum.Font.GothamBold
cdName.TextSize = 14
cdName.TextXAlignment = Enum.TextXAlignment.Left
cdName.ZIndex = 99999
cdName.Parent = chatDisp

local cdMsg = Instance.new("TextLabel")
cdMsg.Size = UDim2.new(1,-16,0,40)
cdMsg.Position = UDim2.new(0,10,0,32)
cdMsg.BackgroundTransparency = 1
cdMsg.Text = ""
cdMsg.TextColor3 = WHITE
cdMsg.Font = Enum.Font.GothamBold
cdMsg.TextSize = 22
cdMsg.TextWrapped = true
cdMsg.TextXAlignment = Enum.TextXAlignment.Left
cdMsg.ZIndex = 99999
cdMsg.Parent = chatDisp

local cdBar = Instance.new("Frame")
cdBar.Size = UDim2.new(1, 0, 0, 3)
cdBar.Position = UDim2.new(0, 0, 1, -3)
cdBar.BackgroundColor3 = CYAN
cdBar.BorderSizePixel = 0
cdBar.ZIndex = 99999
cdBar.Parent = chatDisp
corner(cdBar, 2)

-- ================================
-- MAIN FRAME
-- ================================
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 390, 0, 310)
Frame.Position = UDim2.new(0.5, -195, 0.5, -155)
Frame.BackgroundColor3 = DARK
Frame.BorderSizePixel = 0
Frame.Visible = true
Frame.ZIndex = 100
Frame.ClipsDescendants = true
Frame.Parent = sg
corner(Frame, 14)
local fStroke = Instance.new("UIStroke")
fStroke.Color = Color3.fromRGB(40,40,80)
fStroke.Thickness = 1.5
fStroke.Parent = Frame

local TBar = Instance.new("Frame")
TBar.Size = UDim2.new(1,0,0,40)
TBar.BackgroundColor3 = Color3.fromRGB(16,16,36)
TBar.BorderSizePixel = 0
TBar.ZIndex = 101
TBar.Parent = Frame
corner(TBar, 14)

local TFix = Instance.new("Frame")
TFix.Size = UDim2.new(1,0,0,10)
TFix.Position = UDim2.new(0,0,1,-10)
TFix.BackgroundColor3 = Color3.fromRGB(16,16,36)
TFix.BorderSizePixel = 0
TFix.ZIndex = 101
TFix.Parent = TBar

local TLbl = Instance.new("TextLabel")
TLbl.Size = UDim2.new(1,-50,1,0)
TLbl.Position = UDim2.new(0,12,0,0)
TLbl.BackgroundTransparency = 1
TLbl.Text = "⚡ Universal Admin  •  ☰ geser"
TLbl.TextColor3 = CYAN
TLbl.Font = Enum.Font.GothamBold
TLbl.TextSize = 14
TLbl.TextXAlignment = Enum.TextXAlignment.Left
TLbl.ZIndex = 102
TLbl.Parent = TBar

-- CLOSE BTN (parent sg)
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
-- HORIZONTAL SCROLL
-- ================================
local HScroll = Instance.new("ScrollingFrame")
HScroll.Size = UDim2.new(1,-10,1,-48)
HScroll.Position = UDim2.new(0,5,0,44)
HScroll.BackgroundTransparency = 1
HScroll.ScrollBarThickness = 4
HScroll.ScrollBarImageColor3 = CYAN
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

local function mkSec(order, w)
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

local function secTitle(p, txt, col)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1,-10,0,24)
    l.Position = UDim2.new(0,6,0,4)
    l.BackgroundTransparency = 1
    l.Text = txt
    l.TextColor3 = col or WHITE
    l.Font = Enum.Font.GothamBold
    l.TextSize = 13
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.ZIndex = 103
    l.Parent = p
end

local function secLbl(p, txt, posY, col)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1,-10,0,18)
    l.Position = UDim2.new(0,6,0,posY)
    l.BackgroundTransparency = 1
    l.Text = txt
    l.TextColor3 = col or GRAY
    l.Font = Enum.Font.GothamBold
    l.TextSize = 11
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.ZIndex = 103
    l.Parent = p
    return l
end

local function secBtn(p, txt, x, y, w, h, col)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0, w or 70, 0, h or 28)
    b.Position = UDim2.new(0, x, 0, y)
    b.BackgroundColor3 = col or BLUE
    b.Text = txt
    b.TextColor3 = WHITE
    b.Font = Enum.Font.GothamBold
    b.TextSize = 12
    b.ZIndex = 103
    b.Parent = p
    corner(b, 7)
    return b
end

local function secTog(p, x, y, w, h)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0, w or 148, 0, h or 30)
    b.Position = UDim2.new(0, x, 0, y)
    b.BackgroundColor3 = Color3.fromRGB(50,50,70)
    b.Text = "OFF"
    b.TextColor3 = GRAY
    b.Font = Enum.Font.GothamBold
    b.TextSize = 13
    b.ZIndex = 103
    b.Parent = p
    corner(b, 7)
    return b
end

local function secValLbl(p, val, x, y, col)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(0,50,0,22)
    l.Position = UDim2.new(0,x,0,y)
    l.BackgroundTransparency = 1
    l.Text = tostring(val)
    l.TextColor3 = col or GOLD
    l.Font = Enum.Font.GothamBold
    l.TextSize = 17
    l.TextXAlignment = Enum.TextXAlignment.Center
    l.ZIndex = 103
    l.Parent = p
    return l
end

local function togOn(btn, col)
    btn.BackgroundColor3 = col or GREEN
    btn.TextColor3 = WHITE
    btn.Text = "ON"
end
local function togOff(btn)
    btn.BackgroundColor3 = Color3.fromRGB(50,50,70)
    btn.TextColor3 = GRAY
    btn.Text = "OFF"
end

-- ================================
-- SECTION 1: TERBANG
-- ================================
local flyS = mkSec(1, 168)
secTitle(flyS, "✈️ Terbang", CYAN)
local flyStatLbl = secLbl(flyS, "❌ OFF", 30, RED)
local flySpeedLbl = secLbl(flyS, "Speed: 60", 48, GOLD)
local NaikBtn   = secBtn(flyS, "⬆️", 6,   68, 44, 36, Color3.fromRGB(30,120,50))
local FlyTogBtn = secBtn(flyS, "FLY", 56,  68, 58, 36, GREEN)
local TurunBtn  = secBtn(flyS, "⬇️", 120, 68, 44, 36, Color3.fromRGB(160,40,40))
local FlyDecBtn = secBtn(flyS, "-10", 6,  110, 50, 24, Color3.fromRGB(140,50,20))
local FlyIncBtn = secBtn(flyS, "+10", 114,110, 50, 24, Color3.fromRGB(30,90,160))

-- ================================
-- SECTION 2: SPEED & JUMP
-- ================================
local spjS = mkSec(2, 168)
secTitle(spjS, "🏃 Speed & Jump", WHITE)
secLbl(spjS, "Speed", 34, GRAY)
local spVal = 16
local spLbl = secValLbl(spjS, spVal, 60, 34)
local spDec = secBtn(spjS, "-5",  6,   38, 50, 22, Color3.fromRGB(140,50,20))
local spInc = secBtn(spjS, "+5",  114, 38, 50, 22, Color3.fromRGB(30,90,160))
local spSet = secBtn(spjS, "✅ Set Speed", 6, 66, 156, 26, BLUE)
secLbl(spjS, "Jump", 102, GRAY)
local jpVal = 50
local jpLbl = secValLbl(spjS, jpVal, 60, 102)
local jpDec = secBtn(spjS, "-10", 6,   106, 50, 22, Color3.fromRGB(140,50,20))
local jpInc = secBtn(spjS, "+10", 114, 106, 50, 22, Color3.fromRGB(30,90,160))
local jpSet = secBtn(spjS, "✅ Set Jump", 6, 134, 156, 26, PURP)

-- ================================
-- SECTION 3: INVISIBLE & GOD
-- ================================
local igS = mkSec(3, 168)
secTitle(igS, "👻 Invis & 🛡️ God", WHITE)
local invisStatLbl = secLbl(igS, "👻 Invisible: ❌ OFF", 30, RED)
local invisBtn = secTog(igS, 8, 50, 152)
local godStatLbl = secLbl(igS, "🛡️ God Mode: ❌ OFF", 90, RED)
local godBtn = secTog(igS, 8, 110, 152)

-- ================================
-- SECTION 4: ESP
-- ================================
local espS = mkSec(4, 168)
secTitle(espS, "👁️ ESP", BLUE)
local espPlyStatLbl = secLbl(espS, "Player ESP: ❌ OFF", 30, RED)
local espPlyBtn = secTog(espS, 8, 50, 152, 28)
local espItemStatLbl = secLbl(espS, "Item ESP: ❌ OFF", 90, RED)
local espItemBtn = secTog(espS, 8, 110, 152, 28)

-- ================================
-- SECTION 5: TELEPORT
-- ================================
local tpS = mkSec(5, 168)
secTitle(tpS, "🌀 Teleport", GOLD)
secLbl(tpS, "Tap player untuk TP", 30, GRAY)
local tpBtn    = secBtn(tpS, "🌀 TP ke Spawn",   6, 50,  156, 28, GOLD)
local tpCamBtn = secBtn(tpS, "📍 TP ke Camera",  6, 84,  156, 28, ORANGE)
secLbl(tpS, "TP ke Player:", 118, GRAY)
local tpPlyrBtn = secBtn(tpS, "Pilih Player ▼",  6, 134, 156, 28, Color3.fromRGB(60,60,90))

-- ================================
-- SECTION 6: CHAT ADMIN
-- ================================
local chatS = mkSec(6, 168)
secTitle(chatS, "💬 Chat Admin", CYAN)

local chatBox = Instance.new("TextBox")
chatBox.Size = UDim2.new(1,-12,0,34)
chatBox.Position = UDim2.new(0,6,0,30)
chatBox.BackgroundColor3 = Color3.fromRGB(16,16,26)
chatBox.Text = ""
chatBox.PlaceholderText = "Tulis pesan..."
chatBox.PlaceholderColor3 = GRAY
chatBox.TextColor3 = WHITE
chatBox.Font = Enum.Font.Gotham
chatBox.TextSize = 11
chatBox.ZIndex = 103
chatBox.ClearTextOnFocus = false
chatBox.TextWrapped = true
chatBox.Parent = chatS
corner(chatBox, 7)
Instance.new("UIStroke", chatBox).Color = Color3.fromRGB(50,60,80)

secLbl(chatS, "⚡ Pesan Cepat:", 70, GRAY)
local preset1 = secBtn(chatS, "⚠️ Jangan cheat!",  6, 86,  156, 22, Color3.fromRGB(180,80,20))
local preset2 = secBtn(chatS, "👋 Hai semua!",      6, 114, 156, 22, Color3.fromRGB(30,80,160))
local preset3 = secBtn(chatS, "🚫 Kalian di kick!", 6, 142, 156, 22, RED)
local chatSendBtn = secBtn(chatS, "📢 Kirim Chat", 6, 170, 156, 30, GREEN)
local chatStatLbl = secLbl(chatS, "", 206, GREEN)

-- ================================
-- SECTION 7: EFEK & RESET
-- ================================
local fxS = mkSec(7, 168)
secTitle(fxS, "🎨 Efek & Reset", WHITE)
local fxNoclipStatLbl = secLbl(fxS, "Noclip: ❌ OFF", 30, RED)
local fxNoclipBtn = secTog(fxS, 8, 50, 152, 28)
local fxInfJumpStatLbl = secLbl(fxS, "Inf Jump: ❌ OFF", 86, RED)
local fxInfJumpBtn = secTog(fxS, 8, 106, 152, 28)
local fxResetBtn = secBtn(fxS, "↺ Reset Karakter", 6, 142, 156, 28, Color3.fromRGB(55,60,80))

-- ================================
-- OPEN BTN
-- ================================
local openBtn = Instance.new("TextButton")
openBtn.Size = UDim2.new(0,56,0,56)
openBtn.Position = UDim2.new(0,14,0.43,0)
openBtn.BackgroundColor3 = DARK
openBtn.Text = "⚡"
openBtn.TextScaled = true
openBtn.ZIndex = 9999
openBtn.Visible = false
openBtn.Parent = sg
corner(openBtn, 28)
local obStroke = Instance.new("UIStroke")
obStroke.Color = CYAN
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
    local c = player.Character
    if not c then return end
    local hum  = c:FindFirstChildOfClass("Humanoid")
    local root = c:FindFirstChild("HumanoidRootPart")
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
    FlyTogBtn.BackgroundColor3 = RED; FlyTogBtn.Text = "🛑"
    flyStatLbl.Text = "✅ ON"; flyStatLbl.TextColor3 = GREEN
end

local function stopFly()
    flying = false
    local c = player.Character
    if not c then return end
    local hum = c:FindFirstChildOfClass("Humanoid")
    if hum then hum.PlatformStand = false end
    if bv then bv:Destroy(); bv = nil end
    if bg then bg:Destroy(); bg = nil end
    FlyTogBtn.BackgroundColor3 = GREEN; FlyTogBtn.Text = "FLY"
    flyStatLbl.Text = "❌ OFF"; flyStatLbl.TextColor3 = RED
end

rs.RenderStepped:Connect(function()
    if not flying then return end
    local c = player.Character
    if not c then return end
    local root = c:FindFirstChild("HumanoidRootPart")
    local hum  = c:FindFirstChildOfClass("Humanoid")
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

FlyTogBtn.MouseButton1Click:Connect(function() if flying then stopFly() else startFly() end end)
FlyDecBtn.MouseButton1Click:Connect(function() flySpeed = math.max(10,flySpeed-10); flySpeedLbl.Text="Speed: "..flySpeed end)
FlyIncBtn.MouseButton1Click:Connect(function() flySpeed = math.min(500,flySpeed+10); flySpeedLbl.Text="Speed: "..flySpeed end)
NaikBtn.MouseButton1Down:Connect(function() goUp=true end)
NaikBtn.MouseButton1Up:Connect(function() goUp=false end)
NaikBtn.TouchStarted:Connect(function() goUp=true end)
NaikBtn.TouchEnded:Connect(function() goUp=false end)
TurunBtn.MouseButton1Down:Connect(function() goDown=true end)
TurunBtn.MouseButton1Up:Connect(function() goDown=false end)
TurunBtn.TouchStarted:Connect(function() goDown=true end)
TurunBtn.TouchEnded:Connect(function() goDown=false end)

-- ================================
-- LOGIKA SPEED & JUMP
-- ================================
local function applySpeed(v)
    local c = player.Character; if not c then return end
    local hum = c:FindFirstChildOfClass("Humanoid"); if hum then hum.WalkSpeed = v end
end
local function applyJump(v)
    local c = player.Character; if not c then return end
    local hum = c:FindFirstChildOfClass("Humanoid"); if hum then hum.JumpPower = v end
end

spDec.MouseButton1Click:Connect(function() spVal=math.max(1,spVal-5); spLbl.Text=tostring(spVal) end)
spInc.MouseButton1Click:Connect(function() spVal=math.min(999,spVal+5); spLbl.Text=tostring(spVal) end)
spSet.MouseButton1Click:Connect(function() applySpeed(spVal) end)
jpDec.MouseButton1Click:Connect(function() jpVal=math.max(1,jpVal-10); jpLbl.Text=tostring(jpVal) end)
jpInc.MouseButton1Click:Connect(function() jpVal=math.min(999,jpVal+10); jpLbl.Text=tostring(jpVal) end)
jpSet.MouseButton1Click:Connect(function() applyJump(jpVal) end)

-- ================================
-- LOGIKA INVISIBLE
-- ================================
local isInvis = false
local function applyInvis(state)
    local c = player.Character; if not c then return end
    for _, p in ipairs(c:GetDescendants()) do
        if p:IsA("BasePart") and p.Name ~= "HumanoidRootPart" then p.Transparency = state and 1 or 0 end
        if p:IsA("Decal") then p.Transparency = state and 1 or 0 end
    end
end

invisBtn.MouseButton1Click:Connect(function()
    isInvis = not isInvis
    applyInvis(isInvis)
    if isInvis then togOn(invisBtn, PURP) else togOff(invisBtn) end
    invisStatLbl.Text = "👻 Invisible: "..(isInvis and "✅ ON" or "❌ OFF")
    invisStatLbl.TextColor3 = isInvis and GREEN or RED
end)

-- ================================
-- LOGIKA GOD MODE
-- ================================
local isGod = false
local godConn
godBtn.MouseButton1Click:Connect(function()
    isGod = not isGod
    if isGod then
        togOn(godBtn, GOLD)
        godConn = rs.Heartbeat:Connect(function()
            local c = player.Character; if not c then return end
            local hum = c:FindFirstChildOfClass("Humanoid")
            if hum then hum.Health = hum.MaxHealth end
        end)
    else
        togOff(godBtn)
        if godConn then godConn:Disconnect(); godConn = nil end
    end
    godStatLbl.Text = "🛡️ God Mode: "..(isGod and "✅ ON" or "❌ OFF")
    godStatLbl.TextColor3 = isGod and GREEN or RED
end)

-- ================================
-- LOGIKA ESP
-- ================================
local esp
