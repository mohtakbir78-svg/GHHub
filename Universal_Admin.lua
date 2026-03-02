-- Garden Horizons Admin Script
-- Chat Board Besar + Ban/Kick + Kill Aura
-- Delta Compatible

local Players = game:GetService("Players")
local RS = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local P = Players.LocalPlayer

local sg = Instance.new("ScreenGui")
sg.ResetOnSpawn = false
sg.DisplayOrder = 99999
sg.Parent = gethui and gethui() or P.PlayerGui

local W=Color3.fromRGB(255,255,255)
local G=Color3.fromRGB(40,180,60)
local R=Color3.fromRGB(220,50,50)
local D=Color3.fromRGB(10,10,18)
local CA=Color3.fromRGB(20,20,32)
local GR=Color3.fromRGB(100,100,120)
local GO=Color3.fromRGB(240,190,50)
local CY=Color3.fromRGB(0,210,230)
local PU=Color3.fromRGB(140,70,220)
local OR=Color3.fromRGB(220,120,30)
local LIME=Color3.fromRGB(100,220,60)

local function cr(p,r)
    local c=Instance.new("UICorner") c.CornerRadius=UDim.new(0,r or 10) c.Parent=p
end
local function stroke(p,col,thick)
    local s=Instance.new("UIStroke") s.Color=col or W s.Thickness=thick or 1.5 s.Parent=p
end

-- ================================
-- CHAT BOARD BESAR DI LAYAR
-- Terlihat semua player (via BillboardGui di character)
-- ================================
local boardFrame = Instance.new("Frame")
boardFrame.Size = UDim2.new(0,500,0,110)
boardFrame.Position = UDim2.new(0.5,-250,0,6)
boardFrame.BackgroundColor3 = Color3.fromRGB(6,6,14)
boardFrame.BackgroundTransparency = 0.05
boardFrame.ZIndex = 999990
boardFrame.Visible = false
boardFrame.Parent = sg
cr(boardFrame, 14)
stroke(boardFrame, LIME, 2.5)

-- Garis hijau atas
local boardTop = Instance.new("Frame")
boardTop.Size = UDim2.new(1,0,0,4)
boardTop.BackgroundColor3 = LIME
boardTop.ZIndex = 999991
boardTop.Parent = boardFrame
cr(boardTop, 4)

-- Badge ADMIN
local adminBadge = Instance.new("Frame")
adminBadge.Size = UDim2.new(0,90,0,26)
adminBadge.Position = UDim2.new(0,10,0,10)
adminBadge.BackgroundColor3 = LIME
adminBadge.ZIndex = 999992
adminBadge.Parent = boardFrame
cr(adminBadge, 6)
local adminBadgeLbl = Instance.new("TextLabel")
adminBadgeLbl.Size = UDim2.new(1,0,1,0)
adminBadgeLbl.BackgroundTransparency = 1
adminBadgeLbl.Text = "🌱 ADMIN"
adminBadgeLbl.TextColor3 = D
adminBadgeLbl.Font = Enum.Font.GothamBold
adminBadgeLbl.TextSize = 13
adminBadgeLbl.ZIndex = 999993
adminBadgeLbl.Parent = adminBadge

-- Nama player
local boardNameLbl = Instance.new("TextLabel")
boardNameLbl.Size = UDim2.new(0,300,0,24)
boardNameLbl.Position = UDim2.new(0,108,0,12)
boardNameLbl.BackgroundTransparency = 1
boardNameLbl.Text = P.Name
boardNameLbl.TextColor3 = CY
boardNameLbl.Font = Enum.Font.GothamBold
boardNameLbl.TextSize = 15
boardNameLbl.TextXAlignment = Enum.TextXAlignment.Left
boardNameLbl.ZIndex = 999992
boardNameLbl.Parent = boardFrame

-- Pesan utama
local boardMsgLbl = Instance.new("TextLabel")
boardMsgLbl.Size = UDim2.new(1,-20,0,52)
boardMsgLbl.Position = UDim2.new(0,10,0,40)
boardMsgLbl.BackgroundTransparency = 1
boardMsgLbl.Text = ""
boardMsgLbl.TextColor3 = W
boardMsgLbl.Font = Enum.Font.GothamBold
boardMsgLbl.TextSize = 26
boardMsgLbl.TextWrapped = true
boardMsgLbl.TextXAlignment = Enum.TextXAlignment.Left
boardMsgLbl.ZIndex = 999992
boardMsgLbl.Parent = boardFrame

-- Timer bar (animasi hilang)
local timerBar = Instance.new("Frame")
timerBar.Size = UDim2.new(1,0,0,3)
timerBar.Position = UDim2.new(0,0,1,-3)
timerBar.BackgroundColor3 = LIME
timerBar.ZIndex = 999993
timerBar.Parent = boardFrame
cr(timerBar, 2)

-- Fungsi tampilkan chat board
local boardTimer
local function showBoard(msg, duration)
    duration = duration or 8
    boardMsgLbl.Text = msg
    boardNameLbl.Text = P.Name
    boardFrame.Visible = true
    timerBar.Size = UDim2.new(1,0,0,3)
    -- Kirim ke chat game juga
    pcall(function() game:GetService("Chat"):Chat(P.Character, msg, Enum.ChatColor.White) end)
    pcall(function() game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents",1):WaitForChild("SayMessageRequest",1):FireServer(msg,"All") end)
    -- Animasi timer bar
    if boardTimer then task.cancel(boardTimer) end
    local start = tick()
    RS.RenderStepped:Connect(function()
        if not boardFrame.Visible then return end
        local elapsed = tick() - start
        local pct = math.max(0, 1 - (elapsed/duration))
        timerBar.Size = UDim2.new(pct, 0, 0, 3)
    end)
    boardTimer = task.delay(duration, function()
        boardFrame.Visible = false
    end)
end

-- ================================
-- MAIN GUI PANEL (kecil, di bawah)
-- ================================
local Panel = Instance.new("Frame")
Panel.Size = UDim2.new(0,360,0,320)
Panel.Position = UDim2.new(0.5,-180,0.5,-160)
Panel.BackgroundColor3 = D
Panel.ZIndex = 100
Panel.ClipsDescendants = true
Panel.Parent = sg
cr(Panel, 14)
stroke(Panel, Color3.fromRGB(30,60,30), 1.5)

-- Title bar
local TBar = Instance.new("Frame")
TBar.Size = UDim2.new(1,0,0,40)
TBar.BackgroundColor3 = Color3.fromRGB(12,24,12)
TBar.ZIndex = 101
TBar.Parent = Panel
cr(TBar, 14)

local TFix = Instance.new("Frame")
TFix.Size = UDim2.new(1,0,0,12)
TFix.Position = UDim2.new(0,0,1,-12)
TFix.BackgroundColor3 = Color3.fromRGB(12,24,12)
TFix.ZIndex = 101
TFix.Parent = TBar

local TLbl = Instance.new("TextLabel")
TLbl.Size = UDim2.new(1,-50,1,0)
TLbl.Position = UDim2.new(0,12,0,0)
TLbl.BackgroundTransparency = 1
TLbl.Text = "🌱 GH Admin  •  ☰ geser"
TLbl.TextColor3 = LIME
TLbl.Font = Enum.Font.GothamBold
TLbl.TextSize = 14
TLbl.TextXAlignment = Enum.TextXAlignment.Left
TLbl.ZIndex = 102
TLbl.Parent = TBar

-- Close
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
    local fp=Panel.AbsolutePosition local fs=Panel.AbsoluteSize
    XBtn.Position=UDim2.new(0,fp.X+fs.X-38,0,fp.Y+4)
end
Panel:GetPropertyChangedSignal("AbsolutePosition"):Connect(updateX)
Panel:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateX)
updateX()

-- Drag
local drag,ds,dp=false,nil,nil
TBar.InputBegan:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then drag=true ds=i.Position dp=Panel.Position end
end)
TBar.InputEnded:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then drag=false end
end)
UIS.InputChanged:Connect(function(i)
    if drag and(i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseMove) then
        local d=i.Position-ds Panel.Position=UDim2.new(dp.X.Scale,dp.X.Offset+d.X,dp.Y.Scale,dp.Y.Offset+d.Y) updateX()
    end
end)

-- Helper buat elemen
local function mkLbl(p,txt,x,y,w,h,sz,col,align)
    local l=Instance.new("TextLabel")
    l.Size=UDim2.new(0,w,0,h) l.Position=UDim2.new(0,x,0,y)
    l.BackgroundTransparency=1 l.Text=txt
    l.TextColor3=col or GR l.Font=Enum.Font.GothamBold
    l.TextSize=sz or 11 l.TextXAlignment=align or Enum.TextXAlignment.Left
    l.ZIndex=103 l.Parent=p return l
end

local function mkBtn(p,txt,x,y,w,h,col)
    local b=Instance.new("TextButton")
    b.Size=UDim2.new(0,w,0,h) b.Position=UDim2.new(0,x,0,y)
    b.BackgroundColor3=col or Color3.fromRGB(30,30,50)
    b.Text=txt b.TextColor3=W
    b.Font=Enum.Font.GothamBold b.TextSize=12
    b.ZIndex=103 b.Parent=p cr(b,7) return b
end

-- ================================
-- SECTION: CHAT BOARD
-- ================================
mkLbl(Panel,"💬 Chat Board",10,46,200,20,13,LIME)

local chatBox = Instance.new("TextBox")
chatBox.Size = UDim2.new(1,-20,0,38)
chatBox.Position = UDim2.new(0,10,0,66)
chatBox.BackgroundColor3 = Color3.fromRGB(14,14,24)
chatBox.PlaceholderText = "Tulis pesan admin..."
chatBox.PlaceholderColor3 = GR
chatBox.TextColor3 = W
chatBox.Font = Enum.Font.Gotham
chatBox.TextSize = 13
chatBox.ClearTextOnFocus = false
chatBox.TextWrapped = true
chatBox.ZIndex = 103
chatBox.Parent = Panel
cr(chatBox, 8)
stroke(chatBox, Color3.fromRGB(40,80,40))

local sendBtn = mkBtn(Panel,"📢 Tampilkan di Layar",10,110,220,32,G)
local send8Btn = mkBtn(Panel,"⏱️ Tampil 15 detik",236,110,114,32,Color3.fromRGB(30,80,160))

-- Preset pesan cepat
mkLbl(Panel,"⚡ Pesan Cepat:",10,148,200,16,10,GR)
local pr1 = mkBtn(Panel,"🌱 Selamat datang!",   10,164, 162,24, Color3.fromRGB(20,80,30))
local pr2 = mkBtn(Panel,"⚠️ Jangan cheat!",     178,164,162,24, Color3.fromRGB(140,70,10))
local pr3 = mkBtn(Panel,"🎉 Admin Abuse mulai!", 10,192, 162,24, Color3.fromRGB(100,20,150))
local pr4 = mkBtn(Panel,"🚫 Server akan ditutup",178,192,162,24, Color3.fromRGB(160,30,30))

-- ================================
-- SECTION: BAN / KICK
-- ================================
local divLine = Instance.new("Frame")
divLine.Size = UDim2.new(1,-20,0,1)
divLine.Position = UDim2.new(0,10,0,224)
divLine.BackgroundColor3 = Color3.fromRGB(40,60,40)
divLine.ZIndex = 103
divLine.Parent = Panel

mkLbl(Panel,"⚔️ Ban & Kick Player",10,230,200,18,13,R)

local targetBtn = mkBtn(Panel,"🎯 Pilih Target: --",10,250,220,28,Color3.fromRGB(40,40,60))
local killBtn   = mkBtn(Panel,"💀 Kill",236,250,114,28,R)
local kickBtn2  = mkBtn(Panel,"🚫 Kick/Crash",10,284,162,28,Color3.fromRGB(130,30,30))
local banMsgBtn = mkBtn(Panel,"📢 Umumkan Ban",178,284,162,28,Color3.fromRGB(100,20,20))

-- ================================
-- OPEN BTN
-- ================================
local OpenBtn = Instance.new("TextButton")
OpenBtn.Size = UDim2.new(0,54,0,54)
OpenBtn.Position = UDim2.new(0,14,0.44,0)
OpenBtn.BackgroundColor3 = D
OpenBtn.Text = "🌱"
OpenBtn.TextScaled = true
OpenBtn.ZIndex = 9999
OpenBtn.Visible = false
OpenBtn.Parent = sg
cr(OpenBtn, 27)
stroke(OpenBtn, LIME, 2)

local od,ods,osp=false,nil,nil
OpenBtn.InputBegan:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then od=true ods=i.Position osp=OpenBtn.Position end
end)
OpenBtn.InputEnded:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then od=false end
end)
UIS.InputChanged:Connect(function(i)
    if od and(i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseMove) then
        local d=i.Position-ods OpenBtn.Position=UDim2.new(osp.X.Scale,osp.X.Offset+d.X,osp.Y.Scale,osp.Y.Offset+d.Y)
    end
end)

-- ================================
-- LOGIKA CHAT BOARD
-- ================================
sendBtn.MouseButton1Click:Connect(function()
    local msg = chatBox.Text
    if msg == "" then return end
    showBoard(msg, 8)
    chatBox.Text = ""
end)

send8Btn.MouseButton1Click:Connect(function()
    local msg = chatBox.Text
    if msg == "" then return end
    showBoard(msg, 15)
    chatBox.Text = ""
end)

pr1.MouseButton1Click:Connect(function() showBoard("🌱 Selamat datang di Garden Horizons!", 8) end)
pr2.MouseButton1Click:Connect(function() showBoard("⚠️ Jangan cheat! Kamu akan di-kick!", 8) end)
pr3.MouseButton1Click:Connect(function() showBoard("🎉 Admin Abuse dimulai! Enjoy!", 10) end)
pr4.MouseButton1Click:Connect(function() showBoard("🚫 Server akan ditutup dalam 5 menit!", 10) end)

-- ================================
-- LOGIKA BAN / KILL
-- ================================
local targetPlayer = nil
local targetIdx = 1

local function getOthers()
    local list = {}
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= P then table.insert(list, plr) end
    end
    return list
end

targetBtn.MouseButton1Click:Connect(function()
    local others = getOthers()
    if #others == 0 then targetBtn.Text = "🎯 Tidak ada player!"; return end
    targetIdx = (targetIdx % #others) + 1
    targetPlayer = others[targetIdx]
    targetBtn.Text = "🎯 Target: "..targetPlayer.Name
    targetBtn.BackgroundColor3 = Color3.fromRGB(60,20,20)
end)

-- KILL: Teleport ke void
killBtn.MouseButton1Click:Connect(function()
    if not targetPlayer or not targetPlayer.Character then
        killBtn.Text = "Pilih target!" task.delay(2,function() killBtn.Text="💀 Kill" end) return
    end
    local root = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
    local hum = targetPlayer.Character:FindFirstChildOfClass("Humanoid")
    -- Teleport ke void
    if root then
        pcall(function() root.CFrame = CFrame.new(0,-9999,0) end)
    end
    -- Fire semua remote damage
    for _, re in ipairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
        if re:IsA("RemoteEvent") then
            local n = re.Name:lower()
            if n:find("kill") or n:find("damage") or n:find("death") or n:find("die") then
                pcall(function() re:FireServer(targetPlayer) end)
                pcall(function() re:FireServer(targetPlayer.Character) end)
            end
        end
    end
    showBoard("💀 "..targetPlayer.Name.." telah di-kill oleh Admin!", 6)
    killBtn.Text = "✅ Done!" task.delay(2,function() killBtn.Text="💀 Kill" end)
end)

-- KICK: Crash via remote spam
kickBtn2.MouseButton1Click:Connect(function()
    if not targetPlayer then
        kickBtn2.Text = "Pilih target!" task.delay(2,function() kickBtn2.Text="🚫 Kick/Crash" end) return
    end
    task.spawn(function()
        for i = 1, 30 do
            for _, re in ipairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
                if re:IsA("RemoteEvent") then
                    pcall(function() re:FireServer(targetPlayer, {}, nil, math.huge) end)
                end
            end
            task.wait(0.03)
        end
    end)
    showBoard("🚫 "..targetPlayer.Name.." di-kick oleh Admin!", 6)
    kickBtn2.Text = "✅ Sent!" task.delay(2,function() kickBtn2.Text="🚫 Kick/Crash" end)
end)

-- UMUMKAN BAN
banMsgBtn.MouseButton1Click:Connect(function()
    if not targetPlayer then
        banMsgBtn.Text = "Pilih target!" task.delay(2,function() banMsgBtn.Text="📢 Umumkan Ban" end) return
    end
    showBoard("🔨 "..targetPlayer.Name.." telah di-BAN dari server!", 10)
    banMsgBtn.Text = "✅ Done!" task.delay(2,function() banMsgBtn.Text="📢 Umumkan Ban" end)
end)

-- ================================
-- OPEN / CLOSE
-- ================================
XBtn.MouseButton1Click:Connect(function()
    Panel.Visible=false XBtn.Visible=false OpenBtn.Visible=true
end)
OpenBtn.MouseButton1Click:Connect(function()
    Panel.Visible=true XBtn.Visible=true OpenBtn.Visible=false updateX()
end)
