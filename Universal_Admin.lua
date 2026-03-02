-- PETAPETA Hub Script
-- Auto Farm/Collect + ESP Map + ESP Items dengan Nama + Fly + Speed
-- Game: PETAPETA (Hotel Horror) - Level 7
-- Delta Compatible

local Players = game:GetService("Players")
local RS = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local P = Players.LocalPlayer

local sg = Instance.new("ScreenGui")
sg.ResetOnSpawn = false
sg.DisplayOrder = 9999
sg.Name = "PetaPetaHub"
sg.Parent = gethui and gethui() or P.PlayerGui

local W=Color3.fromRGB(255,255,255)
local G=Color3.fromRGB(40,180,60)
local R=Color3.fromRGB(220,50,50)
local D=Color3.fromRGB(10,10,18)
local CA=Color3.fromRGB(20,20,32)
local GR=Color3.fromRGB(100,100,120)
local GO=Color3.fromRGB(240,190,50)
local CY=Color3.fromRGB(0,210,230)
local PU=Color3.fromRGB(160,80,240)
local OR=Color3.fromRGB(220,120,30)
local RED2=Color3.fromRGB(255,60,60)

local function cr(p,r)
    local c=Instance.new("UICorner") c.CornerRadius=UDim.new(0,r or 10) c.Parent=p
end
local function mkStroke(p,col,th)
    local s=Instance.new("UIStroke") s.Color=col or CY s.Thickness=th or 1.5 s.Parent=p
end
local function togOn(b,c) b.BackgroundColor3=c or G b.TextColor3=W b.Text="ON" end
local function togOff(b) b.BackgroundColor3=Color3.fromRGB(40,40,60) b.TextColor3=GR b.Text="OFF" end

-- MAIN FRAME
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0,380,0,310)
Frame.Position = UDim2.new(0.5,-190,0.5,-155)
Frame.BackgroundColor3 = D
Frame.ZIndex = 100
Frame.ClipsDescendants = true
Frame.Parent = sg
cr(Frame,14)
mkStroke(Frame, Color3.fromRGB(50,0,80), 1.5)

local TBar = Instance.new("Frame")
TBar.Size = UDim2.new(1,0,0,40)
TBar.BackgroundColor3 = Color3.fromRGB(18,0,30)
TBar.ZIndex = 101
TBar.Parent = Frame
cr(TBar,14)

local TFix = Instance.new("Frame")
TFix.Size = UDim2.new(1,0,0,12)
TFix.Position = UDim2.new(0,0,1,-12)
TFix.BackgroundColor3 = Color3.fromRGB(18,0,30)
TFix.ZIndex = 101
TFix.Parent = TBar

local TLbl = Instance.new("TextLabel")
TLbl.Size = UDim2.new(1,-50,1,0)
TLbl.Position = UDim2.new(0,12,0,0)
TLbl.BackgroundTransparency = 1
TLbl.Text = "👹 PETAPETA Hub  •  ☰ geser"
TLbl.TextColor3 = PU
TLbl.Font = Enum.Font.GothamBold
TLbl.TextSize = 13
TLbl.TextXAlignment = Enum.TextXAlignment.Left
TLbl.ZIndex = 102
TLbl.Parent = TBar

local XBtn = Instance.new("TextButton")
XBtn.Size = UDim2.new(0,34,0,34)
XBtn.BackgroundColor3 = R
XBtn.Text = "✕"
XBtn.TextColor3 = W
XBtn.Font = Enum.Font.GothamBold
XBtn.TextSize = 16
XBtn.ZIndex = 999999
XBtn.Parent = sg
cr(XBtn,8)

local function updateX()
    local fp=Frame.AbsolutePosition local fs=Frame.AbsoluteSize
    XBtn.Position=UDim2.new(0,fp.X+fs.X-38,0,fp.Y+4)
end
Frame:GetPropertyChangedSignal("AbsolutePosition"):Connect(updateX)
Frame:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateX)
updateX()

local drag,ds,dp=false,nil,nil
TBar.InputBegan:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then
        drag=true ds=i.Position dp=Frame.Position
    end
end)
TBar.InputEnded:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then drag=false end
end)
UIS.InputChanged:Connect(function(i)
    if drag and(i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseMove) then
        local d=i.Position-ds
        Frame.Position=UDim2.new(dp.X.Scale,dp.X.Offset+d.X,dp.Y.Scale,dp.Y.Offset+d.Y)
        updateX()
    end
end)

local HScroll = Instance.new("ScrollingFrame")
HScroll.Size = UDim2.new(1,-8,1,-48)
HScroll.Position = UDim2.new(0,4,0,44)
HScroll.BackgroundTransparency = 1
HScroll.ScrollBarThickness = 4
HScroll.ScrollBarImageColor3 = PU
HScroll.ScrollingDirection = Enum.ScrollingDirection.X
HScroll.ZIndex = 101
HScroll.Parent = Frame

local HLayout = Instance.new("UIListLayout")
HLayout.FillDirection = Enum.FillDirection.Horizontal
HLayout.Padding = UDim.new(0,6)
HLayout.VerticalAlignment = Enum.VerticalAlignment.Center
HLayout.Parent = HScroll

local HPad = Instance.new("UIPadding")
HPad.PaddingLeft = UDim.new(0,4)
HPad.PaddingRight = UDim.new(0,4)
HPad.Parent = HScroll

HLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    HScroll.CanvasSize = UDim2.new(0,HLayout.AbsoluteContentSize.X+10,0,0)
end)

local function mkSec(order,w)
    local f=Instance.new("Frame")
    f.Size=UDim2.new(0,w or 175,1,-8)
    f.BackgroundColor3=CA f.LayoutOrder=order f.ZIndex=102 f.Parent=HScroll
    cr(f,10) return f
end
local function mkTitle(p,txt,col)
    local l=Instance.new("TextLabel")
    l.Size=UDim2.new(1,-10,0,22) l.Position=UDim2.new(0,6,0,5)
    l.BackgroundTransparency=1 l.Text=txt l.TextColor3=col or W
    l.Font=Enum.Font.GothamBold l.TextSize=13
    l.TextXAlignment=Enum.TextXAlignment.Left l.ZIndex=103 l.Parent=p
end
local function mkLbl(p,txt,y,col)
    local l=Instance.new("TextLabel")
    l.Size=UDim2.new(1,-10,0,16) l.Position=UDim2.new(0,6,0,y)
    l.BackgroundTransparency=1 l.Text=txt l.TextColor3=col or GR
    l.Font=Enum.Font.GothamBold l.TextSize=10
    l.TextXAlignment=Enum.TextXAlignment.Left l.ZIndex=103 l.Parent=p return l
end
local function mkBtn(p,txt,x,y,w,h,col)
    local b=Instance.new("TextButton")
    b.Size=UDim2.new(0,w,0,h) b.Position=UDim2.new(0,x,0,y)
    b.BackgroundColor3=col or Color3.fromRGB(30,30,50)
    b.Text=txt b.TextColor3=W b.Font=Enum.Font.GothamBold b.TextSize=11
    b.ZIndex=103 b.Parent=p cr(b,7) return b
end
local function mkTog(p,x,y,w,h)
    local b=Instance.new("TextButton")
    b.Size=UDim2.new(0,w or 163,0,h or 30) b.Position=UDim2.new(0,x,0,y)
    b.BackgroundColor3=Color3.fromRGB(40,40,60)
    b.Text="OFF" b.TextColor3=GR b.Font=Enum.Font.GothamBold b.TextSize=13
    b.ZIndex=103 b.Parent=p cr(b,7) return b
end

-- ================================
-- S1: FLY + SPEED
-- ================================
local s1=mkSec(1,178)
mkTitle(s1,"✈️ Fly & Speed",CY)
local flyLbl=mkLbl(s1,"Terbang: ❌ OFF",28,R)
local spdLbl=mkLbl(s1,"Speed: 16",44,GO)

local NaikBtn =mkBtn(s1,"⬆️ Naik", 6, 62,80,36,Color3.fromRGB(20,100,40))
local FlyBtn  =mkBtn(s1,"✈️ FLY",  90, 62,82,36,G)
local TurunBtn=mkBtn(s1,"⬇️ Turun",6,104,80,30,Color3.fromRGB(130,30,30))
local StopBtn =mkBtn(s1,"⏹ Stop", 90,104,82,30,Color3.fromRGB(70,70,90))
local FlyDec  =mkBtn(s1,"-10",6,140,52,24,Color3.fromRGB(100,40,20))
local FlyInc  =mkBtn(s1,"+10",120,140,52,24,Color3.fromRGB(20,70,140))
local fspLbl  =Instance.new("TextLabel")
fspLbl.Size=UDim2.new(0,56,0,22) fspLbl.Position=UDim2.new(0,60,0,142)
fspLbl.BackgroundTransparency=1 fspLbl.Text="60"
fspLbl.TextColor3=GO fspLbl.Font=Enum.Font.GothamBold
fspLbl.TextSize=15 fspLbl.TextXAlignment=Enum.TextXAlignment.Center
fspLbl.ZIndex=103 fspLbl.Parent=s1

mkLbl(s1,"WalkSpeed:",170,GR)
local spVal=16
local spDec=mkBtn(s1,"-",6,184,38,22,Color3.fromRGB(100,40,20))
local spVLbl=Instance.new("TextLabel")
spVLbl.Size=UDim2.new(0,52,0,20) spVLbl.Position=UDim2.new(0,48,0,186)
spVLbl.BackgroundTransparency=1 spVLbl.Text="16"
spVLbl.TextColor3=CY spVLbl.Font=Enum.Font.GothamBold spVLbl.TextSize=14
spVLbl.TextXAlignment=Enum.TextXAlignment.Center spVLbl.ZIndex=103 spVLbl.Parent=s1
local spInc=mkBtn(s1,"+",104,184,38,22,Color3.fromRGB(20,70,140))
local spSetBtn=mkBtn(s1,"✅ Set Speed",6,210,163,28,Color3.fromRGB(20,80,160))

-- ================================
-- S2: AUTO FARM
-- ================================
local s2=mkSec(2,178)
mkTitle(s2,"🔑 Auto Farm",GO)

local farmKeywords = {
    "key","box","safecode","paper","code","doll","dollhead","photo","ofuda",
    "rope","lighter","plate","circle","triangle","square","rectangle",
    "candle","colorblock","redblock","blueblock","greenblock","yellowblock",
    "onigiri","partypopper","cursedshard","fragment","clue","note",
    "item","pickup","collect","block","shard","scroll","talisman"
}

local farmStatLbl  = mkLbl(s2,"Status: Siap",28,GR)
local autoFarmBtn  = mkTog(s2,6,46,163,30)
local tpNearBtn    = mkBtn(s2,"📍 TP ke Item Terdekat",6,82,163,28,Color3.fromRGB(80,40,120))
local farmAllBtn   = mkBtn(s2,"⚡ Ambil Semua Sekarang",6,116,163,28,Color3.fromRGB(100,60,20))
local skipExitBtn  = mkBtn(s2,"⏭️ TP ke Exit",6,150,163,28,Color3.fromRGB(30,60,130))
local farmCntLbl   = mkLbl(s2,"Item ditemukan: 0",186,CY)

-- ================================
-- S3: ESP (ITEMS + PLAYER + MONSTER)
-- ================================
local s3=mkSec(3,178)
mkTitle(s3,"👁️ ESP",PU)
local espItmLbl = mkLbl(s3,"Item ESP: ❌ OFF",28,R)
local espItmBtn = mkTog(s3,6,46,163,28)
local espPlyLbl = mkLbl(s3,"Player ESP: ❌ OFF",82,R)
local espPlyBtn = mkTog(s3,6,100,163,28)
local espMonLbl = mkLbl(s3,"👹 Monster ESP: ❌ OFF",136,R)
local espMonBtn = mkTog(s3,6,154,163,28)
local espRefBtn = mkBtn(s3,"🔄 Refresh ESP",6,192,163,26,Color3.fromRGB(40,40,80))

-- ================================
-- S4: MINI MAP / RADAR
-- ================================
local s4=mkSec(4,178)
mkTitle(s4,"🗺️ Mini Map",CY)
local mapLbl    = mkLbl(s4,"Radar: ❌ OFF",28,R)
local mapBtn    = mkTog(s4,6,46,163,28)
local mapSzLbl  = mkLbl(s4,"Ukuran: 200",82,GR)
local mapDecBtn = mkBtn(s4,"-50",6,98,52,22,Color3.fromRGB(100,40,20))
local mapIncBtn = mkBtn(s4,"+50",120,98,52,22,Color3.fromRGB(20,70,140))

-- ================================
-- S5: MISC
-- ================================
local s5=mkSec(5,178)
mkTitle(s5,"⚙️ Misc",W)
local ncLbl  = mkLbl(s5,"Noclip: ❌ OFF",28,R)
local ncBtn  = mkTog(s5,6,46,163,28)
local ijLbl  = mkLbl(s5,"Inf Jump: ❌ OFF",84,R)
local ijBtn  = mkTog(s5,6,102,163,28)
local gdLbl  = mkLbl(s5,"God Mode: ❌ OFF",138,R)
local gdBtn  = mkTog(s5,6,156,163,28)
local rstBtn = mkBtn(s5,"↺ Respawn",6,196,163,26,Color3.fromRGB(55,55,75))

-- ================================
-- OPEN BTN
-- ================================
local OpenBtn = Instance.new("TextButton")
OpenBtn.Size = UDim2.new(0,54,0,54)
OpenBtn.Position = UDim2.new(0,14,0.44,0)
OpenBtn.BackgroundColor3 = D
OpenBtn.Text = "👹"
OpenBtn.TextScaled = true
OpenBtn.ZIndex = 9999
OpenBtn.Visible = false
OpenBtn.Parent = sg
cr(OpenBtn,27)
mkStroke(OpenBtn,PU,2)

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
-- LOGIKA FLY
-- ================================
local flying=false local flySpeed=60
local goUp,goDown=false,false local bv,bg

local function getChar()
    local c=P.Character if not c then return nil,nil,nil end
    return c,c:FindFirstChildOfClass("Humanoid"),c:FindFirstChild("HumanoidRootPart")
end

local function startFly()
    local c,hum,root=getChar() if not hum or not root then return end
    flying=true hum.PlatformStand=true
    if bv then bv:Destroy() end if bg then bg:Destroy() end
    bv=Instance.new("BodyVelocity")
    bv.MaxForce=Vector3.new(1e9,1e9,1e9) bv.Velocity=Vector3.zero bv.Parent=root
    bg=Instance.new("BodyGyro")
    bg.MaxTorque=Vector3.new(1e9,1e9,1e9) bg.D=100 bg.CFrame=root.CFrame bg.Parent=root
    FlyBtn.BackgroundColor3=R FlyBtn.Text="🛑 ON"
    flyLbl.Text="Terbang: ✅ ON" flyLbl.TextColor3=G
end

local function stopFly()
    flying=false goUp=false goDown=false
    local c,hum,root=getChar()
    if hum then hum.PlatformStand=false end
    if bv then bv:Destroy() bv=nil end
    if bg then bg:Destroy() bg=nil end
    FlyBtn.BackgroundColor3=G FlyBtn.Text="✈️ FLY"
    flyLbl.Text="Terbang: ❌ OFF" flyLbl.TextColor3=R
end

RS.RenderStepped:Connect(function()
    if not flying then return end
    local c,hum,root=getChar() if not root or not bv then return end
    local cam=workspace.CurrentCamera
    local dir=Vector3.zero
    if hum and hum.MoveDirection.Magnitude>0 then
        local md=hum.MoveDirection
        local cR=Vector3.new(cam.CFrame.RightVector.X,0,cam.CFrame.RightVector.Z)
        local cF=Vector3.new(cam.CFrame.LookVector.X,0,cam.CFrame.LookVector.Z)
        if cR.Magnitude>0 then cR=cR.Unit end
        if cF.Magnitude>0 then cF=cF.Unit end
        dir=cF*(-md.Z)+cR*md.X
        if dir.Magnitude>0 then dir=dir.Unit end
    end
    if goUp   then dir=dir+Vector3.new(0,1,0) end
    if goDown then dir=dir+Vector3.new(0,-1,0) end
    if dir.Magnitude>0 then dir=dir.Unit end
    bv.Velocity=dir*flySpeed
    bg.CFrame=cam.CFrame
end)

FlyBtn.MouseButton1Click:Connect(function() if flying then stopFly() else startFly() end end)
StopBtn.MouseButton1Click:Connect(function() stopFly() end)
NaikBtn.MouseButton1Down:Connect(function() if not flying then startFly() end goUp=true end)
NaikBtn.MouseButton1Up:Connect(function() goUp=false end)
NaikBtn.TouchStarted:Connect(function(_,gp) if gp then if not flying then startFly() end goUp=true end end)
NaikBtn.TouchEnded:Connect(function(_,gp) if gp then goUp=false end end)
TurunBtn.MouseButton1Down:Connect(function() if not flying then startFly() end goDown=true end)
TurunBtn.MouseButton1Up:Connect(function() goDown=false end)
TurunBtn.TouchStarted:Connect(function(_,gp) if gp then if not flying then startFly() end goDown=true end end)
TurunBtn.TouchEnded:Connect(function(_,gp) if gp then goDown=false end end)
FlyDec.MouseButton1Click:Connect(function() flySpeed=math.max(10,flySpeed-10) fspLbl.Text=tostring(flySpeed) end)
FlyInc.MouseButton1Click:Connect(function() flySpeed=math.min(500,flySpeed+10) fspLbl.Text=tostring(flySpeed) end)

spDec.MouseButton1Click:Connect(function() spVal=math.max(4,spVal-4) spVLbl.Text=tostring(spVal) end)
spInc.MouseButton1Click:Connect(function() spVal=math.min(200,spVal+4) spVLbl.Text=tostring(spVal) end)
local speedConn
spSetBtn.MouseButton1Click:Connect(function()
    if speedConn then speedConn:Disconnect() end
    speedConn=RS.Heartbeat:Connect(function()
        local c2,hum2=getChar() if hum2 and hum2.WalkSpeed~=spVal then hum2.WalkSpeed=spVal end
    end)
    spdLbl.Text="Speed: "..spVal spdLbl.TextColor3=G
    spSetBtn.Text="✅ "..spVal task.delay(2,function() spSetBtn.Text="✅ Set Speed" end)
end)

-- ================================
-- LOGIKA AUTO FARM
-- ================================
local function scanItems()
    local found={}
    for _,obj in ipairs(workspace:GetDescendants()) do
        local n=obj.Name:lower()
        local isItem=false
        for _,kw in ipairs(farmKeywords) do
            if n:find(kw) then isItem=true break end
        end
        if isItem and (obj:IsA("BasePart") or obj:IsA("MeshPart") or obj:IsA("Model") or obj:IsA("Tool")) then
            table.insert(found,obj)
        end
        if obj:IsA("ProximityPrompt") and obj.Enabled then
            table.insert(found,obj)
        end
    end
    return found
end

local function collectObj(obj)
    local c,hum,root=getChar() if not root then return end
    local part=obj
    if obj:IsA("Model") then part=obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart") end
    if obj:IsA("ProximityPrompt") then
        pcall(function() fireproximityprompt(obj) end)
        return
    end
    if not part then return end
    root.CFrame=CFrame.new(part.Position)+Vector3.new(0,3,0)
    task.wait(0.15)
    pcall(function() firetouchinterest(part,root,0) task.wait(0.05) firetouchinterest(part,root,1) end)
    for _,pp in ipairs(obj:GetDescendants()) do
        if pp:IsA("ProximityPrompt") then pcall(function() fireproximityprompt(pp) end) end
    end
end

local autoFarming=false

local function doFarm()
    local items=scanItems()
    farmCntLbl.Text="Item ditemukan: "..#items
    if #items==0 then farmStatLbl.Text="Tidak ada item" farmStatLbl.TextColor3=GR return end
    for i,item in ipairs(items) do
        if not autoFarming then break end
        farmStatLbl.Text="Ambil "..i.."/"..#items
        farmStatLbl.TextColor3=GO
        pcall(function() collectObj(item) end)
        task.wait(0.3)
    end
    farmStatLbl.Text="✅ Selesai!" farmStatLbl.TextColor3=G
end

autoFarmBtn.MouseButton1Click:Connect(function()
    autoFarming=not autoFarming
    if autoFarming then
        togOn(autoFarmBtn,G)
        task.spawn(function()
            while autoFarming do pcall(doFarm) task.wait(2) end
        end)
    else
        togOff(autoFarmBtn)
        farmStatLbl.Text="Status: Berhenti" farmStatLbl.TextColor3=GR
    end
end)

tpNearBtn.MouseButton1Click:Connect(function()
    local items=scanItems()
    farmCntLbl.Text="Item ditemukan: "..#items
    if #items==0 then return end
    local c,hum,root=getChar() if not root then return end
    local near,dist=nil,math.huge
    for _,item in ipairs(items) do
        local part=item
        if item:IsA("Model") then part=item.PrimaryPart or item:FindFirstChildWhichIsA("BasePart") end
        if item:IsA("ProximityPrompt") then part=item.Parent:FindFirstChildWhichIsA("BasePart") end
        if part then
            local d=(part.Position-root.Position).Magnitude
            if d<dist then dist=d near=part end
        end
    end
    if near then root.CFrame=CFrame.new(near.Position)+Vector3.new(0,3,0) end
end)

farmAllBtn.MouseButton1Click:Connect(function()
    task.spawn(function()
        farmAllBtn.Text="⏳ Sedang..."
        autoFarming=true doFarm() autoFarming=false
        farmAllBtn.Text="⚡ Ambil Semua Sekarang"
    end)
end)

skipExitBtn.MouseButton1Click:Connect(function()
    local c,hum,root=getChar() if not root then return end
    for _,obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") or obj:IsA("Model") then
            local n=obj.Name:lower()
            if n:find("exit") or n:find("goal") or n:find("escape") or n:find("finish") or n:find("clear") or n:find("door") then
                local part=obj
                if obj:IsA("Model") then part=obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart") end
                if part then
                    root.CFrame=CFrame.new(part.Position)+Vector3.new(0,4,0)
                    pcall(function() firetouchinterest(part,root,0) task.wait(0.1) firetouchinterest(part,root,1) end)
                    for _,pp in ipairs(obj:GetDescendants()) do
                        if pp:IsA("ProximityPrompt") then pcall(function() fireproximityprompt(pp) end) end
                    end
                    skipExitBtn.Text="✅ TP ke Exit!"
                    task.delay(2,function() skipExitBtn.Text="⏭️ TP ke Exit" end)
                    return
                end
            end
        end
    end
    skipExitBtn.Text="⚠️ Tidak ditemukan"
    task.delay(2,function() skipExitBtn.Text="⏭️ TP ke Exit" end)
end)

-- ================================
-- LOGIKA ESP dengan NAMA
-- ================================
local espList={}
local espItmOn,espPlyOn,espMonOn=false,false,false

local function clearESP()
    for _,v in ipairs(espList) do pcall(function() v:Destroy() end) end
    espList={}
end

local function addESP(adornee,label,col,box)
    if not adornee or not adornee.Parent then return end
    -- BillboardGui dengan nama
    local bg2=Instance.new("BillboardGui")
    bg2.Size=UDim2.new(0,130,0,30) bg2.StudsOffset=Vector3.new(0,4,0)
    bg2.AlwaysOnTop=true bg2.Adornee=adornee bg2.Parent=workspace
    table.insert(espList,bg2)
    local fr=Instance.new("Frame")
    fr.Size=UDim2.new(1,0,1,0) fr.BackgroundColor3=Color3.fromRGB(0,0,0)
    fr.BackgroundTransparency=0.4 fr.BorderSizePixel=0 fr.Parent=bg2 cr(fr,4)
    local tl=Instance.new("TextLabel")
    tl.Size=UDim2.new(1,0,1,0) tl.BackgroundTransparency=1
    tl.Text=label tl.TextColor3=col
    tl.Font=Enum.Font.GothamBold tl.TextSize=12
    tl.TextStrokeTransparency=0 tl.TextStrokeColor3=Color3.fromRGB(0,0,0)
    tl.Parent=fr
    -- Box
    if box then
        local bx=Instance.new("SelectionBox")
        bx.Adornee=adornee bx.Color3=col
        bx.LineThickness=0.05 bx.SurfaceTransparency=0.75 bx.SurfaceColor3=col
        bx.AlwaysOnTop=true bx.ZIndex=5 bx.Parent=workspace
        table.insert(espList,bx)
    end
end

local function refreshESP()
    clearESP()
    if espPlyOn then
        for _,plr in ipairs(Players:GetPlayers()) do
            if plr~=P and plr.Character then
                local root=plr.Character:FindFirstChild("HumanoidRootPart")
                local hum=plr.Character:FindFirstChildOfClass("Humanoid")
                if root then
                    local hp=hum and math.floor(hum.Health) or "?"
                    addESP(root,"👤 "..plr.Name.." HP:"..hp,Color3.fromRGB(255,80,80),true)
                end
            end
        end
    end
    if espMonOn then
        for _,obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("Model") then
                local n=obj.Name:lower()
                if n:find("petapeta") or n:find("monster") or n:find("ghost") or n:find("enemy") or n:find("youkai") or n:find("spirit") or n:find("creature") then
                    local root=obj.PrimaryPart or obj:FindFirstChild("HumanoidRootPart") or obj:FindFirstChildWhichIsA("BasePart")
                    if root then addESP(root,"👹 "..obj.Name,RED2,true) end
                end
            end
        end
    end
    if espItmOn then
        local cnt=0
        for _,obj in ipairs(workspace:GetDescendants()) do
            if cnt>=80 then break end
            local part,displayName=nil,nil
            if obj:IsA("BasePart") or obj:IsA("MeshPart") then
                local n=obj.Name:lower()
                for _,kw in ipairs(farmKeywords) do
                    if n:find(kw) then
                        part=obj displayName="🔑 "..obj.Name break
                    end
                end
            elseif obj:IsA("ProximityPrompt") and obj.Enabled then
                local ac=obj.ActionText local ob2=obj.ObjectText
                if ac~="" or ob2~="" then
                    part=obj.Parent:FindFirstChildWhichIsA("BasePart")
                    displayName="💡 "..(ac~="" and ac or ob2)
                end
            elseif obj:IsA("Tool") then
                part=obj:FindFirstChildWhichIsA("BasePart")
                displayName="🧰 "..obj.Name
            end
            if part and part.Parent then
                addESP(part,displayName,GO,true)
                cnt=cnt+1
            end
        end
    end
end

espItmBtn.MouseButton1Click:Connect(function()
    espItmOn=not espItmOn
    if espItmOn then togOn(espItmBtn,GO) else togOff(espItmBtn) end
    espItmLbl.Text="Item ESP: "..(espItmOn and "✅ ON" or "❌ OFF")
    espItmLbl.TextColor3=espItmOn and G or R
    refreshESP()
end)
espPlyBtn.MouseButton1Click:Connect(function()
    espPlyOn=not espPlyOn
    if espPlyOn then togOn(espPlyBtn,RED2) else togOff(espPlyBtn) end
    espPlyLbl.Text="Player ESP: "..(espPlyOn and "✅ ON" or "❌ OFF")
    espPlyLbl.TextColor3=espPlyOn and G or R
    refreshESP()
end)
espMonBtn.MouseButton1Click:Connect(function()
    espMonOn=not espMonOn
    if espMonOn then togOn(espMonBtn,RED2) else togOff(espMonBtn) end
    espMonLbl.Text="👹 Monster ESP: "..(espMonOn and "✅ ON" or "❌ OFF")
    espMonLbl.TextColor3=espMonOn and G or R
    refreshESP()
end)
espRefBtn.MouseButton1Click:Connect(function()
    refreshESP()
    espRefBtn.Text="✅ Done!" task.delay(1.5,function() espRefBtn.Text="🔄 Refresh ESP" end)
end)
task.spawn(function()
    while true do
        if espItmOn or espPlyOn or espMonOn then pcall(refreshESP) end
        task.wait(3)
    end
end)

-- ================================
-- LOGIKA MINI MAP / RADAR
-- ================================
local mapOn=false local mapSize=200

local radarFrame=Instance.new("Frame")
radarFrame.Size=UDim2.new(0,180,0,180)
radarFrame.Position=UDim2.new(1,-194,0,8)
radarFrame.BackgroundColor3=Color3.fromRGB(4,4,10)
radarFrame.BackgroundTransparency=0.2
radarFrame.ZIndex=500 radarFrame.Visible=false radarFrame.Parent=sg
cr(radarFrame,90) mkStroke(radarFrame,PU,2)

local rH=Instance.new("Frame") rH.Size=UDim2.new(1,0,0,1) rH.Position=UDim2.new(0,0,0.5,0)
rH.BackgroundColor3=Color3.fromRGB(50,50,70) rH.ZIndex=501 rH.Parent=radarFrame
local rV=Instance.new("Frame") rV.Size=UDim2.new(0,1,1,0) rV.Position=UDim2.new(0.5,0,0,0)
rV.BackgroundColor3=Color3.fromRGB(50,50,70) rV.ZIndex=501 rV.Parent=radarFrame

local selfDot=Instance.new("Frame")
selfDot.Size=UDim2.new(0,10,0,10) selfDot.Position=UDim2.new(0.5,-5,0.5,-5)
selfDot.BackgroundColor3=CY selfDot.ZIndex=510 selfDot.Parent=radarFrame cr(selfDot,5)

local rTitle=Instance.new("TextLabel")
rTitle.Size=UDim2.new(1,0,0,16) rTitle.Position=UDim2.new(0,0,1,-18)
rTitle.BackgroundTransparency=1 rTitle.Text="👹 RADAR"
rTitle.TextColor3=PU rTitle.Font=Enum.Font.GothamBold rTitle.TextSize=10
rTitle.TextXAlignment=Enum.TextXAlignment.Center rTitle.ZIndex=510 rTitle.Parent=radarFrame

local radarDots={}
local function getDot(i,col)
    if not radarDots[i] then
        local d=Instance.new("Frame")
        d.Size=UDim2.new(0,8,0,8) d.ZIndex=505 d.BorderSizePixel=0
        d.BackgroundColor3=col or W d.Parent=radarFrame cr(d,4)
        local tl=Instance.new("TextLabel")
        tl.Size=UDim2.new(0,65,0,14) tl.Position=UDim2.new(0,10,0,-3)
        tl.BackgroundTransparency=1 tl.TextColor3=col or W
        tl.Font=Enum.Font.GothamBold tl.TextSize=9 tl.ZIndex=506 tl.Parent=d
        radarDots[i]={dot=d,lbl=tl}
    end
    return radarDots[i]
end
local function hideAllDots()
    for _,v in ipairs(radarDots) do if v.dot then v.dot.Visible=false end end
end

mapBtn.MouseButton1Click:Connect(function()
    mapOn=not mapOn radarFrame.Visible=mapOn
    if mapOn then togOn(mapBtn,PU) else togOff(mapBtn) end
    mapLbl.Text="Radar: "..(mapOn and "✅ ON" or "❌ OFF")
    mapLbl.TextColor3=mapOn and G or R
end)
mapDecBtn.MouseButton1Click:Connect(function() mapSize=math.max(50,mapSize-50) mapSzLbl.Text="Ukuran: "..mapSize end)
mapIncBtn.MouseButton1Click:Connect(function() mapSize=math.min(500,mapSize+50) mapSzLbl.Text="Ukuran: "..mapSize end)

task.spawn(function()
    while true do
        if mapOn then
            pcall(function()
                local c,hum,root=getChar() if not root then return end
                hideAllDots()
                local di=1
                for _,plr in ipairs(Players:GetPlayers()) do
                    if plr~=P and plr.Character then
                        local pr=plr.Character:FindFirstChild("HumanoidRootPart")
                        if pr then
                            local df=pr.Position-root.Position
                            local rx=math.clamp(df.X/mapSize,-0.44,0.44)
                            local rz=math.clamp(df.Z/mapSize,-0.44,0.44)
                            local d=getDot(di,Color3.fromRGB(255,80,80))
                            d.dot.Visible=true d.dot.BackgroundColor3=Color3.fromRGB(255,80,80)
                            d.dot.Position=UDim2.new(0.5+rx,-4,0.5+rz,-4)
                            d.lbl.Text=plr.Name d.lbl.TextColor3=Color3.fromRGB(255,80,80)
                            di=di+1
                        end
                    end
                end
                for _,obj in ipairs(workspace:GetDescendants()) do
                    if di>40 then break end
                    if obj:IsA("Model") then
                        local n=obj.Name:lower()
                        if n:find("petapeta") or n:find("monster") or n:find("ghost") or n:find("enemy") then
                            local pr=obj.PrimaryPart or obj:FindFirstChild("HumanoidRootPart") or obj:FindFirstChildWhichIsA("BasePart")
                            if pr then
                                local df=pr.Position-root.Position
                                local rx=math.clamp(df.X/mapSize,-0.44,0.44)
                                local rz=math.clamp(df.Z/mapSize,-0.44,0.44)
                                local d=getDot(di,RED2)
                                d.dot.Visible=true d.dot.BackgroundColor3=RED2
                                d.dot.Position=UDim2.new(0.5+rx,-4,0.5+rz,-4)
                                d.lbl.Text="👹"..obj.Name d.lbl.TextColor3=RED2
                                di=di+1
                            end
                        end
                    end
                end
                for _,obj in ipairs(workspace:GetDescendants()) do
                    if di>50 then break end
                    if obj:IsA("BasePart") then
                        local n=obj.Name:lower()
                        for _,kw in ipairs({"key","box","doll","rope","candle","block","shard","ofuda","circle","triangle","square","rectangle"}) do
                            if n:find(kw) then
                                local df=obj.Position-root.Position
                                local rx=math.clamp(df.X/mapSize,-0.44,0.44)
                                local rz=math.clamp(df.Z/mapSize,-0.44,0.44)
                                local d=getDot(di,GO)
                                d.dot.Visible=true d.dot.BackgroundColor3=GO
                                d.dot.Position=UDim2.new(0.5+rx,-4,0.5+rz,-4)
                                d.lbl.Text=obj.Name d.lbl.TextColor3=GO
                                di=di+1 break
                            end
                        end
                    end
                end
            end)
        end
        task.wait(0.5)
    end
end)

-- ================================
-- LOGIKA MISC
-- ================================
local noclip=false local ncCn
ncBtn.MouseButton1Click:Connect(function()
    noclip=not noclip
    if noclip then
        togOn(ncBtn,OR)
        ncCn=RS.Stepped:Connect(function()
            local c=P.Character if not c then return end
            for _,p2 in ipairs(c:GetDescendants()) do if p2:IsA("BasePart") then p2.CanCollide=false end end
        end)
    else
        togOff(ncBtn) if ncCn then ncCn:Disconnect() ncCn=nil end
        local c=P.Character if c then
            for _,p2 in ipairs(c:GetDescendants()) do if p2:IsA("BasePart") then p2.CanCollide=true end end
        end
    end
    ncLbl.Text="Noclip: "..(noclip and "✅ ON" or "❌ OFF") ncLbl.TextColor3=noclip and G or R
end)

local infJump=false local ijCn
ijBtn.MouseButton1Click:Connect(function()
    infJump=not infJump
    if infJump then
        togOn(ijBtn,CY)
        ijCn=UIS.JumpRequest:Connect(function()
            local c,hum=getChar() if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
        end)
    else togOff(ijBtn) if ijCn then ijCn:Disconnect() ijCn=nil end end
    ijLbl.Text="Inf Jump: "..(infJump and "✅ ON" or "❌ OFF") ijLbl.TextColor3=infJump and G or R
end)

local isGod=false local gdCn
gdBtn.MouseButton1Click:Connect(function()
    isGod=not isGod
    if isGod then
        togOn(gdBtn,GO)
        gdCn=RS.Heartbeat:Connect(function()
            local c,hum=getChar() if hum then hum.Health=hum.MaxHealth end
        end)
    else togOff(gdBtn) if gdCn then gdCn:Disconnect() gdCn=nil end end
    gdLbl.Text="God Mode: "..(isGod and "✅ ON" or "❌ OFF") gdLbl.TextColor3=isGod and G or R
end)

rstBtn.MouseButton1Click:Connect(function() P:LoadCharacter() end)

P.CharacterAdded:Connect(function()
    task.wait(0.8)
    if speedConn then local c2,hum2=getChar() if hum2 then hum2.WalkSpeed=spVal end end
    if isGod then if gdCn then gdCn:Disconnect() end gdCn=RS.Heartbeat:Connect(function() local c,hum=getChar() if hum then hum.Health=hum.MaxHealth end end) end
    if flying then flying=false bv=nil bg=nil task.wait(0.3) startFly() end
    goUp=false goDown=false
end)

XBtn.MouseButton1Click:Connect(function() Frame.Visible=false XBtn.Visible=false OpenBtn.Visible=true end)
OpenBtn.MouseButton1Click:Connect(function() Frame.Visible=true XBtn.Visible=true OpenBtn.Visible=false updateX() end)
