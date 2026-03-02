-- Universal Admin Hub v2
-- Fixed: Chat, Fly, Speed, Jump, Invisible, ESP
-- Added: Ban/Kill Player
-- Delta Compatible

local Players = game:GetService("Players")
local RS = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local P = Players.LocalPlayer

local sg = Instance.new("ScreenGui")
sg.ResetOnSpawn = false
sg.DisplayOrder = 9999
sg.Parent = gethui and gethui() or P.PlayerGui

local W=Color3.fromRGB(255,255,255)
local G=Color3.fromRGB(40,160,60)
local R=Color3.fromRGB(200,50,50)
local B=Color3.fromRGB(40,120,200)
local D=Color3.fromRGB(14,14,22)
local CA=Color3.fromRGB(24,24,36)
local GR=Color3.fromRGB(120,120,140)
local GO=Color3.fromRGB(240,190,50)
local PU=Color3.fromRGB(120,60,200)
local CY=Color3.fromRGB(0,200,220)
local OR=Color3.fromRGB(220,120,30)

local function cr(p,r)
    local c=Instance.new("UICorner")
    c.CornerRadius=UDim.new(0,r or 10)
    c.Parent=p
end
local function togOn(b,c) b.BackgroundColor3=c or G b.TextColor3=W b.Text="ON" end
local function togOff(b) b.BackgroundColor3=Color3.fromRGB(50,50,70) b.TextColor3=GR b.Text="OFF" end

-- ================================
-- CHAT DISPLAY ATAS LAYAR
-- ================================
local chatDisp = Instance.new("Frame")
chatDisp.Size = UDim2.new(0,440,0,80)
chatDisp.Position = UDim2.new(0.5,-220,0,8)
chatDisp.BackgroundColor3 = Color3.fromRGB(8,8,18)
chatDisp.BackgroundTransparency = 0
chatDisp.BorderSizePixel = 0
chatDisp.ZIndex = 999999
chatDisp.Visible = false
chatDisp.Parent = sg
cr(chatDisp, 12)

local cdStroke = Instance.new("UIStroke")
cdStroke.Color = CY
cdStroke.Thickness = 2.5
cdStroke.Parent = chatDisp

local cdBadge = Instance.new("Frame")
cdBadge.Size = UDim2.new(0,76,0,24)
cdBadge.Position = UDim2.new(0,10,0,8)
cdBadge.BackgroundColor3 = CY
cdBadge.ZIndex = 999999
cdBadge.Parent = chatDisp
cr(cdBadge, 5)

local cdBadgeLbl = Instance.new("TextLabel")
cdBadgeLbl.Size = UDim2.new(1,0,1,0)
cdBadgeLbl.BackgroundTransparency = 1
cdBadgeLbl.Text = "⚡ ADMIN"
cdBadgeLbl.TextColor3 = D
cdBadgeLbl.Font = Enum.Font.GothamBold
cdBadgeLbl.TextSize = 12
cdBadgeLbl.ZIndex = 999999
cdBadgeLbl.Parent = cdBadge

local cdNameLbl = Instance.new("TextLabel")
cdNameLbl.Size = UDim2.new(1,-110,0,24)
cdNameLbl.Position = UDim2.new(0,92,0,8)
cdNameLbl.BackgroundTransparency = 1
cdNameLbl.Text = P.Name
cdNameLbl.TextColor3 = CY
cdNameLbl.Font = Enum.Font.GothamBold
cdNameLbl.TextSize = 14
cdNameLbl.TextXAlignment = Enum.TextXAlignment.Left
cdNameLbl.ZIndex = 999999
cdNameLbl.Parent = chatDisp

local cdMsgLbl = Instance.new("TextLabel")
cdMsgLbl.Size = UDim2.new(1,-16,0,42)
cdMsgLbl.Position = UDim2.new(0,10,0,34)
cdMsgLbl.BackgroundTransparency = 1
cdMsgLbl.Text = ""
cdMsgLbl.TextColor3 = W
cdMsgLbl.Font = Enum.Font.GothamBold
cdMsgLbl.TextSize = 20
cdMsgLbl.TextWrapped = true
cdMsgLbl.TextXAlignment = Enum.TextXAlignment.Left
cdMsgLbl.ZIndex = 999999
cdMsgLbl.Parent = chatDisp

local cdBar = Instance.new("Frame")
cdBar.Size = UDim2.new(1,0,0,3)
cdBar.Position = UDim2.new(0,0,1,-3)
cdBar.BackgroundColor3 = CY
cdBar.ZIndex = 999999
cdBar.Parent = chatDisp
cr(cdBar, 2)

-- Fungsi kirim chat - FIX
local chatTimer
local function kirimChat(msg)
    if not msg or msg == "" then return end
    -- Tampilkan di layar DULU (selalu berhasil)
    cdMsgLbl.Text = msg
    cdNameLbl.Text = P.Name
    chatDisp.Visible = true
    if chatTimer then task.cancel(chatTimer) end
    chatTimer = task.delay(7, function()
        chatDisp.Visible = false
    end)
    -- Kirim ke chat game
    pcall(function()
        game:GetService("Chat"):Chat(P.Character, msg, Enum.ChatColor.White)
    end)
    pcall(function()
        game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents",1):WaitForChild("SayMessageRequest",1):FireServer(msg,"All")
    end)
end

-- ================================
-- MAIN FRAME
-- ================================
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0,390,0,310)
Frame.Position = UDim2.new(0.5,-195,0.5,-155)
Frame.BackgroundColor3 = D
Frame.ZIndex = 100
Frame.ClipsDescendants = true
Frame.Parent = sg
cr(Frame, 14)
Instance.new("UIStroke", Frame).Color = Color3.fromRGB(40,40,80)

local TBar = Instance.new("Frame")
TBar.Size = UDim2.new(1,0,0,40)
TBar.BackgroundColor3 = Color3.fromRGB(16,16,36)
TBar.ZIndex = 101
TBar.Parent = Frame
cr(TBar, 14)

local TFix = Instance.new("Frame")
TFix.Size = UDim2.new(1,0,0,10)
TFix.Position = UDim2.new(0,0,1,-10)
TFix.BackgroundColor3 = Color3.fromRGB(16,16,36)
TFix.ZIndex = 101
TFix.Parent = TBar

local TLbl = Instance.new("TextLabel")
TLbl.Size = UDim2.new(1,-50,1,0)
TLbl.Position = UDim2.new(0,12,0,0)
TLbl.BackgroundTransparency = 1
TLbl.Text = "⚡ Universal Admin v2  •  ☰ geser"
TLbl.TextColor3 = CY
TLbl.Font = Enum.Font.GothamBold
TLbl.TextSize = 13
TLbl.TextXAlignment = Enum.TextXAlignment.Left
TLbl.ZIndex = 102
TLbl.Parent = TBar

-- CLOSE BTN
local XBtn = Instance.new("TextButton")
XBtn.Size = UDim2.new(0,34,0,34)
XBtn.BackgroundColor3 = R
XBtn.Text = "✕"
XBtn.TextColor3 = W
XBtn.Font = Enum.Font.GothamBold
XBtn.TextSize = 16
XBtn.ZIndex = 999999
XBtn.Parent = sg
cr(XBtn, 8)

local function updateX()
    local fp = Frame.AbsolutePosition
    local fs = Frame.AbsoluteSize
    XBtn.Position = UDim2.new(0, fp.X+fs.X-38, 0, fp.Y+4)
end
Frame:GetPropertyChangedSignal("AbsolutePosition"):Connect(updateX)
Frame:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateX)
updateX()

-- DRAG
local drag, dragStart, dragPos = false, nil, nil
TBar.InputBegan:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then
        drag=true; dragStart=i.Position; dragPos=Frame.Position
    end
end)
TBar.InputEnded:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then drag=false end
end)
UIS.InputChanged:Connect(function(i)
    if drag and (i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseMove) then
        local d = i.Position - dragStart
        Frame.Position = UDim2.new(dragPos.X.Scale, dragPos.X.Offset+d.X, dragPos.Y.Scale, dragPos.Y.Offset+d.Y)
        updateX()
    end
end)

-- ================================
-- SCROLL
-- ================================
local HScroll = Instance.new("ScrollingFrame")
HScroll.Size = UDim2.new(1,-10,1,-48)
HScroll.Position = UDim2.new(0,5,0,44)
HScroll.BackgroundTransparency = 1
HScroll.ScrollBarThickness = 4
HScroll.ScrollBarImageColor3 = CY
HScroll.ScrollingDirection = Enum.ScrollingDirection.X
HScroll.ZIndex = 101
HScroll.Parent = Frame

local HLayout = Instance.new("UIListLayout")
HLayout.FillDirection = Enum.FillDirection.Horizontal
HLayout.Padding = UDim.new(0,8)
HLayout.VerticalAlignment = Enum.VerticalAlignment.Center
HLayout.Parent = HScroll

local Pad = Instance.new("UIPadding")
Pad.PaddingLeft = UDim.new(0,4)
Pad.PaddingRight = UDim.new(0,4)
Pad.Parent = HScroll

HLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    HScroll.CanvasSize = UDim2.new(0, HLayout.AbsoluteContentSize.X+10, 0, 0)
end)

-- Helpers
local function mkSec(order, w)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(0, w or 168, 1, -10)
    f.BackgroundColor3 = CA
    f.LayoutOrder = order
    f.ZIndex = 102
    f.Parent = HScroll
    cr(f, 10)
    return f
end

local function mkTitle(p, txt, col)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1,-10,0,24)
    l.Position = UDim2.new(0,6,0,4)
    l.BackgroundTransparency = 1
    l.Text = txt
    l.TextColor3 = col or W
    l.Font = Enum.Font.GothamBold
    l.TextSize = 13
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.ZIndex = 103
    l.Parent = p
end

local function mkLbl(p, txt, y, col)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1,-10,0,18)
    l.Position = UDim2.new(0,6,0,y)
    l.BackgroundTransparency = 1
    l.Text = txt
    l.TextColor3 = col or GR
    l.Font = Enum.Font.GothamBold
    l.TextSize = 11
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.ZIndex = 103
    l.Parent = p
    return l
end

local function mkBtn(p, txt, x, y, w, h, col)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0, w or 70, 0, h or 28)
    b.Position = UDim2.new(0, x, 0, y)
    b.BackgroundColor3 = col or B
    b.Text = txt
    b.TextColor3 = W
    b.Font = Enum.Font.GothamBold
    b.TextSize = 12
    b.ZIndex = 103
    b.Parent = p
    cr(b, 7)
    return b
end

local function mkTog(p, x, y, w, h)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0, w or 152, 0, h or 30)
    b.Position = UDim2.new(0, x, 0, y)
    b.BackgroundColor3 = Color3.fromRGB(50,50,70)
    b.Text = "OFF"
    b.TextColor3 = GR
    b.Font = Enum.Font.GothamBold
    b.TextSize = 13
    b.ZIndex = 103
    b.Parent = p
    cr(b, 7)
    return b
end

local function mkVal(p, v, x, y)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(0,52,0,22)
    l.Position = UDim2.new(0,x,0,y)
    l.BackgroundTransparency = 1
    l.Text = tostring(v)
    l.TextColor3 = GO
    l.Font = Enum.Font.GothamBold
    l.TextSize = 17
    l.TextXAlignment = Enum.TextXAlignment.Center
    l.ZIndex = 103
    l.Parent = p
    return l
end

-- ================================
-- S1: TERBANG (FIXED)
-- ================================
local s1 = mkSec(1)
mkTitle(s1, "✈️ Terbang", CY)
local flyStatLbl = mkLbl(s1, "❌ OFF", 30, R)
local flySpeedLbl = mkLbl(s1, "Speed: 60", 48, GO)

local NaikBtn = mkBtn(s1, "⬆️", 6, 66, 44, 38, Color3.fromRGB(30,120,50))
local FlyBtn  = mkBtn(s1, "FLY", 56, 66, 58, 38, G)
local TurunBtn= mkBtn(s1, "⬇️", 120, 66, 44, 38, Color3.fromRGB(160,40,40))
local FlyDec  = mkBtn(s1, "-10", 6, 110, 50, 24, Color3.fromRGB(140,50,20))
local FlyInc  = mkBtn(s1, "+10", 114, 110, 50, 24, Color3.fromRGB(30,90,160))

-- ================================
-- S2: SPEED & JUMP (FIXED)
-- ================================
local s2 = mkSec(2)
mkTitle(s2, "🏃 Speed & Jump", W)
mkLbl(s2, "WalkSpeed:", 30, GR)
local spVal = 16
local spLbl = mkVal(s2, spVal, 58, 44)
local spDec = mkBtn(s2, "-5",  6,  48, 50, 24, Color3.fromRGB(140,50,20))
local spInc = mkBtn(s2, "+5", 114, 48, 50, 24, Color3.fromRGB(30,90,160))
local spSet = mkBtn(s2, "✅ Terapkan Speed", 6, 78, 156, 28, B)

mkLbl(s2, "JumpPower:", 112, GR)
local jpVal = 50
local jpLbl = mkVal(s2, jpVal, 58, 126)
local jpDec = mkBtn(s2, "-10", 6,  130, 50, 24, Color3.fromRGB(140,50,20))
local jpInc = mkBtn(s2, "+10",114, 130, 50, 24, Color3.fromRGB(30,90,160))
local jpSet = mkBtn(s2, "✅ Terapkan Jump", 6, 160, 156, 28, PU)

-- ================================
-- S3: INVISIBLE & GOD (FIXED)
-- ================================
local s3 = mkSec(3)
mkTitle(s3, "👻 Invis & 🛡️ God", W)
local invisLbl = mkLbl(s3, "👻 Invisible: ❌ OFF", 30, R)
local invisBtn = mkTog(s3, 8, 50)
local godLbl   = mkLbl(s3, "🛡️ God Mode: ❌ OFF", 92, R)
local godBtn   = mkTog(s3, 8, 112)

-- ================================
-- S4: ESP (FIXED)
-- ================================
local s4 = mkSec(4)
mkTitle(s4, "👁️ ESP", B)
local espPlyLbl  = mkLbl(s4, "Player ESP: ❌ OFF", 30, R)
local espPlyBtn  = mkTog(s4, 8, 50, 152, 28)
local espItemLbl = mkLbl(s4, "Item ESP: ❌ OFF", 92, R)
local espItemBtn = mkTog(s4, 8, 112, 152, 28)

-- ================================
-- S5: BAN/KILL PLAYER (NEW)
-- ================================
local s5 = mkSec(5, 172)
mkTitle(s5, "⚔️ Ban & Kill", R)
mkLbl(s5, "Pilih lalu aksi:", 30, GR)
local targetBtn = mkBtn(s5, "Target: --", 6, 48, 160, 26, Color3.fromRGB(60,60,90))
local killBtn2  = mkBtn(s5, "💀 Kill Player", 6, 80, 160, 30, R)
local kickBtn   = mkBtn(s5, "🚫 Kick (Crash)", 6, 116, 160, 30, Color3.fromRGB(140,40,40))
local respBtn   = mkBtn(s5, "🔄 Respawn Target", 6, 152, 160, 26, OR)

-- ================================
-- S6: TELEPORT
-- ================================
local s6 = mkSec(6)
mkTitle(s6, "🌀 Teleport", GO)
mkLbl(s6, "Pilih tujuan:", 30, GR)
local tpSpawnBtn = mkBtn(s6, "🌀 TP ke Spawn",  6, 48, 156, 28, GO)
local tpCamBtn   = mkBtn(s6, "📍 TP ke Camera", 6, 82, 156, 28, OR)
mkLbl(s6, "TP ke Player:", 116, GR)
local tpPlyrBtn  = mkBtn(s6, "Pilih Player ▼",  6, 132, 156, 28, Color3.fromRGB(60,60,90))

-- ================================
-- S7: CHAT ADMIN
-- ================================
local s7 = mkSec(7)
mkTitle(s7, "💬 Chat Admin", CY)

local chatBox = Instance.new("TextBox")
chatBox.Size = UDim2.new(1,-12,0,34)
chatBox.Position = UDim2.new(0,6,0,30)
chatBox.BackgroundColor3 = Color3.fromRGB(16,16,26)
chatBox.PlaceholderText = "Tulis pesan..."
chatBox.PlaceholderColor3 = GR
chatBox.TextColor3 = W
chatBox.Font = Enum.Font.Gotham
chatBox.TextSize = 11
chatBox.ZIndex = 103
chatBox.ClearTextOnFocus = false
chatBox.TextWrapped = true
chatBox.Parent = s7
cr(chatBox, 7)

mkLbl(s7, "⚡ Pesan Cepat:", 70, GR)
local pr1 = mkBtn(s7, "⚠️ Jangan cheat!",  6, 86,  156, 22, Color3.fromRGB(180,80,20))
local pr2 = mkBtn(s7, "👋 Hai semua!",      6, 114, 156, 22, Color3.fromRGB(30,80,160))
local pr3 = mkBtn(s7, "🚫 Kalian di kick!", 6, 142, 156, 22, R)
local chatSendBtn = mkBtn(s7, "📢 Kirim Chat", 6, 170, 156, 30, G)
local chatStatLbl = mkLbl(s7, "", 206, G)

-- ================================
-- S8: EFEK & RESET
-- ================================
local s8 = mkSec(8)
mkTitle(s8, "🎨 Efek & Reset", W)
local noclipLbl  = mkLbl(s8, "Noclip: ❌ OFF", 30, R)
local noclipBtn  = mkTog(s8, 8, 50, 152, 28)
local infJumpLbl = mkLbl(s8, "Inf Jump: ❌ OFF", 92, R)
local infJumpBtn = mkTog(s8, 8, 112, 152, 28)
local resetBtn   = mkBtn(s8, "↺ Reset Karakter", 6, 150, 156, 28, Color3.fromRGB(55,60,80))

-- ================================
-- OPEN BTN
-- ================================
local OpenBtn = Instance.new("TextButton")
OpenBtn.Size = UDim2.new(0,56,0,56)
OpenBtn.Position = UDim2.new(0,14,0.43,0)
OpenBtn.BackgroundColor3 = D
OpenBtn.Text = "⚡"
OpenBtn.TextScaled = true
OpenBtn.ZIndex = 9999
OpenBtn.Visible = false
OpenBtn.Parent = sg
cr(OpenBtn, 28)
Instance.new("UIStroke", OpenBtn).Color = CY

local od, ods, osp = false, nil, nil
OpenBtn.InputBegan:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then od=true ods=i.Position osp=OpenBtn.Position end
end)
OpenBtn.InputEnded:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then od=false end
end)
UIS.InputChanged:Connect(function(i)
    if od and (i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseMove) then
        local d=i.Position-ods OpenBtn.Position=UDim2.new(osp.X.Scale,osp.X.Offset+d.X,osp.Y.Scale,osp.Y.Offset+d.Y)
    end
end)

-- ================================
-- LOGIKA TERBANG (FIXED)
-- ================================
local flying = false
local flySpeed = 60
local goUp, goDown = false, false
local bv, bg

local function getChar()
    local c = P.Character
    if not c then return nil, nil, nil end
    return c, c:FindFirstChildOfClass("Humanoid"), c:FindFirstChild("HumanoidRootPart")
end

local function startFly()
    local c, hum, root = getChar()
    if not hum or not root then return end
    flying = true
    hum.PlatformStand = true
    if bv then bv:Destroy() end
    if bg then bg:Destroy() end
    bv = Instance.new("BodyVelocity")
    bv.MaxForce = Vector3.new(1e9,1e9,1e9)
    bv.Velocity = Vector3.zero
    bv.Parent = root
    bg = Instance.new("BodyGyro")
    bg.MaxTorque = Vector3.new(1e9,1e9,1e9)
    bg.D = 100
    bg.CFrame = root.CFrame
    bg.Parent = root
    FlyBtn.BackgroundColor3 = R
    FlyBtn.Text = "🛑"
    flyStatLbl.Text = "✅ ON"
    flyStatLbl.TextColor3 = G
end

local function stopFly()
    flying = false
    local c, hum, root = getChar()
    if hum then hum.PlatformStand = false end
    if bv then bv:Destroy(); bv=nil end
    if bg then bg:Destroy(); bg=nil end
    FlyBtn.BackgroundColor3 = G
    FlyBtn.Text = "FLY"
    flyStatLbl.Text = "❌ OFF"
    flyStatLbl.TextColor3 = R
end

RS.RenderStepped:Connect(function()
    if not flying then return end
    local c, hum, root = getChar()
    if not root or not bv then return end
    local cam = workspace.CurrentCamera
    local dir = Vector3.zero
    local camLook = Vector3.new(cam.CFrame.LookVector.X, 0, cam.CFrame.LookVector.Z)
    local camRight = Vector3.new(cam.CFrame.RightVector.X, 0, cam.CFrame.RightVector.Z)
    if hum and hum.MoveDirection.Magnitude > 0 then
        local md = hum.MoveDirection
        dir = camLook * md.Z * -1 + camRight * md.X
        if dir.Magnitude > 0 then dir = dir.Unit end
    end
    -- UP/DOWN (FIXED)
    if goUp then dir = dir + Vector3.new(0,1,0) end
    if goDown then dir = dir + Vector3.new(0,-1,0) end
    if dir.Magnitude > 0 then dir = dir.Unit end
    bv.Velocity = dir * flySpeed
    bg.CFrame = cam.CFrame
end)

FlyBtn.MouseButton1Click:Connect(function() if flying then stopFly() else startFly() end end)
FlyDec.MouseButton1Click:Connect(function() flySpeed=math.max(10,flySpeed-10) flySpeedLbl.Text="Speed: "..flySpeed end)
FlyInc.MouseButton1Click:Connect(function() flySpeed=math.min(500,flySpeed+10) flySpeedLbl.Text="Speed: "..flySpeed end)

NaikBtn.MouseButton1Down:Connect(function() goUp=true end)
NaikBtn.MouseButton1Up:Connect(function() goUp=false end)
NaikBtn.TouchStarted:Connect(function(_,gp) if gp then goUp=true end end)
NaikBtn.TouchEnded:Connect(function(_,gp) if gp then goUp=false end end)
TurunBtn.MouseButton1Down:Connect(function() goDown=true end)
TurunBtn.MouseButton1Up:Connect(function() goDown=false end)
TurunBtn.TouchStarted:Connect(function(_,gp) if gp then goDown=true end end)
TurunBtn.TouchEnded:Connect(function(_,gp) if gp then goDown=false end end)

-- ================================
-- LOGIKA SPEED & JUMP (FIXED)
-- ================================
local function applySpeed(v)
    local c, hum = getChar()
    if hum then
        hum.WalkSpeed = v
        -- Tambahan: persistent via loop
    end
end

local function applyJump(v)
    local c, hum = getChar()
    if hum then
        hum.JumpPower = v
        hum.JumpHeight = v / 5
    end
end

-- Persistent speed/jump loop (FIXED - pakai loop bukan sekali set)
local speedActive, jumpActive = false, false
local speedConn, jumpConn

spDec.MouseButton1Click:Connect(function() spVal=math.max(1,spVal-5) spLbl.Text=tostring(spVal) end)
spInc.MouseButton1Click:Connect(function() spVal=math.min(999,spVal+5) spLbl.Text=tostring(spVal) end)
spSet.MouseButton1Click:Connect(function()
    applySpeed(spVal)
    speedActive = true
    if speedConn then speedConn:Disconnect() end
    speedConn = RS.Heartbeat:Connect(function()
        if not speedActive then return end
        local c, hum = getChar()
        if hum and hum.WalkSpeed ~= spVal then hum.WalkSpeed = spVal end
    end)
    spSet.Text = "✅ Speed: "..spVal
    task.delay(2, function() spSet.Text = "✅ Terapkan Speed" end)
end)

jpDec.MouseButton1Click:Connect(function() jpVal=math.max(1,jpVal-10) jpLbl.Text=tostring(jpVal) end)
jpInc.MouseButton1Click:Connect(function() jpVal=math.min(999,jpVal+10) jpLbl.Text=tostring(jpVal) end)
jpSet.MouseButton1Click:Connect(function()
    applyJump(jpVal)
    jumpActive = true
    if jumpConn then jumpConn:Disconnect() end
    jumpConn = RS.Heartbeat:Connect(function()
        if not jumpActive then return end
        local c, hum = getChar()
        if hum and hum.JumpPower ~= jpVal then hum.JumpPower = jpVal end
    end)
    jpSet.Text = "✅ Jump: "..jpVal
    task.delay(2, function() jpSet.Text = "✅ Terapkan Jump" end)
end)

-- ================================
-- LOGIKA INVISIBLE (FIXED)
-- ================================
local isInvis = false
local invisConn

local function setInvis(state)
    local c = P.Character
    if not c then return end
    for _, part in ipairs(c:GetDescendants()) do
        if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
            part.LocalTransparencyModifier = state and 1 or
